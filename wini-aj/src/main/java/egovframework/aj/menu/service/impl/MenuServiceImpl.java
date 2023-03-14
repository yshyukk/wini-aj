package egovframework.aj.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import egovframework.aj.menu.dao.MenuDAO;
import egovframework.aj.menu.service.MenuService;

@Service("menuService")
public class MenuServiceImpl implements MenuService{

	@Resource(name="menuDAO")
	MenuDAO mDAO;
	
	/* 
	 * 
	 */
	@Override
	public Map<String, Object> getMenuInfo(Map<String,Object> commandMap) {
		
		
		List menuList = mDAO.list("menu.getMenuInfo", commandMap);
		
		HashMap<String, Object> menuInfo = new HashMap<>();
		
		menuInfo.put("menuList", menuList);
		
		return menuInfo;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> muDetailInfo(Map<String, Object> commandMap) {
		
		Map<String, Object> respMap = (Map<String, Object>) mDAO.select("menu.muDetailInfo", commandMap);
		return respMap;
	}

	@Override
	public Map<String, Object> menuIUD(Map<String, Object> commandMap) {
		
		Map<String,Object>  result = new HashMap<>();
		
		result.put("IUD",commandMap.get("IUD"));
		
		result.put("muSeq",commandMap.get("muSeq"));
		
		//메뉴이름  중복체크
		int menuCheck = (int) mDAO.select("menu.checkInsMenu", commandMap);
				
		try{
				if(commandMap.get("IUD").equals("I") && commandMap.get("IUD") != null) {
					
					if(menuCheck == 0) {
						mDAO.insert("menu.insMenuInfo", commandMap);
						result.put("msg","success");
					}else {
						result.put("msg","fail");
					}
			
				}else if(commandMap.get("IUD").equals("U") && commandMap.get("IUD") != null) {
					
					if(menuCheck == 0) {
						
						mDAO.update("menu.updMenuInfo", commandMap);
						result.put("msg","success");
					}else {
						result.put("msg","fail");
					}
				}else if(commandMap.get("IUD").equals("D") && commandMap.get("IUD") != null) {
						
					//하위메뉴가 있으면 삭제금지
					int refCheck = (int)mDAO.select("menu.checkChildMenu",commandMap);
					
					//메뉴 level 생성 제한하기 위해 생성하고자 하는 메뉴의 상위메뉴의 레벨을 조회
						
					if(refCheck == 0) {
						mDAO.delete("menu.delMenuInfo", commandMap);
						result.put("msg","success");
					}else {
						result.put("msg","fail");
					}
				}
			}catch(Exception e) {
				result.put("msg","err");
			}
		
		return result;
	}

}
