package model;

public class PartyBoardDTO {
	
	private int party_idx; //참여인덱스
	private String id; //참여업로드 아이디
	private int audio_idx; //원 audioBoard인덱스 FK
	private String title; //제목
	private String contents; //내용
	private String audiofilename; //파일명
	private String audiocontents; //가사
	private String kind; // 협업분야 선택
	private int point; //희망포인트
	private int choice; //채택유무
	private java.sql.Date exdate; //채택전까지 노출기간
	private java.sql.Date regidate; //참여일
	private String img;
	
	//getter/setter
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getAudiocontents() {
		return audiocontents;
	}
	public void setAudiocontents(String audiocontents) {
		this.audiocontents = audiocontents;
	}
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAudiofilename() {
		return audiofilename;
	}
	public void setAudiofilename(String audiofilename) {
		this.audiofilename = audiofilename;
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
	public int getChoice() {
		return choice;
	}
	public void setChoice(int choice) {
		this.choice = choice;
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