package com.secsm.info;

import java.sql.Timestamp;

public class PxReqInfo {

	private int id;
	private int accountId;
	private String title;
	private String context;
	private Timestamp regDate;
	private int status;
	
	public PxReqInfo(int id, int accountId, String title, String context, Timestamp regDate, int status) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.title = title;
		this.context = context;
		this.regDate = regDate;
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
