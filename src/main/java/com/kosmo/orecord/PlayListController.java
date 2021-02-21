package com.kosmo.orecord;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.PlayListImpl;
import model.PlayListDTO;

@Controller
public class PlayListController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/addPlayList.do")
	public String addPlayList(Principal principal, PlayListDTO plDTO) {
		
		String login_id = null;
		int result = -1;
		try {
			login_id = principal.getName();
			
			result = sqlSession.getMapper(PlayListImpl.class).addPlayList(login_id, plDTO.getAudio_idx(), plDTO.getPlname());
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "redirect:/"+login_id+"/playlist";
	}
	
	@RequestMapping("/plAudioDelete.do")
	@ResponseBody
	public Map<String, Object> plAudioDelete(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		String idx = req.getParameter("idx");
		String audio_idx = req.getParameter("audio_idx");
		
		System.out.println("idx:"+idx+"aidx:"+audio_idx);
		
		String login_id = null;
		int result = -1;
		try {
			login_id = principal.getName();
			
			result = sqlSession.getMapper(PlayListImpl.class).plAudioDelete(login_id, idx);
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		map.put("result", result);
		return map;
	}
	
	@RequestMapping("/addpl.do")
	@ResponseBody
	public Map<String, Object> addpl(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int idx = Integer.parseInt(req.getParameter("audio_idx"));
		String pln = req.getParameter("plname");
		
		String login_id = null;
		int result = -1;
		try {
			login_id = principal.getName();
			
			result = sqlSession.getMapper(PlayListImpl.class).addPlayList(login_id, idx, pln);
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		map.put("result", 1);
		return map;
	}
	
}
