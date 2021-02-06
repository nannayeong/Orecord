package com.kosmo.Orecord;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WriteController {
	
	@RequestMapping("/board/partyWrite.do")
	public String partyWrite() {
		return "board/partyWrite";
	}
} 
