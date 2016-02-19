package com.secsm.info;

import java.sql.Timestamp;
import java.util.List;

public class QuestionTimeInfo {

	private int id;
	private int questionId;
	private String problom;
	private Timestamp regDate;
	
	private List<AnswerTimeInfo> answerList = null;
	
	public QuestionTimeInfo(int id, int questionId, String problom, Timestamp regDate) {
		super();
		this.id = id;
		this.questionId = questionId;
		this.problom = problom;
		this.regDate = regDate;
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
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public List<AnswerTimeInfo> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<AnswerTimeInfo> answerList) {
		this.answerList = answerList;
	}
}
