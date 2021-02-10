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
