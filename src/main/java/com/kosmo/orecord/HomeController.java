package com.kosmo.orecord;

import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import model.AlbumDTO;
import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import util.Calculate;
import impl.AudioBoardImpl;
import impl.FollowImpl;
import impl.MainImpl;

/**
 * Handles requests for the application home page. 
 */
@Controller 
public class HomeController {
	Calculate cal = new Calculate();
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class); 

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		
		return "home";
	}

	@Autowired
	private SqlSession sqlSession;

	/* 프레임 메인 */
	@RequestMapping("/main.do")
	public String index(Model model, HttpServletRequest req,
			HttpSession session, Principal principal) {
		
		String path = req.getContextPath();
		
		//로그인
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		//내 팔로잉목록 최대 4개 출력
		ArrayList<FollowDTO> following = new ArrayList<FollowDTO>();
		if(id!="") {
				following = sqlSession.getMapper(FollowImpl.class).following(id);
		HashSet<String> followings = new HashSet<String>();
		for( FollowDTO f : following) {
			followings.add(f.getFollowing_id());
		}}
		
		
		//메인페이지에 출력할 오디오게시글 불러옴
		ArrayList<AudioBoardDTO> audiolist = sqlSession.getMapper(AudioBoardImpl.class).mainAudioList(0,7,1,8);
		
		for(AudioBoardDTO audioDTO : audiolist) {
			
			System.out.println(audioDTO.getImagename()); 
			if(audioDTO.getImagename()==null){
				audioDTO.setImagename(path+"/resources/img/default.jpg");
			}
			else {
				String fileName = audioDTO.getImagename();
				audioDTO.setImagename(path+"/resources/upload/"+fileName);
			}
			
			String fileName = audioDTO.getAudiofilename();
			audioDTO.setAudiofilename(path+"/resources/upload/"+fileName);
		}
		
		HashMap<Integer, Integer> commentC = cal.cCount(audiolist,sqlSession);
		//인기순정렬 맵으로넣음
		model.addAttribute("audiolist", audiolist);
		//댓글수 카운트해서 넣음
		model.addAttribute("commentC", commentC);
		
		
		//audio_idx별 앨범이름 넣음
		ArrayList<AlbumDTO> album = new ArrayList<AlbumDTO>();
		for(AudioBoardDTO dto : audiolist) {
			album.add(sqlSession.selectOne("getalbum",dto.getAlbum_idx()));
		}
		model.addAttribute("album",album);
		
		
		ArrayList<LikeDTO> likes = loadLike(audiolist);
		ArrayList<FollowDTO>  follows = loadFollow(audiolist);
		model.addAttribute("likes",likes);
		model.addAttribute("follows",follows);
		return "main/main";
		
	}
	
	@RequestMapping("/mainload.do")
	@ResponseBody
	public Map<String, Object> mainload(Model model, HttpServletRequest req,
			HttpSession session, Principal principal) {
		Map<String, Object> map = new HashMap<String, Object>();
		int dateCheck = 0;
		//현재 로드된 table수를 불러옴
		int loadedCount = Integer.parseInt(req.getParameter("loadlength"));
		int totalAudio = sqlSession.selectOne("audioCount");
		String logId = req.getParameter("id");
		
		ArrayList<AudioBoardDTO> audiolist = sqlSession.getMapper(AudioBoardImpl.class).mainAudioList(dateCheck,dateCheck+6,loadedCount+1,loadedCount+8);
		System.out.println(audiolist.size());
		if(audiolist.size()==0) {
				dateCheck+=7;
				audiolist=sqlSession.getMapper(AudioBoardImpl.class).mainAudioList(dateCheck,dateCheck+6,loadedCount+1,loadedCount+8);
				if(audiolist.size()==0) {
					map.put("nomoreFeed", "이전 게시물이 없습니다.");
				}
		}else {
		HashMap<Integer, Integer> commentC = cal.cCount(audiolist,sqlSession);
		//인기순정렬 맵으로넣음
		model.addAttribute("audiolist", audiolist); 
		//댓글수 카운트해서 넣음
		model.addAttribute("commentC", commentC);
		
		
		//audio_idx별 앨범이름 넣음
		ArrayList<AlbumDTO> album = new ArrayList<AlbumDTO>();
		for(AudioBoardDTO dto : audiolist) {
			album.add(sqlSession.selectOne("getalbum",dto.getAlbum_idx()));
		}
		model.addAttribute("album",album);
		
		
		ArrayList<LikeDTO> likes = loadLike(audiolist);
		ArrayList<FollowDTO>  follows = loadFollow(audiolist);
		model.addAttribute("likes",likes);
		model.addAttribute("follows",follows);
		
		map.put("audiolist", audiolist);
		map.put("commentC", commentC);
		map.put("album", album);
		map.put("likes", likes);
		map.put("follows", follows);
		}
		map.put("audiolist", audiolist);
		return map;
		
	}
	public ArrayList<FollowDTO>  loadFollow(ArrayList<AudioBoardDTO> audiolist) {
		//불러온 오디오 리스트에 있는 게시자 ID만 HashSet으로 만듦
		HashSet<String> followIds = new HashSet<String>();
		//쿼리로 불러온 모든 게시물의 팔로워와 팔로우 아이디를 중복없이 HashMap에 저장
		ArrayList<FollowDTO> followlist = new ArrayList<FollowDTO>();

		for (int i = 0; i < audiolist.size(); i++) {
			followIds.add(audiolist.get(i).getId());
		}
		Iterator<String> it  = followIds.iterator();
		
		while(it.hasNext()) {
			String a = it.next();
			ArrayList<FollowDTO> follow = sqlSession.getMapper(MainImpl.class).mainFollwerIdList(a);
			for (int i = 0; i < follow.size(); i++) {
				
				followlist.add(follow.get(i));
			}
		}
		System.out.println(followlist.size());

		return followlist;
		
	}
	public ArrayList<LikeDTO> loadLike(ArrayList<AudioBoardDTO> audiolist) {
		//불러온 오디오 리스트에 있는 게시자 ID만 HashSet으로 만듦
		HashSet<Integer> likeIds = new HashSet<Integer>();
		//쿼리로 불러온 모든 게시물의 좋아요와 좋아요한 아이디를 중복없이 HashMap에 저장
		ArrayList<LikeDTO> likeList = new ArrayList<LikeDTO>();
		for (int i = 0; i < audiolist.size(); i++) {
			likeIds.add(audiolist.get(i).getAudio_idx());
		}
		Iterator<Integer> it  = likeIds.iterator();
		
		while(it.hasNext()) {
			int a = it.next();
			ArrayList<LikeDTO> likes = sqlSession.getMapper(MainImpl.class).mainLikeIdList(a);
			for (int i = 0; i < likes.size(); i++) {
				
				likeList.add( likes.get(i));
			}
		}
		return likeList;
		
	}

	
}
