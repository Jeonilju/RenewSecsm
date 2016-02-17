package com.secsm.main;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;

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
import com.secsm.info.BookCategoryInfo;
import com.secsm.info.EquipmentCategoryInfo;
import com.secsm.info.EquipmentItemsInfo;

import net.sf.json.JSONObject;
import com.secsm.info.BookReqInfo;
import com.secsm.dao.BookReqDao;
import com.secsm.info.BookItemsInfo;
import com.secsm.info.BookLogInfo;
import com.secsm.dao.BookCategoryDao;
import com.secsm.dao.BookItemsDao;
import com.secsm.dao.BookLogDao;

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

		List<BookItemsInfo> bookItemsList= bookItemsDao.selectByPage();
		List<BookCategoryInfo> bookCategory= bookCategoryDao.selectALL();
		
		request.setAttribute("bookItemsList", bookItemsList);
		request.setAttribute("bookCategory", bookCategory);
		
		return "book";
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

//	/** 도서 검색 */
//	@ResponseBody
//	@RequestMapping(value = "/api_searchBook", method = RequestMethod.POST)
//	public String EquipmentController_searchBook(HttpServletRequest request,
//			@RequestParam("searchBookType") int searchBookType,
//			@RequestParam("searchBookContent") String searchBookContent) {
//		logger.info("api Search Book");
//
//		List<EquipmentItemsInfo> equipmentItemsList = new ArrayList<EquipmentItemsInfo>();
//		
//		// TODO selectByBook 메소드를 이용하도록 변경
//		
//		if(searchBookType != 0){
//			// 카테고리 검색
//			equipmentItemsList.addAll(equipmentItemsDao.selectByBook(searchBookContent));
//		}
//		else{
//			// 전체검색
//			
//			// 책에 관련된 카테고리 전부르 얻어옴
//			List<EquipmentCategoryInfo> equipmentCategoryList = equipmentCategoryDao.selectIsBook(1);
//			equipmentItemsList.addAll(equipmentItemsDao.selectByBook(searchBookContent));
//		}
//
//		Gson obj = new Gson();
//		String result = obj.toJson(equipmentItemsList);
//		
//		return result;
//	}
//
//	@ResponseBody
//	@RequestMapping(value = "/api_applyBook", method = RequestMethod.POST)
//	public String EquipmentController_applyBook(HttpServletRequest request
//			, @RequestParam("applyEquipmentType") int applyEquipmentType
//			, @RequestParam("applyBookContent") String applyEquipmentContent) {
//		logger.info("api Apply Book");
//
//		AccountInfo info = Util.getLoginedUser(request);
//		int result = equipmentItemsDao.apply(info.getId(),applyEquipmentType, applyEquipmentContent);
//
//		if (result == 0) {
//			return "대여";
//		} else if (result == 1) {
//			return "반납";
//		} else {
//			return "??";
//		}
//	}

	
	
	@ResponseBody
	@RequestMapping(value = "/api_reqList", method = RequestMethod.POST , produces = "text/plain;charset=UTF-8")
	public String EquipmentController_reqBook(HttpServletRequest request,
			@RequestParam("reqListStartDate") String reqListStartDate,
			@RequestParam("reqListEndDate") String reqListEndDate
			) throws UnsupportedEncodingException {
		logger.info("api req list Book");

		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Timestamp startDate = Util.getTimestamp(reqListStartDate);
		Timestamp endDate = Util.getTimestamp(reqListEndDate);
		endDate.setDate(endDate.getDate()+1);
		List<BookReqInfo> bookReqList = bookReqDao.selectByDate(startDate, endDate); 
		
		for(int i=0;i<bookReqList.size();i++){
			Timestamp regDate = bookReqList.get(0).getRegDate();
			bookReqList.get(0).setStrRegDate(Util.getTimestempStr(regDate));
		}
		Gson obj = new Gson();
		String result = obj.toJson(bookReqList);
		System.out.println(result);
		
		return result;
	}
	
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
	
	@ResponseBody
	@RequestMapping(value = "/api_addBook", method = RequestMethod.POST)
	public String EquipmentController_addEquipment(HttpServletRequest request
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
		
		List<BookCategoryInfo> categoryInfo = bookCategoryDao.select(addType);
		
		if(categoryInfo.size() == 0){ return "402";}
		
		BookItemsInfo info = new BookItemsInfo(addCode, addTitle, addPublisher, addAuthor, addImageURL, categoryInfo.get(0).getId(), regDate, addCount, addCount);
		bookItemsDao.create(info);
		return "200";
	}
	
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
		
		List<BookItemsInfo> bookItemsInfo = bookItemsDao.selectByIdNoCategory(rentId);
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
		
		BookLogInfo bookLogInfo = new BookLogInfo(info.getId(),Integer.parseInt(rentId),startDate,Util.getTimestamp(rentEndDate),1);
		bookLogDao.create(bookLogInfo);
		
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value = "/api_logBook", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_logBook(HttpServletRequest request,
			@RequestParam("logOption") String logOption,
			@RequestParam("logSearch") String logSearch,
			@RequestParam("allLog") boolean allLog
			) throws UnsupportedEncodingException {
		logger.info("api log book");

		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		List<BookLogInfo> info = null;
		
		if(logSearch.equals("")){
			if(!allLog) info = bookLogDao.selectAllStatus();
			else info = bookLogDao.selectAll();
		}
		
		else if(logOption.equals("ID")) {
			int id;
			try{
				id = Integer.parseInt(logSearch);
			} catch(Exception e){
				return "402";
			}
			if(!allLog){
				info = bookLogDao.selectById(id); 
			}
			else info = bookLogDao.selectAllById(id);
		}
		
		else if(logOption.equals("도서명")) {
			if(!allLog){
				info = bookLogDao.selectByName(logSearch);
			}
			else info = bookLogDao.selectAllByName(logSearch); 
		}
		
		else if(logOption.equals("대여자")) {
			if(!allLog){
				info = bookLogDao.selectByAccountName(logSearch); 
			}
			else info = bookLogDao.selectAllByAccountName(logSearch); 
		}
		
		else if(logOption.equals("코드")) {
			if(!allLog){
				info = bookLogDao.selectByCode(logSearch); 
			}
			else info = bookLogDao.selectAllByCode(logSearch); 
		}
		
		for(int i=0;i<info.size();i++){
			info.get(i).setStrStartDate(Util.getTimestempStr(info.get(i).getStartDate()));
			info.get(i).setStrEndDate(Util.getTimestempStr(info.get(i).getEndDate()));
		}
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
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
	
	@ResponseBody
	@RequestMapping(value = "/api_deleteCategory", method = RequestMethod.POST)
	public String EquipmentController_deleteCategory(HttpServletRequest request,
			@RequestParam("categoryOption") String categoryOption
			){
		logger.info("api addCategory book");
		
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
	
	@ResponseBody
	@RequestMapping(value = "/api_bookSearch", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String EquipmentController_bookSearch(HttpServletRequest request,
			@RequestParam("searchOption") int searchOption,
			@RequestParam("searchCategory") String searchCategory,
			@RequestParam("searchKeyword") String searchKeyword
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
				info = bookItemsDao.selectByPage();
			}
			else if(searchOption==0){
				info = bookItemsDao.selectByNameNoCategory(searchKeyword);
			}
			else if(searchOption==1){
				info =bookItemsDao.selectByCodeNoCategory(searchKeyword);
			}
			else if(searchOption==2){
				info = bookItemsDao.selectByIdNoCategory(searchKeyword);
			}
			else{}
		}
		
		else{
			if(searchOption==0){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectByName(searchCategory);
				}
				else{
					info = bookItemsDao.selectByName(searchCategory, searchKeyword);
				}
			}
			else if(searchOption==1){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectByCode(searchCategory);
				}
				else{
					info =bookItemsDao.selectByCode(searchCategory, searchKeyword);
				}
			}
			else if(searchOption==2){
				if(searchKeyword.equals("")){
					info = bookItemsDao.selectById(searchCategory);
				}
				else{
					info = bookItemsDao.selectById(searchCategory, searchKeyword);
				}
			}
			else{}
		}
		
			
		Gson obj = new Gson();
		String result = obj.toJson(info);
		
		return result;
	}
	
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
	
	@ResponseBody
	@RequestMapping(value = "/api_deleteBook", method = RequestMethod.POST)
	public String EquipmentController_deleteBook(HttpServletRequest request
			, @RequestParam("modifyId") int modifyId
			) {
		logger.info("api modify book");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if (accountInfo == null) {
			return "401";
		}
		
		bookLogDao.delete(modifyId);
		
		bookItemsDao.delete(modifyId);

		return "200";
	}
}	
