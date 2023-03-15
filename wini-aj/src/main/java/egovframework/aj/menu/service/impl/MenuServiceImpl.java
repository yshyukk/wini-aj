package egovframework.aj.menu.service.impl;

import java.sql.SQLException;
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
	
	/* 
	 * @ 메뉴 리스트 출력 로직
	 * @ param
	 * 		- int : userRole
	 * @ return
	 * 		- map : 유저 권한과 메뉴 권한을 비교해 접근 가능한 리스트만 조회
	 */
	@Override
	public Map<String, Object> getMenuInfo(Map<String,Object> commandMap) {
		
		
		List menuList = mDAO.list("menu.getMenuInfo", commandMap);
		
		HashMap<String, Object> menuInfo = new HashMap<>();
		
		menuInfo.put("menuList", menuList);
		
		return menuInfo;
	}
	
	/*
	 *	@ 메뉴 상세(단건) 조회 
	 * 	@ param
	 * 		- mu_seq : 클릭한 메뉴의 PK값
	 * 	@ return
	 * 		- map : PK가 일치하는 메뉴의 상세 정보
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> muDetailInfo(Map<String, Object> commandMap) {
		
		Map<String, Object> respMap = (Map<String, Object>) mDAO.select("menu.muDetailInfo", commandMap);
		return respMap;
	}
	
	/*
	 *	@ 메뉴 등록, 수정, 삭제 
	 *  @ param
	 *  	- String : IUD ( 등록, 수정, 삭제를 구분하기 위한 값)
	 *  	- menuList.jsp에서 form(id = mu-frm) 내 정보
	 *  @ return
	 *  	- map
	 *  		- string : msg (처리 결과를 구분하기 위한 값)
	 *  		- iud : ajax결과 값에서 iud로 msg를 구분해 해당 알림창 처리하기 위해
	 *  		
	 */
	
	@Override
	public Map<String, Object> menuIUD(Map<String, Object> commandMap) {
		
		Map<String,Object>  result = new HashMap<>();
		
		result.put("IUD",commandMap.get("IUD"));
		
		result.put("muSeq",commandMap.get("muSeq"));
		
		
		//
		String checkNm = (String) commandMap.get("muNm");
		checkNm = checkNm.replace(" ","");
		commandMap.put("checkNm", checkNm);
		//메뉴이름  중복체크
		int menuCheck = (int) mDAO.select("menu.checkInsMenu", commandMap);
				
		try{
				if(commandMap.get("IUD").equals("I") && commandMap.get("IUD") != null) {
					//중복되는 이름이 없으면
					if(menuCheck == 0) {
						
						mDAO.insert("menu.insMenuInfo", commandMap);
						result.put("msg","success");
					
					}else {
						// 중복되는 이름이 있으면
						result.put("msg","checkErr");
					}
			
				}else if(commandMap.get("IUD").equals("U") && commandMap.get("IUD") != null) {
						
						/* 
						*  수정할 때 바꿀 메뉴 이름을 제외하고 다른 메뉴들의 이름 중에서 중복되는 이름이 있는지 체크 
						*/
						int updMenuChek = (int)mDAO.select("menu.checkUpdMenuId",commandMap);
						
						if(updMenuChek == 0) {
							
							mDAO.update("menu.updMenuInfo", commandMap);
							result.put("msg","success");
							
						}else { 
							// 다른 메뉴에서 이름이 존재하면 수정  X
							result.put("msg","checkErr");
						}
						
				}else if(commandMap.get("IUD").equals("D") && commandMap.get("IUD") != null) {
						
					//하위메뉴가 있으면 삭제금지
					int refCheck = (int)mDAO.select("menu.checkChildMenu",commandMap);
					//메뉴 level 생성 제한하기 위해 생성하고자 하는 메뉴의 상위메뉴의 레벨을 조회
						
					if(refCheck == 0) {
						
						mDAO.delete("menu.delMenuInfo", commandMap);
						result.put("msg","success");
					
					}else {
						
						result.put("msg","checkErr");
					}
				}
			}catch(Exception e) {
				result.put("msg","err");
			}
		
		return result;
	}

}
