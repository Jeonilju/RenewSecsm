package com.secsm.info;

public class AttachInfo {

	private int id;
	private int projectId;
	private String path;
	
	public AttachInfo(int id, int projectId, String path) {
		super();
		this.id = id;
		this.projectId = projectId;
		this.path = path;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
}
