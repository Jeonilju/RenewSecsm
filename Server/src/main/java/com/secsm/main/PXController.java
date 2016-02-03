package com.secsm.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
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
import com.secsm.dao.AccountDao;
import com.secsm.dao.PxCategoryDao;
import com.secsm.dao.PxItemsDao;
import com.secsm.dao.PxLogDao;
import com.secsm.dao.PxReqDao;
import com.secsm.info.AccountInfo;
import com.secsm.info.PxItemsInfo;
import com.secsm.info.PxLogInfo;
import com.secsm.info.PxReqInfo;

@Controller
public class PXController {
	private static final Logger logger = LoggerFactory.getLogger(PXController.class);
	
	@Autowired
	private AccountDao accountDao;
	
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

		AccountInfo info = Util.getLoginedUser(request);
		
		if(info == null){
			return "index";
		}
		
		request.setAttribute("accountInfo", info);
		request.setAttribute("pxReqList", pxReqDao.selectAll());
		request.setAttribute("pxLogList", pxLogDao.selectByAccountId(info.getId()));
		
		return "px";
	}
	
	
	/////////////////////////////////////////////////////////////
	/////////////									/////////////
	/////////////				APIs				/////////////
	/////////////									/////////////
	/////////////////////////////////////////////////////////////
	
	/** 상품 구매 */
	@ResponseBody
	@RequestMapping(value = "/api_pxBuyItem", method = RequestMethod.POST)
	public String PXController_buyItem(HttpServletRequest request
			, @RequestParam("type") int type
			, @RequestParam("code") String code){
		logger.info("api_pxBuyItem");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "index";
		}
		
		List<PxItemsInfo> result = new ArrayList<PxItemsInfo>();
		
		if(type == 0){
			// 바코드
			result = pxItemsDao.selectByCode(code);
		}
		else if(type == 1){
			// 상품 명
			result = pxItemsDao.selectByName(code);
		}
		
		if(result.size() == 1){
			// 정상
			accountDao.usePxAmount(info.getId(), result.get(0).getPrice());
			pxLogDao.create(info.getId(), result.get(0).getId(), 0, 1);
			pxItemsDao.useItems(result.get(0).getId(), 1);
			return "0";
		}
		else if(result.size() < 1){
			// 해당 아이템이 존재하지 않음
			return "1";
		}
		else{
			// 있을수 없는일
			return "2";
		}
	}
	
	/** 구매 내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_getPxLog", method = RequestMethod.POST)
	public String PXController_logItem(HttpServletRequest request
			, @RequestParam("logCount") int logCount){
		logger.info("api_getPxLog");
		
		AccountInfo info = Util.getLoginedUser(request);
		List<PxLogInfo> pxLogList = pxLogDao.selectByAccountId(info.getId());
		
		return JSONArray.toJSONString(pxLogList);
	}
	
	/** PX 상품 신청 */
	@ResponseBody
	@RequestMapping(value = "/api_applyReq", method = RequestMethod.POST)
	public String PXController_api_applyReq(HttpServletRequest request
			, @RequestParam("pxApplyTitle") String pxApplyTitle
			, @RequestParam("pxApplyContent") String pxApplyContent){
		logger.info("api_applyReq");
		
		AccountInfo info = Util.getLoginedUser(request);
		pxReqDao.create(info.getId(), pxApplyTitle, pxApplyContent);
		
		return "200";
	}
	
	/** PX 상품 신청 리스트 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_applyReqList", method = RequestMethod.POST)
	public String PXController_api_applyReqList(HttpServletRequest request){
		logger.info("api_applyReqList");
		
		List<PxReqInfo> pxReqList = pxReqDao.selectAll();
		Gson gson = new Gson();
		String result = gson.toJson(pxReqList);
		
		logger.info(result);
		
		return result;
	}
	
	/** PX 상품 추가 */
	@ResponseBody
	@RequestMapping(value = "/api_pxAddItem", method = RequestMethod.POST)
	public String PXController_api_pxAddItem(HttpServletRequest request
			, @RequestParam("pxItemsName") String name
			, @RequestParam("pxItemsCode") String code
			, @RequestParam("pxItemsPrice") int price
			, @RequestParam("pxItemsDescription") String description
			, @RequestParam("pxItemsCount") int count){
		logger.info("api_pxAddItem");
		
		pxItemsDao.create(name, code, price, description, count);
		
		return "200";
	}
	
	
}
