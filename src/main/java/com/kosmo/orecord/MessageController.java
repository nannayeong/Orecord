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
import impl.MessageImpl;
import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import model.MemberDTO;
import model.NotificationDTO;
import util.Calculate;

@Controller
public class MessageController {
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} 
	
	@RequestMapping(value="/msgSave.do")
	@ResponseBody
	public Map<String, Object> MsgSave(Model model, HttpServletRequest req, Principal principal, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String sender = req.getParameter("sender");
		String receiver = req.getParameter("receiver");
		String msg = req.getParameter("msg");
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx")) ;
		System.out.println("이건되냐");
		int suc = sqlSession.getMapper(MessageImpl.class).saveMsg(sender, receiver, msg, audio_idx);
		map.put("결과", suc);
		System.out.println("결과"+suc);
		return map;

	}
	@RequestMapping(value="/msgRead.do")
	@ResponseBody
	public Map<String, Object> MsgRead(Model model, HttpServletRequest req, Principal principal, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		int n_idx = Integer.parseInt(req.getParameter("n_idx"));
		int suc = sqlSession.getMapper(MessageImpl.class).readMsg(n_idx);
		System.out.println("결과"+suc);
		return map;

	}
	@RequestMapping(value="/msgLoad.do")
	public String MsgLoad(Model model, HttpServletRequest req, Principal principal, HttpSession session) {
		
		String receiver = req.getParameter("user_id");
		ArrayList<NotificationDTO> noti = sqlSession.getMapper(MessageImpl.class).loadMsg(receiver);
		model.addAttribute("notis",noti);
		return "main/noti";
	}
}
