package model;

public class AudioBoardDTO {
	
	private int audio_idx; //게시물인덱스
	private String audiotitle; //곡이름
	private String id; //게시물 작성자 아이디 
	private int album_idx; //앨범인덱스(FK)
	private String audiofilename;//서버에 저장될 오디오파일명
	private String artistname; // 아티스트이름
	private String contents; //곡설명
	private String imagename; //서버에 저장될 이미지 파일명
	private String category; //카테고리(띄어쓰기로 구분)
	private java.sql.Date regidate; //게시일
	private int play_count; //재생횟수
	private int like_count; //좋아요 수
	private int party; // 협업참여여부 
	
	/*album table innerjoin*/
	private String albumName;
	private String albumJacket;
	
	/* member table innerjoin */
	private String img;
	
	/*like table*/
	private boolean like; 
	
	//getter/setter
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getAudio_idx() {
		return audio_idx;
	}
	public void setAudio_idx(int audio_idx) {
		this.audio_idx = audio_idx;
	}
	public String getAudiotitle() {
		return audiotitle;
	}
	public void setAudiotitle(String audiotitle) {
		this.audiotitle = audiotitle;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getAlbum_idx() {
		return album_idx;
	}
	public void setAlbum_idx(int album_idx) {
		this.album_idx = album_idx;
	}
	public String getAudiofilename() {
		return audiofilename;
	}
	public void setAudiofilename(String audiofilename) {
		this.audiofilename = audiofilename;
	}
	public String getArtistname() {
		return artistname;
	}
	public void setArtistname(String artistname) {
		this.artistname = artistname;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getImagename() {
		return imagename;
	}
	public void setImagename(String imagename) {
		this.imagename = imagename; 
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	public int getPlay_count() {
		return play_count;
	}
	public void setPlay_count(int play_count) {
		this.play_count = play_count;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getParty() {
		return party;
	}
	public void setParty(int party) {
		this.party = party;
	}
	
	
	public String getAlbumName() {
		return albumName;
	}
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}
	public String getAlbumJacket() {
		return albumJacket;
	}
	public void setAlbumJacket(String albumJacket) {
		this.albumJacket = albumJacket;
	}
	
	public boolean isLike() {
		return like;
	}
	public void setLike(boolean like) {
		this.like = like;
	}
	
	
}