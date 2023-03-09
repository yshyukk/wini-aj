package egovframework.aj.menu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuController {

	@RequestMapping(value = "/menuList.do")
	public String menuList() {
		return "/menu/menuList";
	}
}
