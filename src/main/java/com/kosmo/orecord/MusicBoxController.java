package com.kosmo.orecord;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import impl.AudioBoardImpl;
import impl.MusicBoxImpl;
import impl.PlayListImpl;
import model.AudioBoardDTO;
import model.PlayListDTO;

@Controller
public class MusicBoxController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/musicbox")
	public String main(HttpServletRequest req, Principal principal, HttpSession session, HttpServletResponse resp, Model model) {
		
		/*현재 탭*/
		String state = req.getParameter("state");
		if(state==null) {
			state = "song";
		}
		
		//새롭게 입력받은 audio_idx
		String audio_idx = req.getParameter("audio_idx");
		System.out.println("audio"+audio_idx);
		//현재 로그인 했는지 안했는지 확인
		String login_id = null;
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {}
		
		ArrayList<AudioBoardDTO> audioList = null;
		//게스트유저
		int result = -1;
		String ip = null;
		if(login_id==null) {
			//아이피주소
			req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			ip = req.getHeader("X-FORWARDED-FOR");
			if (ip == null)
				ip = req.getRemoteAddr();
			System.out.println("ip"+ip);
			
			//새로운 오디오 입력시
			if(audio_idx!=null) {
				result = sqlSession.getMapper(MusicBoxImpl.class).addFreeList("", audio_idx, ip);
			}
			
			//오디오 리스트 출력
			audioList = sqlSession.getMapper(MusicBoxImpl.class).np("",ip);
		}
		//로그인유저
		else {
			//새로운 오디오 입력시
			if(audio_idx!=null) {
				result = sqlSession.getMapper(MusicBoxImpl.class).addFreeList(login_id, audio_idx, "");
			}
			
			audioList = sqlSession.getMapper(MusicBoxImpl.class).np(login_id,"");
		}
		
		System.out.println("여기"+audioList);
		model.addAttribute("audioList",audioList);
		model.addAttribute("listsize", audioList.size());

		return "musicbox/musicbox";
	}
	
	@RequestMapping("nextList.do")
	@ResponseBody
	public Map<String, Object> nextlist(HttpServletRequest req, Principal principal, HttpSession session, HttpServletResponse resp, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String login_id = null;
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {}
		
		ArrayList<AudioBoardDTO> audioList = null;
		//게스트유저
		int result = -1;
		String ip = null;
		if(login_id==null) {
			//아이피주소
			req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			ip = req.getHeader("X-FORWARDED-FOR");
			if (ip == null)
				ip = req.getRemoteAddr();
			System.out.println("ip"+ip);
			
			//오디오 리스트 출력
			audioList = sqlSession.getMapper(MusicBoxImpl.class).np("",ip);
		}
		//로그인유저
		else {
			audioList = sqlSession.getMapper(MusicBoxImpl.class).np(login_id,"");
		}
		
		
		//오디오리스트의 길이 구하기
		int arr = Integer.parseInt(req.getParameter("arr"));
		
		int i = 1;
		for(AudioBoardDTO dto : audioList) {
			if(arr==i) {
				map.put("dto", dto);
				break;
			}
			i++;
		}
		
		return map;
	}
	
//	@RequestMapping("/freeList.do")
//	public String freeList(HttpServletRequest req, Principal principal, HttpSession session, HttpServletResponse resp, Model model) {
//	
//		/*페이징*/
//		int pageSize = 10;
//		
//		int nowPage = Integer.parseInt(req.getParameter("nowPage"));
//		int start = (nowPage-1)*pageSize+1;
//		int end = nowPage * pageSize;
//		
//		//현재 로그인 했는지 안했는지 확인
//		String login_id = null;
//		try {
//			login_id = principal.getName();
//		}
//		catch(Exception e) {}
//		
//		ArrayList<AudioBoardDTO> audioList = null;
//		//게스트유저
//		int result = -1;
//		String ip = null;
//		if(login_id==null) {
//			//아이피주소
//			req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//			ip = req.getHeader("X-FORWARDED-FOR");
//			if (ip == null)
//				ip = req.getRemoteAddr();
//			System.out.println("ip"+ip);
//			
//			//오디오 리스트 출력
//			audioList = sqlSession.getMapper(MusicBoxImpl.class).selectFreeList("",ip,start,end);
//		}
//		//로그인유저
//		else {
//			//오디오리스트출력
//			audioList = sqlSession.getMapper(MusicBoxImpl.class).selectFreeList(login_id,"",start,end);
//		}
//		
//		System.out.println("여기"+audioList);
//		model.addAttribute("audioList",audioList);
//		
//		return "musicbox/freeList";
//	}
}
