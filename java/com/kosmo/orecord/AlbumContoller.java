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
				//중복일때
				if(addAlbumName.equals(album.getAlbumName())) {
					result = 0;
					break;
				}
			}
			if(addAlbumName.equals("default")) {
				result = 0;
			}
			
			//중복이 아닐때
			if(result!=0) {
				result = sqlSession.getMapper(AlbumImpl.class).addAlbum(login_id, addAlbumName);
				if(result==1) {
					map.put("addAlbumName", addAlbumName);
				}
			}
		
			System.out.println(result);
			map.put("result", result);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping("/deleteAlbum.do")
	@ResponseBody
	public Map<String, Object> deleteAlbum(Principal principal, HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		int album_idx = Integer.parseInt(req.getParameter("album_idx"));

		String login_id = null;
		int result = -1;
		
		try {
			login_id = principal.getName();
			System.out.println(login_id);
			
			result = sqlSession.getMapper(AlbumImpl.class).deleteAlbum(login_id, album_idx);
			System.out.println(result);

		}
		catch(Exception e) {
			e.printStackTrace();
		}

		map.put("result", result);
		return map;
	}
	
	@RequestMapping("/albumModify.do")
	public String albumM(MultipartHttpServletRequest req,Principal principal) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		int album_idx = Integer.parseInt(req.getParameter("album_idx"));
		String albumName = req.getParameter("albumName");
		String albumJacket = null;
		String login_id = null;
		
		
		
		try {
			login_id = principal.getName();
			
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			File directory = new File(path);
			if(!directory.isDirectory()) {
				directory.mkdirs();
			}
			
			//업로드 폼의 file필드 갯수만큼 반복
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				System.out.println("filename"+fileName);
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				
				//한글깨짐방지 처리 후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				
				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if("".equals(originalName)) {
					continue;
				}
				
				//파일명에서 확장자를 가져옴
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
				String saveFileName = getUuid() + ext;
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				
				/*서버 저장 imagename*/
				if(fileName.equals("imagename")) {
					albumJacket = saveFileName;
					System.out.println("imagename"+albumJacket);
				}
				mfile.transferTo(serverFullName);
			}
			
			System.out.println(albumName + album_idx + login_id + albumJacket);
			int result = sqlSession.getMapper(AlbumImpl.class).modifyAlbum(login_id, album_idx, albumJacket, albumName);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/"+login_id+"/album";
		
	}
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
}
