package com.human.ex;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.human.dto.HireDto;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.PageMaker;
import com.human.model.HireService;
import com.human.model.NewsResponse;
import com.human.vo.PageMaker;

@Controller
@RequestMapping("/hire/*")
public class HireController {

	private static final Logger logger = LoggerFactory.getLogger(HireController.class);

	@Autowired
	private HireService service;
	
	//메인 페이지 
//	@RequestMapping(value = "/main", method = RequestMethod.GET)
//	public void mainGET() {
//		logger.info("main get........................");
//	}	
//	@RequestMapping(value = "/main", method = RequestMethod.POST)
//	public String mainPOST() {
//		logger.info("main post........................");
//		return "redirect:/hire/main";
//	}
//	
//	//뉴스 페이지 
//		@RequestMapping(value = "/news", method = RequestMethod.GET)
//		public void newsGET() {
//			logger.info("main get........................");
//		}	
//		@RequestMapping(value = "/news", method = RequestMethod.POST)
//		public String newsPOST() {
//			logger.info("main post........................");
//			return "redirect:/hire/news";
//		}
//		
//	// 글쓰기
//	@RequestMapping(value = "/register", method = RequestMethod.GET)
//	public void registerGET(HireDto board, Model model) throws Exception {
//
//		logger.info("register get ...........");
//
//		String[] category = service.category();
//		model.addAttribute("category", category);
//	}
//
//	@RequestMapping(value = "/register", method = RequestMethod.POST)
//	public String registPOST(HireDto board, Model model, RedirectAttributes rttr) throws Exception {
//
//		logger.info("regist post ...........");
//		logger.info(board.toString());
//
//		service.regist(board);
//
//		rttr.addFlashAttribute("msg", "success");
//
//		return "redirect:/hire/listAll";
//
//	}

	
	
	// 목록 조회
    @GetMapping("/listAllHire")
    public String listAllHire(Model model) {
        try {
           List<HireDto> hireDto = service.listAll();
            model.addAttribute("hireDto", hireDto);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 로직 추가
        }
        return "/hire/listAllHire";
    }
	
	
//	// 게시물조회
//	@RequestMapping(value = "/listAllHire", method = RequestMethod.GET)
//	public void listAll(@RequestParam(value = "hGroupKind", required = false) String hGroupKind, String hGKsearchType,
//			PageMaker pm, Model model) throws Exception {
//		logger.info(hGroupKind);
//
//		if (hGroupKind == null) {
//			// listSearchCriteria 호출할 때는 bId를 설정하지 않음
//			logger.info("listPage");
//			System.out.println("--list pm " + pm);
//			model.addAttribute("list", service.listSearch(pm));
//			pm.setTotalCount(service.listSearchCount(pm));
//
//		} else {
//			logger.info("listPage");
//			System.out.println("--list pm " + pm);
//			model.addAttribute("list", service.hGroupKindSearch(pm));
//			pm.setTotalCount(service.hGroupKindSearchCount(pm));
//
//			if (hGroupKind.equals("")) {
//				logger.info("listPage");
//				System.out.println("--list pm " + pm);
//				model.addAttribute("list", service.listSearch(pm));
//				pm.setTotalCount(service.listSearchCount(pm));
//			}
//
//		}
//		String[] category = service.category();
//		model.addAttribute("category", category);
//
//	}
	
	


    
	// 게시물 읽기
	@RequestMapping(value = "/readHire", method = RequestMethod.GET)
	public void read(@RequestParam("hId") int hId, Model model) throws Exception {
		logger.info("read......................" + hId);
		service.increaseViewCount(hId);
		
		List<HireDto> hireDtoList = new ArrayList<>();
	    hireDtoList.add(service.read(hId));
	    
	    model.addAttribute("hireDtoList", hireDtoList);
		
//		model.addAttribute(service.read(hId));
//		model.addAttribute(hireDao,service.read(bId)); 위랑 아래랑 같은 코드임
//		String[] category = service.category();
//		model.addAttribute("category", category);

	}

//	// 삭제
//	@RequestMapping(value = "/remove", method = RequestMethod.POST)
//	public String remove(@RequestParam("bId") int bId, RedirectAttributes rttr)
//			throws Exception {
//
//		service.remove(bId);
//
//		rttr.addFlashAttribute("msg", "success");
//		return "redirect:/hire/listAll";
//	}
//
//	// 수정
//	@RequestMapping(value = "/modify", method = RequestMethod.GET)
//
//	public void modifyGET(int bId, Model model) throws Exception {
//
//		model.addAttribute(service.read(bId));
//		
//		String[] category = service.category();
//		model.addAttribute("category", category);
//	}
//
//	@RequestMapping(value = "/modify", method = RequestMethod.POST)
//
//		public String modifyPOST(HireDto board, RedirectAttributes rttr) throws Exception {
//		service.modify(board);
//
//		rttr.addFlashAttribute("msg", "success");
//
//		return "redirect:/hire/listAll";
//	}
//
//
//	
//	
//	// 좋아요
//	@RequestMapping(value = "/bLike", method = RequestMethod.GET)
//	public String bLike(@RequestParam("bId") int bId, Model model) throws Exception {
//		logger.info("bLike......................" + bId);
//		service.hLike(Id);
//		return "redirect:/hire/listAll";
//	}
//
//	// 답글
//	@RequestMapping(value = "/reply", method = RequestMethod.GET)
//	public void replyGet(@RequestParam("bId") int bId, Model model) throws Exception {
//		logger.info("reply get ...........");
//		model.addAttribute(service.read(bId));
//		
//		String[] category = service.category();
//		model.addAttribute("category", category);
//	}

	

}
