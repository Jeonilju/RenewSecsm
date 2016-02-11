package com.secsm.info;

import java.sql.Timestamp;

public class QuestionInfo {

	private int id;
	private int accountId;
	private String title;
	private String content;
	private Timestamp regDate;
	private Timestamp startDate;
	private Timestamp endDate;
	
	public QuestionInfo(int id, int accountId, String title, String content, Timestamp regDate, Timestamp startDate,
			Timestamp endDate) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.startDate = startDate;
		this.endDate = endDate;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Timestamp getStartDate() {
		return startDate;
	}
	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}
	public Timestamp getEndDate() {
		return endDate;
	}
	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}
}
