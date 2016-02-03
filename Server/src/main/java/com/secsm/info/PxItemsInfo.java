package com.secsm.info;

public class PxItemsInfo {
	
	private int id;
	private String name;
	private String code;
	private int price;
	private String description;
	private int count;
	
	public PxItemsInfo(int id, String name, String code, int price, String description, int count) {
		super();
		this.id = id;
		this.name = name;
		this.code = code;
		this.price = price;
		this.description = description;
		this.count = count;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
