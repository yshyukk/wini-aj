package egovframework.user.service;

import java.util.List;

import egovframework.user.vo.MbrVO;

public interface MbrService {
	
	// 로그인
	public MbrVO mbrLogin(MbrVO mbrVO) throws Exception;
	
	// 회원가입
	public void mbrInsert(MbrVO mbrVO) throws Exception;
	
	// 회원가입 - 아이디 중복체크
	public int idCheck(MbrVO mbrVO) throws Exception;
	
	// 마이페이지 - 회원 조회
	public MbrVO mbrPage(int mbr_sn) throws Exception;
	
	// 마이페이지 - 회원 수정
	public void mbrUpdate(MbrVO mbrVO) throws Exception;
	
	// 마이페이지 - 회원 탈퇴
	public void mbrDelete(MbrVO mbrVO) throws Exception;
	
	// 사용자 권한 관리 페이지 - 회원 리스트 출력
	public List<MbrVO> mbrList(MbrVO mbrVO) throws Exception;
	
	// 사용자 권한 관리 페이지 - 회원 권한 변경
	public void mbrAuthorityUpdate(MbrVO mbrVO) throws Exception;
	
	// 사용자 권한 관리 페이지 - 회원가입 승인 대기 리스트 출력
	public List<MbrVO> mbrWaitList(MbrVO mbrVO) throws Exception;
	
	// 사용자 권한 관리 페이지 - 회원가입 승인
	public void mbrPermission(MbrVO mbrVO) throws Exception;
	
	// 사용자 권한 관리 페이지 - 회원가입 거부
	public void mbrRefusal(MbrVO mbrVO) throws Exception;
}
