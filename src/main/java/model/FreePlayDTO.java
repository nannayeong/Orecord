package model;

import java.util.Date;

public class FreePlayDTO {

	private int fp_idx;
	private String id;
	private int audio_idx;
	private Date fp_regidate;
	private String guestip;
	
	public int getFp_idx() {
		return fp_idx;
	}
	public void setFp_idx(int fp_idx) {
		this.fp_idx = fp_idx;
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
	public Date getFp_regidate() {
		return fp_regidate;
	}
	public void setFp_regidate(Date fp_regidate) {
		this.fp_regidate = fp_regidate;
	}
	public String getGuestip() {
		return guestip;
	}
	public void setGuestip(String guestip) {
		this.guestip = guestip;
	}
	
	
} 
