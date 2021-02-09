package com.kosmo.orecord;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.AlbumImpl;
import impl.AudioBoardImpl;
import impl.FollowImpl;
import impl.MemberImpl;
import impl.MypageImpl;
import model.AlbumDTO;
import model.AudioBoardDTO;
import model.MemberDTO;

@Controller
public class MyPageController {

	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/{user_id}/record")
	public String record(@PathVariable String user_id, Model model, Principal principal, HttpServletRequest req) { 
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);	
		
		/*로그인 유저의 계정정보*/
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		MemberDTO loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/default.jpg");
		}
		
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);
		
		return "mypage/record";
	}

	@RequestMapping("/{user_id}/album")
	public String album(@PathVariable String user_id, Model model, HttpServletRequest req, Principal principal) {
		
		String path = req.getContextPath();
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/default.jpg");
		}
	
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("user_id", user_id);

		return "mypage/album";
	}
	
	@RequestMapping("/{user_id}/playlist")
	public String playlist(@PathVariable String user_id, Model model, HttpServletRequest req) {
		
		String path = req.getContextPath();
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/default.jpg");
		}
	
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("user_id", user_id);

		return "mypage/playlist";
	}
	
	/*회원삭제하기*/
	@RequestMapping("/memberDelete.do")
	public String memberDelete(HttpServletRequest req, HttpSession session) {
		
		/*
		if(session.getAttribute("siteUserInfo")==null){
			return "./login.do";
		}
		*/
		sqlSession.getMapper(MypageImpl.class).memberDelete(req.getParameter("id"));
		
		return "main/main";
		
	}
	
	/*회원 수정하기*/
	@RequestMapping("/memberEdit.do")
	public String memberEdit(HttpServletRequest req, Principal principal, MemberDTO memberDTO)
	{		
		//수정처리 전 로그인 확인
		
		String id = null;
		//로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.	
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String pw = req.getParameter("pw");
		String email = req.getParameter("email_1")+"@"+req.getParameter("email_2");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address")+"/"+req.getParameter("addr1")+"/"+req.getParameter("addr2");
		String intro = req.getParameter("intro");
		String img = req.getParameter("img");
		id = principal.getName();
		
		//수정폼에서 전송한 모든 폼값을 한꺼번에 저장한 커맨드객체를 사용한다. 
		int applyRow = sqlSession.getMapper(MypageImpl.class).memberEdit(pw, email, phone, address, intro, img, id);
		
		System.out.println("수정처리된 레코드수:"+ applyRow);
		
		return "redirect:/"+id+"/main.do";
	}
	
	@RequestMapping("/mypageAlbum.do")
	public String mypageA(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		String user_id = req.getParameter("user_id");	
		ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumList(user_id);
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		
		/*앨범*/
		for(AlbumDTO albumDTO : albumList) {
			if(albumDTO.getAlbumJacket()==null){
				albumDTO.setAlbumJacket(path+"/default.jpg");
			}
			else {
				String fileName = albumDTO.getAlbumJacket();
				albumDTO.setAlbumJacket(path+"/upload/"+fileName);
			}
		}
		
		/*음원*/
		for(AudioBoardDTO audioDTO : audioList) {
			
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/upload/"+fileName);
			}
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/upload/"+fileName);
		}

		model.addAttribute("albumList", albumList);
		model.addAttribute("audioList", audioList);
		
		return "mypage/mypageAlbum";
	}
	
	@RequestMapping("/mypagePlay.do")
	public String mypageP(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		String user_id = req.getParameter("user_id");	
		ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumList(user_id);
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		
		/*나의 플레이리스트 가져와서 앨범명별로 분류한 후 map에 집어넣기*/
		
		/*1. 플레이리스트 가져오기*/
		
		/*2. for문으로 플레이리스트의 앨범이름을 hashset에 넣은 후 map('albumName', albumList)에 넣기*/
		
		/*3.플레이리스트 DTO map에 넣기*/
		
		/*앨범*/
		for(AlbumDTO albumDTO : albumList) {
			if(albumDTO.getAlbumJacket()==null){
				albumDTO.setAlbumJacket(path+"/default.jpg");
			}
			else {
				String fileName = albumDTO.getAlbumJacket();
				albumDTO.setAlbumJacket(path+"/upload/"+fileName);
			}
		}
		
		/*음원*/
		for(AudioBoardDTO audioDTO : audioList) {
			
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/upload/"+fileName);
			}
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/upload/"+fileName);
		}

		model.addAttribute("albumList", albumList);
		model.addAttribute("audioList", audioList);
		
		return "mypage/mypagePlay";
	}
	
	@RequestMapping("/mypageRecord.do")
	public String mypageR(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		String user_id = req.getParameter("user_id");
		
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		
		System.out.println(audioList);
		/*음원*/
		for(AudioBoardDTO audioDTO : audioList) {
			
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/upload/"+fileName);
			}
			
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/upload/"+fileName);
		}

		model.addAttribute("audioList", audioList);
		
		return "mypage/mypageRecord";
	}
	
	@RequestMapping("/mypageFollowTrack.do")
	@ResponseBody
	public Map<String, Object> mypageF(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_id = req.getParameter("user_id");
		
		System.out.println("팔로우 유저" +user_id);
		
		/*팔로우*/
		int followingCount = sqlSession.getMapper(FollowImpl.class).followingCount(user_id);
		int followerCount = sqlSession.getMapper(FollowImpl.class).followerCount(user_id);
		
		/*오디오수*/
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);
		
		System.out.println("오디오"+audioList.size());
		
		map.put("followingCount", followingCount);
		map.put("followerCount", followerCount);
		map.put("trackCount", audioList.size());
		
		return map;
	}
	
}
