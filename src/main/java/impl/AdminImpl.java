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
	
////////////////////// member
	
	//회원리스트보기
	public ArrayList<MemberDTO> listPage(MemberDTO memberDTO);
	//회원정보조회
	public MemberDTO memberView(String id);
	//회원 삭제
	public int memberDelete(String id);
	//회원정보 수정
	public int memberEdit(String pw, String email, String phone, String address, String intro, String img, String id);
	
	
///////////////////// audioBoard
	
	//오디오리스트보기
	public ArrayList<AudioBoardDTO> adAudioList(AudioBoardDTO audioBoardDTO);
	//오디오 상세보기
	public AudioBoardDTO adAudioView(int audio_idx);
	//오디오 수정하기
	public int adAudioEdit(String audiotitle, String audiofilename, String artistname, String albumName, String imagename, String category, int party, int audio_idx);
	//오디오 삭제하기
	public int adAudioDELETE(int audio_idx);
	
	
//////////////////// album 
	
	//앨범리스트 보기
	public ArrayList<AlbumDTO> adalbumList(AlbumDTO albumDTO);
	//앨범상세보기
	public AlbumDTO adalbumView(int album_idx);
	//앨범수정하기
	public int adalbumEdit(String albumName, String albumJacket, int album_idx);
	public int AlbumNoJacketEdit(int album_idx, String albumName);
	//앨범삭제하기
	public int adalbumDelete(int album_idx);
	
/////////////////// sponsorship
	
	//후원리스트
	public ArrayList<SponsorshipDTO> sponsorshipList(SponsorshipDTO sponsorshipDTO);
	//후원상세보기
	public SponsorshipDTO sponsorshipView(int idx);
	//후원 수정하기
	public Integer sponsorshipEdit(int sponPoint, String patronId, int idx);
	//후원 삭제하기
	public int sponsorshipDelete(int idx);
	
	
/////////////////// charge
	
	//충전리스트
	public ArrayList<ChargeDTO> chargeList(ChargeDTO chargeDTO);
	//충전상세보기
	public ChargeDTO chargeView(int idx);
	//충전 수정하기
	public Integer chargeEdit(int totalPayment, int VAT, int chargePoint, String paymentType, int idx);
	//충전 삭제하기
	public int chargeDelete(int idx);
	
	
//////////////////// exchange
	//환전리스트
	public ArrayList<ExchangeDTO> exchangeList(ExchangeDTO exchangeDTO);
	//환전상세보기
	public ExchangeDTO exchangeView(int idx);
	//환전수정하기
	public int exchangeEdit(int exchangePoint, int exchageFee, int exchangedMoney, 
		String accountBank, String accountNumber, String accountName, int idx);
	//환전삭제하기
	public int exchangeDelete(int idx);
	
	
////////////////////// mcomment	
	
	//댓글리스트
	public ArrayList<MCommentDTO> mCommentList(MCommentDTO mCommentDTO);
	//댓글상세보기
	public MCommentDTO mCommentView(int comment_idx);
	//댓글수정하기
	public int mCommentEdit(String contents, int comment_idx);
	//댓글삭제하기
	public int mCommentDelete(int comment_idx);
	
	
///////////////////// partyBoard
	
	//협업리스트
	public ArrayList<PartyBoardDTO> partyList(PartyBoardDTO partyBoardDTO);
	//협업상세보기
	public PartyBoardDTO partyView(int party_idx);
	//협업수정하기
	public int partyEdit(int audio_idx, String title, String contents, String audiocontents, String audiofilename, 
			String kind, int point, int choice, int party_idx);
	public int partyEdit1(int audio_idx, String title, String contents, String audiocontents, 
			String kind, int point, int choice, int party_idx);
	//협업삭제하기
	public int partyDelete(int party_idx);
	
	
//////////////////// report
	
	//신고리스트
	public ArrayList<ReportDTO> reportList(ReportDTO reportDTO);
	//신고상세보기
	public ReportDTO reportView(int r_idx);
	//신고수정하기
	public int reportEdit(String r_id, String kind, String reason, int r_idx);
	//신고삭제하기
	public int reportDelete(int r_idx);
}
