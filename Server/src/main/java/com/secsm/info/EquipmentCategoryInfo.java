package com.secsm.info;

public class EquipmentCategoryInfo {
	
	private int id;
	private String name;
	private int isBook;
	
	public EquipmentCategoryInfo(int id, String name, int isBook) {
		super();
		this.id = id;
		this.name = name;
		this.isBook = isBook;
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
	public int getIsBook() {
		return isBook;
	}
	public void setIsBook(int isBook) {
		this.isBook = isBook;
	}
}
