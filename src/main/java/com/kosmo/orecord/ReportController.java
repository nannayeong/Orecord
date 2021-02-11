package com.kosmo.orecord;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import impl.ReportImpl;
import model.ReportDTO;



@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/report/reportlist.do")
	public String reportList(Model model, Principal principal, ReportDTO reportDTO) {
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		ArrayList<ReportDTO> report = sqlSession.getMapper(ReportImpl.class).listView(reportDTO);
		//ReportDTO report = sqlSession.getMapper(ReportImpl.class).reportView();
		
		model.addAttribute("report", report);
		
		return "report/reportlist";
	}
	
	//글쓰기 페이지 
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
		
		return "report/reportwrite";
	}
	
	//신고글쓰기
	@RequestMapping(value = "/report/writeAction.do", method = RequestMethod.POST)
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
		System.out.println(s_id+ r_id+ kind+ reason);
		
		
		//Mybatis 사용
		int ReportInfo = sqlSession.getMapper(ReportImpl.class).ReportInfo(s_id, r_id, kind, reason);
		model.addAttribute("ReportInfo", ReportInfo);
		
		if(ReportInfo==1) {
			System.out.println("신고글쓰기성공");			
		}
		
		return "report/reportlist";
	}
	
	//수정페이지
	@RequestMapping("/report/reportModify.do")
	public String modify(Model model, HttpServletRequest req, Principal principal)
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
		
		ReportDTO rpView = sqlSession.getMapper(ReportImpl.class).rpView(s_id);
		model.addAttribute("rpView", rpView);
		
		return "report/reportModify"; 
	}
	
	
	//수정처리
	@RequestMapping(value = "/report/modifyAction.do", method = RequestMethod.POST)
	public String modifyAction(Model model , Principal principal, HttpServletRequest req)
	{
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String r_id = req.getParameter("r_id");
		String kind = req.getParameter("kind");
		String reason = req.getParameter("reason");
		String s_id = principal.getName();
		
		ReportDTO rpView = sqlSession.getMapper(ReportImpl.class).rpView(s_id);
		model.addAttribute("rpView", rpView);
		
		int r_idx = rpView.getR_idx();
		
		int reportModify = sqlSession.getMapper(ReportImpl.class).ReportModify(r_id, kind, reason, r_idx);
		
		if(reportModify==1) {
			System.out.println("수정완료");			
		}
		
		return "report/reportlist";
		
	}
	
//	@RequestMapping("/report/delete.do")
//	public String delete(HttpServletRequest req, HttpSession session) {
//		
//		//로그인확인
//		if(session.getAttribute("siteUserInfo")==null) {
//			return "redirect:login.do";
//		}
//		
//		//Mybatis 사용
//		sqlSession.getMapper(MybatisDAOImpl.class).delete(
//			req.getParameter("idx"),
//			((MemberVO)session.getAttribute("siteUserInfo")).getId());
//		
//		return "redirect:list.do";
//	}
}
