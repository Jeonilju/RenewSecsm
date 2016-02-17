package com.secsm.info;

import java.sql.Timestamp;

public class QuestionContentInfo implements Comparable<QuestionContentInfo> {
	public int id;
	public int qType;
	public String qTitle;
	public String q1;
	public String q2;
	public String q3;
	public String q4;
	public String q5;
	public Timestamp regDate;
	
	public int compareTo(QuestionContentInfo arg0) {
		
		if(regDate != null && arg0.regDate != null){
			return regDate.compareTo(arg0.regDate);
		}
		
		return 0;
	}
}
