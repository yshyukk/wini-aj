package egovframework.aj.menu.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
		return "/menu/menuList";
	}
	
	@RequestMapping(value="/menuInfo.do")
	@ResponseBody
	public Map<String,Object> menuInfo(Map<String,Object> commandMap) {
		Map<String,Object> menuInfo = mService.getMenuInfo(commandMap);
		return menuInfo;
	}
	
	
	@RequestMapping("muDetailInfo.do")
	@ResponseBody
	public Map<String,Object> muDetailInfo(@RequestParam Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.muDetailInfo(commandMap);
		
		return result;	
	}
	
	@RequestMapping("menuIUD.do")
	@ResponseBody
	public Map<String,Object> menuIUD(Map<String,Object> commandMap) {		
		
		Map<String,Object> result = mService.menuIUD(commandMap);
		
		return result;	
	}

		
		
}
