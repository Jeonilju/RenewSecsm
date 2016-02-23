package com.secsm.info;
import java.sql.Timestamp;

public class BookReqInfo {
	private int id;
	private String accountName;
	private int accountId;
	private String title;
	private String publisher;
	private String author;
	private String link;
	private String imageURL;
	private int pay;
	private Timestamp regDate;
	private String strRegDate;
	
	public BookReqInfo(int accountId, String title, String publisher, String author, String link, String imageURL, int pay, Timestamp regDate) {
		this.accountId = accountId;
		this.title = title;
		this.publisher = publisher;
		this.author = author;
		this.link = link;
		this.imageURL = imageURL;
		this.pay = pay;
		this.regDate = regDate;
	}
	
	public BookReqInfo(int id, int accountId, String title, String publisher, String author, String link, String imageURL, int pay, Timestamp regDate) {
		this.id = id;
		this.accountId = accountId;
		this.title = title;
		this.publisher = publisher;
		this.author = author;
		this.link = link;
		this.imageURL = imageURL;
		this.pay = pay;
		this.regDate = regDate;
	}
	
	public BookReqInfo(int id, String accountName, String title, String publisher, String author, String link, String imageURL, int pay, Timestamp regDate) {
		this.id = id;
		this.accountName = accountName;
		this.title = title;
		this.publisher = publisher;
		this.author = author;
		this.link = link;
		this.imageURL = imageURL;
		this.pay = pay;
		this.regDate = regDate;
	}
	
	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public String getStrRegDate() {
		return strRegDate;
	}

	public void setStrRegDate(String strRegDate) {
		this.strRegDate = strRegDate;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
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
}
