package com.secsm.info;

public class AttachInfo {

	private int id;
	private int projectId;
	private String path;
	private String tag;
	private String name;
	
	public AttachInfo(int id, int projectId, String path, String tag, String name) {
		super();
		this.id = id;
		this.projectId = projectId;
		this.path = path;
		this.tag = tag;
		this.name = name;
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
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
