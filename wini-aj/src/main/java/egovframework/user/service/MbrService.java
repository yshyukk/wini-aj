package egovframework.user.service;

import egovframework.user.vo.MbrVO;

public interface MbrService {
	
	// 로그인
	public MbrVO mbrLogin(MbrVO mbrVO) throws Exception;
	
	// 회원가입
	public void mbrInsert(MbrVO mbrVO) throws Exception;

}
