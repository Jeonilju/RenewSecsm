package com.secsm.info;

public class AnswerChoiceInfo {

	private int id;
	private int questionId;
	private int accountId;
	private int answer;
	public AnswerChoiceInfo(int id, int questionId, int accountId, int answer) {
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
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	
}
