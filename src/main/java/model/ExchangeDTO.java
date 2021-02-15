package model;

import java.sql.Date;

public class ExchangeDTO {
	private int idx;
	private String id;
	private Date regidate;
	private int exchangePoint;
	private int exchangeFee;
	private int exchangedMoney;
	private String accountBank;
	private String accountNumber;
	private String accountName;
	private int exchangeResult;
	
	
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
	public int getExchangePoint() {
		return exchangePoint;
	}
	public void setExchangePoint(int exchangePoint) {
		this.exchangePoint = exchangePoint;
	}
	public int getExchangeFee() {
		return exchangeFee;
	}
	public void setExchangeFee(int exchangeFee) {
		this.exchangeFee = exchangeFee;
	}
	public int getExchangedMoney() {
		return exchangedMoney;
	}
	public void setExchangedMoney(int exchangedMoney) {
		this.exchangedMoney = exchangedMoney;
	}
	public String getAccountBank() {
		return accountBank;
	}
	public void setAccountBank(String accountBank) {
		this.accountBank = accountBank;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public int getExchangeResult() {
		return exchangeResult;
	}
	public void setExchangeResult(int exchangeResult) {
		this.exchangeResult = exchangeResult;
	}
}
