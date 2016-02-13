package com.secsm.main;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.secsm.conf.Util;
import com.secsm.dao.AttachDao;
import com.secsm.dao.ProjectDao;
import com.secsm.info.AttachInfo;
import com.secsm.info.ProjectInfo;

@Controller
public class ProjectController {
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private AttachDao attachDao;
	
	
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
		List<AttachInfo> attachList = attachDao.selectByProjectId(id);
		
		if(info == null)
			return "projectNotFound";
		
		request.setAttribute("projectInfo", info);
		request.setAttribute("attachList", attachList);
		
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
	public String ProjectController_setProjectStatus(HttpServletRequest request
			, @RequestParam("projectId") int projectId
 			, @RequestParam("status") int status) {
		logger.info("api_setProjectStatus");
		
		projectDao.setStatus(projectId, status);
		
		return "200";
	}
	
	/** 파일 업로드 */
	@ResponseBody
	@RequestMapping(value = "/api_projectAddAttach", method = RequestMethod.POST)
	public String ProjectController_addAttach(HttpServletRequest request
			, @RequestParam("projectId") int projectId
			, @RequestParam("tag") String tag
			, @RequestParam("attachFile") MultipartFile attachedFile) {
		logger.info("api_projectAddAttach");
		
		if(!attachedFile.isEmpty())
		{
			String fileLocation = "projectId_" + attachedFile.getOriginalFilename();
			
			try 
			{
				byte[] bytes = attachedFile.getBytes();
				
				String saveDir = "";
	 			String tempSavePath = request.getRealPath(File.separator) + "upload\\"; 
	 			String savePath = tempSavePath.replace('\\', '/'); 
	 			File targetDir = new File(savePath);
	 			if (!targetDir.exists()) 
	 			{
	 				targetDir.mkdirs();
	 			}
	 			saveDir = savePath;
	 			
				// Creating the directory to store file
				String rootPath = saveDir + fileLocation;
				
				// Create the file on server
				File serverFile = new File(saveDir + fileLocation);
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				
				logger.info("Server File Location=" + serverFile.getAbsolutePath());
				
				attachDao.create(projectId, fileLocation, tag, fileLocation);
				return "200";
			}	 
			catch (Exception e) 
			{
				logger.info("file error : " + e.toString());
        	}
		}
		return "500";		
	}
	
	/** 파일 다운로드 */
	@RequestMapping(value = "/FileDownload", method = RequestMethod.POST)
   	public String FileDownload(HttpServletRequest request, HttpServletResponse response) {
		logger.info("FileDownload");
		
		String fileName = request.getParameter("filename");
		request.setAttribute("filename", fileName);
	   
		return "FileDownload";
	}
}
