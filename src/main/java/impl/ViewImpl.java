package impl;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.AudioBoardDTO;
import model.MCommentDTO;

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
	public int modifyAction(AudioBoardDTO audioBoardDTO);
	
} 
