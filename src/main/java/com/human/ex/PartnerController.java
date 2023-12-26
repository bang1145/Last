package com.human.ex;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.dto.BoardDto;
import com.human.dto.PartnerDto;
import com.human.model.PartnerService;
import com.human.vo.PageMaker;

@Controller
@RequestMapping("/partner/")
public class PartnerController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
    @Autowired
    private PartnerService partnerService;

//    // 목록 조회
//    @RequestMapping(value = "/listPartner", method = RequestMethod.GET)
//    public void listPartner(@ModelAttribute Model model) throws Exception{
//    	logger.info("listPartner......................");
//    	List<PartnerDto> partnerDto = partnerService.listPartner();
//    	model.addAttribute("partnerDto", partnerDto);
//	}
    @GetMapping("/listPartner")
    public String listPartner(Model model) {
        try {
        	List<PartnerDto> partnerDto = partnerService.listPartner();
            model.addAttribute("partnerDto", partnerDto);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 로직 추가
        }
        return "/partner/listPartner";
    }

 // 게시물 읽기
 	@RequestMapping(value = "/readPartner", method = RequestMethod.GET)
 	public void readPartner(@RequestParam("pId") Integer pId, Model model) throws Exception {
 		logger.info("readPartner......................" + pId);
 		partnerService.partnerViewCount(pId);
 		model.addAttribute(partnerService.readPartner(pId));
 	}
 	
 	@RequestMapping(value = "/insertPartner", method = RequestMethod.GET)
	public void insertPartnerGET(@ModelAttribute PartnerDto partner, Model model) throws Exception {

		logger.info("insertPartner get ...........");
	}
 	
 	//글 쓰기
 	@RequestMapping(value = "/insertPartner", method = RequestMethod.POST)
	public String insertPartnerPOST(@ModelAttribute PartnerDto partner, Model model, RedirectAttributes rttr) throws Exception {

		logger.info("insertPartner post ...........");
		logger.info(partner.toString());

		partnerService.insertPartner(partner);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/partner/listPartner";

	}

 	// 수정
 	@RequestMapping(value = "/updatePartner", method = RequestMethod.GET)

 	public void updatePartnerGET(Integer pId, Model model) throws Exception {

 		model.addAttribute(partnerService.readPartner(pId));
 		
 	}

 	@RequestMapping(value = "/updatePartner", method = RequestMethod.POST)

 		public String updatePartnerPOST(PartnerDto partner, RedirectAttributes rttr) throws Exception {
 		partnerService.updatePartner(partner);

 		rttr.addFlashAttribute("msg", "success");

 		return "redirect:/partner/listPartner";
 	}


    // 삭제
 	@RequestMapping(value = "/deletePartner", method = RequestMethod.POST)
 	public String deletePartner(@RequestParam("pId") int pId, RedirectAttributes rttr)
 			throws Exception {

 		partnerService.deletePartner(pId);

 		rttr.addFlashAttribute("msg", "success");
 		return "redirect:/partner/listPartner";
 	}

}
