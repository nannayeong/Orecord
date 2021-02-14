package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.AdminImpl;
import impl.AlbumImpl;
import impl.PartyImpl;
import impl.ViewImpl;
import model.AlbumDTO;
import model.AudioBoardDTO;
import model.ChargeDTO;
import model.ExchangeDTO;
import model.MCommentDTO;
import model.MemberDTO;
import model.PartyBoardDTO;
import model.ReportDTO;
import model.SponsorshipDTO;

@Controller
public class AdminController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//회원리스트보기
	@RequestMapping("/admin/main")
	public String main(Model model, HttpServletRequest req, MemberDTO memberDTO) {
		
		ArrayList<MemberDTO> lists = sqlSession.getMapper(AdminImpl.class).listPage(memberDTO);
		
		model.addAttribute("lists", lists);
		
		return "admin/main";
	}
	
	/*회원삭제하기*/
	@RequestMapping("/admin/admemberDelete.do")
	public String memberDelete(HttpServletRequest req, Model model) {
		
		int delete = sqlSession.getMapper(AdminImpl.class).memberDelete(req.getParameter("id"));
		model.addAttribute("delete", delete);
		
		if(delete == 1) {
			System.out.println("삭제완료");			
		}
		
		return "redirect:/admin/main";
		
	}
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	/*회원수정폼*/
	@RequestMapping("/admin/admemberEdit.do")
	public String memberEdit(Principal principal, Model model, HttpServletRequest req) {
		String id1 = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id1= principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String id = req.getParameter("id");
		
		MemberDTO dto = sqlSession.getMapper(AdminImpl.class).memberView(id);
		model.addAttribute("dto", dto);
		
		//주소 나누기
		String[] addArr = dto.getAddress().split("\\/");
		model.addAttribute("addArr", addArr);
		
		String[] emailArr = dto.getEmail().split("\\@");
		model.addAttribute("emailArr", emailArr);
		
		
		return "/admin/memberEdit";
	}
	
	/*회원 수정하기*/
	@RequestMapping(value = "/admin/admemberEditAction.do", method = RequestMethod.POST)
	public String memberEditAction(Principal principal, MultipartHttpServletRequest req)
	{		
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		String id = null;
		
		try {
			id = principal.getName();
			//업로드폼의 file속성의 필드를 가져온다.
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			String pw = req.getParameter("pw");
			String email = req.getParameter("email_1")+"@"+req.getParameter("email_2");
			String phone = req.getParameter("phone");
			String address = req.getParameter("address")+"/"+req.getParameter("addr1")+"/"+req.getParameter("addr2");
			String intro = req.getParameter("intro");
			String img = req.getParameter("img");
			String user_id = req.getParameter("id");
			
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
				img = originalName;
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
					img = saveFileName;
					System.out.println("imagename"+img);
				}
				
				mfile.transferTo(serverFullName);
			}
			
			//수정폼에서 전송한 모든 폼값을 한꺼번에 저장한 커맨드객체를 사용한다. 
			int applyRow = sqlSession.getMapper(AdminImpl.class).memberEdit(pw, email, phone, address, intro, img, user_id);
			
			System.out.println("수정처리된 레코드수:"+ applyRow);
			System.out.println(pw +" "+ email+" " + phone+" " + address+" " + intro+" " + img+" " + user_id);
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/main";
	}
	
	/*오디오리스트*/
	@RequestMapping("/admin/adaudioboardList.do")
	public String adaudioboardList(Model model, AudioBoardDTO audioBoardDTO) {
		
		ArrayList<AudioBoardDTO> adaudio = sqlSession.getMapper(AdminImpl.class).adAudioList(audioBoardDTO);
		
		model.addAttribute("adaudio", adaudio);
		
		return "admin/adaudioboardList";
	}
	
	
	/*앨범리스트*/
	@RequestMapping("/admin/adalbumList.do")
	public String adalbumList(Model model, AlbumDTO albumDTO) {
		
		ArrayList<AlbumDTO> adalbum = sqlSession.getMapper(AdminImpl.class).adalbumList(albumDTO);
		
		model.addAttribute("adalbum", adalbum);
		
		return "admin/adalbumList";
	}
	/*앨범수정폼*/
	@RequestMapping("/admin/adalbumEdit.do")
	public String adalbumEdit(Model model, HttpServletRequest req, AlbumDTO albumDTO) {
		
		int album_idx = Integer.parseInt(req.getParameter("album_idx"));
		System.out.println(album_idx+"-------------------------------");
		
		AlbumDTO adalbumEdit = sqlSession.getMapper(AdminImpl.class).adalbumView(album_idx);
		model.addAttribute("adalbumEdit", adalbumEdit);
		
		return "admin/adalbumEdit";
	}
	/*앨범 수정하기*/
	@RequestMapping("/admin/adalbumEditAction.do")
	public String adalbumEditAction(MultipartHttpServletRequest req,Principal principal) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		int album_idx = Integer.parseInt(req.getParameter("album_idx"));
		String albumName = req.getParameter("albumName");
		String albumJacket = req.getParameter("imagename");
		String login_id = null;
		
		System.out.println("어드민앨범수정");
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
			
			System.out.println("앨범이름:"+albumName +"번호"+ album_idx + "아이디"+login_id + "이미지"+albumJacket);
			if(albumJacket==null) {
				sqlSession.getMapper(AdminImpl.class).AlbumNoJacketEdit(album_idx, albumName);
			}
			sqlSession.getMapper(AdminImpl.class).adalbumEdit(albumName, albumJacket, album_idx);
		}
		catch(Exception e) {
			System.out.println("로그인"+e.getMessage());
		}
		
		return "redirect:/admin/adalbumList.do";
	}
	/*앨범 삭제하기*/
	@RequestMapping("/admin/adalbumDelete.do")
	public String adalbumDelete(HttpServletRequest req) {
		
		int album_idx = Integer.parseInt(req.getParameter("album_idx"));
		
		int adalbumDelete = sqlSession.getMapper(AdminImpl.class).adalbumDelete(album_idx);
		if(adalbumDelete==1) {
			System.out.println("어드민앨범 삭제성공");
		}
		
		return "redirect:/admin/adalbumList.do";
	}
	
	/*후원리스트*/
	@RequestMapping("/admin/sponsorshipList.do")
	public String sponsorshipList(Model model, SponsorshipDTO sponsorshipDTO) {
		
		ArrayList<SponsorshipDTO> sponsorshipList = sqlSession.getMapper(AdminImpl.class).sponsorshipList(sponsorshipDTO);
		
		model.addAttribute("sponsorshipList", sponsorshipList);
		
		return "admin/sponsorshipList";
	}
	/*후원수정폼*/
	@RequestMapping("/admin/sponsorshipEdit.do")
	public String sponsorshipEdit(Model model, HttpServletRequest req) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		SponsorshipDTO spondto = sqlSession.getMapper(AdminImpl.class).sponsorshipView(idx);
		System.out.println(spondto.getIdx()+"---------------------------------");
		model.addAttribute("spondto", spondto);
		
		return "admin/sponsorshipEdit";
	}
	/*후원 수정하기*/
	@RequestMapping("/admin/sponsorshipEditAction.do")
	public String sponsorshipEditAction(Model model, HttpServletRequest req) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		int sponPoint = Integer.parseInt(req.getParameter("sponPoint"));
		String patronId = req.getParameter("patronId");
		
		sqlSession.getMapper(AdminImpl.class).sponsorshipEdit(sponPoint, patronId, idx);
		
		return "redirect:/admin/sponsorshipList.do";
	}
	/*후원 삭제하기*/
	@RequestMapping("/admin/sponsorDelete.do")
	public String sponsorDelete(Model model, HttpServletRequest req) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		int sponsorDelete = sqlSession.getMapper(AdminImpl.class).sponsorshipDelete(idx);
		if(sponsorDelete==1) {
			System.out.println("어드민후원삭제 성공");
		}
		
		return "redirect:/admin/sponsorshipList.do";
		
	}
	
	/*충전리스트*/
	@RequestMapping("/admin/chargeList.do")
	public String chargeList(Model model, ChargeDTO chargeDTO) {
		
		ArrayList<ChargeDTO> chargeList = sqlSession.getMapper(AdminImpl.class).chargeList(chargeDTO);
		
		model.addAttribute("chargeList", chargeList);
		
		return "admin/chargeList";
	}
	/*충전 수정폼*/
	@RequestMapping("/admin/chargeEdit.do")
	public String chargeEdit(Model model, HttpServletRequest req) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		ChargeDTO chargeDTO = sqlSession.getMapper(AdminImpl.class).chargeView(idx);
		model.addAttribute("chargeDTO", chargeDTO);
		System.out.println(chargeDTO.getIdx()+"-------------------");
		return "admin/chargeEdit";
	}
	/*충전 수정하기*/
	@RequestMapping("/admin/chargeEditAction.do")
	public String chargeEditAction(HttpServletRequest req) {
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		//자꾸 널값나옴..... ㅜㅜㅠ
		int totalPayment = Integer.parseInt(req.getParameter("totalPayment"));
		int VAT = Integer.parseInt(req.getParameter("VAT"));
		int chargePoint = Integer.parseInt(req.getParameter("chargePoint"));
		String paymentType = req.getParameter("paymentType");
		
		sqlSession.getMapper(AdminImpl.class).chargeEdit(totalPayment, VAT, chargePoint, paymentType, idx);
		
		return "redirect:/admin/chargeList.do";
	}
	/*충전 삭제하기*/
	@RequestMapping("/admin/chargeDelete.do")
	public String chargeDelete(HttpServletRequest req){
		
		int idx = Integer.parseInt(req.getParameter("idx"));
		
		int chargeDelete = sqlSession.getMapper(AdminImpl.class).chargeDelete(idx);
		
		if(chargeDelete==1) {
			System.out.println("어드민 충전 삭제성공");
		}
		
		return "redirect:/admin/chargeList.do";
	}
	
	
	/*환전리스트*/
	@RequestMapping("/admin/exchangeList.do")
	public String exchangeList(Model model, ExchangeDTO exchangeDTO) {
		
		ArrayList<ExchangeDTO> exchangeList = sqlSession.getMapper(AdminImpl.class).exchangeList(exchangeDTO);
		
		model.addAttribute("exchangeList", exchangeList);
		
		return "admin/exchangeList";
	}
	/*환전수정폼*/
	
	
	/*댓글리스트*/
	@RequestMapping("/admin/mCommentList.do")
	public String mCommentList(Model model, MCommentDTO mCommentDTO) {
		
		ArrayList<MCommentDTO> mCommentList = sqlSession.getMapper(AdminImpl.class).mCommentList(mCommentDTO);
		
		model.addAttribute("mCommentList", mCommentList);
		
		return "admin/mCommentList";
	}
	/*댓글 수정폼*/
	@RequestMapping("/admin/mCommentEdit.do")
	public String mCommentEdit(Model model, HttpServletRequest req) {
		
		int comment_idx = Integer.parseInt(req.getParameter("comment_idx"));
		
		MCommentDTO mCommentDTO = sqlSession.getMapper(AdminImpl.class).mCommentView(comment_idx);
		
		model.addAttribute("mCommentDTO", mCommentDTO);
		
		return "admin/mCommentEdit";
	}
	/*댓글 수정하기*/
	@RequestMapping("/admin/mCommentEditAction.do")
	public String mCommentEditAction(Model model, HttpServletRequest req) {
		
		int comment_idx = Integer.parseInt(req.getParameter("comment_idx"));
		String contents = req.getParameter("contents");
		
		sqlSession.getMapper(AdminImpl.class).mCommentEdit(contents, comment_idx);
		
		return "redirect:/admin/mCommentList.do";
	}
	/*댓글삭제하기*/
	@RequestMapping("/admin/mCommentDelete.do")
	public String mCommentDelete(HttpServletRequest req) {
		
		int comment_idx = Integer.parseInt(req.getParameter("comment_idx"));
		
		sqlSession.getMapper(AdminImpl.class).mCommentDelete(comment_idx);
		
		return "redirect:/admin/mCommentList.do";
	}
	
	
	/*협업리스트*/
	@RequestMapping("/admin/partyList.do")
	public String partyList(Model model, PartyBoardDTO partyBoardDTO) {
		
		ArrayList<PartyBoardDTO> partyList = sqlSession.getMapper(AdminImpl.class).partyList(partyBoardDTO);
		
		model.addAttribute("partyList", partyList);
		
		return "admin/partyList";
	}
	/*협업수정폼*/
	@RequestMapping("/admin/partyEdit.do")
	public String partyEdit(Model model, HttpServletRequest req) {
		
		int party_idx = Integer.parseInt(req.getParameter("party_idx"));
		
		PartyBoardDTO partyBoardDTO = sqlSession.getMapper(AdminImpl.class).partyView(party_idx);
		model.addAttribute("partyBoardDTO", partyBoardDTO);
		
		return "admin/partyEdit";
	}
	/*협업수정하기*/
	@RequestMapping("/admin/partyEditAction.do")
	public String partyEditAction(MultipartHttpServletRequest req, Model model, Principal principal) {
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		
		String name = null;
		int party_idx = Integer.parseInt(req.getParameter("party_idx"));
		int audio_idx = Integer.parseInt(req.getParameter("audio_idx"));
		System.out.println("audio_idx = "+ audio_idx);
		
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
			
			int choice = Integer.parseInt(req.getParameter("choice"));
			
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
				int result3 = sqlSession.getMapper(AdminImpl.class).partyEdit1(audio_idx, title, contents, audiocontents, kind, point, 
						choice, party_idx);
				System.out.println("입력결과 = "+ result3);
				
				model.addAttribute("audio_idx", audio_idx);
			}
			else {
				int result2 = sqlSession.getMapper(AdminImpl.class).partyEdit(audio_idx, title, contents, audiocontents, audiofilename, 
						kind, point, choice, party_idx);
						
				System.out.println("입력결과 = "+ result2);
				
				model.addAttribute("audio_idx", audio_idx);
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/partyList.do";
	}
	/*협업삭제하기*/
	@RequestMapping("/admin/partyDelete.do")
	public String partyDelete(HttpServletRequest req) {
		
		int party_idx = Integer.parseInt(req.getParameter("party_idx"));
		
		sqlSession.getMapper(AdminImpl.class).partyDelete(party_idx);
		
		return "redirect:/admin/partyList.do";
	}
	
	/*신고리스트*/
	@RequestMapping("/admin/reportList.do")
	public String reportList(Model model, ReportDTO reportDTO) {
		
		ArrayList<ReportDTO> reportList = sqlSession.getMapper(AdminImpl.class).reportList(reportDTO);
		
		model.addAttribute("reportList", reportList);
		
		return "admin/reportList";
	}
	/*신고수정폼*/
	@RequestMapping("/admin/reportEdit.do")
	public String reportEdit(HttpServletRequest req, Model model) {
		
		int r_idx = Integer.parseInt(req.getParameter("r_idx"));
		
		ReportDTO reportDTO = sqlSession.getMapper(AdminImpl.class).reportView(r_idx);
		model.addAttribute("reportDTO", reportDTO);
		
		return "admin/reportEdit";
	}
	/*신고수정하기*/
	@RequestMapping("/admin/reportEditAction.do")
	public String reportEditAction(HttpServletRequest req) {
		
		int r_idx = Integer.parseInt(req.getParameter("r_idx"));
		String r_id = req.getParameter("r_id");
		String kind = req.getParameter("kind");
		String reason = req.getParameter("reason");
		
		sqlSession.getMapper(AdminImpl.class).reportEdit(r_id, kind, reason, r_idx);
		
		return "redirect:/admin/reportList.do";
	}
	/*신고삭제*/
	@RequestMapping("/admin/reportDelete.do")
	public String reportDelete(HttpServletRequest req) {
		
		int r_idx = Integer.parseInt(req.getParameter("r_idx"));
		
		int reportDelete = sqlSession.getMapper(AdminImpl.class).reportDelete(r_idx);
		
		if(reportDelete==1) {
			System.out.println("어드민리포트 삭제성공");
		}
		
		return "redirect:/admin/reportList.do";
	}
}
