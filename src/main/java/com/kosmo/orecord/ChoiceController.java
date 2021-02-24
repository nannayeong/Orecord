package com.kosmo.orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import impl.ChoiceImpl;
import impl.PointImpl;
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
	public String choiceAction(Model model, HttpServletRequest req, Principal principal,
			HttpSession session) {
		
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
		
		MemberDTO mdto = (MemberDTO)session.getAttribute("user");
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(id);
		mdto.setMypoint(memberDTO.getMypoint());
		session.setAttribute("user", mdto);
		
		model.addAttribute("audio_idx", idx);
		
		
		/* return "/orecord/board/SendMessage.do?="+idx+"&r_id="+id; */
		/* return "redirect:partyList.do?audio_idx="+idx; */
		//return "redirect:partyView.do?party_idx="+party_idx;
		return "redirect:SendMessage.do?r_id="+id; 
	}
	
	//웹소켓 + 웹노티 보내기
	@RequestMapping(value="/board/SendMessage.do", method=RequestMethod.GET)
	public String webMessage(HttpSession session, Principal principal,
			HttpServletRequest req, Model model) {
		
		int idx = Integer.parseInt(req.getParameter("audio_idx"));
		String s_id = req.getParameter("s_id");
		System.out.println("s_id="+s_id);
		String r_id = req.getParameter("r_id");
		String msg = req.getParameter("msg");
		model.addAttribute("audio_idx", idx);
		model.addAttribute("r_id", r_id);
		
		session.setAttribute("chat_room", "myRoom1");
		//본인이 사용할 아이디 입력
		session.setAttribute("chat_id", s_id);
		
		//알림테이블에 추가
//		int result = sqlSession.getMapper(ChoiceImpl.class).notification(s_id, r_id, msg);
//		System.out.println("알림테이블추가="+result);
		
		return "board/SendMessage";
	}
}
