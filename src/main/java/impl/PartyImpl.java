package impl;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.AudioBoardDTO;
import model.MemberDTO;
import model.PartyBoardDTO;

@Service
public interface PartyImpl {
	
	//협업신청리스트
	public ArrayList<PartyBoardDTO> partyList(int audio_idx);
	
	//협업신청폼
	public AudioBoardDTO partyWrite(int audio_idx);
		
	//협업신청처리
	public int partyAction(@Param("id") String id,
			@Param("audio_idx") int audio_idx,
			@Param("title") String title,
			@Param("contents") String contents,
			@Param("audiofilename") String audiofilename,
			@Param("audiocontents") String audiocontents,
			@Param("kind") String kind,
			@Param("point") int point);
	
	//협업신청처리(오디오파일X)
	public int partyAction2(@Param("id") String id,
			@Param("audio_idx") int audio_idx,
			@Param("title") String title,
			@Param("contents") String contents,
			@Param("audiocontents") String audiocontents,
			@Param("kind") String kind,
			@Param("point") int point);
	
	//협업신청서 상세페이지
	public PartyBoardDTO partyView(@Param("party_idx") int party_idx);
	
	//나의 포인트 조회
	public MemberDTO myPoint(String id);
	
	public ArrayList<PartyBoardDTO> mydopartychoice(String id, int start, int end);
	public ArrayList<PartyBoardDTO> mydopartynotchoice(String id, int start, int end);
	
	public int mypartychoicecount(String id);
	public int mypartynotchoicecount(String id);
	

	public ArrayList<PartyBoardDTO> partyMemberView(int audio_idx);
	
	public ArrayList<AudioBoardDTO> party1(String id);

	public ArrayList<PartyBoardDTO> partyMemberView(int audio_idx, int choice);

}
