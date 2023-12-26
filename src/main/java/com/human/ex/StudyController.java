package com.human.ex;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.human.dao.StudyDao;
import com.human.dao.StudyReplyDao;
import com.human.dto.StudyDto;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.PageMaker;
import com.human.model.StudyService;
import com.human.model.NewsResponse;
import com.human.vo.StudyPageMaker;

@Controller
@RequestMapping("/study/*")
public class StudyController {

	private static final Logger logger = LoggerFactory.getLogger(StudyController.class);

	@Autowired
	private StudyService service;
	// 글쓰기
	@RequestMapping(value = "/studyRegister", method = RequestMethod.GET)
	public void studyRegisterGET(StudyDto study, Model model) throws Exception {

		logger.info("studyRegister get ...........");

		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/studyRegister", method = RequestMethod.POST)
	public String studyRegisterPOST(StudyDto study, Model model, RedirectAttributes rttr) throws Exception {

		logger.info("studyRegister post ...........");
		logger.info(study.toString());

		service.regist(study);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/study/studyListAll";

	}

	// 게시물조회
	@RequestMapping(value = "/studyListAll", method = RequestMethod.GET)
	public void studyListAll(@RequestParam(value = "sGroupKind", required = false) String sGroupKind, String sGKsearchType,
			StudyPageMaker spm, Model model) throws Exception {
		logger.info(sGroupKind);

		if (sGroupKind == null) {
			// listSearchCriteria 호출할 때는 bId를 설정하지 않음
			logger.info("listPage");
			System.out.println("--list spm " + spm);
			model.addAttribute("list", service.listSearch(spm));
			spm.setTotalCount(service.listSearchCount(spm));

		} else {
			logger.info("listPage");
			System.out.println("--list spm " + spm);
			model.addAttribute("list", service.sGroupKindSearch(spm));
			spm.setTotalCount(service.sGroupKindSearchCount(spm));

			if (sGroupKind.equals("")) {
				logger.info("listPage");
				System.out.println("--list spm " + spm);
				model.addAttribute("list", service.listSearch(spm));
				spm.setTotalCount(service.listSearchCount(spm));
			}

		}
		String[] category = service.category();
		model.addAttribute("category", category);

	}


	// 게시물 읽기
	@RequestMapping(value = "/studyRead", method = RequestMethod.GET)
	public void studyRead(@RequestParam("sId") int sId, Model model) throws Exception {
		logger.info("studyRead......................" + sId);
		service.increaseViewCount(sId);
		model.addAttribute(service.read(sId));
		String[] category = service.category();
		model.addAttribute("category", category);

	}

	// 삭제
	@RequestMapping(value = "/studyRemove", method = RequestMethod.POST)
	public String studyRemove(@RequestParam("sId") int sId, RedirectAttributes rttr)
			throws Exception {

		service.studyRemove(sId);

		rttr.addFlashAttribute("msg", "success");
		return "redirect:/study/studyListAll";
	}

	// 수정
	@RequestMapping(value = "/studyModify", method = RequestMethod.GET)

	public void studyModifyGET(int sId, Model model) throws Exception {

		model.addAttribute(service.read(sId));
		
		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/studyModify", method = RequestMethod.POST)

		public String studyModifyPOST(StudyDto study, RedirectAttributes rttr) throws Exception {
		service.modify(study);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/study/studyListAll";
	}
	
	// 좋아요
	@RequestMapping(value = "/sLike", method = RequestMethod.GET)
	public String sLike(@RequestParam("sId") int sId, Model model) throws Exception {
		logger.info("sLike......................" + sId);
		service.sLike(sId);
		return "redirect:/study/studyListAll";
	}

	// 답글
	@RequestMapping(value = "/studyReply", method = RequestMethod.GET)
	public void replyGet(@RequestParam("sId") int sId, Model model) throws Exception {
		logger.info("studyreplies get ...........");
		model.addAttribute(service.read(sId));
		
		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/studyReply", method = RequestMethod.POST)
	public String replyPost(@RequestParam("sId") int sId, Model model, StudyDto study, RedirectAttributes rttr)
			throws Exception {
		StudyDto dto = service.read(sId);

		int parentSGroup = dto.getsGroup();
		int parentSStep = dto.getsStep();
		int parentSIndent = dto.getsIndent();

		service.replyStep(parentSGroup, parentSStep);

		study.setsIndent(parentSIndent + 1);
		study.setsStep(parentSStep + 1);

		service.replyCreate(study);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/study/studyListAll";
	}
	
}
