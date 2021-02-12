package com.kosmo.orecord;
 
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import impl.PartyImpl;
import model.AudioBoardDTO;
import model.PartyBoardDTO;

@Controller
public class PartyController {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//협업신청목록
	@RequestMapping("/board/partyList.do")
	public String partyList(Model model, HttpServletRequest req, Principal principal) {
		
		String partyIdx = req.getParameter("audio_idx");
		System.out.println("audio_idx????"+ partyIdx);
		
		ArrayList<PartyBoardDTO> partyList = null;
		
		if(partyIdx!=null) {
			partyList =
				sqlSession.getMapper(PartyImpl.class).partyList(
					Integer.parseInt(partyIdx));
		}
		
//		for(PartyBoardDTO dto : partyList) {
//			String temp = dto.getTitle().replace("\r\n", "<br/>");
//			dto.setTitle(temp);
//			String temp2 = dto.getContents().replace("\r\n", "<br/>");
//			dto.setContents(temp2);
//		}
		model.addAttribute("audio_idx", partyIdx);
		model.addAttribute("partyList", partyList);
		
		return "board/partyList";
	}
	
	//협업신청폼
	@RequestMapping("/board/partyWrite.do")
	public String partyWrite(Model model, HttpServletRequest req, Principal principal) {
		
		String party1 = req.getParameter("audio_idx");
		System.out.println("audio_idx = "+ party1);
		
		/*절대경로*/
		String path = req.getContextPath();
		
		//매퍼 호출
		AudioBoardDTO party =
				sqlSession.getMapper(PartyImpl.class).partyWrite(
				Integer.parseInt(req.getParameter("audio_idx")));
		
		//모델객체에 저장
		model.addAttribute("audio_idx", party1);
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
			MultipartHttpServletRequest req, Principal principal) {
		
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
	
	//협업신청서 상세페이지
	@RequestMapping("/board/partyView.do")
	public String partyView(Model model, HttpServletRequest req, Principal principal,
			HttpServletResponse resp) {
		
		//idx값이 넘어오는지 확인
		String idx = req.getParameter("party_idx");
		System.out.println("party_idx = "+ idx);
		String audiofilename = req.getParameter("audiofilename");
		
		/*절대경로*/
		String path = req.getContextPath();
		
		
		//Mapper 호출
		PartyBoardDTO partyView =
			sqlSession.getMapper(PartyImpl.class).partyView(
				Integer.parseInt(req.getParameter("party_idx")),
				req.getParameter("id"));
			
		partyView.setAudiofilename(path+"/resources/upload/"+partyView.getAudiofilename());
			
		model.addAttribute("partyView", partyView);
		model.addAttribute("party_idx", idx);
		
		return "board/partyView";
	}
	
	//파일 다운로드
	@RequestMapping("/board/download.do")
	public ModelAndView downLoad(HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		
		//저장된 파일명
		String fileName = req.getParameter("audiofilename");
		System.out.println("저장된 파일명 : "+ fileName);
		String[] file2 = fileName.split("/");
		String[] file3 = fileName.split("\\.");
		
		//원본 파일명
		String oriFileName = req.getParameter("oriFileName");
		String oriFileName2 = oriFileName+"."+file3[1];
		System.out.println("원본 파일명 : "+ oriFileName2);
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		//경로와 파일명을 통해 File객체 생성
		File downloadFile = new File(path+"/"+file2[4]);
		//해당 경로에 파일이 있는지 확인
		if(!downloadFile.canRead()) {
			throw new Exception("파일을 찾을수 없습니다.");
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileDownloadView");//다운로드 할 View명
		mv.addObject("downloadFile", downloadFile);//저장된파일명
		mv.addObject("oriFileName", oriFileName2);//원본파일명
		
		return mv;
	}
} 
