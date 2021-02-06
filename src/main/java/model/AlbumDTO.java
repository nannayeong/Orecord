package model;

public class AlbumDTO {

	private int album_idx;
	private String id;
	private String albumName;
	private String albumJacket;
	
	public int getAlbum_idx() {
		return album_idx;
	}
	public void setAlbum_idx(int album_idx) {
		this.album_idx = album_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
} 
