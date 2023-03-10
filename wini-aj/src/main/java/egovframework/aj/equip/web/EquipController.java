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
	
	@RequestMapping(value = "/equipType.do")
	@ResponseBody 
	public List equipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		List typeResult = EquipService.list_map("EquipDAO.selectEquipType", equipMap);
		
		return typeResult;
	}
	
	@RequestMapping(value = "/equipList.do")
	@ResponseBody 
	public List equipList(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		List listResult = EquipService.list_map("EquipDAO.selectEquipList", equipMap);
		
		return listResult;
	}
	
	@RequestMapping(value = "/addEquipType.do")
	@ResponseBody 
	public String addEquipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.insert("EquipDAO.insertEquipType", equipMap);

		return null;
	}
	
	
	
	
}
