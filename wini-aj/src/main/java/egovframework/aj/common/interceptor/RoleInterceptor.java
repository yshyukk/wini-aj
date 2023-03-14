package egovframework.aj.common.interceptor;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

import egovframework.aj.menu.service.MenuService;

/*
 * @pre : controller에 가기 전 request를 가로채 처리
 * @request에서 메뉴권한과 user권한을 비교해서 권한이 없으면 권한처리하는 요청으로 sendRedirect
 */
public class RoleInterceptor extends WebContentInterceptor{
	
	/*
	 * @Autowired MenuService mService;
	 * 
	 * @Override public boolean preHandle(HttpServletRequest request,
	 * HttpServletResponse response, Object handler) throws ServletException {
	 * System.out.println("preRun");
	 * 
	 * try { request.setCharacterEncoding("UTF-8"); } catch
	 * (UnsupportedEncodingException e) { e.printStackTrace(); }
	 * 
	 * HttpSession session = request.getSession();
	 * 
	 * int userRole = (int) session.getAttribute("mbr_type");
	 * 
	 * if(userRole < 3) { System.out.println("run"); return true; }else { try {
	 * response.sendRedirect("/main.do"); } catch (IOException e) {
	 * e.printStackTrace(); } return false;
	 * 
	 * } }
	 */
//	@Autowired
//	UserService userService;
//	
//	@Autowired
//	MenuService menuService;
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws ServletException {
//		
//		try {
//			request.setCharacterEncoding("UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		int params = Integer.parseInt(request.getParameter("menuId"));
//		String aParam = request.getParameter("accessRole");
//    	System.out.println("preRun");
//
//		HttpSession session = request.getSession(false);
//		
//		Integer userId =  (Integer) session.getAttribute("userId");
//
//		int userRole = 0;
//		if(userId == null) {
//			userRole =4;
//		} else {
//			userRole = userService.getUserRole(userId);
//		}	
//		
//		MenuVO menuVo = new MenuVO();
//		menuVo.setMenuId(params);		
//		
//		int menuAccess = menuService.getUserAuth(menuVo);
//		
//		if(menuAccess >= userRole) {
//			return true;
//		} else {
//			try {
//				response.sendRedirect("/mainPage.do");
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			return false;
//		}		
//	}
//	
}
