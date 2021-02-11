package com.kosmo.orecord;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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

import impl.AlbumImpl;
import impl.AudioBoardImpl;
import impl.FollowImpl;
import impl.LikeImpl;
import impl.McommentImpl;
import impl.MemberImpl;
import impl.MypageImpl;
import impl.PlayListImpl;
import model.AlbumDTO;
import model.AudioBoardDTO;
import model.MemberDTO;
import model.PlayListDTO;

@Controller
public class MyPageController {

	private static final MemberDTO MemberDTO = null;
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/{user_id}/record")
	public String record(@PathVariable String user_id, Model model, Principal principal, HttpServletRequest req) { 
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);	
		
		/*로그인 유저의 계정정보*/
		MemberDTO loginDTO = null;
		try {
			login_id = principal.getName();
			 loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/resources/img/default.jpg");
		}
		
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);
		
		return "mypage/record";
	}

	@RequestMapping("/{user_id}/album")
	public String album(@PathVariable String user_id, Model model, HttpServletRequest req, Principal principal) {
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		/*로그인 유저의 계정정보*/
		MemberDTO loginDTO = null;
		try {
			login_id = principal.getName();
			loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/resources/img/default.jpg");
		}
	
		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);

		return "mypage/album";
	}
	
	@RequestMapping("/{user_id}/playlist")
	public String playlist(@PathVariable String user_id, Model model, HttpServletRequest req, Principal principal) {
		
		String path = req.getContextPath();
		String login_id = null;
		
		/*계정정보*/
		MemberDTO memberDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(user_id);
		
		/*로그인 유저의 계정정보*/
		MemberDTO loginDTO = null;
		try {
			login_id = principal.getName();
			loginDTO = sqlSession.getMapper(MemberImpl.class).memberInfo(login_id);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		if(memberDTO.getImg()==null) {
			memberDTO.setImg(path+"/resources/img/default.jpg");
		}

		model.addAttribute("memberDTO", memberDTO);
		model.addAttribute("loginDTO", loginDTO);
		model.addAttribute("user_id", user_id);

		return "mypage/playlist";
	}
	
	/*회원삭제하기*/
	@RequestMapping("/memberDelete.do")
	public String memberDelete(HttpServletRequest req, Principal principal) {
		
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		int delete = sqlSession.getMapper(MypageImpl.class).memberDelete(id);
		
		if(delete==1) {
			System.out.println("회원삭제완료");
		}
		
		return "redirect:/main.do";
		
	}
	
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된UUID-2:"+uuid);
		return uuid;
	}
	
	@RequestMapping("/pwCheck.do")
	public String pwCheck(Principal principal, Model model, HttpServletRequest req) {
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String pw = req.getParameter("pw");
		String pw2 = req.getParameter("pw2");
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).memberView(id);
		model.addAttribute("dto", dto);
		
		System.out.println(pw + " "+ pw2);
		
		return "mypage/pwCheck";
	}
	
	/*회원수정폼*/
	@RequestMapping("/memberEdit.do")
	public String memberEdit(Principal principal, Model model) {
		String id = null;
		/*로그인 없이 접근시 nullpointerexception발생, security로 접근권한 설정해야함.*/
		try {
			id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		MemberDTO dto = sqlSession.getMapper(MypageImpl.class).memberView(id);
		model.addAttribute("dto", dto);
		
		//주소 나누기
		String[] addArr = dto.getAddress().split("\\/");
		model.addAttribute("addArr", addArr);
		
		String[] emailArr = dto.getEmail().split("\\@");
		model.addAttribute("emailArr", emailArr);
		
		
		return "mypage/memberEdit";
	}
	
	/*회원 수정하기*/
	@RequestMapping(value = "/memberEditAction.do", method = RequestMethod.POST)
	public String memberEditAction(Principal principal, MultipartHttpServletRequest req)
	{		
		
		//서버의 물리적경로 얻어오기
		String path = req.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		String id = null;
		
		try {
			
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
			id = principal.getName();
			
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
			int applyRow = sqlSession.getMapper(MypageImpl.class).memberEdit(pw, email, phone, address, intro, img, id);
			
			System.out.println("수정처리된 레코드수:"+ applyRow);
			System.out.println(pw +" "+ email+" " + phone+" " + address+" " + intro+" " + img+" " + id);
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/"+id+".do";
	}
	
	@RequestMapping("/mypageAlbum.do")
	public String mypageA(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		
		String user_id = req.getParameter("user_id");	
		
		/*페이징*/
		//1. 앨범 토탈카운트
		int albumTotalCount = sqlSession.getMapper(AlbumImpl.class).albumTotalCount(user_id);
		
		int pageSize = 5;
		int blockPage = 5;
		
		int nowPage = Integer.parseInt(req.getParameter("nowPage"));
		int start = (nowPage-1)*pageSize+1;
		int end = nowPage * pageSize;
		
		String pagingStr = "";
		
		//1.전체페이지 구하기
		int totalPage = 
		(int)(Math.ceil(((double)albumTotalCount/pageSize)));
		
		/*2.현재페이지번호를 통해 이전 페이지블럭에
		해당하는 페이지를 구한다.
		*/
		int intTemp = 
			(((nowPage-1) / blockPage) * blockPage) + 1;
		
		if(intTemp != 1) {
			//첫번째 페이지 블럭에서는 출력되지 않음
			//두번째 페이지 블럭부터 출력됨.
			pagingStr += ""
				+ "<a href='javascript:paging(1);'>"
				+ "<img src='../images/paging1.gif'></a>";
			pagingStr += "&nbsp;";
			pagingStr += ""
				+ "<a href='javascript:paging("+(intTemp-blockPage)+");'>"
				+ "<img src='../images/paging2.gif'></a>";
		}
					
		//페이지표시 제어를 위한 변수
		int blockCount = 1;
		/*
		4.페이지를 뿌려주는 로직 : blockPage의 수만큼 또는
			마지막페이지가 될때까지 페이지를 출력한다.
		*/
		while(blockCount<=blockPage && intTemp<=totalPage)
		{
			if(intTemp==nowPage) {
				pagingStr += "&nbsp;"+intTemp+"&nbsp;";
			}
			else {
				pagingStr += "&nbsp;<a href='javascript:paging("+intTemp+");'>"+
					intTemp+"</a>&nbsp;";
			}
			intTemp++;
			blockCount++;
		}
		
		//5.다음페이지블럭 & 마지막페이지 바로가기
		if(intTemp <= totalPage) {
			pagingStr += "<a href='javascript:paging("+intTemp+");'>"
				+ "<img src='../images/paging3.gif'></a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='javascript:paging("+totalPage+");'>"
				+ "<img src='../images/paging4.gif'></a>";
		}		
		
		/*로그인유저의 플레이리스트 가져오기*/
		String login_id = null;
		ArrayList<PlayListDTO> plList = null;
		try {
			login_id = principal.getName();
			plList = sqlSession.getMapper(PlayListImpl.class).select(login_id);
			
			if(plList.size()==0) {
				PlayListDTO dto = new PlayListDTO();
				dto.setPlname("default");
				plList.add(dto);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		ArrayList<AlbumDTO> albumList = sqlSession.getMapper(AlbumImpl.class).albumListPaging(user_id, start, end);
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		
		/*앨범*/
		for(AlbumDTO albumDTO : albumList) {
			if(albumDTO.getAlbumJacket()==null){
				albumDTO.setAlbumJacket(path+"/resources/img/default.jpg");
			}
			else {
				String fileName = albumDTO.getAlbumJacket();
				albumDTO.setAlbumJacket(path+"/resources/upload/"+fileName);
			}
		}
		
		/*음원*/
		for(AudioBoardDTO audioDTO : audioList) {
			
			System.out.println("이미지이름"+audioDTO.getImagename()); 
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/resources/img/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/resources/upload/"+fileName);
			}
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/resources/upload/"+fileName);
			

			/*음원에 대한 로그인 유저의 좋아요*/
			if(login_id!=null) {
				int likeResult = sqlSession.getMapper(LikeImpl.class).myLike(audioDTO.getAudio_idx(), login_id);
				System.out.println("likeResult"+likeResult);
				
				if(likeResult==1) {
					audioDTO.setLike(true);
				}
				else {
					audioDTO.setLike(false);
				}
			}
		}

		model.addAttribute("plList", plList);
		model.addAttribute("albumList", albumList);
		model.addAttribute("audioList", audioList);
		model.addAttribute("pagingStr", pagingStr);
		
		return "mypage/mypageAlbum";
	}
	
	@RequestMapping("/mypagePlay.do")
	public String mypageP(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		String user_id = req.getParameter("user_id");	
		String login_id = null;
		
		try {
			login_id = principal.getName();
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		/*1. 플레이리스트 가져오기*/
		ArrayList<PlayListDTO> plList = sqlSession.getMapper(PlayListImpl.class).myplaylist(user_id);
		/*2. for문으로 플레이리스트의 앨범이름을 hashset에 넣은 후 map('albumName', albumList)에 넣기*/
		HashSet<String> plSet = new HashSet<String>();
		for(PlayListDTO plDTO : plList) {
			plSet.add(plDTO.getPlname());
			
			if(plDTO.getImagename()==null) {
				plDTO.setImagename(path+"/resources/img/default.jpg");
			}
			else {
				String fileName = plDTO.getImagename();
				plDTO.setImagename(path+"/resources/upload/"+fileName);
			}
			String fileName = plDTO.getAudiofilename();
			plDTO.setAudiofilename(path+"/resources/upload/"+fileName);
			
			
			/*음원에 대한 로그인 유저의 좋아요*/
			if(login_id!=null) {
				int likeResult = sqlSession.getMapper(LikeImpl.class).myLike(plDTO.getAudio_idx(), login_id);
				System.out.println("likeResult"+likeResult);
				
				if(likeResult==1) {
					plDTO.setLike(true);
				}
				else {
					plDTO.setLike(false);
				}
			}
		}
		
		/*3.플레이리스트 DTO map에 넣기*/		
		model.addAttribute("plSet", plSet);//폴더명
		model.addAttribute("plList",plList);//전체리스트
		
		return "mypage/mypagePlay";
	}
	
	@RequestMapping("/mypageRecord.do")
	public String mypageR(Principal principal, HttpServletRequest req, Model model){
		
		String path = req.getContextPath();
		String user_id = req.getParameter("user_id");
		
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);	
		
		/*로그인유저의 플레이리스트 가져오기*/
		String login_id = null;
		ArrayList<PlayListDTO> plList = null;
		try {
			login_id = principal.getName();
			plList = sqlSession.getMapper(PlayListImpl.class).select(login_id);
			
			if(plList.size()==0) {
				PlayListDTO dto = new PlayListDTO();
				dto.setPlname("default");
				plList.add(dto);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		/*음원*/
		for(AudioBoardDTO audioDTO : audioList) {
			
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/resources/img/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/resources/upload/"+fileName);
			}
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/resources/upload/"+fileName);
			
			/*음원에 달린 코맨트*/
			int commentCount = sqlSession.getMapper(McommentImpl.class).audioCommentCount(audioDTO.getAudio_idx());
			
			audioDTO.setCommentCount(commentCount);
			
			System.out.println("좋아요:"+audioDTO.getLike_count());
			
			/*음원에 대한 로그인 유저의 좋아요*/
			if(login_id!=null) {
				int likeResult = sqlSession.getMapper(LikeImpl.class).myLike(audioDTO.getAudio_idx(), login_id);
				System.out.println("likeResult"+likeResult);
				
				if(likeResult==1) {
					audioDTO.setLike(true);
				}
				else {
					audioDTO.setLike(false);
				}
			}	
		}
		model.addAttribute("plList", plList);
		model.addAttribute("audioList", audioList);
		
		return "mypage/mypageRecord";
	}
	
	@RequestMapping("/mypageFollowTrack.do")
	@ResponseBody
	public Map<String, Object> mypageF(Principal principal, HttpServletRequest req){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_id = req.getParameter("user_id");
		
		System.out.println("팔로우 유저" +user_id);
		
		/*팔로우*/
		int followingCount = sqlSession.getMapper(FollowImpl.class).followingCount(user_id);
		int followerCount = sqlSession.getMapper(FollowImpl.class).followerCount(user_id);
		
		/*오디오수*/
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(AudioBoardImpl.class).audioList(user_id);
		
		System.out.println("오디오"+audioList.size());
		
		map.put("followingCount", followingCount);
		map.put("followerCount", followerCount);
		map.put("trackCount", audioList.size());
		
		return map;
	}
	
}