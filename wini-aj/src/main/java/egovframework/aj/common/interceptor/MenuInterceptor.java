package egovframework.aj.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

import com.fasterxml.jackson.databind.ObjectMapper;

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
		  
		  System.out.println("POST!!!!RUN!!!!");
		  HashMap<String,Object> commandMap = new HashMap<>();
		  
		  commandMap.put("userRole", userRole);
		  
		  Map<String,Object> menuInfo = mService.getMenuInfo(commandMap);
		  
		  /*
		   * objectMapper
		   *  : JSON <-> java Object 해주는 Jackson 라이브러리의 클래스 
		   */
		  ObjectMapper objMapper = new ObjectMapper();
		  // map을 jsson으로 parsing해서
		  String jsonResult = objMapper.writeValueAsString(menuInfo);
		  //ajax로 결과를 보낼때 contentType과 그려줄 String을 매핑해서 보내줌

		  response.setContentType("application/json;charset=UTF-8");
		  
		  response.getWriter().write(jsonResult);
		  
 	}
	
}
