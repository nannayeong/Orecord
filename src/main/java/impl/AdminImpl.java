package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface AdminImpl {

	//어드민 로그인
	public MemberDTO login(String id, String pw);
}
