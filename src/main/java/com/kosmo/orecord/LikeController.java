package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.AdminImpl;
import impl.LikeImpl;
import model.MemberDTO;

@Controller
public class LikeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/nolike.do")
	@ResponseBody
	public Map<String, Object> nolike(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		String login_id = null;
		String audio_idx = req.getParameter("audio_idx");
		
		try {
			login_id = principal.getName();
			
			/*liketable에서 삭제하기*/
			int result = sqlSession.getMapper(LikeImpl.class).nolike(audio_idx, login_id);
			
			/*audiotable like숫자 내리기*/
			sqlSession.getMapper(LikeImpl.class).removelike(Integer.parseInt(audio_idx));
			
			/*현재 like 수*/
			int likecount = sqlSession.getMapper(LikeImpl.class).countlike(Integer.parseInt(audio_idx));
			
			map.put("result", result);
			map.put("likecount", likecount);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	@RequestMapping("/like.do")
	@ResponseBody
	public Map<String, Object> like(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		String login_id = null;
		String audio_idx = req.getParameter("audio_idx");
		
		try {
			login_id = principal.getName();
			
			/*like테이블 추가하기*/
			int result = sqlSession.getMapper(LikeImpl.class).like(audio_idx, login_id);
			
			/*audiotable like숫자 올리기*/
			sqlSession.getMapper(LikeImpl.class).addlike(Integer.parseInt(audio_idx));
			
			/*현재 like 수*/
			int likecount = sqlSession.getMapper(LikeImpl.class).countlike(Integer.parseInt(audio_idx));
			
			map.put("result", result);
			map.put("likecount", likecount);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
}

//package com.kosmo.orecord;
//
//import java.security.Principal;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import impl.LikeImpl;
//import model.LikeDTO;
//import util.Calculate;
//
//@Controller
//public class LikeController {
//	@Autowired
//	SqlSession sqlSession;
//	public void setSqlSession(SqlSession sqlSession) {
//		this.sqlSession = sqlSession;
//	}
//
//	@RequestMapping("/like.do") 
//	@ResponseBody
//	public Map<String, Object> like(Model model, HttpServletRequest req,
//			HttpSession session, Principal principal) {
//
//		/*like한 게시물 인덱스번호*/
//		int audio_idx = Integer.parseInt(req.getParameter("audio_idx")) ;
//		
//		/*login한 아이디*/
//		String like_id = principal.getName();
//		
//		/*객체저장*/
//		LikeDTO likedto = new LikeDTO();
//		likedto.setAudio_idx(audio_idx);
//		likedto.setLike_id(like_id);
//		
//		//Follow 테이블에 insert하고 성공시 1을 반환받음
//		int suc = sqlSession.insert("like", likedto); //like table추가
//		int add = sqlSession.update("addlike",audio_idx); //audioBoard table count++
//		
//		System.out.println(suc);
//		System.out.println(add);
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		//해당 게시물의 라이크 갯수 조회
//		int likeCount = sqlSession.selectOne("countlike", audio_idx);
//		
//		map.put("like", suc);
//		map.put("likeadd", add);
//		map.put("likecount",likeCount);
//		
//		return map;
//		}
//	@RequestMapping("/nolike.do")
//	@ResponseBody
//	public Map<String, Object> nolike(Model model, HttpServletRequest req,
//		HttpSession session) {
//		LikeDTO likedto = new LikeDTO();
//		int audio_idx = Integer.parseInt(req.getParameter("audio_idx")) ;
//		String like_id = req.getParameter("like_id");
//		likedto.setAudio_idx(audio_idx);
//		likedto.setLike_id(like_id);
//		//Follow 테이블에 insert하고 성공시 1을 반환받음
//		int suc = sqlSession.delete("nolike", likedto);
//		int remove = sqlSession.delete("removelike", audio_idx);
//		Map<String, Object> map = new HashMap<String, Object>();
//		//해당 게시물의 라이크 갯수 조회
//		int likeCount = sqlSession.selectOne("countlike", audio_idx);
//		map.put("unlike", suc);
//		map.put("likeremove", remove);
//		map.put("likecount",likeCount);
//		return map;
//	}
//	
//	@RequestMapping("/likeCheck.do")
//	@ResponseBody
//	public Map<String, Object> likeCheck(HttpServletRequest req, Principal principal){
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		String user_id = req.getParameter("user_id");
//		
//		/*좋아요 목록 가져오기*/
//		String login_id = null;
//		try {
//			login_id = principal.getName();
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		List<Integer> likeList = sqlSession.getMapper(LikeImpl.class).selectLike(login_id, user_id);
//		
//		map.put("likeIdx", likeList);
//		
//		return map;
//	}
//}

