package com.secsm.main;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secsm.dao.PxCategoryDao;
import com.secsm.dao.PxItemsDao;
import com.secsm.dao.PxLogDao;
import com.secsm.dao.PxReqDao;

@Controller
public class PXController {
	private static final Logger logger = LoggerFactory.getLogger(PXController.class);
	
	@Autowired
	private PxCategoryDao pxCategoryDao;
	
	@Autowired
	private PxItemsDao pxItemsDao;
	
	@Autowired
	private PxLogDao pxLogDao;
	
	@Autowired
	private PxReqDao pxReqDao;
	
	@RequestMapping(value = "/px", method = RequestMethod.GET)
	public String MainController_index(HttpServletRequest request) {
		logger.info("px Page");

		return "px";
	}
	
	
	/////////////////////////////////////////////////////////////
	/////////////									/////////////
	/////////////				APIs				/////////////
	/////////////									/////////////
	/////////////////////////////////////////////////////////////
	
	@ResponseBody
	@RequestMapping(value = "/api_pxBuyItem", method = RequestMethod.POST)
	public String PXController_buyItem(){
		logger.info("api_pxBuyItem");
		
		return "";
	}
	
	
}
