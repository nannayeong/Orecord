package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Array;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.AlbumImpl;
import impl.AudioBoardImpl;
import model.AlbumDTO;

@Controller
public class UploadController {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} 
	
	/*업로드*/
	@RequestMapping("/upload.do")
	public String upload(Principal principal, Model model) {
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		/*앨범 리스트 불러오기*/
		ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumList(id);
		AlbumDTO albumDTO = new AlbumDTO();
		
		/*아무 앨범도 없을 때*/
		if(albumList.size()==0) {
			albumDTO.setAlbumName("default");
			albumList.add(albumDTO);
		}
		
		model.addAttribute("albumList", albumList);
		
		return "/upload/upload";
	}
	
	/*
	 UUID(Universally Unique Identifier)
	 	: 범용 고유 식별자. randomUUID()를 통해 문자열을 생성하면 
	 	하이픈이 4개 포함된 32자의 랜덤하고 유니크한 문자열이 생성된다.
	 	JDK에서 기본클래스로 제공된다.
	 */
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}

	/*파일업로드 처리*/
	@RequestMapping(value = "/uploadAction.do", method = RequestMethod.POST)
	public String uploadAction(Model model, MultipartHttpServletRequest req, HttpSession session, Principal principal) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		String id = null;
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.
			String audiotitle = req.getParameter("audiotitle");
			id = principal.getName();
			String albumName = req.getParameter("albumName");
			String artistname = req.getParameter("artistname");
			String contents = req.getParameter("contents");
			String category = req.getParameter("country")+" "+req.getParameter("genre");
			//int party = Integer.parseInt(req.getParameter("party"));
			String col = req.getParameter("party");
			int party = 0;
			
			if(col.equals("Y")) {
				party = 1;
			}
			else{
				party = 0;
			}
			
			String audiofilename = null;
			String imagename = null;
			int album_idx = -1;
			
			/*앨범*/
			//내가 만든 앨범리스트 불러오기
			ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumList(id);
			
			//사용자 입력 앨범이름 없을때 무조건 default앨범
			if(albumName==null||albumName.equals("")) {
				albumName="default";
			}
			
			//사용자가 입력한 앨범이름 중복확인
			for(AlbumDTO album : albumList) {
				if(album.getAlbumName().equals(albumName)) {
					album_idx = album.getAlbum_idx();
					break;
				}
			}
			//중복되는게 없으면 새 앨범 만들고 idx select
			if(album_idx==-1) {
				int addAlbumResult = sqlSession.getMapper(AlbumImpl.class).addAlbum(id, albumName);
				album_idx = sqlSession.getMapper(AlbumImpl.class).albumIdxSelect(id, albumName);
			}
			
			/*
			 물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가 있는지 확인한다.
			 만약 없다면 mkdir()로 생성한다.
			 */
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
					imagename = saveFileName;
					System.out.println("imagename"+imagename);
				}
				/*서버 저장 audiofilename*/
				else if(fileName.equals("audiofilename")) {
					audiofilename = saveFileName;
					System.out.println("audiofilename"+audiofilename);
					
				}
				mfile.transferTo(serverFullName);
			}
			
			int result = sqlSession.getMapper(AudioBoardImpl.class).addAudioBoard(audiotitle, id, album_idx, audiofilename, artistname, contents, imagename, category, party);
			
			
			if(result==1) {
				System.out.println("성공!");
			}
			
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/orecord/"+id+"/record";
	}
}
