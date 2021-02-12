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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.AdminImpl;
import impl.AlbumImpl;
import impl.AudioBoardImpl;
import model.AlbumDTO;
import model.MemberDTO;

@Controller
public class AudioController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/recordDelete.do")
	@ResponseBody
	public Map<String, Object> recordDelete(Principal principal, HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		String login_id = null;
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx"));
		int result = -1;
		try {
			login_id = principal.getName();
			
			/*삭제*/
			result = sqlSession.getMapper(AudioBoardImpl.class).recordDelete(login_id, audio_idx);
		
	
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		System.out.println("오디오리절"+result);
		
		map.put("result", result);
		return map;
	}

}
