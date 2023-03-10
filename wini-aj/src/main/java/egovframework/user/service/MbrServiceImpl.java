package egovframework.user.service;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.user.vo.MbrVO;

@Service("MbrService")
public class MbrServiceImpl implements MbrService{
	
	@Resource(name="MbrDAO")
	private MbrDAO mbrDAO;

	@Inject
	PasswordEncoder passwordEncoder;
	
	// 로그인
	@Override
	public MbrVO mbrLogin(MbrVO mbrVO) throws Exception {
		MbrVO vo = (MbrVO) mbrDAO.select("user.mbrLogin", mbrVO);
		
		// 비밀번호가 일치하면 vo 반환
		if(passwordEncoder.matches(mbrVO.getPassword(), vo.getPassword())) {
			return vo;
		// 비밀번호가 일치하지 않으면 null 반환
		}else {
			vo = null;
			return vo;
		}
	}
	
	// 회원가입
	@Override
	public void mbrInsert(MbrVO mbrVO) throws Exception {
		
		// 비밀번호 암호화
		String encPassword = passwordEncoder.encode(mbrVO.getPassword());
		mbrVO.setPassword(encPassword);
		
		mbrDAO.insert("user.mbrInsert", mbrVO);
	}
}
