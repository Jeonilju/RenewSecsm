package com.secsm.info;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class QuestionChoiceInfo {

	private int id;
	private int questionID;
	private String problom;
	private String p1;
	private String p2;
	private String p3;
	private String p4;
	private String p5;
	private Timestamp regDate;
	
	private List<AnswerChoiceInfo> answerList = null;
	
	public QuestionChoiceInfo(int id, int questionID, String problom, String p1, String p2, String p3, String p4, String p5, Timestamp regDate) {
		super();
		this.id = id;
		this.problom = problom;
		this.questionID = questionID;
		this.p1 = p1;
		this.p2 = p2;
		this.p3 = p3;
		this.p4 = p4;
		this.p5 = p5;
		this.regDate = regDate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuestionID() {
		return questionID;
	}
	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}
	public String getProblom() {
		return problom;
	}
	public void setProblom(String problom) {
		this.problom = problom;
	}
	public String getP1() {
		return p1;
	}
	public void setP1(String p1) {
		this.p1 = p1;
	}
	public String getP2() {
		return p2;
	}
	public void setP2(String p2) {
		this.p2 = p2;
	}
	public String getP3() {
		return p3;
	}
	public void setP3(String p3) {
		this.p3 = p3;
	}
	public String getP4() {
		return p4;
	}
	public void setP4(String p4) {
		this.p4 = p4;
	}
	public String getP5() {
		return p5;
	}
	public void setP5(String p5) {
		this.p5 = p5;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public List<AnswerChoiceInfo> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<AnswerChoiceInfo> answerList) {
		this.answerList = answerList;
	}
}
