package egovframework.aj.equip.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.aj.equip.service.EquipService;

@Controller
public class EquipController {

	@Resource(name = "EquipService")
	private EquipService EquipService;
	
	
	@RequestMapping(value = "/equipmain.do")
	public String equipmain() {
		return "/equip/equipList";
	}
	
	@RequestMapping(value = "/equipList.do")
	@ResponseBody 
	public List equipList(@RequestParam Map<String, Object> commandMap) throws Exception {
		
		List result = EquipService.list_map("EquipDAO.selectEquipType", commandMap);
		
		return result;
	}
}
