package egovframework.ajmain.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

@Controller
public class ajmainController {

	@RequestMapping(value = "/ajmain.do")
	public String ajmain() throws Exception {
		return "sample/main";
	}
	
}
