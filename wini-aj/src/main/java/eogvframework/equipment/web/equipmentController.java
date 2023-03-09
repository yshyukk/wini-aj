package eogvframework.equipment.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class equipmentController {
	
	@RequestMapping(value = "/equipTypeList.do")
	public String equipTypeList() throws Exception {

		return "sample/equipmain";
	}
}
