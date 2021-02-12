package com.kosmo.orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import impl.ChoiceImpl;
import model.MemberDTO;

@Controller
public class ChoiceController {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//채택하기
	@RequestMapping(value="/board/choiceAction.do",method=RequestMethod.POST)
	public String choiceAction(Model model, HttpServletRequest req, Principal principal) {
		
		int idx = Integer.parseInt(req.getParameter("audio_idx"));
		String name = principal.getName();
		System.out.println("본인 아이디:"+ name);
		String id = req.getParameter("id");
		System.out.println("상대방 아이디:"+ id);
		int point = Integer.parseInt(req.getParameter("point"));
		System.out.println("요구포인트:"+point);
		int party_idx = Integer.parseInt(req.getParameter("party_idx"));
		
		//채택하는 사람의 포인트 차감을 위한 매퍼 호출
		int result1 = sqlSession.getMapper(ChoiceImpl.class).choiceAction1(
				point, name);
		System.out.println("입력결과:"+ result1);
		
		//채택받는 사람의 포인트 추가를 위한 매퍼 호출
		int result2 = sqlSession.getMapper(ChoiceImpl.class).choiceAction2(
				point, id);
		System.out.println("입력결과:"+ result2);
		
		//채택받은 사람의 게시글 choice값 1로 변경
		int result3 = sqlSession.getMapper(ChoiceImpl.class).choiceAction3(
				id, party_idx);
		System.out.println("입력결과:"+ result3);
		
		//내가 가진 포인트가 요구포인트보다 낮을때
		//나의 포인트를 조회한다.
		MemberDTO myPoint =
				sqlSession.getMapper(ChoiceImpl.class).myPoint(
					name);
		model.addAttribute("myPoint", myPoint);
		
		return "redirect:partyList.do?audio_idx="+idx;
	}
}
