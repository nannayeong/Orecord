package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface MypageImpl {
	
	//회원정보조회
	public MemberDTO memberView(String id); 
	 
	//회원 삭제
	public int memberDelete(String id);
	
	//회원정보 수정
	public int memberEdit(String pw, String email, String phone, String address, String intro, String img, String id);
}


