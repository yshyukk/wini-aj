package egovframework.aj.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

import egovframework.aj.menu.service.MenuService;

public class MenuInterceptor extends WebContentInterceptor{

	@Autowired
	MenuService mService;
	
	
	/*
	 * @ post : response전 응답을 가로채서 처리
	 * @ session에 저장된 user권한을 비교해서 service로직 처리 후 결과값 처리
	 * @ 인터셉터를 거칠 경로 설정 : dispatcher - servlet
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		
		  HttpSession session = request.getSession();
		  
		  //로그인 시 session에 저장한 사용자 권한 값을 가져와서 int userRole = (int)
		  int userRole = (int) session.getAttribute("mbr_type");

		  HashMap<String,Object> commandMap = new HashMap<>();
		  
		  commandMap.put("userRole", userRole);
		  
		  System.out.println("post:::"+commandMap.get("userRole"));
		 
		  Map<String,Object> menuInfo = mService.getMenuInfo(commandMap);
		  
		  modelAndView.addObject("menuInfo", menuInfo); //
			/*
			 * modelAndView.addObject("menuList", menuList); //
			 * modelAndView.addObject("userRole", userRole);
			 */
		  
		 // response.sendRedirect("/mainPage.do"); // 만약에 GetOutputStram() 어저구 오류가 나면
		 // Interceptor 건드릴것
		 	}
	
}
