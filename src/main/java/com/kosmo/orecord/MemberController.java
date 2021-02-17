package com.kosmo.orecord;

import java.io.File; 
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import impl.MemberImpl;

@Controller
public class MemberController {
	
	@Autowired
	private SqlSession sqlSession;
	
	/*로그인*/
	@RequestMapping("/member/login.do")
	public String Login(Model model, Principal principal, HttpServletRequest req) {

		String id = "";
		try {
			id = principal.getName();
			System.out.println("id=" + id);
		} catch (Exception e) {
			e.printStackTrace();
		}  
		
		/*인증페이지로 이동하기 전 url기억*/
		String referrer = req.getHeader("Referer");
	    req.getSession().setAttribute("prevPage", referrer);
	    
		model.addAttribute("id", id);
		
		return "member/login";
	}
	
	/*로그인 이전페이지로 이동*/
	@RequestMapping("/member/loginPrev.do")
	public String loginP(HttpSession session) {
		
		String prv = session.getAttribute("prevPage").toString();
		System.out.println(prv);
		
		return "redirect:"+prv;
	}
	
	/* 카카오로그인 테스트 */
	@RequestMapping("/member/login")
    public String kakao(@RequestParam(value = "code", required = false) String code) throws Exception{
        System.out.println("#########" + code);
        return "testPage";
    }
	
	
	
	/*로그아웃@*/
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET) 
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication(); 
		
		if (auth != null){ 
			new SecurityContextLogoutHandler().logout(request, response, auth); 
			System.out.println("로그아웃했따.");
		} 
		return "redirect:member/login.do"; 
	}
	
	/*약관동의*/
	@RequestMapping("/member/membershipsub.do")
	public String membershipsub() {
		return "member/membershipsub";
	}
	
	/*회원가입*/
	@RequestMapping("/member/membership.do")
	public String membership() {
		return "member/membership";
	}
	
//	/*비밀번호 찾기 폼*/
//	@RequestMapping("/pwfind.do")
//	public String pwfind() {
//		return "";
//	}
	 
	@RequestMapping("/member/accessDenied.do")
	public String AccessDenied() {
		return "member/accessDenied";
	}	
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	
	/*회원가입처리*/
	@RequestMapping(value = "/member/membershipAction.do", method = RequestMethod.POST)
	public String memberAction(Model model, MultipartHttpServletRequest req) {

		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		try {
			//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			String nickname = req.getParameter("nickname");
			String email = req.getParameter("email_1")+"@"+req.getParameter("email_2");
			String phone = req.getParameter("phone");
			String address = req.getParameter("address")+"/"+req.getParameter("addr1")+"/"+req.getParameter("addr2");
			String intro = req.getParameter("intro");
			String img= null;
			System.out.println(id);
			
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
			
			System.out.println(id+"**"+ pw+"**"+nickname+"**"+email+"**"+phone+"**"+address+"**"+intro+"**"+img);
			int result = sqlSession.getMapper(MemberImpl.class).
					membershipInfo(id, pw, nickname, email, phone, address, intro, img);
			
			if(result==1) {
				System.out.println("성공!");
				model.addAttribute("memberResult", "success");
			}
			else {
				System.out.println("회원가입 실패..");
				model.addAttribute("memberResult", "fail");
			}
			
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/member/login.do";
	}
}

