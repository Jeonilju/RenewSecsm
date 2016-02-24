package com.secsm.info;

import java.sql.Timestamp;

public class EquipmentReqInfo {
	private int id;
	private String accountName;
	private int accountId;
	private int projectId;
	private String typeKr;
	private String typeEn;
	private String titleKr;
	private String titleEn;
	private String brand;
	private String link;
	private int pay;
	private int count;
	private String content;
	private Timestamp regDate;
	private String strRegDate;
	
	public EquipmentReqInfo(int accountId, int projectId, String typeKr, String typeEn, String titleKr, String titleEn, String brand,
			String link, int pay, int count, String content, Timestamp regDate) {
		this.accountId = accountId;
		this.projectId = projectId;
		this.typeKr = typeKr;
		this.typeEn = typeEn;
		this.titleKr = titleKr;
		this.titleEn = titleEn;
		this.brand = brand;
		this.link = link;
		this.pay = pay;
		this.count = count;
		this.content = content;
		this.regDate = regDate;
	}
	
	public EquipmentReqInfo(int id, String accountName, int projectId, String typeKr, String typeEn, String titleKr, String titleEn, String brand,
			String link, int pay, int count, String content, Timestamp regDate) {
		this.id = id;
		this.accountName = accountName;
		this.projectId = projectId;
		this.typeKr = typeKr;
		this.typeEn = typeEn;
		this.titleKr = titleKr;
		this.titleEn = titleEn;
		this.brand = brand;
		this.link = link;
		this.pay = pay;
		this.count = count;
		this.content = content;
		this.regDate = regDate;
	}

	public EquipmentReqInfo(int id, int accountId, int projectId, String typeKr, String typeEn, String titleKr, String titleEn, String brand,
			String link, int pay, int count, String content, Timestamp regDate) {
		this.id = id;
		this.accountId = accountId;
		this.projectId = projectId;
		this.typeKr = typeKr;
		this.typeEn = typeEn;
		this.titleKr = titleKr;
		this.titleEn = titleEn;
		this.brand = brand;
		this.link = link;
		this.pay = pay;
		this.count = count;
		this.content = content;
		this.regDate = regDate;
	}
	
	
	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public String getTypeKr() {
		return typeKr;
	}

	public void setTypeKr(String typeKr) {
		this.typeKr = typeKr;
	}

	public String getTypeEn() {
		return typeEn;
	}

	public void setTypeEn(String typeEn) {
		this.typeEn = typeEn;
	}

	public String getTitleKr() {
		return titleKr;
	}

	public void setTitleKr(String titleKr) {
		this.titleKr = titleKr;
	}

	public String getTitleEn() {
		return titleEn;
	}

	public void setTitleEn(String titleEn) {
		this.titleEn = titleEn;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getPay() {
		return pay;
	}

	public void setPay(int pay) {
		this.pay = pay;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public String getStrRegDate() {
		return strRegDate;
	}

	public void setStrRegDate(String strRegDate) {
		this.strRegDate = strRegDate;
	}
	
}

