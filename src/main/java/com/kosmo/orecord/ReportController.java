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
		
		String s_id = principal.getName();
		
		ArrayList<ReportDTO> report = sqlSession.getMapper(ReportImpl.class).listView(s_id);
		
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
		
		ReportDTO ret = sqlSession.getMapper(ReportImpl.class).View(principal.getName());
		model.addAttribute("ret", ret);
		
		return "report/reportwrite";
	}
	
	//신고글쓰기
	@RequestMapping("/report/writeAction.do")
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
		else {
			System.out.println("신고글쓰기실패");	
		}
		
		return "redirect:/report/reportlist.do";
	}
	
	//수정페이지
	@RequestMapping("/report/reportModify.do")
	public String modify(Model model, HttpServletRequest req, Principal principal)
	{
		ReportDTO reportDTO = new ReportDTO();
		String r_idx = req.getParameter("r_idx");
		
		System.out.println("idx"+r_idx);
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		ReportDTO rpView = sqlSession.getMapper(ReportImpl.class).rpView(Integer.parseInt(r_idx));
		model.addAttribute("r_idx", r_idx);
		model.addAttribute("rpView", rpView);
		
		return "report/reportModify"; 
	}
	
	
	//수정처리
	@RequestMapping(value = "/report/modifyAction.do", method = RequestMethod.POST)
	public String modifyAction(Model model , Principal principal, HttpServletRequest req)
	{
		
		ReportDTO reportDTO = new ReportDTO();
		String r_idx = req.getParameter("r_idx");
		
		System.out.println("r_idx"+r_idx);
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
			
			String r_id = req.getParameter("r_id");
			String kind = req.getParameter("kind");
			String reason = req.getParameter("reason");
			String s_id = principal.getName();
			
			int reportModify = sqlSession.getMapper(ReportImpl.class).ReportModify(kind, reason, r_id, Integer.parseInt(r_idx));
			System.out.println("입력결과:"+reportModify);
			
			if(reportModify==1) {
				System.out.println("수정완료");			
			}
		}
		catch (NumberFormatException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		 
		return "redirect:/report/reportlist.do";
		
	}
	
	/* 신고글 삭제하기 */
	@RequestMapping("/report/deleteAction.do")
	public String deleteAction(Model model, HttpServletRequest req, Principal principal, ReportDTO reportDTO) {
		
		String id = null;
		
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		String s_id = principal.getName();
		
		int rp = sqlSession.getMapper(ReportImpl.class).ReportDelete(s_id,
				Integer.parseInt(req.getParameter("r_idx")));
		System.out.println("삭제완료:"+rp);
//		model.addAttribute("rp", rp);

//		int r_idx = rp.getR_idx();
		//int r_idx = reportDTO.getR_idx();
		
		//int delete = sqlSession.getMapper(ReportImpl.class).ReportDelete(r_idx);
		
//		if(delete==1) {
//			System.out.println("삭제완료..!");
//		}
//		else {
//			System.out.println("신고삭제실패");
//		}
		
		
		return "redirect:/report/reportlist.do";
	}
}
