package model;

public class NotificationDTO {
	
	private int n_idx;
	private String s_id;
	private String r_id;
	private java.sql.Date stime;
	private String msg;
	private String exMsg;
	
	//getter/setter
	public int getN_idx() {
		return n_idx;
	}
	public void setN_idx(int n_idx) {
		this.n_idx = n_idx;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public java.sql.Date getStime() {
		return stime;
	}
	public void setStime(java.sql.Date stime) {
		this.stime = stime;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getExMsg() {
		return exMsg;
	}
	public void setExMsg(String exMsg) {
		this.exMsg = exMsg;
	}
}