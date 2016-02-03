package com.secsm.info;

import java.sql.Timestamp;

public class PxLogInfo {

	private int id;
	private int accountId;
	private int pxItemsId;
	private Timestamp regDate;
	
	// 0: 구매, 1: 환불
	private int type;
	private int count;
	
	private String name;
	private int price;
	
	public PxLogInfo(int id, int accountId, int pxItemsId, Timestamp regDate, int type, int count) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.pxItemsId = pxItemsId;
		this.regDate = regDate;
		this.type = type;
		this.count = count;
	}
	
	public PxLogInfo(int id, int accountId, int pxItemsId, Timestamp regDate, int type, int count, String name,
			int price) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.pxItemsId = pxItemsId;
		this.regDate = regDate;
		this.type = type;
		this.count = count;
		this.name = name;
		this.price = price;
	}

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
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
	public int getPxItemsId() {
		return pxItemsId;
	}
	public void setPxItemsId(int pxItemsId) {
		this.pxItemsId = pxItemsId;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
