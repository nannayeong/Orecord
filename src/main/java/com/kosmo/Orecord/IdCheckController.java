package com.kosmo.Orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import impl.MemberImpl;
 
@Controller 
public class IdCheckController{
	
	@Autowired
	private SqlSession sqlSession;
	
	/*중복체크*/
	@RequestMapping("/member/idChk.do")
	public String idChk(Model model, HttpServletRequest req, Principal principal) {
		
		//전송된 값을 가져와 변수에 저장한다.
		
		String id = req.getParameter("id");
		
		int jungbokId = sqlSession.getMapper(MemberImpl.class).idChk(id);
		
		model.addAttribute("id", id);
		model.addAttribute("jungbokId", jungbokId);
		
		//eq.setAttribute("id", id);
		//req.setAttribute("jungbokId", jungbokId);
		
		return "member/idChkPupup";
	}
}
