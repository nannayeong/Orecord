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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import impl.FollowImpl;
import impl.MainImpl;
import impl.MemberImpl;
import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import model.MemberDTO;
import util.Calculate;

@Controller
public class FollowController {
	Calculate cal = new Calculate();
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} 
	
	//팔로우하기
	@RequestMapping("/addFollower.do")
	@ResponseBody
	public Map<String, Object> follow(Model model, HttpServletRequest req, Principal principal, HttpSession session) {
		//팔로우 DTO만들어 ajax전달받은 id 2개를 입력후 
		FollowDTO follow = new FollowDTO();
		String followId = principal.getName();//내아이디
		String followerId = req.getParameter("followerId");//팔로우할아이디
		
		follow.setFollowing_id(followerId);
		follow.setUser_id(followId);
		//Follow 테이블에 insert하고 성공시 1을 반환받음
		int suc = sqlSession.insert("follow", follow);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("folSuc", suc);
		//팔로우 버튼옆 표시할 팔로워 수
		int followCount = sqlSession.selectOne("followerCount",followerId);
		map.put("followcount", followCount);
		return map;

	}
	
	@RequestMapping("/unFollow.do")
	@ResponseBody
	public Map<String, Object> unfollow(Model model, HttpServletRequest req, Principal principal) {
		FollowDTO follow = new FollowDTO();
		String followId = principal.getName();
		String followerId = req.getParameter("followerId");
		follow.setFollowing_id(followerId);
		follow.setUser_id(followId);
		//Follow 테이블에 insert하고 성공시 1을 반환받음
		int suc = sqlSession.delete("unFollow", follow);
		Map<String, Object> map = new HashMap<String, Object>();
		//팔로우 버튼옆 표시할 팔로워 수
		int followCount = sqlSession.selectOne("followerCount",followerId);
		map.put("followcount", followCount);
		map.put("unfolSuc", suc);
		
		return map;
	}
	
	@RequestMapping("/checkFollow.do")
	@ResponseBody
	public Map<String, Object> checkF(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String login_id = null;
		String user_id = req.getParameter("user_id");
		
		System.out.println(user_id);
		
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		int result = sqlSession.getMapper(FollowImpl.class).followingCheck(login_id, user_id); //내 아이디, 내가 팔로우한 아이디
		System.out.println("팔로우"+result);
		
		map.put("follow", result);
		
		return map;
	}
	
	@RequestMapping("/{user_id}/myFollowing")
	public String myFollowing(@PathVariable String user_id, Model model, Principal principal, HttpServletRequest req) {
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);	
		
		/*로그인 유저의 계정정보*/
		MemberDTO loginDTO = null;
		try {
			login_id = principal.getName();
			 loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/resources/img/default.jpg");
		}else {
			String fileName = memberDTO.getImg();
			memberDTO.setImg(path+"/resources/upload/"+fileName);
		}
		
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(user_id);
		ArrayList<MemberDTO> artists = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO, Integer>();
		
		for(FollowDTO dto : follows) {
			String following = dto.getFollowing_id();
			MemberDTO followingMember = sqlSession.getMapper(MemberImpl.class).memberInfo(following);	
			ArrayList<FollowDTO> followers = sqlSession.getMapper(FollowImpl.class).followers(followingMember.getId());
			memberMap.put(followingMember, followers.size());
			artists.add(followingMember);
		}
		
		model.addAttribute("artists",artists);
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);
		model.addAttribute("memberMap",memberMap);
		
		
		return "mypage/following";
	}
	
	@RequestMapping("/{user_id}/myFollowers")
	public String myFollowers(@PathVariable String user_id, Model model, Principal principal, HttpServletRequest req) {
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);	
		
		/*로그인 유저의 계정정보*/
		MemberDTO loginDTO = null;
		try {
			login_id = principal.getName();
			 loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/resources/img/default.jpg");
		}else {
			String fileName = memberDTO.getImg();
			memberDTO.setImg(path+"/resources/upload/"+fileName);
		}
		
		ArrayList<FollowDTO> myfollower = sqlSession.getMapper(FollowImpl.class).followers(user_id);
		ArrayList<MemberDTO> artists = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO, Integer>();
		
		//나를 팔로우한 사람들
		for(FollowDTO dto : myfollower) {
			String following = dto.getUser_id();
			MemberDTO followingMember = sqlSession.getMapper(MemberImpl.class).memberInfo(following);	
			ArrayList<FollowDTO> followers = sqlSession.getMapper(FollowImpl.class).followers(followingMember.getId());
			memberMap.put(followingMember, followers.size());
			artists.add(followingMember);
		}
		
		model.addAttribute("artists",artists);
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);
		model.addAttribute("memberMap",memberMap);
		
		
		return "mypage/followers";
	}
}
