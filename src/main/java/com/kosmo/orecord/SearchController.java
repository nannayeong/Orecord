package com.kosmo.orecord;

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

import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import model.MemberDTO;
import util.Calculate;
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
	public String search(Model model, HttpServletRequest req) { //테스트용 ID
		String searchWord = req.getParameter("searchWord");
		//아티스트명으로 검색한 오디오의 id모음
		
		
		
		/////////제목으로검색 게시물5개  1번
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(SearchImpl.class).searchAudioM(searchWord);
		//아티스트명으로 검색5개
		HashMap popMap1 = cal.calcuPop(audioList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap1", popMap1);
		HashMap<Integer, Integer> commentC1 = cal.cCount(audioList,sqlSession);
		model.addAttribute("commentC1", commentC1);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes1 = loadLike(audioList);
		ArrayList<FollowDTO> follows1 = loadFollow(audioList);
		model.addAttribute("likes1",likes1);
		model.addAttribute("follows1",follows1);
		

		/////////////아티스트명으로 게시글찾기 2번
		ArrayList<AudioBoardDTO> audioByNameList = sqlSession.getMapper(SearchImpl.class).searchAudioByArtistM(searchWord);
		//아티스트명으로 검색5개
		HashMap popMap2 = cal.calcuPop(audioByNameList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap2", popMap2);
		HashMap<Integer, Integer> commentC2 = cal.cCount(audioByNameList,sqlSession);
		model.addAttribute("commentC2", commentC2);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes2 = loadLike(audioByNameList);
		ArrayList<FollowDTO> follows2 = loadFollow(audioByNameList);
		model.addAttribute("likes2",likes2);
		model.addAttribute("follows2",follows2);
		
		
		//아이디 찾기위한 오디오 불러오기
		ArrayList<AudioBoardDTO> findmember = sqlSession.getMapper(SearchImpl.class).searchAudioByArtist(searchWord);
		HashSet<String> ids = new HashSet<String>();
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO,Integer>();
		for(int i=0;i<findmember.size();i++) {
			ids.add(findmember.get(i).getId());
		}
		Iterator<String> it = ids.iterator();
		while(it.hasNext()) {
			String id1 = it.next(); 
			ArrayList<MemberDTO> memberByArtist = sqlSession.getMapper(SearchImpl.class).searchArtistM(id1);
		for(int i=0;i<memberByArtist.size();i++) {
			String id2 = memberByArtist.get(i).getId();
			int countF = sqlSession.selectOne("followerCount",id2);
			memberMap.put( memberByArtist.get(i),countF);
		}}
		ArrayList<MemberDTO> artists=cal.arrayByFollow(memberMap);
		ArrayList<FollowDTO> follows4 = loadFollow(findmember);
		model.addAttribute("follows4",follows4);
		model.addAttribute("artists",artists);
		model.addAttribute("followset",memberMap);
		
		//컨텐츠로 검색
		ArrayList<AudioBoardDTO> byContents = sqlSession.getMapper(SearchImpl.class).searchContentM(searchWord);
		for(AudioBoardDTO audios : byContents) {
			String contents = cal.makeSearchText(audios.getContents(),searchWord);
			audios.setContents(contents);
		}
		
		HashMap<Integer,AudioBoardDTO> popMap3 = cal.calcuPop(byContents);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap3", popMap3);
		HashMap<Integer, Integer> commentC3 = cal.cCount(byContents,sqlSession);
		model.addAttribute("commentC3", commentC3);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes3 = loadLike(byContents);
		ArrayList<FollowDTO> follows3 = loadFollow(byContents);
		model.addAttribute("likes3",likes3);
		model.addAttribute("follows3",follows3);
		model.addAttribute("searchWord",searchWord);
		return "main/searchMain";
	}
	
	@RequestMapping("/searchAudio.do")
	public String searchAudio(Model model, HttpServletRequest req) {
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> audioList = sqlSession.getMapper(SearchImpl.class).searchAudioM(searchWord);
		//아티스트명으로 검색5개
		HashMap popMap1 = cal.calcuPop(audioList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap1", popMap1);
		HashMap<Integer, Integer> commentC1 = cal.cCount(audioList,sqlSession);
		model.addAttribute("commentC1", commentC1);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes1 = loadLike(audioList);
		ArrayList<FollowDTO> follows1 = loadFollow(audioList);
		model.addAttribute("likes1",likes1);
		model.addAttribute("follows1",follows1);
		model.addAttribute("searchType","title");
		model.addAttribute("searchWord",searchWord);
		return "main/search";
		
	}
	@RequestMapping("/searchAudioByArtist.do")
	public String searchAudioByArtist(Model model, HttpServletRequest req) {
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> audioByNameList = sqlSession.getMapper(SearchImpl.class).searchAudioByArtistM(searchWord);
		//아티스트명으로 검색5개
		HashMap popMap2 = cal.calcuPop(audioByNameList);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap2", popMap2);
		HashMap<Integer, Integer> commentC2 = cal.cCount(audioByNameList,sqlSession);
		model.addAttribute("commentC2", commentC2);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes2 = loadLike(audioByNameList);
		ArrayList<FollowDTO> follows2 = loadFollow(audioByNameList);
		model.addAttribute("likes2",likes2);
		model.addAttribute("follows2",follows2);
		
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","byartist");
		return "main/search";
		
	}
	@RequestMapping("/searchArtist.do")
	public String searchArtist(Model model, HttpServletRequest req) {
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> findmember = sqlSession.getMapper(SearchImpl.class).searchAudioByArtist(searchWord);
		HashSet<String> ids = new HashSet<String>();
		HashMap<MemberDTO,Integer> memberMap = new HashMap<MemberDTO,Integer>();
		for(int i=0;i<findmember.size();i++) {
			ids.add(findmember.get(i).getId());
		}
		Iterator<String> it = ids.iterator();
		while(it.hasNext()) {
			String id1 = it.next();
			ArrayList<MemberDTO> memberByArtist = sqlSession.getMapper(SearchImpl.class).searchArtistM(id1);
		for(int i=0;i<memberByArtist.size();i++) {
			String id2 = memberByArtist.get(i).getId();
			int countF = sqlSession.selectOne("followerCount",id2);
			memberMap.put( memberByArtist.get(i),countF);
		}}
		ArrayList<MemberDTO> artists=cal.arrayByFollow(memberMap);
		ArrayList<FollowDTO> follows4 = loadFollow(findmember);
		model.addAttribute("follows4",follows4);
		model.addAttribute("artists",artists);
		model.addAttribute("followset",memberMap);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","artist");
		return "main/search";
		
	}
	@RequestMapping("/searchContents.do")
	public String searchContents(Model model, HttpServletRequest req) {
		//검색페이지에 출력할 오디오게시글 불러옴
		String searchWord = req.getParameter("searchWord");
		ArrayList<AudioBoardDTO> byContents = sqlSession.getMapper(SearchImpl.class).searchContentM(searchWord);
		for(AudioBoardDTO audios : byContents) {
			String contents = cal.makeSearchText(audios.getContents(),searchWord);
			audios.setContents(contents);
		}
		
		HashMap<Integer,AudioBoardDTO> popMap3 = cal.calcuPop(byContents);
		//인기순정렬 맵으로넣음
		model.addAttribute("popMap3", popMap3);
		HashMap<Integer, Integer> commentC3 = cal.cCount(byContents,sqlSession);
		model.addAttribute("commentC3", commentC3);
		//댓글수 카운트해서 넣음
		ArrayList<LikeDTO> likes3 = loadLike(byContents);
		ArrayList<FollowDTO> follows3 = loadFollow(byContents);
		model.addAttribute("likes3",likes3);
		model.addAttribute("follows3",follows3);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchType","contents");
		return "main/search";
		
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
