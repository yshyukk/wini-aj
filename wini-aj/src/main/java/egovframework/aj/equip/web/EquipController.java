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
	
//	장비 목록 페이지 이동
	@RequestMapping(value = "/equipmain.do")
	public String equipmain() {
		return "/equip/equipList";
	}
//	장비 점검 관리 페이지 이동
	@RequestMapping(value = "/equipMgrmain.do")
	public String equipMgrmain() {
		return "/equip/equipListMgr";
	}
	
/**
 * 장비 종류(타입)에 관련된 컨트롤러
 * CRUD
 * */
	
//	장비 종류 목록 조회
	@RequestMapping(value = "/equipType.do")
	@ResponseBody 
	public List equipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		List typeResult = EquipService.list_map("EquipDAO.selectEquipType", equipMap);
		
		return typeResult;
	}

//	장비 종류 추가
	@RequestMapping(value = "/addEquipType.do")
	@ResponseBody 
	public String addEquipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.insert("EquipDAO.insertEquipType", equipMap);

		return null;
	}
//	장비 종류 삭제
	@RequestMapping(value = "/deleteEquipType.do")
	@ResponseBody 
	public String deleteEquipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.delete("EquipDAO.deleteEquipType", equipMap);

		return null;
	}
//	장비 종류 수정
	@RequestMapping(value = "/updateEquipType.do")
	@ResponseBody 
	public String updateEquipType(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.update("EquipDAO.updateEquipType", equipMap);

		return null;
	}
	
	
	
/**
 * 장비에 관련된 컨트롤러
 * CRUD
 * */
//	장비 목록 조회
	@RequestMapping(value = "/equipList.do")
	@ResponseBody 
	public List equipList(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		List listResult = EquipService.list_map("EquipDAO.selectEquipList", equipMap);
		
		return listResult;
	}
//	장비 추가
	@RequestMapping(value = "/addEquip.do")
	@ResponseBody 
	public String addEquip(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.insert("EquipDAO.insertEquip", equipMap);

		return null;
	}
// 장비 상세보기 (관리자용)
	@RequestMapping(value = "/detailEquip.do")
	@ResponseBody 
	public List detailEquip(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		List detailResult = EquipService.list_map("EquipDAO.selectEquipDetail", equipMap);
		
		return detailResult;
	}
//	장비 수정 (관리자용)
	@RequestMapping(value = "/updateEquip.do")
	@ResponseBody 
	public String updateEquip(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.update("EquipDAO.updateEquip", equipMap);

		return null;
	}
//	장비 삭제
	@RequestMapping(value = "/deleteEquip.do")
	@ResponseBody 
	public String deleteEquip(@RequestParam Map<String, Object> equipMap) throws Exception {
		
		EquipService.delete("EquipDAO.deleteEquip", equipMap);

		return null;
	}
}
