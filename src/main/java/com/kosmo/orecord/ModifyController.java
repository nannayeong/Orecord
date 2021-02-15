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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.ViewImpl;
import model.AudioBoardDTO;
import model.MCommentDTO;

@Controller
public class ModifyController {
	
	@Autowired
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//수정 페이지
	@RequestMapping("/board/modify.do")
	public String Modify(Model model, HttpServletRequest req, Principal principal) {
		
		//값이 넘어오는지 확인
		String qwer = req.getParameter("audio_idx");
		System.out.println("audio_idx = "+ qwer);
		String name = principal.getName();
		System.out.println("id = "+ name);
		
		AudioBoardDTO modify =
			sqlSession.getMapper(ViewImpl.class).modify(
				Integer.parseInt(req.getParameter("audio_idx")),
				principal.getName());
		
		//모델객체에 데이터 저장
		model.addAttribute("modify", modify);
		
		return "board/modify";
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
	
	//수정처리 
	@RequestMapping(value="/board/modifyAction.do", method=RequestMethod.POST)
	public String modifyAction(Principal principal,
			Model model, MultipartHttpServletRequest req) {
		
		//수정처리 전 로그인 확인
		if(principal.getName()==null) {
			return "redirect:view.do"; 
		}
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		String id = null;
		
		
		int modi1 = Integer.parseInt(req.getParameter("audio_idx"));
		System.out.println("audio_idx2 = "+ modi1);
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = req.getParameter("audiofilename");
			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.
			String audiotitle = req.getParameter("audiotitle");
			id = principal.getName();
			String artistname = req.getParameter("artistname");
			String contents = req.getParameter("contents");
			String category = req.getParameter("country")+" "+req.getParameter("genre");
			String audiofilename = null;
			String imagename = null;
			
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
			
			//오디오,이미지X > 오디오X > 이미지X > 오디오,이미지O
			if(audiofilename==null && imagename==null) {
				int result3 = sqlSession.getMapper(ViewImpl.class)
					.modifyAction4(audiotitle, artistname, contents,
						category, modi1, id);
				System.out.println("오디오,이미지X="+result3);
				model.addAttribute("audio_idx", modi1);
			}
			else if(audiofilename==null) {
				int result = sqlSession.getMapper(ViewImpl.class)
					.modifyAction2(audiotitle, artistname,
						contents, imagename, category, modi1, id);
				System.out.println("오디오X="+ result);
				model.addAttribute("audio_idx", modi1);
			}
			else if(imagename==null) {
				int result2 = sqlSession.getMapper(ViewImpl.class)
					.modifyAction3(audiotitle, artistname, contents,
						audiofilename, category, modi1, id);
				System.out.println("이미지X="+ result2);
				model.addAttribute("audio_idx", modi1);
			}
			else {
				int applyRow = sqlSession.getMapper(ViewImpl.class)
						.modifyAction(audiotitle, artistname, contents,
								audiofilename, imagename, category, modi1, id);
				System.out.println("수정처리된 레코드수 : "+ applyRow);
				
				//모델객체에 idx저장
				model.addAttribute("audio_idx", modi1);
			}
			
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:view.do";
	}
	
	
}
