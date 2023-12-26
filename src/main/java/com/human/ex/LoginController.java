package com.human.ex;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.dto.UserDto;
import com.human.model.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userservice;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	
	@RequestMapping(value = "/admin/user/login", method = RequestMethod.GET)
	public String userLogin(Locale locale, Model model) {
		return "/admin/user/login";
	}
	@RequestMapping(value = "/admin/user/login", method = RequestMethod.POST)
    public String userLoginPost(Locale locale, Model model) throws Exception{
      
      return "redirect:/board/main";
	}
	@RequestMapping(value = "/admin/user/selectAll", method = RequestMethod.GET)
	public String selectAll(Model model) throws Exception{
		model.addAttribute("list", userservice.userSelectAll());
		return "/admin/user/selectAll";
	}
	
	@RequestMapping(value = "/admin/user/insert", method = RequestMethod.GET)
	public String userInsert() {
		return "/admin/user/insert";
	}
	@RequestMapping(value = "/admin/user/insert", method = RequestMethod.POST)
	public String userInsertDB(UserDto humanDto,RedirectAttributes rttr) throws Exception{
//		String encPassword = passwordEncoder.encode(humanDto.getPassword());
//		humanDto.setPassword(encPassword);
		userservice.userInsert(humanDto);
		System.out.println(humanDto);
		rttr.addFlashAttribute("msg","success");
		return "redirect:/board/main";
	}
}
