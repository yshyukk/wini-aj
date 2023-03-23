package egovframework.aj.ex.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExController {
	
	@RequestMapping(value = "/exPage.do")
	public String exPage() {
	
		return "ex/ex1.tiles";
	}
	
	
}
