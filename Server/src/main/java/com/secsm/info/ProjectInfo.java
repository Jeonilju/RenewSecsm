package com.secsm.info;

import java.sql.Timestamp;

public class ProjectInfo {

	private int id;
	private String name;
	private String summary;
	private String description;

	private String pl;
	private String team;

	private Timestamp startDate;
	private Timestamp endDate;
	private Timestamp regDate;
	
	private int status;
	
	public ProjectInfo(int id, String name, String summary, String description, String pl, String team, int status, Timestamp startDate, Timestamp endDate, Timestamp regDate){
		this.id = id;
		this.name = name;
		this.summary = summary;
		this.description = description;
		this.pl = pl;
		this.team = team;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
		this.regDate = regDate;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getPl() {
		return pl;
	}
	public void setPl(String pl) {
		this.pl = pl;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
}
