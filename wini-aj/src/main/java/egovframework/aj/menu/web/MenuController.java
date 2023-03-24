package egovframework.aj.menu.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.aj.menu.service.MenuService;

@Controller
public class MenuController {
	
	
	/*	@ 상단 메뉴바 및 페이지 전체에 메뉴 관련 기능에 대한 컨트롤러
	 *  @ 메뉴바는 tiles를 이용
	 *    - menuNav.jsp 경로 : WEB-INF/tiles/content/header/menuNav.jsp
	 *  @ sql.xml
	 *    - sqlmap/menu/menu-map.xml
	 */
	@Resource(name="menuService")
	private MenuService mService;
	
	/*
	 * @ 메뉴바 출력
	 */
	@RequestMapping(value = "/menuNav.do")
	public String menuNav() {
	
		return "/menu/menuNav";
	}
	
	/*
	 *	@ 메뉴 관리 페이지 출력 
	 */
	@RequestMapping(value = "/menuList.do")
	public String menuList() {
		return "menu/menuList.tiles";
	}
	
	/*
	 *	@ 메뉴 LIST 출력
	 *		- 메뉴 관리 페이지에서 메뉴 LIST 출력
	 *	@ param : commandMap 
	 *		- userRole : 세션에 젖아한 유저 권한
	 *	@ return : map 
	 *		- list: 메뉴정보
	 *		- string: 에러메세지
	 */
	
	@RequestMapping(value="/menuInfo.do")
	@ResponseBody
	public Map<String,Object> menuInfo(HttpServletRequest request, @RequestParam Map<String,Object> commandMap) {
		//로그인 시 session에 저장한 사용자 권한 값을 가져와서
		HttpSession session = request.getSession();
	
		int userRole = (int) session.getAttribute("mbr_type");
		
		commandMap.put("userRole", userRole);
		//유저권한과 메뉴접근 권한을 비교해 메뉴 list 조회
		
		Map<String,Object> menuInfo = mService.getMenuInfo(commandMap);
		
		return menuInfo;
	}
	
	/*
	 *	@ 메뉴 단건 조회
	 *	@ param : commandMap 
	 *		- mu_seq: 메뉴 PK  
	 * 	@ return : map 
	 * 		- map : mu_seq가 일치하는 메뉴의 정보 
	 */
	@RequestMapping("muDetailInfo.do")
	@ResponseBody
	public Map<String,Object> muDetailInfo(@RequestParam Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.muDetailInfo(commandMap);
		
		return result;	
	}
	/*
	 * @ 메뉴 IUD
	 * @ param : commandMap 
	 * 		- IUD : 등록(I), 수정(U), 삭제(D) 구분하기 위한 string 
	 * 		- menuList.jsp에서 form(id = mu-frm) 내 정보
	 * @return : map
	 * 		- String msg : 각각 로직 처리 후 처리 결과 구분하기 위한 값
	 */
	@RequestMapping("menuIUD.do")
	@ResponseBody
	public Map<String,Object> menuIUD(@RequestParam Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.menuIUD(commandMap);
		
		return result;	
	}

		
		
}
