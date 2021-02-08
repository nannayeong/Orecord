package com.kosmo.orecord;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import impl.ReportImpl;
import model.MemberDTO;
import model.ReportDTO;



@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
	
	//글쓰기 페이지 : session영역을사용하기 위해 HttpSession을 매개변수로 기술함.
	@RequestMapping("/report/write.do")
	public String write(Model model, Principal principal, HttpServletRequest req)
	{
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return "report/write";
	}
	
	//신고글쓰기
	@RequestMapping(value="/report/writeAction.do", method=RequestMethod.POST)
	public String writeAction(Model model,HttpServletRequest req, Principal principal)
	{
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String s_id = principal.getName();
		String r_id = req.getParameter("r_id");
		String kind = req.getParameter("kind");
		String reason = req.getParameter("reason");
		
		//Mybatis 사용
		sqlSession.getMapper(ReportImpl.class).ReportInfo(s_id, r_id, kind, reason);
		
		return "redirect:list.do";
	}
	
	//수정페이지
	@RequestMapping("/mybatis/modify.do")
	public String modify(Model model, HttpServletRequest req,
			HttpSession session)
	{
		if(session.getAttribute("siteUserInfo")==null) {
			//수정페이지 진입전 로그인 확인
			return "redirect:login.do";
		}
		
		//Mapper쪽으로 전달할 파ㅏ미터를 저장할 용도의 DTO객체 생성
		ParameterDTO parameterDTO = new ParameterDTO();
		parameterDTO.setBoard_idx(req.getParameter("idx"));//일련번호
		parameterDTO.setUser_id(
			((MemberDTO)session.getAttribute("siteUserInfo")).getId());
		
		//Mapper호출시 DTO객체를 파라미터로 전달
		MyBoardDTO dto =
		sqlSession.getMapper(MybatisDAOImpl.class).view(parameterDTO);
		
		model.addAttribute("dto", dto);
		return "07Mybatis/modify"; 
	}
	//수정처리
	@RequestMapping("/report/modifyAction.do")
	public String modifyAction(HttpSession session, MyBoardDTO myBoardDTO)
	{
		
		//수정처리 전 로그인 확인
		if(session.getAttribute("siteUserInfo")==null)
		{
			
			//modela.addAttribute("backYrl", "07Mybatis/modify");
			return "redirect:login.do";
		}
		
		sqlSession.getMapper(MybatisDAOImpl.class).modify(myBoardDTO);
		
		return "redirect:list.do";
	}
	
	@RequestMapping("/report/delete.do")
	public String delete(HttpServletRequest req, HttpSession session) {
		
		//로그인확인
		if(session.getAttribute("siteUserInfo")==null) {
			return "redirect:login.do";
		}
		
		//Mybatis 사용
		sqlSession.getMapper(MybatisDAOImpl.class).delete(
			req.getParameter("idx"),
			((MemberVO)session.getAttribute("siteUserInfo")).getId());
		
		return "redirect:list.do";
	}
}
