package egovframework.user.service;

import java.util.List;

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
		
		// 비밀번호 확인
		if(passwordEncoder.matches(mbrVO.getPassword(), vo.getPassword())) {
			return vo;
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

	// 회원가입 - 아이디 중복체크
	@Override
	public int idCheck(MbrVO mbrVO) throws Exception {

		return (int) mbrDAO.select("user.idCheck", mbrVO);
	}

	// 마이페이지 - 회원 조회
	@Override
	public MbrVO mbrPage(int mbr_sn) throws Exception {

		return (MbrVO) mbrDAO.select("user.mbrPage", mbr_sn);
	}
	
	// 마이페이지 - 회원 수정
	@Override
	public void mbrUpdate(MbrVO mbrVO) throws Exception {
		mbrDAO.update("user.mbrUpdate", mbrVO);
	}
	
	// 마이페이지 - 회원 탈퇴
	@Override
	public void mbrDelete(MbrVO mbrVO) throws Exception {
		mbrDAO.update("user.mbrDelete", mbrVO);
	}

	// 사용자 권한 관리 페이지 - 회원 리스트
	@Override
	public List<MbrVO> mbrList(MbrVO mbrVO) throws Exception {
		
		List mbrList = mbrDAO.list("user.mbrList", mbrVO);
		
		return mbrList;
	}

	// 사용자 권한 관리 페이지 - 회원 권한 변경
	@Override
	public void mbrAuthorityUpdate(MbrVO mbrVO) throws Exception {
		mbrDAO.update("user.mbrAuthorityUpdate", mbrVO);	
	}
	
	// 사용자 권한 관리 페이지 - 회원 탈퇴
	@Override
	public void adminDelete(MbrVO mbrVO) throws Exception {
		mbrDAO.update("user.adminDelete", mbrVO);	
	}
	
	// 사용자 권한 관리 페이지 - 회원가입 승인 대기 리스트
	@Override
	public List<MbrVO> mbrWaitList(MbrVO mbrVO) throws Exception {
		
		List mbrWaitList = mbrDAO.list("user.mbrWaitList", mbrVO);
		
		return mbrWaitList;
	}
	
	// 사용자 권한 관리 페이지 - 회원가입 승인
	@Override
	public void mbrPermission(MbrVO mbrVO) throws Exception {
		mbrDAO.update("user.mbrPermission", mbrVO);	
	}
	
	// 사용자 권한 관리 페이지 - 회원가입 거부
	@Override
	public void mbrRefusal(MbrVO mbrVO) throws Exception {
		mbrDAO.delete("user.mbrRefusal", mbrVO);	
	}
}