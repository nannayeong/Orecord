package impl;

import org.springframework.stereotype.Service;

import model.MemberDTO;

@Service
public interface ChoiceImpl {
	
	//채택하는 사람의 포인트 차감
	public int choiceAction1(int point, String id);
	
	//채택받는 사람의 포인트 추가
	public int choiceAction2(int point, String id);
	
	//채택받은 사람의 게시글 choice값 1로 변경
	public int choiceAction3(String id, int choice);
	
	public int notification(String s_id, String r_id, String msg);
}
