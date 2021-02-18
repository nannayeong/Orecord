package com.kosmo.orecord;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MusicBoxController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//회원리스트보기
	@RequestMapping("/musicbox")
	public String main() {
		
		return "musicbox/musicbox";
	}
	
	
}
