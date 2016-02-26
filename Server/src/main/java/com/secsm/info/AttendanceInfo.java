package com.secsm.info;

import java.sql.Timestamp;

public class AttendanceInfo {

	private Timestamp regDate;
	private String cardnum;
	
	public AttendanceInfo(Timestamp regDate, String cardnum){
		this.regDate = regDate;
		this.cardnum = cardnum;
	}
	
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public String getCardnum() {
		return cardnum;
	}

	public void setCardnum(String cardnum) {
		this.cardnum = cardnum;
	}
	
}
