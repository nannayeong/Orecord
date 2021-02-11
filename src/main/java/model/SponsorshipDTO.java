package model;

import java.sql.Date;

public class SponsorshipDTO {
	private int idx;
	private String sponsorId;
	private Date regidate;
	private int sponPoint;
	private String patronId;
	private int paymentResult;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSponsorId() {
		return sponsorId;
	}
	public void setSponsorId(String sponsorId) {
		this.sponsorId = sponsorId;
	}
	public Date getRegidate() {
		return regidate;
	}
	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}
	public int getSponPoint() {
		return sponPoint;
	}
	public void setSponPoint(int sponPoint) {
		this.sponPoint = sponPoint;
	}
	public String getPatronId() {
		return patronId;
	}
	public void setPatronId(String patronId) {
		this.patronId = patronId;
	}
	public int getPaymentResult() {
		return paymentResult;
	}
	public void setPaymentResult(int paymentResult) {
		this.paymentResult = paymentResult;
	}
	
}
