package com.kosmo.Orecord;

import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Locale;

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
		ArrayList<AudioBoardDTO> audiolist = sqlSession.getMapper(AudioBoardImpl.class).mainAudioList();
		
		HashMap popMap = cal.calcuPop(audiolist);
		HashMap<Integer, Integer> commentC = cal.cCount(audiolist,sqlSession);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap", popMap);
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
