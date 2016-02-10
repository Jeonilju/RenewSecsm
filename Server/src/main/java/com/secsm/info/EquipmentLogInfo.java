package com.secsm.info;

import java.sql.Timestamp;

public class EquipmentLogInfo {

	private int id;
	private int accountId;
	private Timestamp regDate;
	private int type;
	private int equipmentItemsId;
	private Timestamp startDate;
	private Timestamp endDate;
	private int status;
	
	public EquipmentLogInfo(int id, int accountId, Timestamp regDate, int type, int equipmentItemsId,
			Timestamp startDate, Timestamp endDate, int status) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.regDate = regDate;
		this.type = type;
		this.equipmentItemsId = equipmentItemsId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
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
	public int getEquipmentItemsId() {
		return equipmentItemsId;
	}
	public void setEquipmentItemsId(int equipmentItemsId) {
		this.equipmentItemsId = equipmentItemsId;
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
	
	
}
