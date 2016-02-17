package com.secsm.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		System.out.println(code);
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
			pxLogDao.create(info.getId(), result.get(0).getId(), 0, 1,result.get(0).getName(),result.get(0).getPrice());
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
	

	
	/** 상품 신청 승인 */
	@ResponseBody
	@RequestMapping(value = "/api_Accept", method = RequestMethod.POST)
	public String PXController_Accept(HttpServletRequest request
			, @RequestParam("idx") int idx){
		logger.info("api_Accept");
		System.out.println(idx);
		AccountInfo info = Util.getLoginedUser(request);
		pxReqDao.Accept(idx);
		
		return "200";
	}
	
	/** PX 금액 확인 */
	@ResponseBody
	@RequestMapping(value = "/api_GetPxAmount", method = RequestMethod.POST)
	public int PXController_getPxamount(HttpServletRequest request){
		logger.info("api_PxGetAmount");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return 0;
		}
		
		int amount = accountDao.CheckAmount(info.getId());
		
		return amount;
	}
	
	/** 금액 충전 */
	@ResponseBody
	@RequestMapping(value = "/api_Charge_Money", method = RequestMethod.POST)
	public String PXController_Charge(HttpServletRequest request
			, @RequestParam("money") int money){
		logger.info("api_Charge_money");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "index";
		}
		
		accountDao.refund_usePxAmount(info.getId(),money);
		return "0";
		
	}
	
	
	/** PX 환불 신청 */
	@ResponseBody
	@RequestMapping(value = "/Refund_px_items", method = RequestMethod.POST)
	public String Refind_Px_Items(HttpServletRequest request
			, @RequestParam("idx") int idx){
		
		logger.info("api_process_refund");
		AccountInfo info = Util.getLoginedUser(request);
		
		List<PxLogInfo> result = pxLogDao.selectById(idx);
		List<PxItemsInfo> result1 = pxItemsDao.select(result.get(0).getPxItemsId());
		
		if(result.size() == 1){
			// 정상
			accountDao.refund_usePxAmount(result.get(0).getAccountId(), result1.get(0).getPrice());
			pxLogDao.delete(idx);
			pxItemsDao.refund_useItems(result.get(0).getPxItemsId(), 1);
			return "200";

		}
		else{
			// 비정상
			return "440";
		}
	}
	
	/** PX 환불 신청 */
	@ResponseBody
	@RequestMapping(value = "/api_Delete_req_list", method = RequestMethod.POST)
	public String Delete_PxReq_list(HttpServletRequest request
			, @RequestParam("idx") int idx){
		
		logger.info("api_process_refund");
		AccountInfo info = Util.getLoginedUser(request);
		
		pxReqDao.delete(idx);
		return "200";
	}
	
	/** PX 상품 신청 리스트 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_applyReqList", method = RequestMethod.POST)
	public String PXController_api_applyReqList(HttpServletRequest request){
		logger.info("api_applyReqList");
		
		AccountInfo info = Util.getLoginedUser(request);

		List<PxReqInfo> pxReqList = pxReqDao.selectAll();
		Gson gson = new Gson();
		String result = gson.toJson(pxReqList);
			
		logger.info(result);
			
		return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/api_px_Autocomplete", method = RequestMethod.POST)
	public String PXController_Px_Auto(HttpServletRequest request){
	
		List<PxItemsInfo> px_autoList = pxItemsDao.selectAll();
		Gson gson = new Gson();
		String result = gson.toJson(px_autoList);
			
		logger.info(result);
		
		return result;
	}
	
	/** 구매 내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_getPxLog", method = RequestMethod.POST)
	public String PXController_logItem(HttpServletRequest request)
	{
		logger.info("api_getPxLog");
		
		AccountInfo info = Util.getLoginedUser(request);
		System.out.println(info.getId());
		List<PxLogInfo> pxLogList = pxLogDao.selectByAccountId(info.getId());
<<<<<<< HEAD
		int rowCount = pxLogDao.total_list_num();
		System.out.println(rowCount);
		
		Gson gson = new Gson();
		String result = gson.toJson(pxLogList);
=======
		
		Gson gson = new Gson();
		String result = gson.toJson(pxLogList);
		logger.info(result);
>>>>>>> 9adebf25fcf7b1f7f23cdeb13179bc160722a8bc
		
		return result;
	}
	
	/** Semi 구매 내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_current_buyList", method = RequestMethod.POST)
	public String PXController_Semi_list(HttpServletRequest request,
			 @RequestParam("num") int num)
	{
		logger.info("api_semi_getPxLog");
		
		System.out.println(num);
		
		AccountInfo info = Util.getLoginedUser(request);
		System.out.println(info.getId());
		List<PxLogInfo> pxLogList = pxLogDao.selectBydate(num);
	//	int id = pxLogList.get(0).getPxItemsId();
	//	List<PxItemsInfo> pxItemList =pxItemsDao.select(id);
	//	pxLogList.get(0).setName(pxItemList.get(0).getName());
		Gson gson = new Gson();
		String result = gson.toJson(pxLogList);
		logger.info(result);
		return result;
	}

	@RequestMapping(value = "/paging", method = RequestMethod.GET)
	public String Paging(@RequestParam int pageNum, Model model){
	
		int Page_size = 10;
		int Page_max_count =10;
		int TotalCount = pxLogDao.total_list_num();		//전체 글 개수
		int pageTotalCount = (TotalCount/Page_size);			//전체 페이지 계산
		int startPage = (pageNum/Page_max_count) * Page_max_count + 1;
		
		int endPage;
		
		if(pageTotalCount - (startPage-1) < Page_max_count){
			endPage = (startPage) + (pageTotalCount% Page_max_count);
		}
		else{
			endPage = (startPage-1) + Page_max_count;
		}
		
		model.addAttribute("pageNum", pageNum); //선택한 글번호 전송
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageTotalCount", pageTotalCount);
		model.addAttribute("pageMaxCount", Page_max_count);
		
		return "/modals/pxBuyItemsListModal";
		
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
