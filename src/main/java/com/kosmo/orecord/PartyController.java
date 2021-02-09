package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.PartyImpl;
import impl.ViewImpl;
import model.AudioBoardDTO;

@Controller
public class PartyController {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//협업신청폼
	@RequestMapping("/board/partyWrite.do")
	public String partyWrite(Model model, HttpServletRequest req, Principal principal) {
		
		String party1 = req.getParameter("audio_idx");
		System.out.println("audio_idx = "+ party1);
		
		/*절대경로*/
		String path = req.getContextPath();
		
		AudioBoardDTO party =
				sqlSession.getMapper(PartyImpl.class).partyWrite(
				Integer.parseInt(req.getParameter("audio_idx")));
		
		
		model.addAttribute("party", party);
		
		return "board/partyWrite";
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
	
	//협업신청처리
	@RequestMapping(value="/board/partyWriteAction.do", method=RequestMethod.POST)
	public String partyWriteAction(Model model,
			MultipartHttpServletRequest req, Principal principal,
			HttpServletRequest request) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		
		String name = null;
		int party3 = Integer.parseInt(req.getParameter("audio_idx"));
		System.out.println("audio_idx2 = "+ party3);
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = req.getParameter("audiofilename");
			System.out.println("오디오파일 = "+fileName);
			
			
			//파일외에 폼값 받음.
//			String idx = req.getParameter("audio_idx");
//			System.out.println("idx = "+ idx);
//			int party2 = Integer.parseInt(req.getParameter("audio_idx"));
//			System.out.println("audio_idx = "+ party2);
			name = principal.getName();
			String id = req.getParameter("id");
			//String regidate = req.getParameter("regidate");
			String audiocontents = req.getParameter("audiocontents");
			String kind = req.getParameter("kind");
			int point = Integer.parseInt(req.getParameter("point"));
			String title = req.getParameter("title");
			String contents = req.getParameter("contents");
			
			String audiofilename = null;
			
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
				System.out.println("filename="+fileName);
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
				
				/*서버 저장 audiofilename*/
				if(fileName.equals("audiofilename")) {
					audiofilename = saveFileName;
					System.out.println("audiofilename"+audiofilename);
					
				}
				mfile.transferTo(serverFullName);
			}
			
			if(audiofilename==null) {
				int result3 = sqlSession.getMapper(PartyImpl.class).partyAction2(
						name, party3, title, contents, audiocontents, kind, point);
				System.out.println("입력결과 = "+ result3);
				
				model.addAttribute("audio_idx", party3);
			}
			else {
				int result2 = sqlSession.getMapper(PartyImpl.class).partyAction(
						name, party3, title, contents, audiofilename, audiocontents, kind, point);
				System.out.println("입력결과 = "+ result2);
				
				model.addAttribute("audio_idx", party3);
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:view.do?audio_idx="+ party3;
	}
} 
