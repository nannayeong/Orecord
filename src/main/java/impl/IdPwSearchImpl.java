package impl;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface IdPwSearchImpl {
	
	
	//아이디찾기
	public MemberDTO idSearch(@Param("nickname") String nickname, @Param("email") String email);
	
	//비밀번호찾기
	public MemberDTO pwSearch(@Param("nickname") String nickname, @Param("id") String id, @Param("email") String email);
	
}
