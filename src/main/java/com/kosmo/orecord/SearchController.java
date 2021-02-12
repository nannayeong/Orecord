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

import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import model.MemberDTO;
import util.Calculate;
import impl.FollowImpl;
import impl.MainImpl;
import impl.SearchImpl;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class SearchController {
	Calculate cal = new Calculate();
	@Autowired
	private SqlSession sqlSession;
 
	/* 프레임 메인 */
	@RequestMapping("/search.do") 
	////////////검색메인(각5개항목 나열)
	public String search(Model model, HttpServletRequest req, Principal principal) {
		String searchWord = req.getParameter("searchWord");
		//아티스트명으로 검색한 오디오의 id모음
		//로그인
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		
		
		/////////제목으로검색 게시물5개  1번
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(SearchImpl.class).searchAudioM(searchWord);
		//아티스트명으로 검색5개
		String path = req.getContextPath();
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
		}
		HashMap popMap1 = cal.calcuPop(audioList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap1", popMap1);
		HashMap<Integer, Integer> commentC1 = cal.cCount(audioList,sqlSession);
		model.addAttribute("commentC1", commentC1);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes1 = loadLike(audioList);
		model.addAttribute("likes1",likes1);
		

		/////////////아티스트명으로 게시글찾기 2번
		ArrayList<AudioBoardDTO> audioByNameList = sqlSession.getMapper(SearchImpl.class).searchAudioByArtistM(searchWord);
		//아티스트명으로 검색5개
		for(AudioBoardDTO audioDTO : audioByNameList) {
			
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
		HashMap popMap2 = cal.calcuPop(audioByNameList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap2", popMap2);
		HashMap<Integer, Integer> commentC2 = cal.cCount(audioByNameList,sqlSession);
		model.addAttribute("commentC2", commentC2);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes2 = loadLike(audioByNameList);
		model.addAttribute("likes2",likes2);
		
		
		
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO, Integer>();
		//검색페이지에 출력할 오디오게시글 불러옴
		ArrayList<MemberDTO> artists = sqlSession.getMapper(SearchImpl.class).searchArtistM(searchWord);
		for(MemberDTO dto : artists) {
			String followingId = dto.getId();
			HashSet<String> followerSet = new HashSet<String>();
			ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).followers(followingId);
			for(FollowDTO fdto : follows) {
				followerSet.add(fdto.getUser_id());
			}
			memberMap.put(dto, follows.size());
		}
		ArrayList<MemberDTO> arrayByF = cal.arrayByFollow(memberMap);
		if(arrayByF.size()>8) {
		for(int i=arrayByF.size()-1;i>7;i--) {
			arrayByF.remove(i);
		}}
		model.addAttribute("artists",arrayByF);
		model.addAttribute("memberMap",memberMap);

		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		
		
		
		//컨텐츠로 검색
		ArrayList<AudioBoardDTO> byContents = sqlSession.getMapper(SearchImpl.class).searchContentM(searchWord);
		for(AudioBoardDTO audioDTO : byContents) {
			
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
		
		for(AudioBoardDTO audios : byContents) {
			String contents = cal.makeSearchText(audios.getContents(),searchWord);
			audios.setContents(contents);
		}
		
		
		HashMap<Integer,AudioBoardDTO> popMap3 = cal.calcuPop(byContents);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap3", popMap3);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes3 = loadLike(byContents);
		model.addAttribute("likes3",likes3);
		model.addAttribute("searchWord",searchWord);
		
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		
		
		return "main/searchMain";
	}
	
	@RequestMapping("/searchAudio.do")
	public String searchAudio(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(SearchImpl.class).search("AUDIOTITLE",searchWord,1,8);
		//아티스트명으로 검색
		ArrayList<LikeDTO> likes1 = loadLike(audioList);
		ArrayList<FollowDTO> follows1 = loadFollow(audioList);
		model.addAttribute("audioList",audioList);
		model.addAttribute("likes1",likes1);
		model.addAttribute("follows1",follows1);
		model.addAttribute("searchType","title");
		model.addAttribute("searchWord",searchWord);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/search";
	}
	
	@RequestMapping("/searchAudioLoad.do")
	public String searchAudioload(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		String searchWord = req.getParameter("searchWord");
		int loadedCount = Integer.parseInt(req.getParameter("loadlength"));
		int totalAudio = sqlSession.getMapper(SearchImpl.class).searchTotal("AUDIOTITLE", searchWord);
		ArrayList<AudioBoardDTO> audioList = new ArrayList<AudioBoardDTO>();
		if(totalAudio!=loadedCount) {
			audioList = sqlSession.getMapper(SearchImpl.class).search("audiotitle",searchWord,loadedCount+1,loadedCount+8);
		}
		
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes = loadLike(audioList);
		model.addAttribute("audiolist",audioList);
		model.addAttribute("likes",likes);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/audiolistAdd";
	}
	////////아티스트명으로 곡찾기
	@RequestMapping("/searchAudioByArtist.do")
	public String searchAudioByArtist(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		
		ArrayList<AudioBoardDTO> audioByNameList = sqlSession.getMapper(SearchImpl.class).search("artistname",searchWord,1,8);
		
		
		//아티스트명으로 검색5개
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes2 = loadLike(audioByNameList);
		model.addAttribute("likes2",likes2);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		model.addAttribute("audioByNameList",audioByNameList);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","byartist");
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/search";
		
	}
	@RequestMapping("/searchAudioByArtistLoad.do")
	public String searchAudioByArtistLoad(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		String searchType = req.getParameter("searchType");
		int loadedCount = Integer.parseInt(req.getParameter("loadlength"));
		int totalAudio = sqlSession.getMapper(SearchImpl.class).searchTotal(searchType, searchWord);
		
		ArrayList<AudioBoardDTO> audioByNameList = new ArrayList<AudioBoardDTO>();
		if(totalAudio!=loadedCount) {
			audioByNameList = sqlSession.getMapper(SearchImpl.class).search("artistname",searchWord,loadedCount+1,loadedCount+8);
		}
		
		//아티스트명으로 검색5개
		//댓글수 카운트해서 넣음
		model.addAttribute("audiolist",audioByNameList);
		ArrayList<LikeDTO> likes2 = loadLike(audioByNameList);
		model.addAttribute("likes",likes2);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/audiolistAdd";
		
	}
	////////아티스트 찾기
	@RequestMapping("/searchArtist.do")
	public String searchArtist(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO, Integer>();
		String searchWord = req.getParameter("searchWord");
		ArrayList<MemberDTO> artists = sqlSession.getMapper(SearchImpl.class).searchArtist(searchWord);
		for(MemberDTO dto : artists) {
			String followingId = dto.getId();
			HashSet<String> followerSet = new HashSet<String>();
			ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).followers(followingId);
			for(FollowDTO fdto : follows) {
				followerSet.add(fdto.getUser_id());
			}
			memberMap.put(dto, follows.size());
		}
		ArrayList<MemberDTO> arrayByF = cal.arrayByFollow(memberMap);
		if(arrayByF.size()>8) {
		for(int i=arrayByF.size()-1;i>7;i--) {
			arrayByF.remove(i);
		}}
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		model.addAttribute("artists",arrayByF);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","artist");
		model.addAttribute("memberMap",memberMap);
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/search";
		
	}
	@RequestMapping("/searchArtistLoad.do")
	public String searchArtistLoad(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO, Integer>();
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		ArrayList<MemberDTO> artists = sqlSession.getMapper(SearchImpl.class).searchArtist(searchWord);
		for(MemberDTO dto : artists) {
			String followingId = dto.getId();
			HashSet<String> followerSet = new HashSet<String>();
			ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).followers(followingId);
			for(FollowDTO fdto : follows) {
				followerSet.add(fdto.getUser_id());
			}
			memberMap.put(dto, follows.size());
		}
		ArrayList<MemberDTO> arrayByF = cal.arrayByFollow(memberMap);
		int loadedCount = Integer.parseInt(req.getParameter("loadlength"));
		int totalMember = artists.size();
		if(loadedCount<totalMember) {
			for(int i=loadedCount-1;i>=0;i--) {
				arrayByF.remove(i);
			}
		}else {
			arrayByF.clear();
		}
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		model.addAttribute("artists",arrayByF);
		model.addAttribute("memberMap",memberMap);
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/artistAdd";
		
	}
	@RequestMapping("/searchContents.do")
	public String searchContents(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> byContents = sqlSession.getMapper(SearchImpl.class).search("contents",searchWord,1,8);;
		for(AudioBoardDTO audios : byContents) {
			String contents = cal.makeSearchText(audios.getContents(),searchWord);
			audios.setContents(contents);
		}
		
		model.addAttribute("popMap3", byContents);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes3 = loadLike(byContents);
		model.addAttribute("likes3",likes3);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","contents");
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/search";
		
	}
	@RequestMapping("/searchContentsLoad.do")
	public String searchContentsLoad(Model model, HttpServletRequest req, Principal principal) {
		String id="";
		try {
			 id = principal.getName();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		String searchWord = req.getParameter("searchWord");
		String searchType = req.getParameter("searchType");
		int loadedCount = Integer.parseInt(req.getParameter("loadlength"));
		int totalAudio = sqlSession.getMapper(SearchImpl.class).searchTotal(searchType, searchWord);
		ArrayList<AudioBoardDTO> byContents = new ArrayList<AudioBoardDTO>();
		if(totalAudio!=loadedCount) {
			byContents = sqlSession.getMapper(SearchImpl.class).search(searchType,searchWord,loadedCount+1,loadedCount+8);
		}
		
		model.addAttribute("audiolist", byContents);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes3 = loadLike(byContents);
		model.addAttribute("likes",likes3);
		ArrayList<FollowDTO> follows = sqlSession.getMapper(FollowImpl.class).following(id);
		model.addAttribute("follows",follows);
		
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","contents");
		
		//팔로우추천 4명
		ArrayList<MemberDTO> recFollow = new ArrayList<MemberDTO>();
		HashMap<MemberDTO,Integer> recMemberMap = new HashMap<MemberDTO, Integer>();
		if(id!=null) {
			recMemberMap = cal.recommandFollowByFollowing(sqlSession,id);
			recFollow = cal.arrayByFollow(recMemberMap);
		}
		model.addAttribute("recFollow",recFollow);
		model.addAttribute("recMemberMap",recMemberMap);
		return "main/audiolistContentsAdd";
		
	}
	@RequestMapping("/loadsearchCount.do")
	@ResponseBody 
	public Map<String, String> countLoad(Model model, HttpServletRequest req, HttpSession session) {
		
		int loaded = Integer.parseInt(req.getParameter("loadlength"));
		String searchWord = req.getParameter("searchWord");
		String searchType = req.getParameter("searchType");
		int totalAudio = 0;
		
		if(searchType.equals("nickname")) {
			totalAudio = sqlSession.getMapper(SearchImpl.class).searchArtistTotal(searchWord);	
			
		}else {
		totalAudio = sqlSession.getMapper(SearchImpl.class).searchTotal(searchType, searchWord);
		
		}		
		Map<String, String> map = new HashMap<String, String>();
		if(loaded==totalAudio) {
		map.put("nomoreFeed", "이전 게시물이 없습니다.");
		
		}
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
