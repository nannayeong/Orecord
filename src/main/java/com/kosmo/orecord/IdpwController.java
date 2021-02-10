package com.kosmo.orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import impl.IdPwSearchImpl;
import model.MemberDTO;

@Controller
public class IdpwController {
	
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/member/id_pwSearch.do")
	public String idpwSearch(Model model, Principal principal, HttpServletRequest req){
		
		
		return "member/id_pw";
	}
	
	@RequestMapping("/member/idSearch.do")
	public String idSearch(Model model, Principal principal, HttpServletRequest req){
		
		
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email");
		
		MemberDTO idSearch = sqlSession.getMapper(IdPwSearchImpl.class).idSearch(nickname, email);
		System.out.println("아디찾기성공:"+idSearch);
		
		model.addAttribute("idSearch", idSearch);
		
		return "member/id_pw";
	}
}
