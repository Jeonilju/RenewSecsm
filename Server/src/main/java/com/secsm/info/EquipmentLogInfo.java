package com.secsm.info;

import java.sql.Timestamp;

public class EquipmentLogInfo {
	int id;
	int accountId;
	String accountName;
	int equipmentItemsId;
	String equipmentItemsName;
	Timestamp startDate;
	String strStartDate;
	Timestamp endDate;
	String strEndDate;
	int status;
	
	public EquipmentLogInfo(int accountId, int equipmentItemsId, Timestamp startDate, Timestamp endDate, int status) {
		this.accountId = accountId;
		this.equipmentItemsId = equipmentItemsId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}

	public EquipmentLogInfo(int id, int accountId, String accountName, int equipmentItemsId, String equipmentItemsName,
			Timestamp startDate, Timestamp endDate, int status) {
		this.id = id;
		this.accountId = accountId;
		this.accountName = accountName;
		this.equipmentItemsId = equipmentItemsId;
		this.equipmentItemsName = equipmentItemsName;
		this.startDate = startDate;
		this.endDate = endDate;
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

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public int getEquipmentItemsId() {
		return equipmentItemsId;
	}

	public void setEquipmentItemsId(int equipmentItemsId) {
		this.equipmentItemsId = equipmentItemsId;
	}

	public String getEquipmentItemsName() {
		return equipmentItemsName;
	}

	public void setEquipmentItemsName(String equipmentItemsName) {
		this.equipmentItemsName = equipmentItemsName;
	}

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public String getStrStartDate() {
		return strStartDate;
	}

	public void setStrStartDate(String strStartDate) {
		this.strStartDate = strStartDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public String getStrEndDate() {
		return strEndDate;
	}

	public void setStrEndDate(String strEndDate) {
		this.strEndDate = strEndDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
