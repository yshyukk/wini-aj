package egovframework.aj.menu.service;

import java.util.Map;

public interface MenuService {
	//메뉴 리스트 조회
	public Map<String,Object> getMenuInfo(Map<String,Object> commandMap);
	
	//메뉴 상세조회
	public Map<String,Object> muDetailInfo(Map<String,Object> commandMap);
	
	//메뉴 IUD
	public Map<String,Object> menuIUD(Map<String,Object> commandMap);
}
