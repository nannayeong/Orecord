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
import model.AlbumDTO;
import model.MemberDTO;

@Controller
public class AlbumContoller {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/addAlbum.do")
	@ResponseBody
	public Map<String, Object> addAlbum(Principal principal, HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		String login_id = null;
		String addAlbumName = req.getParameter("addAlbumName");
		int result = -1;
		try {
			login_id = principal.getName();
			
			/*앨범리스트가져오기*/
			ArrayList<AlbumDTO> aDTOList = sqlSession.getMapper(AlbumImpl.class).albumList(login_id);
			
			//중복체크
			for(AlbumDTO album : aDTOList) {
				if(addAlbumName.equals(album.getAlbumName())) {
					result = 0;
				}
				else {
					result = sqlSession.getMapper(AlbumImpl.class).addAlbum(login_id, addAlbumName);
					if(result==1) {//중복없을때만
						map.put("addAlbumName", addAlbumName);
					}
				}
			}
			map.put("result", result);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
}
