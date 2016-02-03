package com.secsm.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secsm.conf.Util;
import com.secsm.dao.EquipmentCategoryDao;
import com.secsm.dao.EquipmentItemsDao;
import com.secsm.dao.EquipmentLogDao;
import com.secsm.dao.EquipmentReqDao;
import com.secsm.info.AccountInfo;
import com.secsm.info.EquipmentCategoryInfo;
import com.secsm.info.EquipmentItemsInfo;

import net.sf.json.JSONObject;

@Controller
public class EquipmentController {
	
	private static final Logger logger = LoggerFactory.getLogger(EquipmentController.class);

	@Autowired
	private EquipmentCategoryDao equipmentCategoryDao;

	@Autowired
	private EquipmentItemsDao equipmentItemsDao;
	
	@Autowired
	private EquipmentLogDao equipmentLogDao;

	@Autowired
	private EquipmentReqDao equipmentReqDao;
	
	
	@RequestMapping(value = "/equipment", method = RequestMethod.GET)
	public String MainController_equipment_index(HttpServletRequest request) {
		logger.info("equipment Page");

		AccountInfo info = Util.getLoginedUser(request);
		List<EquipmentCategoryInfo> equipmentCategoryList  = equipmentCategoryDao.selectIsBook(0);
		
		request.setAttribute("accountInfo", info);
		request.setAttribute("equipmentCategoryList", equipmentCategoryList);
		
		
		return "equipment";		
	}
	
	@RequestMapping(value = "/book", method = RequestMethod.GET)
	public String MainController_book_index(HttpServletRequest request) {
		logger.info("book Page");
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			// 비로그인 
			return "index";
		}
		else{
			// 로그인
			return "book";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/api_searchEquipment", method = RequestMethod.POST)
	public String EquipmentController_searchEquipment(HttpServletRequest request
			, @RequestParam("searchEquipmentType") int searchEquipmentType
			, @RequestParam("searchEquipmentContent") String searchEquipmentContent) {
		logger.info("api Search Equipment");
		
		List<EquipmentItemsInfo> equipmentItemsList = equipmentItemsDao.select(searchEquipmentType, searchEquipmentContent);
		
		JSONObject jsonObj = new JSONObject();
		// TODO Json 으로 변경하여 보내기
		return "200";
	}

	@ResponseBody
	@RequestMapping(value = "/api_applyEquipment", method = RequestMethod.POST)
	public String EquipmentController_applyEquipment(HttpServletRequest request
			, @RequestParam("applyEquipmentContent") String applyEquipmentContent) {
		logger.info("api Apply Equipment");
		
		AccountInfo info = Util.getLoginedUser(request);
		int result = equipmentItemsDao.apply(applyEquipmentContent);
		
		if(result == 0){
			return "대여";
		}
		else if(result == 1){
			return "반납";
		}
		else{
			return "??";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/api_reqEquipment", method = RequestMethod.POST)
	public String EquipmentController_reqEquipment(HttpServletRequest request
			, @RequestParam("reqEquipmentTitle") String reqEquipmentTitle
			, @RequestParam("reqEquipmentContent") String reqEquipmentContent) {
		logger.info("api req Equipment");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "401";
		}
		
		equipmentReqDao.create(info.getId(), reqEquipmentTitle, reqEquipmentContent);
		
		return "";
	}
	
}	
