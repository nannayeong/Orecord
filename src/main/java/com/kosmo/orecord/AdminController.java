package com.kosmo.orecord;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping("/admin/main")
	public String main() {
		
		return "admin/main";
	}

}
