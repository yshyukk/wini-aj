package egovframework.user.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.user.service.MbrService;
import egovframework.user.vo.MbrVO;

@Controller
public class MbrController {
	
	@Resource(name = "MbrService")
	private MbrService mbrService;
	
	// 로그인 페이지
	@RequestMapping(value = "/login.do") 
	public String login() throws Exception {

		return "user/MbrLogin"; 
	}
	
	// 로그인
	@RequestMapping(value = "/mbrLogin.do", method = RequestMethod.POST)
	@ResponseBody
	public MbrVO mbrLogin(MbrVO mbrVO, HttpSession session) throws Exception {
		
		int mbr_sn = mbrService.mbrLogin(mbrVO).getMbr_sn(); // 로그인 된 회원 번호
		int mbr_type = mbrService.mbrLogin(mbrVO).getMbr_type(); // 로그인 된 회원 구분
		
		// 세션에 회원 번호, 회원 구분 저장
		session.setAttribute("mbr_sn", mbr_sn);
		session.setAttribute("mbr_type", mbr_type);

		return mbrService.mbrLogin(mbrVO); 
	}
	
	// 회원가입 페이지
	@RequestMapping(value = "/join.do") 
	public String join() throws Exception {

		return "user/MbrJoin"; 
	}
	
	// 회원가입
	@RequestMapping(value = "/mbrJoin.do", method = RequestMethod.POST)
	@ResponseBody
	public void mbrInsert(MbrVO mbrVO) throws Exception {
		
		mbrService.mbrInsert(mbrVO);
	}
}
