package com.human.ex;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
import com.human.dto.BoardDto;
import com.human.dto.UserDto;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.PageMaker;
import com.human.model.BoardService;
import com.human.model.NewsResponse;
import com.human.model.UserService;
import com.human.vo.PageMaker;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService service;
	@Autowired
	private UserService userservice;
	//메인 페이지 
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET() {
		logger.info("main get........................");
	}	
	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String mainPOST() {
		logger.info("main post........................");
		return "redirect:/board/main";
	}
	
	//뉴스 페이지 
		@RequestMapping(value = "/news", method = RequestMethod.GET)
		public void newsGET() {
			logger.info("main get........................");
		}	
		@RequestMapping(value = "/news", method = RequestMethod.POST)
		public String newsPOST() {
			logger.info("main post........................");
			return "redirect:/board/news";
		}
		
	// 글쓰기
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(BoardDto board, Model model) throws Exception {

		logger.info("register get ...........");

		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardDto board, Model model, RedirectAttributes rttr) throws Exception {

		logger.info("regist post ...........");
		logger.info(board.toString());

		service.regist(board);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/board/listAll";

	}

	// 게시물조회
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(@RequestParam(value = "bGroupKind", required = false) String bGroupKind, String bGKsearchType,
			PageMaker pm, Model model) throws Exception {
		logger.info(bGroupKind);

		if (bGroupKind == null) {
			// listSearchCriteria 호출할 때는 bId를 설정하지 않음
			logger.info("listPage");
			System.out.println("--list pm " + pm);
			model.addAttribute("list", service.listSearch(pm));
			pm.setTotalCount(service.listSearchCount(pm));

		} else {
			logger.info("listPage");
			System.out.println("--list pm " + pm);
			model.addAttribute("list", service.bGroupKindSearch(pm));
			pm.setTotalCount(service.bGroupKindSearchCount(pm));

			if (bGroupKind.equals("")) {
				logger.info("listPage");
				System.out.println("--list pm " + pm);
				model.addAttribute("list", service.listSearch(pm));
				pm.setTotalCount(service.listSearchCount(pm));
			}

		}
		String[] category = service.category();
		model.addAttribute("category", category);

	}


	// 게시물 읽기
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bId") int bId, Model model) throws Exception {
		logger.info("read......................" + bId);
		service.increaseViewCount(bId);
		model.addAttribute(service.read(bId));
//		model.addAttribute(boardDao,service.read(bId)); 위랑 아래랑 같은 코드임
		String[] category = service.category();
		model.addAttribute("category", category);

	}

	// 삭제
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bId") int bId, RedirectAttributes rttr)
			throws Exception {

		service.remove(bId);

		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/listAll";
	}

	// 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)

	public void modifyGET(int bId, Model model) throws Exception {

		model.addAttribute(service.read(bId));
		
		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)

		public String modifyPOST(BoardDto board, RedirectAttributes rttr) throws Exception {
		service.modify(board);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/board/listAll";
	}


	
	
	// 좋아요
	@RequestMapping(value = "/bLike", method = RequestMethod.GET)
	public String bLike(@RequestParam("bId") int bId, Model model) throws Exception {
		logger.info("bLike......................" + bId);
		service.bLike(bId);
		return "redirect:/board/listAll";
	}

	// 답글
	@RequestMapping(value = "/reply", method = RequestMethod.GET)
	public void replyGet(@RequestParam("bId") int bId, Model model) throws Exception {
		logger.info("reply get ...........");
		model.addAttribute(service.read(bId));
		
		String[] category = service.category();
		model.addAttribute("category", category);
	}

	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String replyPost(@RequestParam("bId") int bId, Model model, BoardDto board, RedirectAttributes rttr)
			throws Exception {
		BoardDto dto = service.read(bId);

		int parentBGroup = dto.getbGroup();
		int parentBStep = dto.getbStep();
		int parentBIndent = dto.getbIndent();

		service.replyStep(parentBGroup, parentBStep);

		board.setbIndent(parentBIndent + 1);
		board.setbStep(parentBStep + 1);

		service.replyCreate(board);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/listAll";
	}
	
	//뉴스 api 
	@RequestMapping("/searchNews")
	public String searchNews(@RequestParam String query, Model model) throws JsonParseException, JsonMappingException, IOException {
	    String apiUrl = "https://openapi.naver.com/v1/search/news.json?query=" + query + "&display=10&rss";
	    String apiKey = "FyZA5rYKGmihTc5Bu21U"; // 발급받은 네이버 API 키로 대체

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("X-Naver-Client-Id", apiKey);
	    headers.set("X-Naver-Client-Secret", "MojOXOgHPi");

	    HttpEntity<String> entity = new HttpEntity<>(headers);

	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

	    String result = responseEntity.getBody();

	    // JSON 문자열을 자바 객체로 변환
	    ObjectMapper objectMapper = new ObjectMapper();
	    objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	    NewsResponse newsResponse = objectMapper.readValue(result, NewsResponse.class);

	    // 이미지 URL을 뷰로 전달
	    model.addAttribute("newsResult", newsResponse);
	    model.addAttribute("imageUrl", newsResponse.getItems().get(0).getImage()); // 예시로 첫 번째 아이템의 이미지 URL 사용

	    return "board/newsResult"; // newsResult.jsp로 이동
	}
//	@RequestMapping(value = "/login", method = RequestMethod.GET)
//	public String userLogin(Locale locale, Model model) {
//		return "board/login";
//	}
//	@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
//	public String selectAll(Model model) throws Exception{
//		model.addAttribute("list", userservice.userSelectAll());
//		return "/board/selectAll";
//	}
//	
//	@RequestMapping(value = "/userInsert", method = RequestMethod.GET)
//	public String userInsert() {
//		return "board/insert";
//	}
//	@RequestMapping(value = "/userInsert", method = RequestMethod.POST)
//	public String userInsertDB(UserDto humanDto,RedirectAttributes rttr) throws Exception{
////		String encPassword = passwordEncoder.encode(humanDto.getPassword());
////		humanDto.setPassword(encPassword);
//		userservice.userInsert(humanDto);
//		System.out.println(humanDto);
//		rttr.addFlashAttribute("msg","success");
//		return "redirect:/board/selectAll";
//	}
}
