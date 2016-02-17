package com.secsm.info;

import java.sql.Timestamp;

public class BookLogInfo {
	int id;
	int accountId;
	String accountName;
	int bookItemsId;
	String bookItemsName;
	Timestamp startDate;
	String strStartDate;
	Timestamp endDate;
	String strEndDate;
	int status;
	
	public BookLogInfo(int accountId, int bookItemsId, Timestamp startDate, Timestamp endDate, int status) {
		this.accountId = accountId;
		this.bookItemsId = bookItemsId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}
	
	public BookLogInfo(int id ,int accountId, String accountName, int bookItemsId, String bookItemsName, Timestamp startDate, Timestamp endDate, int status) {
		this.id = id;
		this.accountId = accountId;
		this.accountName = accountName;
		this.bookItemsId = bookItemsId;
		this.bookItemsName = bookItemsName;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}

	
	public String getBookItemsName() {
		return bookItemsName;
	}

	public void setBookItemsName(String bookItemsName) {
		this.bookItemsName = bookItemsName;
	}

	public String getStrStartDate() {
		return strStartDate;
	}

	public void setStrStartDate(String strStartDate) {
		this.strStartDate = strStartDate;
	}

	public String getStrEndDate() {
		return strEndDate;
	}

	public void setStrEndDate(String strEndDate) {
		this.strEndDate = strEndDate;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
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

	public int getBookItemsId() {
		return bookItemsId;
	}

	public void setBookItemsId(int bookItemsId) {
		this.bookItemsId = bookItemsId;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
