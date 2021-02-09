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

import impl.ViewImpl;
import model.AudioBoardDTO;
import model.MCommentDTO;

@Controller
public class ViewController {
	
	@Autowired
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//상세보기 페이지
	@RequestMapping("/board/view.do")
	public String View(Model model, HttpServletRequest req, Principal principal) {
		
		//idx값이 넘어오는지 확인
		String idx = req.getParameter("audio_idx");
		System.out.println("audio_idx = "+ idx);
		
		/*절대경로*/
		String path = req.getContextPath();
		
		//Mapper 호출
		AudioBoardDTO view =
			sqlSession.getMapper(ViewImpl.class).View(
			Integer.parseInt(req.getParameter("audio_idx")));
		
		String temp2 = view.getContents().replaceAll("\r\n", "<br/>");
		view.setContents(temp2);
		
		if(view.getImagename()==null) {
			view.setImagename(path+"/resources/img/default.jpg");
		}
		else {
			view.setImagename(path+"/resources/upload/"+view.getImagename());
		}
		view.setAudiofilename(path+"/resources/upload/"+view.getAudiofilename());
		
		
		//모델객체에 데이터 저장
		model.addAttribute("audio", view);
		
		/*Commnet*/
		ArrayList<MCommentDTO> comments =
			sqlSession.getMapper(ViewImpl.class).mComment(
				Integer.parseInt(req.getParameter("audio_idx")));
		
		for(MCommentDTO dto : comments) {
			
			String temp = dto.getContents().replace("\r\n", "<br/>");
			dto.setContents(temp);
		}
		model.addAttribute("comments", comments);
		
		return "board/view";
		
	}
	
	//댓글입력처리
	@RequestMapping(value="/board/commentAction.do",
			method=RequestMethod.POST)
	public String CommentAction(Model model, HttpServletRequest req,
		HttpSession session, Principal principal) {
		
		//값이 넘어오는지 확인
		String qwe = req.getParameter("audio_idx");
		System.out.println(qwe);
		String zxc = req.getParameter("contents");
		System.out.println(zxc);
		
		String id = principal.getName();
		session.setAttribute("id", id);
		System.out.println(id);
		model.addAttribute("id");
		
		//Mapper호출
		int result = sqlSession.getMapper(ViewImpl.class).commentAction(
			Integer.parseInt(req.getParameter("audio_idx")),
			principal.getName(),
			req.getParameter("contents"));
		System.out.println("입력결과"+ result);
		
		//model객체에 audio_idx저장
		model.addAttribute("audio_idx", qwe);
		
		return "redirect:view.do";
	}
	
	//댓글삭제처리
	@RequestMapping("/board/delete.do")
	public String delete(HttpServletRequest req, Principal principal,
			Model model) {
		
		//삭제 전 로그인 확인
		if(principal.getName()==null) {
			return "redirect:view.do"; 
		}
		
		//값이 넘어오는지 확인
		String si = principal.getName();
		System.out.println("아이디:"+ si);
		String comment_idx = req.getParameter("comment_idx");
		System.out.println("comment_idx = "+ comment_idx);
		String audio_idx = req.getParameter("audio_idx");
		System.out.println("audio_idx = "+ audio_idx);
		
		//매퍼호출
		int result = sqlSession.getMapper(ViewImpl.class).delete(
			Integer.parseInt(req.getParameter("comment_idx")),
			principal.getName());
		System.out.println("결과  = "+ result);
		
		//모델객체에 idx저장
		model.addAttribute("audio_idx", audio_idx);
		model.addAttribute("comment_idx", comment_idx);
		
		return "redirect:view.do";
	}
	
}
