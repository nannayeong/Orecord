package com.kosmo.orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import impl.MemberImpl;
 
@Controller
public class NickCheckController{
	
	@Autowired
	private SqlSession sqlSession;
	
	/*중복체크*/
	@RequestMapping("/member/nickChk.do")
	public String nickChk(Model model, HttpServletRequest req, Principal principal) {
		
		//전송된 값을 가져와 변수에 저장한다.
		
		String nick = req.getParameter("nickname");
		
		int jungbokNick = sqlSession.getMapper(MemberImpl.class).nickChk(nick);
		
		model.addAttribute("nick", nick);
		model.addAttribute("jungbokNick", jungbokNick);
		
		//eq.setAttribute("id", id);
		//req.setAttribute("jungbokId", jungbokId);
		
		return "member/nickChkPupup";
	}
}
