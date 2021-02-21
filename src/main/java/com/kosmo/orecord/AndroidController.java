package com.kosmo.orecord;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.AndroidImpl;
import model.AudioBoardDTO;
import model.MemberDTO;

@Controller
public class AndroidController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/android", method = {RequestMethod.POST})
	public String androidPage(HttpServletRequest req, Model model) {
		
		System.out.println("서버에서 안드로이드 접속 요청함");
		
		try {
			String androidID = req.getParameter("id");
			String androidPW = req.getParameter("pw");
			System.out.println("안드로이드에서 받아온 id : "+ androidID);
			System.out.println("안드로이드에서 받아온 pw : "+ androidPW);
			model.addAttribute("android", androidID);
			return "android";
		} catch (Exception e) {
			e.printStackTrace();
			return "null";
		}
	}
	
	//JSONArray로 데이터 반환
	@RequestMapping("/android/memberList.do")
	@ResponseBody
	public ArrayList<MemberDTO> memberList(HttpServletRequest req){
		
		System.out.println("요청들어옴");
		//JSONArray로 반환할 경우
		ArrayList<MemberDTO> lists = sqlSession.getMapper(AndroidImpl.class).memberList();
		
		return lists;
	}
	
	//로그인
	@RequestMapping("/android/memberLogin.do")
	@ResponseBody
	public Map<String, Object> memberLogin(MemberDTO memberDTO, Model model){
		
		System.out.println("Login요청들어옴");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//String id = principal.getName();
		
		MemberDTO memberInfo = sqlSession.getMapper(AndroidImpl.class).memberLogin(memberDTO);
		model.addAttribute("memberInfo", memberInfo);
		
		if(memberInfo==null) {
			returnMap.put("isLogin", 0);
		}
		else {
			returnMap.put("memberInfo", memberInfo);
			returnMap.put("isLogin", 1);
		}
		System.out.println(returnMap);
		return returnMap;
	}
	
	//메인화면 플레이리스트
	@RequestMapping("/android/audioBoardView.do")
	@ResponseBody
	public ArrayList<AudioBoardDTO> audioBoardView(AudioBoardDTO audioBoardDTO){
		
		System.out.println("안드 메인화면 요청들어옴");
		
		ArrayList<AudioBoardDTO> mainList = sqlSession.getMapper(AndroidImpl.class).audioBoardView();
		
		return mainList;
	}
}
