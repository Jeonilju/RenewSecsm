package com.secsm.info;

public class QuestionTimeInfo {

	private int id;
	private int questionId;
	private String problom;
	public QuestionTimeInfo(int id, int questionId, String problom) {
		super();
		this.id = id;
		this.questionId = questionId;
		this.problom = problom;
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
	public String getProblom() {
		return problom;
	}
	public void setProblom(String problom) {
		this.problom = problom;
	}
}
