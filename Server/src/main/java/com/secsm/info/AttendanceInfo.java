package com.secsm.info;

import java.sql.Timestamp;

public class AttendanceInfo {

	private Timestamp regDate;
	private int cardnum;
	
	public AttendanceInfo(Timestamp regDate, int cardnum){
		this.regDate = regDate;
		this.cardnum = cardnum;
	}
	
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getCardnum() {
		return cardnum;
	}

	public void setCardnum(int cardnum) {
		this.cardnum = cardnum;
	}
	
}
