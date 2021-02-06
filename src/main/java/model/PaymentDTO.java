package model;

import java.sql.Date;

public class PaymentDTO {
	private int idx;
	private String id;
	private Date regidate;
	private int totalPayment;
	private int VAT;
	private int chargePoint;
	private String paymentType;
	private int paymentResult;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getRegidate() {
		return regidate;
	}
	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}
	public int getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(int totalPayment) {
		this.totalPayment = totalPayment;
	}
	public int getVAT() {
		return VAT;
	}
	public void setVAT(int vAT) {
		VAT = vAT;
	}
	public int getChargePoint() {
		return chargePoint;
	}
	public void setChargePoint(int chargePoint) {
		this.chargePoint = chargePoint;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public int getPaymentResult() {
		return paymentResult;
	}
	public void setPaymentResult(int paymentResult) {
		this.paymentResult = paymentResult;
	}
	
	
	
} 
