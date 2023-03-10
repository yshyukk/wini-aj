package egovframework.user.vo;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;

public class MbrVO {

	private int mbr_sn;
	private String mbr_id;
	private String password;
	private String mbr_nm;
	private String mbr_pos;
	private String mbr_gen;
	private String mbr_tel;
	private String mbr_email;
	
	public int getMbr_sn() {
		return mbr_sn;
	}
	public void setMbr_sn(int mbr_sn) {
		this.mbr_sn = mbr_sn;
	}
	public String getMbr_id() {
		return mbr_id;
	}
	public void setMbr_id(String mbr_id) {
		this.mbr_id = mbr_id;
	}
	public String getPassword() {
		
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMbr_nm() {
		return mbr_nm;
	}
	public void setMbr_nm(String mbr_nm) {
		this.mbr_nm = mbr_nm;
	}
	public String getMbr_pos() {
		return mbr_pos;
	}
	public void setMbr_pos(String mbr_pos) {
		this.mbr_pos = mbr_pos;
	}
	public String getMbr_gen() {
		return mbr_gen;
	}
	public void setMbr_gen(String mbr_gen) {
		this.mbr_gen = mbr_gen;
	}
	public String getMbr_tel() {
		return mbr_tel;
	}
	public void setMbr_tel(String mbr_tel) {
		this.mbr_tel = mbr_tel;
	}
	public String getMbr_email() {
		return mbr_email;
	}
	public void setMbr_email(String mbr_email) {
		this.mbr_email = mbr_email;
	}
}
