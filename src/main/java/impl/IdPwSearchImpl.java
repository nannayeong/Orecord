package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface IdPwSearchImpl {
	
	
	//아이디찾기
	public MemberDTO idSearch(String nickname, String email);
	
	//비밀번호찾기
	public MemberDTO pwSearch(String nickname, String id, String email);
	
}
