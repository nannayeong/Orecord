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
	
	
	/*팔로잉페이지 리스트*/
	@RequestMapping("/{user_id}/following")
	public String following(@PathVariable String user_id, Model model) {
		
		//계정정보가져오기
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg("../default.jpg");
		}
		
		model.addAttribute("memberDTO", memberDTO);
		
		//팔로잉리스트가져오기
		ArrayList<FollowDTO> lists = sqlSession.getMapper(FollowImpl.class).following(user_id);
		
		//팔로잉유저 이미지 없는경우 기본이미지로 바꾸기
		for(FollowDTO dto : lists) {
			if(dto.getImg()==null) {
				dto.setImg("../default.jpg");
			}
		}
		
		model.addAttribute("followingList", lists);

		return "follow/following";
	}
	
	/*팔로우페이지 리스트*/
	@RequestMapping("/{user_id}/followers")
	public String followers(@PathVariable String user_id, Model model) {
		
		//계정정보가져오기
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg("../default.jpg");
		}
		
		model.addAttribute("memberDTO", memberDTO);
		
		//팔로우리스트가져오기
		ArrayList<FollowDTO> lists = sqlSession.getMapper(FollowImpl.class).followers(user_id);
		for(FollowDTO dto : lists) {
			if(dto.getImg()==null) {
				dto.setImg("../default.jpg");
			}
		}
		
		model.addAttribute("followersList", lists);
		
		return "follow/followers";
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
		map.put("unfolSuc", suc);
		
		return map;
	}
	
//	@RequestMapping("/checkFollow.do")
//	@ResponseBody
//	public Map<String, Object> checkF(Principal principal, HttpServletRequest req){
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		String login_id = null;
//		String user_id = req.getParameter("user_id");
//		
//		System.out.println(user_id);
//		
//		try {
//			login_id = principal.getName();
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return map;
//	}
//	
//	@RequestMapping("/addF.do")
//	public String addF(HttpServletRequest req, Principal principal, RedirectAttributes rttr) {
//		
//		FollowDTO follow = new FollowDTO();
//		String referer = req.getHeader("Referer");
//		
//		String followId = principal.getName();//내아이디
//		String followerId = req.getParameter("followerId");//팔로우할아이디
//		
//		follow.setFollowing_id(followerId);
//		follow.setUser_id(followId);
//		
//		//Follow 테이블에 insert하고 성공시 1을 반환받음
//		int suc = sqlSession.insert("follow", follow);
//		
//		return "redirect:"+referer;
//	}
//	
//	@RequestMapping("/unF.do")
//	public String unF(HttpServletRequest req, Principal principal, RedirectAttributes rttr) {
//		FollowDTO follow = new FollowDTO();
//		String referer = req.getHeader("Referer");
//		
//		String followId = principal.getName();
//		String followerId = req.getParameter("followerId");
//		
//		follow.setFollowing_id(followerId);
//		follow.setUser_id(followId);
//		
//		//Follow 테이블에 insert하고 성공시 1을 반환받음
//		int suc = sqlSession.delete("unFollow", follow);
//		
//		return "redirect:"+referer;
//	}

}
