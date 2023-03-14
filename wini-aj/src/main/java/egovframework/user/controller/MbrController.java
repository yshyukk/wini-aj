package egovframework.user.controller;

import java.util.List;

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
		
		// 세션에 회원 번호, 권한 저장
		session.setAttribute("mbr_sn", mbrService.mbrLogin(mbrVO).getMbr_sn());
		session.setAttribute("mbr_type", mbrService.mbrLogin(mbrVO).getMbr_type());

		return mbrService.mbrLogin(mbrVO); 
	}
	
	// 로그아웃
	@RequestMapping(value = "/mbrLogout.do")
	public String mbrLogout(HttpSession session) throws Exception {
		
		session.invalidate(); // 세션 전체 초기화

		return "user/MbrLogin"; 
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
	
	// 회원가입 - 아이디 중복체크
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(MbrVO mbrVO) throws Exception {
		
		return mbrService.idCheck(mbrVO);
	}
	
	// 마이페이지
	@RequestMapping(value = "/myPage.do") 
	public String myPage() throws Exception {

		return "user/MbrPage.tiles"; 
	}
	
	// 마이페이지 - 회원 조회
	@RequestMapping(value = "/mbrPage.do", method = RequestMethod.POST)
	@ResponseBody
	public MbrVO mbrPage(HttpSession session) throws Exception {
		
		int mbr_sn = (int) session.getAttribute("mbr_sn"); // 세션에 저장되어 있는 회원 번호

		return mbrService.mbrPage(mbr_sn); 
	}
	
	// 마이페이지 - 회원 수정
	@RequestMapping(value = "/mbrUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public void mbrUpdate(MbrVO mbrVO, HttpSession session) throws Exception {

		int mbr_sn = (int) session.getAttribute("mbr_sn"); // 세션에 저장되어 있는 회원 번호
		mbrVO.setMbr_sn(mbr_sn);
		
		mbrService.mbrUpdate(mbrVO);
	}
	
	// 마이페이지 - 회원 탈퇴
	@RequestMapping(value = "/mbrDelete.do")
	public String mbrDelete(MbrVO mbrVO, HttpSession session) throws Exception {

		int mbr_sn = (int) session.getAttribute("mbr_sn"); // 세션에 저장되어 있는 회원 번호
		mbrVO.setMbr_sn(mbr_sn);
		
		mbrService.mbrDelete(mbrVO);
		
		return "user/MbrLogin";
	}
	
	// 사용자 권한 관리 페이지
	@RequestMapping(value = "/mbrAuthority.do") 
	public String mbrAuthority() throws Exception {

		return "user/MbrAuthority.tiles"; 
	}
	
	// 사용자 권한 관리 페이지 - 회원 리스트 출력
	@RequestMapping(value ="/mbrList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<MbrVO> mbrList(MbrVO mbrVO) throws Exception {
	
		return mbrService.mbrList(mbrVO); 
	}
	
	// 사용자 권한 관리 페이지 - 권한 변경
	@RequestMapping(value = "/mbrAuthorityUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public void mbrAuthorityUpdate(MbrVO mbrVO, HttpSession session) throws Exception {
		
		mbrService.mbrAuthorityUpdate(mbrVO);
	}
	
	// 사용자 권한 관리 페이지 - 회원가입 승인 대기 리스트 출력
	@RequestMapping(value ="/mbrWaitList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<MbrVO> mbrWaitList(MbrVO mbrVO) throws Exception {
	
		return mbrService.mbrWaitList(mbrVO); 
	}
	
	// 사용자 권한 관리 페이지 - 회원가입 승인
	@RequestMapping(value = "/mbrWait.do", method = RequestMethod.POST)
	@ResponseBody
	public void mbrWait(MbrVO mbrVO, HttpSession session) throws Exception {

		mbrService.mbrWait(mbrVO);
	}
}
