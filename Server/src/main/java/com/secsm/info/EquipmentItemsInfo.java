package com.secsm.info;

import java.sql.Timestamp;

public class EquipmentItemsInfo {

	private int id;
	private String code;
	private String name;
	private String manufacturer;
	private String imageURL;
	private int type;
	private Timestamp regDate;
	private int count;
	private int totalCount;
	
	public EquipmentItemsInfo(int id, String code, String name, String manufacturer, String imageURL, int type,
			Timestamp regDate, int count, int totalCount) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.manufacturer = manufacturer;
		this.imageURL = imageURL;
		this.type = type;
		this.regDate = regDate;
		this.count = count;
		this.totalCount = totalCount;
	}
	
	public EquipmentItemsInfo(String code, String name, String manufacturer, String imageURL, int type,
			Timestamp regDate, int count, int totalCount) {
		this.code = code;
		this.name = name;
		this.manufacturer = manufacturer;
		this.imageURL = imageURL;
		this.type = type;
		this.regDate = regDate;
		this.count = count;
		this.totalCount = totalCount;
	}

	
	public EquipmentItemsInfo(int id, String code, String name, String manufacturer, int type,
			Timestamp regDate, int count, int totalCount) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.manufacturer = manufacturer;
		this.type = type;
		this.regDate = regDate;
		this.count = count;
		this.totalCount = totalCount;
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

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
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
