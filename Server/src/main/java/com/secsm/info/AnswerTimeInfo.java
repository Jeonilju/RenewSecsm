package com.secsm.info;

import java.sql.Timestamp;

public class AnswerTimeInfo {

	private int id;
	private int questionId;
	private int accountId;
	private Timestamp answer;
	public AnswerTimeInfo(int id, int questionId, int accountId, Timestamp answer) {
		super();
		this.id = id;
		this.questionId = questionId;
		this.accountId = accountId;
		this.answer = answer;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public Timestamp getAnswer() {
		return answer;
	}
	public void setAnswer(Timestamp answer) {
		this.answer = answer;
	}
	
}
