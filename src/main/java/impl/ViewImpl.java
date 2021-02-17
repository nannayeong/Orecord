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
	
	//상세페이지 삭제처리
	public int viewDelete(int audio_idx, String id);
	
	//댓글리스트
	public ArrayList<MCommentDTO> mComment(int audio_idx);
	
	//댓글추가
	public int commentAction(int audio_idx, String id, String contents);
	
	//댓글 삭제
	public int delete(int comment_idx);
	
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
	
	//좋아요 누를시 likeboard추가
	public int likeBoard(int audio_idx, String like_id);
	//좋아요 취소시 likeboard삭제
	public int noLikeBoard(int audio_idx, String like_id);
	
	//좋아요 누를시 audioboard like_count 증가
	public int likeUp(int audio_idx);
	//좋아요 취소시 audioboard like_count 감소
	public int likeDown(int audio_idx);
	
	//좋아요 카운트
	public int likeCount(int audio_idx);
} 
