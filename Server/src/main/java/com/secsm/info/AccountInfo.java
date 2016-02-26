package com.secsm.info;

public class AccountInfo {
	private int id;
	private String name;
	private String email;
	private String pw;
	private String phone;
	private int gender;
	private int grade;
	private int pxAmount;
	private int cardnum;
	
	public AccountInfo(int id, String name, String email, String pw, String phone, int grade, int pxAmount, int gender, int cardnum){
		this.id = id;
		this.name = name;
		this.email = email;
		this.pw = pw;
		this.phone = phone;
		this.grade = grade;
		this.pxAmount = pxAmount;
		this.gender = gender;
		this.cardnum = cardnum;
	}

	public int getPxAmount() {
		return pxAmount;
	}

	public void setPxAmount(int pxAmount) {
		this.pxAmount = pxAmount;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getCardnum() {
		return cardnum;
	}
	public void setCardnum(int cardnum) {
		this.cardnum = cardnum;
	}
}
