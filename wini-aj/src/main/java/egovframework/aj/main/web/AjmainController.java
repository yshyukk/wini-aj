package egovframework.aj.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AjmainController {

	@RequestMapping(value = "/main.do")
	public String menuList() {
		return "/menu/main";
	}
	
}
