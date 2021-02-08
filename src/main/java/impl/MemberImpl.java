package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface MemberImpl {
	
	public MemberDTO memberInfo(String id);
	
	//회원가입
	public int membershipInfo(String id, String pw, String nickname, String email, String phone, String address, String intro, String img);
	
	//아이디 중복체크 
	public int idChk(String id);
	 
	//닉네임 중복체크
	public int nickChk(String nickName);
}

