package com.kosmo.Orecord;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller 
public class DonateController {
	@Autowired
	private SqlSession sqlSession;

	/* 프레임 메인 */
	@RequestMapping("/donate.do")
	public String donate(Model model, HttpServletRequest req,
			HttpSession session, Principal principal) {
		return "main/donate";
		
	}
}
