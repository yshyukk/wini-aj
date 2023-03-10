package egovframework.user.service;

import javax.annotation.Resource;
import javax.inject.Inject;

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
		
		if(passwordEncoder.matches(mbrVO.getPassword(), vo.getPassword())) {
			System.out.println("비밀번호 일치");
			
			vo.setPassword(mbrVO.getPassword());
			
			return vo;
		}else {
			
			vo = null;
			
			return vo;
		}
	}
	
	// 회원가입
	@Override
	public void mbrInsert(MbrVO mbrVO) throws Exception {
		
		String encPassword = passwordEncoder.encode(mbrVO.getPassword());
		mbrVO.setPassword(encPassword);
		
		mbrDAO.insert("user.mbrInsert", mbrVO);
	}
}
