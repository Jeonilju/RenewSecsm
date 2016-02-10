package com.secsm.main;

import java.util.ArrayList;
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

import com.google.gson.Gson;
import com.secsm.conf.Util;
import com.secsm.dao.EquipmentCategoryDao;
import com.secsm.dao.EquipmentItemsDao;
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
	private EquipmentReqDao equipmentReqDao;
	
	@RequestMapping(value = "/equipment", method = RequestMethod.GET)
	public String MainController_equipment_index(HttpServletRequest request) {
		logger.info("equipment Page");

		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "index";
		}
		
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
///////////////////////////////////////////////////////////////////////////
////////////////										  /////////////////
////////////////				Common APIs				  /////////////////
////////////////										  /////////////////
///////////////////////////////////////////////////////////////////////////

	/** 기자제 카테고리 추가 */
	@ResponseBody
	@RequestMapping(value = "/api_addEquipmentCategory", method = RequestMethod.POST)
	public String EquipmentController_addEquipmentCategory(HttpServletRequest request
			, @RequestParam("categotyName") String categotyName
			, @RequestParam("categotyIsBook") int categotyIsBook) {
		logger.info("api add Equipment Category");
		equipmentCategoryDao.create(categotyName, categotyIsBook);
		
		return "200";
	}
	
	
	
///////////////////////////////////////////////////////////////////////////
////////////////										  /////////////////
////////////////				Equipment APIs			  /////////////////
////////////////										  /////////////////
///////////////////////////////////////////////////////////////////////////
	
	
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
	
///////////////////////////////////////////////////////////////////////////
////////////////										  /////////////////
////////////////				Book APIs				  /////////////////
////////////////										  /////////////////
///////////////////////////////////////////////////////////////////////////

	/** 도서 검색 */
	@ResponseBody
	@RequestMapping(value = "/api_searchBook", method = RequestMethod.POST)
	public String EquipmentController_searchBook(HttpServletRequest request,
			@RequestParam("searchBookType") int searchBookType,
			@RequestParam("searchBookContent") String searchBookContent) {
		logger.info("api Search Book");

		List<EquipmentItemsInfo> equipmentItemsList = new ArrayList<EquipmentItemsInfo>();
		
		// TODO selectByBook 메소드를 이용하도록 변경
		
		if(searchBookType != 0){
			// 카테고리 검색
			equipmentItemsList.addAll(equipmentItemsDao.select(searchBookType, searchBookContent));
		}
		else{
			// 전체검색
			List<EquipmentCategoryInfo> equipmentCategoryList = equipmentCategoryDao.selectIsBook(1);
			
			for(int n=0;n< equipmentCategoryList.size();n++){
				equipmentItemsList.addAll(equipmentItemsDao.select(equipmentCategoryList.get(n).getId(), searchBookContent));
			}			
		}

		Gson obj = new Gson();
		String result = obj.toJson(equipmentItemsList);
		
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/api_applyBook", method = RequestMethod.POST)
	public String EquipmentController_applyBook(HttpServletRequest request,
			@RequestParam("applyBookContent") String applyEquipmentContent) {
		logger.info("api Apply Book");

		AccountInfo info = Util.getLoginedUser(request);
		int result = equipmentItemsDao.apply(applyEquipmentContent);

		if (result == 0) {
			return "대여";
		} else if (result == 1) {
			return "반납";
		} else {
			return "??";
		}
	}

	/** 도서 신청 */
	@ResponseBody
	@RequestMapping(value = "/api_reqBook", method = RequestMethod.POST)
	public String EquipmentController_reqBook(HttpServletRequest request,
			@RequestParam("reqEquipmentTitle") String reqEquipmentTitle,
			@RequestParam("reqEquipmentContent") String reqEquipmentContent) {
		logger.info("api req Equipment");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}

		equipmentReqDao.create(info.getId(), reqEquipmentTitle, reqEquipmentContent);

		return "";
	}
	
}	
