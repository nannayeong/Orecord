package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.AlbumDTO;
import model.AudioBoardDTO;
import model.ChargeDTO;
import model.ExchangeDTO;
import model.MCommentDTO;
import model.MemberDTO;
import model.PartyBoardDTO;
import model.ReportDTO;
import model.SponsorshipDTO;


@Service
public interface AdminImpl {
	
	//회원리스트보기
	public ArrayList<MemberDTO> listPage(MemberDTO memberDTO);
	
	//회원정보조회
	public MemberDTO memberView(String id);
	
	//회원 삭제
	public int memberDelete(String id);
		
	//회원정보 수정
	public int memberEdit(String pw, String email, String phone, String address, String intro, String img, String id);
	
///////////// audioBoard
	
	//오디오리스트보기
	public ArrayList<AudioBoardDTO> adAudioList(AudioBoardDTO audioBoardDTO);
	
	//오디오 상세보기
	public AudioBoardDTO adAudioView(int audio_idx);
	
	//오디오 수정하기
	public int adAudioEdit(String audiotitle, String audiofilename, String artistname, String albumName, String imagename, String category, int party, int audio_idx);
	
	//오디오 삭제하기
	public int adAudioDELETE(int audio_idx);
	
	//앨범리스트 보기
	public ArrayList<AlbumDTO> adalbumList(AlbumDTO albumDTO);
	
	//후원리스트
	public ArrayList<SponsorshipDTO> sponsorshipList(SponsorshipDTO sponsorshipDTO);
	
	//충전리스트
	public ArrayList<ChargeDTO> chargeList(ChargeDTO chargeDTO);
	
	//환전리스트
	public ArrayList<ExchangeDTO> exchangeList(ExchangeDTO exchangeDTO);
	
	//댓글리스트
	public ArrayList<MCommentDTO> mCommentList(MCommentDTO mCommentDTO);
	
	//협업리스트
	public ArrayList<PartyBoardDTO> partyList(PartyBoardDTO partyBoardDTO);
	
	//신고리스트
	public ArrayList<ReportDTO> reportList(ReportDTO reportDTO);
}
