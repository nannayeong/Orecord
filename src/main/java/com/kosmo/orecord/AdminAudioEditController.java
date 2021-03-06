package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.AdminImpl;
import model.AudioBoardDTO;

@Controller
public class AdminAudioEditController {
	
	@Autowired
	SqlSession sqlSession;
	
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
	
	/*오디오수정폼*/
	@RequestMapping("/admin/adaudioboardEdit.do")
	public String adaudioboardEdit(Model model, HttpServletRequest req, AudioBoardDTO audioBoardDTO) {
		
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx"));
		
		System.out.println("audio_idx"+audio_idx);
		
		AudioBoardDTO adaudio = sqlSession.getMapper(AdminImpl.class).adAudioView(audio_idx);
		
		System.out.println(adaudio.getAudio_idx()+"----------------------------");
		
		model.addAttribute("adaudio", adaudio);
		
		return "admin/adaudioboardEdit";
	}
	
	/*수정하기*/
	@RequestMapping(value = "/admin/adaudioboardEditAction.do" , method = RequestMethod.POST)
	public String audioEditAction(Model model, MultipartHttpServletRequest req , AudioBoardDTO audioBoardDTO) {
		
		String albumName = req.getParameter("albumName");
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		String id = null;
		
		
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx"));
		System.out.println("audio_idx = "+ audio_idx);
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = req.getParameter("audiofilename");
			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.
			String audiotitle = req.getParameter("audiotitle");
			String artistname = req.getParameter("artistname");
			String contents = req.getParameter("contents");
			String category = req.getParameter("country")+" "+req.getParameter("genre");
			int party = -1;
			String audiofilename = null;
			String imagename = null;
			
			
			if(req.getParameter("party")==null) {
				party = 0;
			}
			else {
				if(req.getParameter("party").equals("Y")) {
					party = 1;
				}
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
			
			int audioEditAction = sqlSession.getMapper(AdminImpl.class).adAudioEdit
					(audiotitle, audiofilename, artistname, albumName, imagename, category, party, audio_idx);
			
			System.out.println("수정처리된 레코드수 : "+ audioEditAction);
			
			model.addAttribute("audioEditAction", audioEditAction);
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/adaudioboardList.do";
	}
	
	/*오디오 삭제하기*/
	@RequestMapping("/admin/adAudioDelete.do")
	public String adAudioDelete(Model model, HttpServletRequest req, AudioBoardDTO audioBoardDTO) {
		
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx"));
		
		System.out.println("audio_idx"+audio_idx);
		
		int audiodelete = sqlSession.getMapper(AdminImpl.class).adAudioDELETE(audio_idx);
		
		if(audiodelete == 1) {
			System.out.println("어드민오디오 삭제성공");
		}
		return "redirect:/admin/adaudioboardList.do";
	}
}
