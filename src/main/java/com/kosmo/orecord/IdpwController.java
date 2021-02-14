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
	
	//아이디찾기
	@RequestMapping("/member/idSearch.do")
	public String idSearch(Model model, Principal principal, HttpServletRequest req){
		
		
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email1");
		
		MemberDTO idSearch = sqlSession.getMapper(IdPwSearchImpl.class).idSearch(nickname, email);
		System.out.println("아디:"+idSearch);
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("email", email);
		
		model.addAttribute("idSearch", idSearch);
		
		return "member/id_pw";
	}
	
	//비밀번호 찾기
	@RequestMapping("/member/pwSearch.do")
	public String pwSearch(Model model, Principal principal, HttpServletRequest req){
		
		
		String nickname = req.getParameter("nickname1");
		String email = req.getParameter("email2");
		String id = req.getParameter("id");
		
		MemberDTO pwSearch = sqlSession.getMapper(IdPwSearchImpl.class).pwSearch(nickname, id, email);
		System.out.println("비번:"+pwSearch);
		
		model.addAttribute("nickname1", nickname);
		model.addAttribute("email2", email);
		model.addAttribute("id", id);
		
		model.addAttribute("pwSearch", pwSearch);
		
		return "member/id_pw";
	}
}
