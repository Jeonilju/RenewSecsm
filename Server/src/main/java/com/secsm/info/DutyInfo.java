package com.secsm.info;

import java.sql.Timestamp;

public class DutyInfo {

	private int id;
	private Timestamp dutyDate;
	private String name1;
	private String name2;
	private String name3;
	private int accountId1;
	private int accountId2;
	private int accountId3;
	
	
	public DutyInfo(int id, int accountId) {
		this.id = id;
	}
	
	public DutyInfo(int id, Timestamp dutyDate, String name1, String name2, String name3) {
		this.id = id;
		this.dutyDate = dutyDate;
		this.name1 = name1;
		this.name2 = name2;
		this.name3 = name3;
	}
	
	public DutyInfo(int id, Timestamp dutyDate, int accountId1, int accountId2, int accountId3) {
		this.id = id;
		this.dutyDate = dutyDate;
		this.accountId1 = accountId1;
		this.accountId2 = accountId2;
		this.accountId3 = accountId3;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Timestamp getDutyDate() {
		return dutyDate;
	}

	public void setDutyDate(Timestamp dutyDate) {
		this.dutyDate = dutyDate;
	}

	public String getName1() {
		return name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getName2() {
		return name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

	public String getName3() {
		return name3;
	}

	public void setName3(String name3) {
		this.name3 = name3;
	}

	public int getAccountId1() {
		return accountId1;
	}

	public void setAccountId1(int accountId1) {
		this.accountId1 = accountId1;
	}

	public int getAccountId2() {
		return accountId2;
	}

	public void setAccountId2(int accountId2) {
		this.accountId2 = accountId2;
	}

	public int getAccountId3() {
		return accountId3;
	}

	public void setAccountId3(int accountId3) {
		this.accountId3 = accountId3;
	}
	
}