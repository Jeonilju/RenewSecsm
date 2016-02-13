package com.secsm.main;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secsm.conf.Util;
import com.secsm.dao.ProjectDao;
import com.secsm.info.ProjectInfo;

@Controller
public class ProjectController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	private ProjectDao projectDao;
	
	/** 교육 Main */
	@RequestMapping(value = "/project", method = RequestMethod.GET)
	public String ProjectController_project_index(HttpServletRequest request
			, @RequestParam(value="page", defaultValue = "0") int page) {
		logger.info("project Page: " + page);
		
		request.setAttribute("projectList", projectDao.selectByPage(page, 10));
		return "project";
	}
		
	@RequestMapping(value = "/addProject", method = RequestMethod.POST)
	public String ProjectController_add(HttpServletRequest request
			, @RequestParam("name") String name
 			, @RequestParam("summary") String summary
 			, @RequestParam("discription") String discription
 			, @RequestParam("PL") String pl
 			, @RequestParam("teamMember") String teamMember
 			, @RequestParam("startDate") String startDate
 			, @RequestParam("endDate") String endDate) {
		logger.info("addProject Page");

		Timestamp startDate_ = Timestamp.valueOf(startDate);
		Timestamp endDate_ = Timestamp.valueOf(endDate);
		
		projectDao.create(name, summary, discription, pl, teamMember, startDate_, endDate_);
		
		return "addProject";
	}
	
	@RequestMapping(value = "/updateProject", method = RequestMethod.POST)
	public String ProjectController_update(HttpServletRequest request
			, @RequestParam("id") int id
 			, @RequestParam("name") String name
 			, @RequestParam("summary") String summary
 			, @RequestParam("discription") String discription
 			, @RequestParam("PL") String pl
 			, @RequestParam("teamMember") String teamMember
 			, @RequestParam("startDate") String startDate
 			, @RequestParam("endDate") String endDate) {
		logger.info("updateProject Page");

		return "updateProject";
	}
	
	@RequestMapping(value = "/detailProject/{id}", method = RequestMethod.GET)
	public String ProjectController_detail(HttpServletRequest request
			, @PathVariable(value="id") int id) {
		logger.info("detailProject Page");
		
		ProjectInfo info = projectDao.selectById(id);
		
		if(info == null)
			return "projectNotFound";
		
		request.setAttribute("projectInfo", info);
		
		return "detailProject";
	}

////////////////////////////////////////////////////////////////////////
///////////////										////////////////////
///////////////					APIs				////////////////////
///////////////										////////////////////
////////////////////////////////////////////////////////////////////////
	
	@ResponseBody
	@RequestMapping(value = "/api_createProject", method = RequestMethod.POST)
	public String ProjectController_index(HttpServletRequest request
			, @RequestParam("createProjectName") String name
 			, @RequestParam("createProjectSummary") String summary
 			, @RequestParam("createProjectDiscription") String discription
 			, @RequestParam("createProjectPL") String pl
 			, @RequestParam("createProjectPL") String teamMember
 			, @RequestParam("createProjectStartDate") String startDate
 			, @RequestParam("createProjectEndDate") String endDate) {
		logger.info("api_createProject");
		projectDao.create(name, summary, discription, pl, teamMember, Util.getTimestamp(startDate), Util.getTimestamp(endDate));
		
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value = "/api_setProjectStatus", method = RequestMethod.POST)
	public String ProjectController_index(HttpServletRequest request
			, @RequestParam("projectId") String projectId
 			, @RequestParam("status") String status) {
		logger.info("api_setProjectStatus");
		
		return "200";
	}
}
