package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface IdPwSearchImpl {
	
	//아이디찾기
	public MemberDTO idSearch(String nickname, String email);
	
}
