package egovframework.aj.main.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AjmainController {

	@RequestMapping(value = "/main.do")
	public String menuList(HttpSession session, HttpServletRequest request) {
		
		// 세선에 저장된 회원 번호, 회원 구분 값 가져오기
//		session = request.getSession(false);
		int mbr_sn = (int) session.getAttribute("mbr_sn");
		int mbr_type = (int) session.getAttribute("mbr_type");
//		session.setMaxInactiveInterval(10);
	
		return "menu/main.tiles";
	}
}
