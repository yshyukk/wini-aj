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
	
	@Resource(name="menuService")
	private MenuService mService;
	
	@RequestMapping(value = "/menuNav.do")
	public String menuNav() {
	
		return "/menu/menuNav";
	}
	
	@RequestMapping(value = "/menuList.do")
	public String menuList() {
		return "menu/menuList.tiles";
	}
	
	@RequestMapping(value="/menuInfo.do")
	@ResponseBody
	public Map<String,Object> menuInfo(HttpServletRequest request, Map<String,Object> commandMap) {
		//로그인 시 session에 저장한 사용자 권한 값을 가져와서
		HttpSession session = request.getSession();
	
		int userRole = (int) session.getAttribute("mbr_type");
		
		commandMap.put("userRole", userRole);
	
		Map<String,Object> menuInfo = mService.getMenuInfo(commandMap);
		
		return menuInfo;
	}
	
	
	@RequestMapping("muDetailInfo.do")
	@ResponseBody
	public Map<String,Object> muDetailInfo(@RequestParam Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.muDetailInfo(commandMap);
		
		return result;	
	}
	/*
	 * @ 메뉴 IUD 
	 */
	@RequestMapping("menuIUD.do")
	@ResponseBody
	public Map<String,Object> menuIUD(@RequestParam Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.menuIUD(commandMap);
		
		return result;	
	}

		
		
}
