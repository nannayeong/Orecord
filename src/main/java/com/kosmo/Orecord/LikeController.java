package com.kosmo.Orecord;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.LikeImpl;
import model.LikeDTO;
import util.Calculate;
@Controller
public class LikeController {
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@RequestMapping("/like.do") 
	@ResponseBody
	public Map<String, Object> like(Model model, HttpServletRequest req,
			HttpSession session, Principal principal) {

		/*like한 게시물 인덱스번호*/
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx")) ;
		
		/*login한 아이디*/
		String like_id = principal.getName();
		
		/*객체저장*/
		LikeDTO likedto = new LikeDTO();
		likedto.setAudio_idx(audio_idx);
		likedto.setLike_id(like_id);
		
		//Follow 테이블에 insert하고 성공시 1을 반환받음
		int suc = sqlSession.insert("like", likedto); //like table추가
		int add = sqlSession.update("addlike",audio_idx); //audioBoard table count++
		
		System.out.println(suc);
		System.out.println(add);
		Map<String, Object> map = new HashMap<String, Object>();
		
		//해당 게시물의 라이크 갯수 조회
		int likeCount = sqlSession.selectOne("countlike", audio_idx);
		
		map.put("like", suc);
		map.put("likeadd", add);
		map.put("likecount",likeCount);
		
		return map;
		}
	@RequestMapping("/nolike.do")
	@ResponseBody
	public Map<String, Object> nolike(Model model, HttpServletRequest req,
		HttpSession session) {
		LikeDTO likedto = new LikeDTO();
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx")) ;
		String like_id = req.getParameter("like_id");
		likedto.setAudio_idx(audio_idx);
		likedto.setLike_id(like_id);
		//Follow 테이블에 insert하고 성공시 1을 반환받음
		int suc = sqlSession.delete("nolike", likedto);
		int remove = sqlSession.delete("removelike", audio_idx);
		Map<String, Object> map = new HashMap<String, Object>();
		//해당 게시물의 라이크 갯수 조회
		int likeCount = sqlSession.selectOne("countlike", audio_idx);
		map.put("unlike", suc);
		map.put("likeremove", remove);
		map.put("likecount",likeCount);
		return map;
	}
	
	@RequestMapping("/likeCheck.do")
	@ResponseBody
	public Map<String, Object> likeCheck(HttpServletRequest req, Principal principal){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_id = req.getParameter("user_id");
		
		/*좋아요 목록 가져오기*/
		String login_id = null;
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		List<Integer> likeList = sqlSession.getMapper(LikeImpl.class).selectLike(login_id, user_id);
		
		map.put("likeIdx", likeList);
		
		return map;
	}
}
