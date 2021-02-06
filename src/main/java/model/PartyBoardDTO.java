package model;

public class PartyBoardDTO {
	
	private int party_idx; //참여인덱스
	private String id; //참여업로드 아이디
	private int audio_idx; //원 audioBoard인덱스 FK
	private String kind; //참여종류(편곡, 작사)
	private int point; //희망포인트
	private int adoption; //채택유무
	private java.sql.Date exdate; //채택전까지 노출기간
	private java.sql.Date regidate; //참여일
	
	//getter/setter
	public int getParty_idx() {
		return party_idx;
	}
	public void setParty_idx(int party_idx) {
		this.party_idx = party_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getAudio_idx() {
		return audio_idx;
	}
	public void setAudio_idx(int audio_idx) {
		this.audio_idx = audio_idx;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getAdoption() {
		return adoption;
	}
	public void setAdoption(int adoption) {
		this.adoption = adoption;
	}
	public java.sql.Date getExdate() {
		return exdate;
	}
	public void setExdate(java.sql.Date exdate) {
		this.exdate = exdate;
	}
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
} 
