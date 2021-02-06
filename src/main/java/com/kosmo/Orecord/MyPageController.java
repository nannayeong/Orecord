package com.kosmo.Orecord;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import impl.AlbumImpl;
import impl.AudioBoardImpl;
import impl.FollowImpl;
import impl.LikeImpl;
import impl.MemberImpl;
import impl.MypageImpl;
import model.AlbumDTO;
import model.AudioBoardDTO;
import model.MemberDTO;
import util.WebSecurityConfig;

@Controller
public class MyPageController {

	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} 
	
	@RequestMapping("/{user_id}/record")
	public String record(@PathVariable String user_id, Model model, Principal principal) {
		
		String login_id = null;
		
		try {
			login_id = principal.getName();
			
			/*로그인 했을때만 팔로잉정보*/
			int result = sqlSession.getMapper(FollowImpl.class).followingCheck(login_id, user_id);
			
			if(result==1) {
				model.addAttribute("follow","true");
			}
			else {
				model.addAttribute("follow","false");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		/*계정정보*/
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(dto.getImg()==null) {
			dto.setImg("../default.jpg");
		}
		
		model.addAttribute("memberDTO", dto);
		
		/*팔로잉&팔로워 수*/
		int followingCount = sqlSession.getMapper(FollowImpl.class).followingCount(user_id);
		int followerCount = sqlSession.getMapper(FollowImpl.class).followerCount(user_id);
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("followingCount", followingCount);
		model.addAttribute("followerCount", followerCount);
		
		
		
		/*포인트 정보 불러오기*/
		
		
		return "mypage/record";
	}

	@RequestMapping("/{user_id}/album")
	public String album(@PathVariable String user_id, Model model, HttpServletRequest req, Principal principal) {
		
		String path = req.getContextPath();
		System.out.println(req.getContextPath());
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/default.jpg");
		}
		
		model.addAttribute("memberDTO", memberDTO);
		
		/*팔로잉&팔로워 수*/
		int followingCount = sqlSession.getMapper(FollowImpl.class).followingCount(user_id);
		int followerCount = sqlSession.getMapper(FollowImpl.class).followerCount(user_id);
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("followingCount", followingCount);
		model.addAttribute("followerCount", followerCount);
		
		/*앨범목록불러오기*/
		ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumList(user_id);
		model.addAttribute("albumList", albumList);
		
		for(AlbumDTO albumDTO : albumList) {
			if(albumDTO.getAlbumJacket()==null){
				albumDTO.setAlbumJacket(path+"/default.jpg");
			}
			else {
				String fileName = albumDTO.getAlbumJacket();
				albumDTO.setAlbumJacket(path+"/upload/"+fileName);
			}
		}

		/*음원목록불러오기*/
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		model.addAttribute("audioList", audioList);
		
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
		return "mypage/album";
	}
	
	@RequestMapping("/{user_id}/playlist")
	public String playlist(@PathVariable String user_id, Model model) {
		/*계정정보*/
		MemberDTO dto = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(dto.getImg()==null) {
			dto.setImg("../default.jpg");
		}
		
		model.addAttribute("memberDTO", dto);
		
		/*팔로잉&팔로워 수*/
		int followingCount = sqlSession.getMapper(FollowImpl.class).followingCount(user_id);
		int followerCount = sqlSession.getMapper(FollowImpl.class).followerCount(user_id);
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("followingCount", followingCount);
		model.addAttribute("followerCount", followerCount);
		
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
}
