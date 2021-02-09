package com.kosmo.orecord;

import java.security.Principal;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
			e.printStackTrace();
		}
		
		return "redirect:/"+login_id+"/playlist";
	}
}
