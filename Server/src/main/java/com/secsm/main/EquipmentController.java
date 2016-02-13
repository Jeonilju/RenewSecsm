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
	
	@RequestMapping(value = "/equipmentReqExcel", method = RequestMethod.GET)
	public String EquipmentController_ReqExcel(HttpServletRequest request) {
		logger.info("equipmentReqExcel");
		AccountInfo info = Util.getLoginedUser(request);
		
		if(info.getGrade() == 0 || 
				info.getGrade() == 5){
			// 장비부장 권한
			request.setAttribute("equipmentReqList", equipmentReqDao.selectAll());
			return "equipmentExcel";
		}
		else{
			// TODO 권한 없음
			return "index";
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
		
		List<EquipmentItemsInfo> equipmentItemsList = equipmentItemsDao.selectByCategory(searchEquipmentType, searchEquipmentContent);
		
		Gson gson = new Gson();
		logger.info(gson.toJson(equipmentItemsList));
		return gson.toJson(equipmentItemsList);
	}

	@ResponseBody
	@RequestMapping(value = "/api_applyEquipment", method = RequestMethod.POST)
	public String EquipmentController_applyEquipment(HttpServletRequest request
			, @RequestParam("applyEquipmentType") int applyEquipmentType
			, @RequestParam("applyEquipmentContent") String applyEquipmentContent) {
		logger.info("api Apply Equipment");
		
		AccountInfo info = Util.getLoginedUser(request);
		int result = equipmentItemsDao.apply(info.getId(), applyEquipmentType, applyEquipmentContent);
		
		if(result == 0){
			return "대여";
		}
		else if(result == 1){
			return "반납";
		}
		else{
			logger.info("재대로 처리 안됨");
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
			equipmentItemsList.addAll(equipmentItemsDao.selectByBook(searchBookContent));
		}
		else{
			// 전체검색
			
			// 책에 관련된 카테고리 전부르 얻어옴
			List<EquipmentCategoryInfo> equipmentCategoryList = equipmentCategoryDao.selectIsBook(1);
			equipmentItemsList.addAll(equipmentItemsDao.selectByBook(searchBookContent));
		}

		Gson obj = new Gson();
		String result = obj.toJson(equipmentItemsList);
		
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/api_applyBook", method = RequestMethod.POST)
	public String EquipmentController_applyBook(HttpServletRequest request
			, @RequestParam("applyEquipmentType") int applyEquipmentType
			, @RequestParam("applyBookContent") String applyEquipmentContent) {
		logger.info("api Apply Book");

		AccountInfo info = Util.getLoginedUser(request);
		int result = equipmentItemsDao.apply(info.getId(),applyEquipmentType, applyEquipmentContent);

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
	
	@ResponseBody
	@RequestMapping(value = "/api_addEquipment", method = RequestMethod.POST)
	public String EquipmentController_addEquipment(HttpServletRequest request
			, @RequestParam("addEquipmentName") String addEquipmentName
			, @RequestParam("addEquipmentCode") String addEquipmentCode
			, @RequestParam("addEquipmentCount") int addEquipmentCount
			, @RequestParam("addEquipmentType") int addEquipmentType
			, @RequestParam("addEquipmentContent") String addEquipmentContent) {
		logger.info("api add Equipment");
		
		equipmentItemsDao.create(addEquipmentCode, addEquipmentName, addEquipmentType, addEquipmentCount, addEquipmentContent);
		
		
		return "200";
	}
}	
