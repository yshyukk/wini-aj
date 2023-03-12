package egovframework.aj.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.aj.menu.dao.MenuDAO;
import egovframework.aj.menu.service.MenuService;

@Service("menuService")
public class MenuServiceImpl implements MenuService{

	@Resource(name="menuDAO")
	MenuDAO mDAO;
	/* $
	 * 
	 */
	@Override
	public Map<String, Object> getMenuInfo(Map<String,Object> commandMap) {
		List menuList = mDAO.list("menu.getMenuInfo");
		
		HashMap<String, Object> menuINfo = new HashMap<>();
		
		menuINfo.put("menuList", menuList);
		
		return menuINfo;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> muDetailInfo(Map<String, Object> commandMap) {
		
		Map<String, Object> respMap = (Map<String, Object>) mDAO.select("menu.muDetailInfo", commandMap);
		return respMap;
	}

	@Override
	public Map<String, Object> menuIUD(Map<String, Object> commandMap) {
		// TODO Auto-generated method stub
		return null;
	}

}
