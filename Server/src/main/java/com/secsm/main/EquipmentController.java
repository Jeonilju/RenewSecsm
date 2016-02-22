package com.secsm.main;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
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
import com.secsm.dao.BookCategoryDao;
import com.secsm.dao.BookItemsDao;
import com.secsm.dao.BookLogDao;
import com.secsm.dao.BookReqDao;
import com.secsm.dao.EquipmentCategoryDao;
import com.secsm.dao.EquipmentItemsDao;
import com.secsm.dao.EquipmentLogDao;
import com.secsm.dao.EquipmentReqDao;
import com.secsm.info.AccountInfo;
import com.secsm.info.BookCategoryInfo;
import com.secsm.info.BookItemsInfo;
import com.secsm.info.BookLogInfo;
import com.secsm.info.BookReqInfo;
import com.secsm.info.EquipmentCategoryInfo;
import com.secsm.info.EquipmentItemsInfo;
import com.secsm.info.EquipmentLogInfo;
import com.secsm.info.EquipmentReqInfo;

@Controller
public class EquipmentController {
	
	private static final Logger logger = LoggerFactory.getLogger(EquipmentController.class);

	@Autowired
	private EquipmentCategoryDao equipmentCategoryDao;

	@Autowired
	private EquipmentItemsDao equipmentItemsDao;

	@Autowired
	private EquipmentReqDao equipmentReqDao;
	
	@Autowired
	private EquipmentLogDao equipmentLogDao;
	
	@Autowired
	private BookReqDao bookReqDao;

	@Autowired
	private BookItemsDao bookItemsDao;	
	
	@Autowired
	private BookLogDao bookLogDao;	
	
	@Autowired
	private BookCategoryDao bookCategoryDao;
	
	@RequestMapping(value = "/equipment", method = RequestMethod.GET)
	public String MainController_equipment_index(HttpServletRequest request) {
		logger.info("equipment Page");

		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "index";
		}
		
		List<EquipmentCategoryInfo> equipmentCategory= equipmentCategoryDao.selectAll();
		request.setAttribute("equipmentCategory", equipmentCategory);
		request.setAttribute("accountInfo", info);
		
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

		List<BookCategoryInfo> bookCategory= bookCategoryDao.selectALL();
		request.setAttribute("bookCategory", bookCategory);
		request.setAttribute("accountInfo", info);
		
		return "book";
	}
	
	@RequestMapping(value = "/equipmentReqExcel", method = RequestMethod.GET)
	public String EquipmentController_equipmentReqExcel(HttpServletRequest request,
			@RequestParam("reqListStartDate") String reqListStartDate,
			@RequestParam("reqListEndDate") String reqListEndDate
			) {
		logger.info("equipmentReqExcel");
		AccountInfo info = Util.getLoginedUser(request);
		
		if(info == null){
			// 비로그인
			return "index";
		}
		else if(info.getGrade() == 0 || 
				info.getGrade() == 4){
			Timestamp startDate = Util.getTimestamp(reqListStartDate);
			Timestamp endDate = Util.getTimestamp(reqListEndDate);
			endDate.setDate(endDate.getDate()+1);
			List<EquipmentReqInfo> equipmentReqList =  equipmentReqDao.selectByDate(startDate,endDate);
			for(int i=0;i<equipmentReqList.size();i++){
				Timestamp regDate = equipmentReqList.get(i).getRegDate();
				equipmentReqList.get(i).setStrRegDate(Util.getTimestempStr(regDate));
			}
			request.setAttribute("equipmentReqList",equipmentReqList);
			request.setAttribute("accountInfo", info);
			
			return "equipmentExcel";
		}
		else{
			return "index";
		}
	}
	
	@RequestMapping(value = "/bookReqExcel", method = RequestMethod.GET)
	public String EquipmentController_bookReqExcel(HttpServletRequest request,
			@RequestParam("reqListStartDate") String reqListStartDate,
			@RequestParam("reqListEndDate") String reqListEndDate
			) {
		logger.info("bookReqExcel");
		AccountInfo info = Util.getLoginedUser(request);
		
		if(info == null){
			// 비로그인
			return "index";
		}
		else if(info.getGrade() == 0 || 
				info.getGrade() == 4){
			Timestamp startDate = Util.getTimestamp(reqListStartDate);
			Timestamp endDate = Util.getTimestamp(reqListEndDate);
			endDate.setDate(endDate.getDate()+1);
			List<BookReqInfo> bookReqList =  bookReqDao.selectByDate(startDate,endDate);
			for(int i=0;i<bookReqList.size();i++){
				Timestamp regDate = bookReqList.get(i).getRegDate();
				bookReqList.get(i).setStrRegDate(Util.getTimestempStr(regDate));
			}
			request.setAttribute("bookReqList",bookReqList);
			request.setAttribute("accountInfo", info);
			
			return "bookExcel";
		}
		else{
			return "index";
		}
	}
	
	
///////////////////////////////////////////////////////////////////////////
////////////////										  /////////////////
////////////////				Equipment APIs			  /////////////////
////////////////										  /////////////////
///////////////////////////////////////////////////////////////////////////
		
	/** 장비 신청 */
	@ResponseBody
	@RequestMapping(value = "/api_reqEquipment", method = RequestMethod.POST)
	public String EquipmentController_reqEquipment(HttpServletRequest request,
			@RequestParam("reqTypeKr") String reqTypeKr,
			@RequestParam("reqTypeEn") String reqTypeEn,
			@RequestParam("reqTitleKr") String reqTitleKr,
			@RequestParam("reqTitleEn") String reqTitleEn,
			@RequestParam("reqBrand") String reqBrand,
			@RequestParam("reqLink") String reqLink,
			@RequestParam("reqContent") String reqContent,
			@RequestParam("reqPay") int reqPay,
			@RequestParam("reqCount") int reqCount
			) {
		logger.info("api req Equipment");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Date date = new Date();
		Timestamp regDate = new Timestamp(date.getTime());
		
		EquipmentReqInfo equipmentReqInfo = new EquipmentReqInfo(info.getId(),reqTypeKr, reqTypeEn,reqTitleKr,
				reqTitleEn,reqBrand,reqLink,reqPay,reqCount,reqContent,regDate); 
		equipmentReqDao.create(equipmentReqInfo);

		return "200";
	}
	
	/** 장비 요청 리스트 */
	@ResponseBody
	@RequestMapping(value = "/api_equipmentReqList", method = RequestMethod.POST , produces = "text/plain;charset=UTF-8")
	public String EquipmentController_epuipmentReqList(HttpServletRequest request,
			@RequestParam("reqListStartDate") String reqListStartDate,
			@RequestParam("reqListEndDate") String reqListEndDate,
			@RequestParam("reqPage") int reqPage
			) throws UnsupportedEncodingException {
		logger.info("api req list Epuipment");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Timestamp startDate = Util.getTimestamp(reqListStartDate);
		Timestamp endDate = Util.getTimestamp(reqListEndDate);
		endDate.setDate(endDate.getDate()+1);
		List<EquipmentReqInfo> equipmentReqList = equipmentReqDao.selectByDate(startDate, endDate, reqPage); 
		
		for(int i=0;i<equipmentReqList.size();i++){
			Timestamp regDate = equipmentReqList.get(i).getRegDate();
			equipmentReqList.get(i).setStrRegDate(Util.getTimestempStr(regDate));
		}
		Gson obj = new Gson();
		String result = obj.toJson(equipmentReqList);
		System.out.println(result);
		
		return result;
	}
	
	/** 장비 추가 */
	@ResponseBody
	@RequestMapping(value = "/api_addEquipment", method = RequestMethod.POST)
	public String EquipmentController_addEquipment(HttpServletRequest request
			, @RequestParam("addCode") String addCode
			, @RequestParam("addTitle") String addTitle
			, @RequestParam("addManufacturer") String addManufacturer
			, @RequestParam("addImageURL") String addImageURL
			, @RequestParam("addType") String addType
			, @RequestParam("addCount") int addCount) {
		logger.info("api add Book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		Date date = new Date();
		Timestamp regDate = new Timestamp(date.getTime());
		List<EquipmentCategoryInfo> categoryInfo = equipmentCategoryDao.select(addType);
		
		if(categoryInfo.size() == 0){ return "402";}
		
		EquipmentItemsInfo info = new EquipmentItemsInfo(addCode, addTitle, addManufacturer, addImageURL, categoryInfo.get(0).getId(), regDate, addCount, addCount);
		equipmentItemsDao.create(info);
		return "200";
	}
	
	/** 장비 카테고리 추가*/
	@ResponseBody
	@RequestMapping(value = "/api_equipmentAddCategory", method = RequestMethod.POST)
	public String EquipmentController_equipmentAddCategory(HttpServletRequest request,
			@RequestParam("addCategoryName") String addCategoryName
			){
		logger.info("api equipment AddCategory");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentCategoryInfo> info = equipmentCategoryDao.select(addCategoryName);
		if(info.size()!=0){
			return "402";
		}
		
		equipmentCategoryDao.create(addCategoryName);
		
		return "200";
	}
	
	/** 장비 카테고리 삭제*/
	@ResponseBody
	@RequestMapping(value = "/api_equipmentDeleteCategory", method = RequestMethod.POST)
	public String EquipmentController_equipmentDeleteCategory(HttpServletRequest request,
			@RequestParam("categoryOption") String categoryOption
			){
		logger.info("api equipment DeleteCategory");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentCategoryInfo> info = equipmentCategoryDao.select(categoryOption);
		if(info.size()==1){
			if(info.get(0).getId()==1) return "402";
			try{
				equipmentCategoryDao.delete(info.get(0).getId());
			}catch(Exception e){
				return "404";
			}
			
			return "200";
		}
		else{
			return "403";
		}
		
	}
	

	/** 장비 로그 리스트*/
	@ResponseBody
	@RequestMapping(value = "/api_logEquipment", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_logEquipment(HttpServletRequest request,
			@RequestParam("logOption") String logOption,
			@RequestParam("logSearch") String logSearch,
			@RequestParam("allLog") boolean allLog,
			@RequestParam("logPage") int logPage,
			@RequestParam("overDate") boolean overDate
			) throws UnsupportedEncodingException {
		logger.info("api log Equipment");

		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentLogInfo> info = null;
		
		if(overDate){
			Date date = new Date();
			date = new Date(date.getYear(),date.getMonth(),date.getDate()-1);
			Timestamp now = new Timestamp(date.getTime());
			
			info = equipmentLogDao.selectOverDate(now, logPage); 
		}
		
		else if(logSearch.equals("")){
			if(!allLog) info = equipmentLogDao.selectAllStatus(logPage);
			else info = equipmentLogDao.selectAll(logPage);
		}
		
		else if(logOption.equals("ID")) {
			int id;
			try{
				id = Integer.parseInt(logSearch);
			} catch(Exception e){
				return "402";
			}
			if(!allLog){
				info = equipmentLogDao.selectById(id,logPage); 
			}
			else info = equipmentLogDao.selectAllById(id,logPage);
		}
		
		else if(logOption.equals("장비명")) {
			if(!allLog){
				info = equipmentLogDao.selectByName(logSearch, logPage);
			}
			else info = equipmentLogDao.selectAllByName(logSearch, logPage); 
		}
		
		else if(logOption.equals("대여자")) {
			if(!allLog){
				info = equipmentLogDao.selectByAccountName(logSearch, logPage); 
			}
			else info = equipmentLogDao.selectAllByAccountName(logSearch, logPage); 
		}
		
		else if(logOption.equals("코드")) {
			if(!allLog){
				info = equipmentLogDao.selectByCode(logSearch, logPage); 
			}
			else info = equipmentLogDao.selectAllByCode(logSearch, logPage); 
		}
		
		for(int i=0;i<info.size();i++){
			info.get(i).setStrStartDate(Util.getTimestempStr(info.get(i).getStartDate()));
			info.get(i).setStrEndDate(Util.getTimestempStr(info.get(i).getEndDate()));
		}
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
	/** 장비검색*/
	@ResponseBody
	@RequestMapping(value = "/api_equipmentSearch", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_equipmentSearch(HttpServletRequest request,
			@RequestParam("searchOption") int searchOption,
			@RequestParam("searchCategory") String searchCategory,
			@RequestParam("searchKeyword") String searchKeyword,
			@RequestParam("searchPage") int searchPage
			) throws UnsupportedEncodingException {
		logger.info("api equipmentSearch");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentCategoryInfo> categoryInfo = equipmentCategoryDao.select(searchCategory);
		List<EquipmentItemsInfo> info = null;
		if(categoryInfo.size()==0){
			return "402";
		}
		
		if(categoryInfo.get(0).getId()==1){
			if(searchKeyword.equals("")){
				info = equipmentItemsDao.selectByPage(searchPage);
			}
			else if(searchOption==0){
				info = equipmentItemsDao.selectByNameNoCategory(searchKeyword, searchPage);
			}
			else if(searchOption==1){
				info = equipmentItemsDao.selectByCodeNoCategory(searchKeyword, searchPage);
			}
			else if(searchOption==2){
				info = equipmentItemsDao.selectByIdNoCategory(searchKeyword, searchPage);
			}
			else{}
		}
		
		else{
			if(searchOption==0){
				if(searchKeyword.equals("")){
					info = equipmentItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info = equipmentItemsDao.selectByName(searchCategory, searchKeyword, searchPage);
				}
			}
			else if(searchOption==1){
				if(searchKeyword.equals("")){
					info = equipmentItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info = equipmentItemsDao.selectByCode(searchCategory, searchKeyword, searchPage);
				}
			}
			else if(searchOption==2){
				if(searchKeyword.equals("")){
					info = equipmentItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info = equipmentItemsDao.selectById(searchCategory, searchKeyword, searchPage);
				}
			}
			else{}
		}
		
			
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		System.out.println(result);
		return result;
	}
	
	
	/** 수정장비 검색*/
	@ResponseBody
	@RequestMapping(value = "/api_equipmentSearchForModify", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_equipmentSearchForModify(HttpServletRequest request,
			@RequestParam("searchId") int searchId
			) throws UnsupportedEncodingException {
		logger.info("api equipmentSearchForModify");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentItemsInfo> info = equipmentItemsDao.select(searchId);
		
		if(info.size()==0){
			return "402";
		}
		
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
	/** 장비 수정*/
	@ResponseBody
	@RequestMapping(value = "/api_modifyEquipment", method = RequestMethod.POST)
	public String EquipmentController_modifyEquipment(HttpServletRequest request
			, @RequestParam("modifyId") int modifyId
			, @RequestParam("modifyCode") String modifyCode
			, @RequestParam("modifyTitle") String modifyTitle
			, @RequestParam("modifyManufacturer") String modifyManufacturer
			, @RequestParam("modifyImageURL") String modifyImageURL
			, @RequestParam("modifyType") int modifyType
			, @RequestParam("modifyCount") int modifyCount) {
		logger.info("api modify Equipment");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<EquipmentCategoryInfo> categoryInfo = equipmentCategoryDao.select(modifyType);
		
		if(categoryInfo.size() == 0){
			return "404";
		}
		
		List<EquipmentItemsInfo> countTest = equipmentItemsDao.select(modifyId);
		if(countTest.size()==0){
			return "403";
		}
		else if(countTest.get(0).getCount()!=countTest.get(0).getTotalCount()){
			return "402";
		}
		
		EquipmentItemsInfo info = new EquipmentItemsInfo(modifyId, modifyCode, modifyTitle, modifyManufacturer, modifyImageURL, categoryInfo.get(0).getId(), modifyCount, modifyCount);
		equipmentItemsDao.modify(info);
		return "200";
	}
	
	/** 장비 삭제*/
	@ResponseBody
	@RequestMapping(value = "/api_deleteEquipment", method = RequestMethod.POST)
	public String EquipmentController_deleteEquipment(HttpServletRequest request
			, @RequestParam("modifyId") int modifyId
			) {
		logger.info("api delete equipment");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		equipmentLogDao.delete(modifyId);
		
		equipmentItemsDao.delete(modifyId);

		return "200";
	}
	
	/** 장비 대여*/
	@ResponseBody
	@RequestMapping(value = "/api_rentEquipment", method = RequestMethod.POST)
	public String EquipmentController_rentEquipment(HttpServletRequest request,
			@RequestParam("rentId") String rentId,
			@RequestParam("rentEndDate") String rentEndDate
			){
		logger.info("api rent Equipment");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Date date = new Date();
		date = new Date(date.getYear(),date.getMonth(),date.getDate());
		Timestamp startDate = new Timestamp(date.getTime());
		Timestamp endDate = Util.getTimestamp(rentEndDate);
		if(startDate.getTime() > endDate.getTime()){
			return "404";
		}
		
		List<EquipmentItemsInfo> equipmentItemsInfo = equipmentItemsDao.selectByIdNoCategory(rentId,0);
		if(equipmentItemsInfo.size()>0){
			if(equipmentItemsInfo.get(0).getCount()>0){
				equipmentItemsDao.downCount(rentId);
			}
			else{
				return "403";
			}
		}
		else{
			return "402";
		}
		
		EquipmentLogInfo equipmentLogInfo = new EquipmentLogInfo(info.getId(),Integer.parseInt(rentId),startDate,endDate,1);
		equipmentLogDao.create(equipmentLogInfo);
		
		return "200";
	}
	
	/** 장비 반납*/
	@ResponseBody
	@RequestMapping(value = "/api_rentBackEquipment", method = RequestMethod.POST)
	public String EquipmentController_rentBackEquipment(HttpServletRequest request,
			@RequestParam("logId") int logId,
			@RequestParam("accountId") int accountId,
			@RequestParam("equipmentItemsId") int equipmentItemsId
			){
		logger.info("api rentBack Equipment");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		else if(info.getId() != accountId){
			return "402";
		}
		
		equipmentLogDao.rentBack(logId);
		equipmentItemsDao.upCount(equipmentItemsId);
		
		Date date = new Date();
		Timestamp now = new Timestamp(date.getTime());
		equipmentLogDao.updateEndDate(logId, now);
		
		return "200";
	}

	
///////////////////////////////////////////////////////////////////////////
////////////////										  /////////////////
////////////////				Book APIs				  /////////////////
////////////////										  /////////////////
///////////////////////////////////////////////////////////////////////////
	
	/** 도서 신청 */
	@ResponseBody
	@RequestMapping(value = "/api_reqBook", method = RequestMethod.POST)
	public String EquipmentController_reqBook(HttpServletRequest request,
			@RequestParam("reqTitle") String reqTitle,
			@RequestParam("reqPublisher") String reqPublisher,
			@RequestParam("reqAuthor") String reqAuthor,
			@RequestParam("reqLink") String reqLink,
			@RequestParam("reqImageURL") String reqImageURL,
			@RequestParam("reqPay") int reqPay
			) {
		logger.info("api req Book");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Date date = new Date();
		Timestamp regDate = new Timestamp(date.getTime());
		
		BookReqInfo bookReqInfo = new BookReqInfo(info.getId(),reqTitle,reqPublisher,reqAuthor,
				reqLink,reqImageURL,reqPay,regDate); 
		bookReqDao.create(bookReqInfo);

		return "200";
	}
	
	/** 도서 요청 리스트 */
	@ResponseBody
	@RequestMapping(value = "/api_reqList", method = RequestMethod.POST , produces = "text/plain;charset=UTF-8")
	public String EquipmentController_reqList(HttpServletRequest request,
			@RequestParam("reqListStartDate") String reqListStartDate,
			@RequestParam("reqListEndDate") String reqListEndDate,
			@RequestParam("reqPage") int reqPage
			) throws UnsupportedEncodingException {
		logger.info("api req list Book");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Timestamp startDate = Util.getTimestamp(reqListStartDate);
		Timestamp endDate = Util.getTimestamp(reqListEndDate);
		endDate.setDate(endDate.getDate()+1);
		List<BookReqInfo> bookReqList = bookReqDao.selectByDate(startDate, endDate, reqPage); 
		
		for(int i=0;i<bookReqList.size();i++){
			Timestamp regDate = bookReqList.get(i).getRegDate();
			bookReqList.get(i).setStrRegDate(Util.getTimestempStr(regDate));
		}
		Gson obj = new Gson();
		String result = obj.toJson(bookReqList);
		System.out.println(result);
		
		return result;
	}
	
	/** 도서 추가 */
	@ResponseBody
	@RequestMapping(value = "/api_addBook", method = RequestMethod.POST)
	public String EquipmentController_addBook(HttpServletRequest request
			, @RequestParam("addCode") String addCode
			, @RequestParam("addTitle") String addTitle
			, @RequestParam("addPublisher") String addPublisher
			, @RequestParam("addAuthor") String addAuthor
			, @RequestParam("addImageURL") String addImageURL
			, @RequestParam("addType") String addType
			, @RequestParam("addCount") int addCount) {
		logger.info("api add Book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		Date date = new Date();
		Timestamp regDate = new Timestamp(date.getTime());
		System.out.println(addType);
		List<BookCategoryInfo> categoryInfo = bookCategoryDao.select(addType);
		
		if(categoryInfo.size() == 0){ return "402";}
		
		BookItemsInfo info = new BookItemsInfo(addCode, addTitle, addPublisher, addAuthor, addImageURL, categoryInfo.get(0).getId(), regDate, addCount, addCount);
		bookItemsDao.create(info);
		return "200";
	}
	
	/** 도서 카테고리 추가*/
	@ResponseBody
	@RequestMapping(value = "/api_addCategory", method = RequestMethod.POST)
	public String EquipmentController_addCategory(HttpServletRequest request,
			@RequestParam("addCategoryName") String addCategoryName
			){
		logger.info("api addCategory book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookCategoryInfo> info = bookCategoryDao.select(addCategoryName);
		if(info.size()!=0){
			return "402";
		}
		
		bookCategoryDao.create(addCategoryName);
		
		return "200";
	}
	
	/** 도서 카테고리 삭제*/
	@ResponseBody
	@RequestMapping(value = "/api_deleteCategory", method = RequestMethod.POST)
	public String EquipmentController_deleteCategory(HttpServletRequest request,
			@RequestParam("categoryOption") String categoryOption
			){
		logger.info("api deleteCategory book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookCategoryInfo> info = bookCategoryDao.select(categoryOption);
		if(info.size()==1){
			if(info.get(0).getId()==1) return "402";
			try{
				bookCategoryDao.delete(info.get(0).getId());
			}catch(Exception e){
				return "404";
			}
			
			return "200";
		}
		else{
			return "403";
		}
		
	}
	
	/** 도서 로그 리스트*/
	@ResponseBody
	@RequestMapping(value = "/api_logBook", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_logBook(HttpServletRequest request,
			@RequestParam("logOption") String logOption,
			@RequestParam("logSearch") String logSearch,
			@RequestParam("allLog") boolean allLog,
			@RequestParam("logPage") int logPage,
			@RequestParam("overDate") boolean overDate
			) throws UnsupportedEncodingException {
		logger.info("api log book");

		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookLogInfo> info = null;
		
		if(overDate){
			Date date = new Date();
			date = new Date(date.getYear(),date.getMonth(),date.getDate()-1);
			Timestamp now = new Timestamp(date.getTime());
			
			info = bookLogDao.selectOverDate(now, logPage); 
		}
		
		else if(logSearch.equals("")){
			if(!allLog) info = bookLogDao.selectAllStatus(logPage);
			else info = bookLogDao.selectAll(logPage);
		}
		
		else if(logOption.equals("ID")) {
			int id;
			try{
				id = Integer.parseInt(logSearch);
			} catch(Exception e){
				return "402";
			}
			if(!allLog){
				info = bookLogDao.selectById(id,logPage); 
			}
			else info = bookLogDao.selectAllById(id,logPage);
		}
		
		else if(logOption.equals("도서명")) {
			if(!allLog){
				info = bookLogDao.selectByName(logSearch, logPage);
			}
			else info = bookLogDao.selectAllByName(logSearch, logPage); 
		}
		
		else if(logOption.equals("대여자")) {
			if(!allLog){
				info = bookLogDao.selectByAccountName(logSearch, logPage); 
			}
			else info = bookLogDao.selectAllByAccountName(logSearch, logPage); 
		}
		
		else if(logOption.equals("코드")) {
			if(!allLog){
				info = bookLogDao.selectByCode(logSearch, logPage); 
			}
			else info = bookLogDao.selectAllByCode(logSearch, logPage); 
		}
		
		for(int i=0;i<info.size();i++){
			info.get(i).setStrStartDate(Util.getTimestempStr(info.get(i).getStartDate()));
			info.get(i).setStrEndDate(Util.getTimestempStr(info.get(i).getEndDate()));
		}
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
	/** 도서검색*/
	@ResponseBody
	@RequestMapping(value = "/api_bookSearch", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_bookSearch(HttpServletRequest request,
			@RequestParam("searchOption") int searchOption,
			@RequestParam("searchCategory") String searchCategory,
			@RequestParam("searchKeyword") String searchKeyword,
			@RequestParam("searchPage") int searchPage
			) throws UnsupportedEncodingException {
		logger.info("api bookSearch book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookCategoryInfo> categoryInfo = bookCategoryDao.select(searchCategory);
		List<BookItemsInfo> info = null;
		if(categoryInfo.size()==0){
			return "402";
		}
		
		if(categoryInfo.get(0).getId()==1){
			if(searchKeyword.equals("")){
				info = bookItemsDao.selectByPage(searchPage);
			}
			else if(searchOption==0){
				info = bookItemsDao.selectByNameNoCategory(searchKeyword, searchPage);
			}
			else if(searchOption==1){
				info =bookItemsDao.selectByCodeNoCategory(searchKeyword, searchPage);
			}
			else if(searchOption==2){
				info = bookItemsDao.selectByIdNoCategory(searchKeyword, searchPage);
			}
			else{}
		}
		
		else{
			if(searchOption==0){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info = bookItemsDao.selectByName(searchCategory, searchKeyword, searchPage);
				}
			}
			else if(searchOption==1){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info =bookItemsDao.selectByCode(searchCategory, searchKeyword, searchPage);
				}
			}
			else if(searchOption==2){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectByCategory(searchCategory, searchPage);
				}
				else{
					info = bookItemsDao.selectById(searchCategory, searchKeyword, searchPage);
				}
			}
			else{}
		}
		
			
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		System.out.println(result);
		return result;
	}
	
	/** 수정도서 검색*/
	@ResponseBody
	@RequestMapping(value = "/api_bookSearchForModify", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_bookSearchForModify(HttpServletRequest request,
			@RequestParam("searchId") int searchId
			) throws UnsupportedEncodingException {
		logger.info("api bookSearchForModify");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookItemsInfo> info = bookItemsDao.select(searchId);
		
		if(info.size()==0){
			return "402";
		}
		
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
	/** 도서 수정*/
	@ResponseBody
	@RequestMapping(value = "/api_modifyBook", method = RequestMethod.POST)
	public String EquipmentController_modifyBook(HttpServletRequest request
			, @RequestParam("modifyId") int modifyId
			, @RequestParam("modifyCode") String modifyCode
			, @RequestParam("modifyTitle") String modifyTitle
			, @RequestParam("modifyPublisher") String modifyPublisher
			, @RequestParam("modifyAuthor") String modifyAuthor
			, @RequestParam("modifyImageURL") String modifyImageURL
			, @RequestParam("modifyType") int modifyType
			, @RequestParam("modifyCount") int modifyCount) {
		logger.info("api modify book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookCategoryInfo> categoryInfo = bookCategoryDao.select(modifyType);
		
		if(categoryInfo.size() == 0){
			return "404";
		}
		
		List<BookItemsInfo> countTest = bookItemsDao.select(modifyId);
		if(countTest.size()==0){
			return "403";
		}
		else if(countTest.get(0).getCount()!=countTest.get(0).getTotalCount()){
			return "402";
		}
		
		BookItemsInfo info = new BookItemsInfo(modifyId, modifyCode, modifyTitle, modifyPublisher, modifyAuthor, modifyImageURL, categoryInfo.get(0).getId(), modifyCount, modifyCount);
		bookItemsDao.modify(info);
		return "200";
	}
	
	/** 도서 삭제*/
	@ResponseBody
	@RequestMapping(value = "/api_deleteBook", method = RequestMethod.POST)
	public String EquipmentController_deleteBook(HttpServletRequest request
			, @RequestParam("modifyId") int modifyId
			) {
		logger.info("api delete book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		bookLogDao.delete(modifyId);
		
		bookItemsDao.delete(modifyId);

		return "200";
	}	
	
	/** 도서 대여*/
	@ResponseBody
	@RequestMapping(value = "/api_rentBook", method = RequestMethod.POST)
	public String EquipmentController_rentBook(HttpServletRequest request,
			@RequestParam("rentId") String rentId,
			@RequestParam("rentEndDate") String rentEndDate
			){
		logger.info("api rent book");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Date date = new Date();
		date = new Date(date.getYear(),date.getMonth(),date.getDate());
		Timestamp startDate = new Timestamp(date.getTime());
		Timestamp endDate = Util.getTimestamp(rentEndDate);
		if(startDate.getTime() > endDate.getTime()){
			return "404";
		}
		
		List<BookItemsInfo> bookItemsInfo = bookItemsDao.selectByIdNoCategory(rentId,0);
		if(bookItemsInfo.size()>0){
			if(bookItemsInfo.get(0).getCount()>0){
				bookItemsDao.downCount(rentId);
			}
			else{
				return "403";
			}
		}
		else{
			return "402";
		}
		
		BookLogInfo bookLogInfo = new BookLogInfo(info.getId(),Integer.parseInt(rentId),startDate,endDate,1);
		bookLogDao.create(bookLogInfo);
		
		return "200";
	}
	
	/** 도서 반납*/
	@ResponseBody
	@RequestMapping(value = "/api_rentBack", method = RequestMethod.POST)
	public String EquipmentController_rentBack(HttpServletRequest request,
			@RequestParam("logId") int logId,
			@RequestParam("accountId") int accountId,
			@RequestParam("bookItemsId") int bookItemsId
			){
		logger.info("api rentBack book");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		else if(info.getId() != accountId){
			return "402";
		}
		
		bookLogDao.rentBack(logId);
		bookItemsDao.upCount(bookItemsId);
		
		Date date = new Date();
		Timestamp now = new Timestamp(date.getTime());
		bookLogDao.updateEndDate(logId, now);
		
		return "200";
	}

}	
