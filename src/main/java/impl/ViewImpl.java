package impl;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.AudioBoardDTO;
import model.MCommentDTO;
import model.PartyBoardDTO;
 
@Service
public interface ViewImpl {
	
	//상세페이지
	public AudioBoardDTO View(int audio_idx);
	
	//댓글리스트
	public ArrayList<MCommentDTO> mComment(int audio_idx);
	
	//댓글추가
	public int commentAction(
		@Param("audio_idx") int audio_idx,
		@Param("id") String id,
		@Param("contents") String contents);
	
	//데이터 삭제
	public int delete(@Param("comment_idx") int comment_idx,
		@Param("id") String id);
	
	//기존게시물 조회
	public AudioBoardDTO modify(@Param("audio_idx") int audio_idx,
		@Param("id") String id);
	
	//게시물 수정하기
	public int modifyAction(String audiotitle, String aritstname,
		String contents, String audiofilename, String imagename,
		String category, int party, int audio_idx, String id);
	
	//게시물 수정하기(오디오파일X)
	public int modifyAction2(String audiotitle, String artistname,
		String contents, String imagename, String category, int party,
		int audio_idx, String id);
	
	//게시물 수정하기(이미지파일X)
	public int modifyAction3(String audiotitle, String artistname,
		String contents, String audiofilename, String category, int party,
		int audio_idx, String id);
	
	//게시물 수정하기(오디오, 이미지X)
	public int modifyAction4(String audiotitle, String artistname,
		String contents, String category, int party,
		int audio_idx, String id);
	
	//협업자 불러오기
	public ArrayList<PartyBoardDTO> partyMember(int audio_idx);
	
	//참여자가 없을때를 위한 쿼리문
	public PartyBoardDTO notParty(int audio_idx);
	
	//채택한 글이 없을때 참여자 목록을 위한 쿼리문
	public PartyBoardDTO notChoice(int audio_idx);
	
	//재생횟수증가
	public int addPlay(int audio_idx);
	//재생횟수 가져오기
	public int playCount(int audio_idx);
} 
