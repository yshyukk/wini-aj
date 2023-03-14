package egovframework.aj.main.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AjmainController {

	@RequestMapping(value = "/main.do")
	public String menuList(HttpSession session, HttpServletRequest request) {
			
		return "/menu/main";
	}
}