package com.secsm.info;
import java.sql.Timestamp;

public class BookItemsInfo {
	private int id;
	private String code;
	private String name;
	private String publisher;
	private String author;
	private String imageURL;
	private int type;
	private Timestamp regDate;
	private int count;
	private int totalCount;
	
	public BookItemsInfo(int id, String code, String name, String publisher, String author, String imageURL, int type, Timestamp regDate, int count,
			int totalCount) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.imageURL = imageURL;
		this.type = type;
		this.regDate = regDate;
		this.count = count;
		this.totalCount = totalCount;
	}
	
	public BookItemsInfo(String code, String name, String publisher, String author, String imageURL, int type, Timestamp regDate, int count,
			int totalCount) {
		this.code = code;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.imageURL = imageURL;
		this.type = type;
		this.regDate = regDate;
		this.count = count;
		this.totalCount = totalCount;
	}
	
	public BookItemsInfo(int id, String code, String name, String publisher, String author, String imageURL, int type, int count,
			int totalCount) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.imageURL = imageURL;
		this.type = type;
		this.count = count;
		this.totalCount = totalCount;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
}
