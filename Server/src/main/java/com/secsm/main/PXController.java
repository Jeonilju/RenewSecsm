package com.secsm.main;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.annotations.GenerationTime;
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
import com.secsm.conf.*;

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
		request.setAttribute("pxReqList", pxReqDao.selectAll(0));
		request.setAttribute("pxLogList", pxLogDao.selectByAccountId(info.getId(),0));
		
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
			, @RequestParam("code") String code
			, @RequestParam("cnt") int cnt
			, @RequestParam("templist") List<Integer> templist
			, @RequestParam("templen") int templen
			){
		
		logger.info("api_pxBuyItem");
	
		System.out.println(templist);
		
		
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
			
			if(result.get(0).getCount() - cnt <= 0){
				return "2";
			}
			else{
				Date date = new Date();
				Timestamp regDate = new Timestamp(date.getTime());
				
				//혼자 구매하는경우
				if(templen == 0 ){
					accountDao.usePxAmount(info.getId(), result.get(0).getPrice()*cnt);
					pxLogDao.create(info.getId(), result.get(0).getId(), 0, cnt,result.get(0).getName(),result.get(0).getPrice()*cnt,"-",regDate);
					pxItemsDao.useItems(result.get(0).getId(),cnt);
					return "0";
				}
				else{
					//함께 구매하는 경우
					int totalprice = (result.get(0).getPrice()*cnt)/(templen+1);
					
					//구매하는 사람 본인 with_buy str
					String str = "";
				//	List<AccountInfo> temp = accountDao.selectById(templist.get(0));
					str = str.concat(info.getName());
					
					int random_type = (int)(Math.random()*100000000);
					
					while(pxLogDao.check_equal_type(random_type)>0){
						random_type = (int)(Math.random()*100000000);
					}
					
					for(int i = 0 ; i < templen ; i++){
						List<AccountInfo> temp = accountDao.selectById(templist.get(i));
						str = str.concat(",");
						str = str.concat(temp.get(0).getName());
						
					}
					
					System.out.println(str);
					accountDao.usePxAmount(info.getId(), totalprice);
					pxLogDao.create(info.getId(), result.get(0).getId(), random_type, cnt,result.get(0).getName(),totalprice,str,regDate);
					pxItemsDao.useItems(result.get(0).getId(),cnt);
					
				
					for(int i = 0 ; i < templen ; i++){
						accountDao.usePxAmount(templist.get(i), totalprice);
						pxLogDao.create(templist.get(i), result.get(0).getId(), random_type, cnt,result.get(0).getName(),totalprice,str,regDate);
					}
					return "0";
				}
			}
		}
		else if(result.size() < 1){
			// 해당 아이템이 존재하지 않음
			return "1";
		}
		else{
		// 있을수 없는일
			return "3";
		}
	}
	

	
	/** 상품 신청 승인 */
	@ResponseBody
	@RequestMapping(value = "/api_Accept", method = RequestMethod.POST)
	public String PXController_Accept(HttpServletRequest request
			, @RequestParam("idx") int idx){
		logger.info("api_Accept");
	//	System.out.println(idx);
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
			return -1;
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
		String[] with_name = result.get(0).getWith_buy().split(",");
		
		if(result.size() == 1){
			// 정상
			
			accountDao.refund_usePxAmount(result.get(0).getAccountId(), result.get(0).getPrice());
			pxLogDao.delete(idx);
			pxItemsDao.refund_useItems(result.get(0).getPxItemsId(), result.get(0).getCount());
		//	System.out.println(with_name[0]);
			
			if(with_name[0].equals("-")){
				return "200";
			}
			else{
				
				List<AccountInfo> duplicate_user = accountDao.selectById(result.get(0).getAccountId());
				
				for(int i = 0 ; i < with_name.length ; i++){
					System.out.println(with_name[i]);
					if(!duplicate_user.get(0).getName().equals(with_name[i])){
						int find_type = result.get(0).getType();
						List<AccountInfo> refund_member = accountDao.selectByName(with_name[i]);
						List<PxLogInfo> result1 = pxLogDao.selectByType(find_type,refund_member.get(0).getId());
						
						accountDao.refund_usePxAmount(result1.get(0).getAccountId(), result1.get(0).getPrice());
						pxLogDao.delete(result1.get(0).getId());
					}
				}
				return "200";
			}
		}
		else{
			// 비정상
			return "440";
		}
	}
	
	/** PX 목록에서 삭제 */
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
	@RequestMapping(value = "/api_applyReqList", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String PXController_api_applyReqList(HttpServletRequest request
			,@RequestParam("pagenum") int pagenum){
		logger.info("api_applyReqList");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		if(pagenum <0){ 
			return "300";
		}
		int totalnum = pxReqDao.total_list();

		if(pagenum > totalnum){
			return "400";
		}
		else{
			List<PxReqInfo> pxReqList = pxReqDao.selectAll(pagenum);
			Gson gson = new Gson();
			String result = gson.toJson(pxReqList);
			logger.info(result);
			return result;
		}
	}
	
	/** 함께 구매할 회원 선택*/
	@ResponseBody
	@RequestMapping(value = "/api_togetherList", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String PXController_api_TogetherList(HttpServletRequest request){
		logger.info("api_togetherList");
		
		AccountInfo info = Util.getLoginedUser(request);
	
		List<AccountInfo> memberlist = accountDao.selectNotIn(info.getId());
		Gson gson = new Gson();
		String result = gson.toJson(memberlist);
		logger.info(result);
		return result;
		
	}
	
	/**자동완성*/
	@ResponseBody
	@RequestMapping(value = "/api_px_Autocomplete", method = RequestMethod.POST ,produces = "application/text; charset=utf8")
	public String PXController_Px_Auto(HttpServletRequest request){
	
		List<PxItemsInfo> px_autoList = pxItemsDao.selectAll();
		Gson gson = new Gson();
		String result = gson.toJson(px_autoList);
			
		logger.info(result);
		
		return result;
	}
	
	/** 구매 내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_getPxLog", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String PXController_logItem(HttpServletRequest request,
			@RequestParam("opt") int opt,
			@RequestParam("pagenum") int pagenum)
	{
		logger.info("api_getPxLog");
		if(pagenum <0){ 
			return "300";
		}
		
		AccountInfo info = Util.getLoginedUser(request);
		System.out.println(info.getId());
		
		int totalnum = pxLogDao.total_list_num_Byid(info.getId());

		if(pagenum > totalnum){
			return "400";
		}
		else{
			List<PxLogInfo> pxLogList = pxLogDao.selectByAccountId(info.getId(),pagenum);
			Gson gson = new Gson();
			String result = gson.toJson(pxLogList);
			return result;
		}
	}
	
	/** Semi 구매 내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_current_buyList", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String PXController_Semi_list(HttpServletRequest request,
			 @RequestParam("num") int num)
	{
		logger.info("api_semi_getPxLog");
		
		System.out.println(num);
		
		AccountInfo info = Util.getLoginedUser(request);
		System.out.println(info.getId());
		List<PxLogInfo> pxLogList = pxLogDao.selectBydate(info.getId(),num);
		Gson gson = new Gson();
		String result = gson.toJson(pxLogList);
		logger.info(result);
		return result;
	}
	
	
	
	/** 미정산자 명단 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_not_paid_list", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String PXController_not_paid_list(HttpServletRequest request)
	{
		logger.info("api_not_paid_Px");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		
		List<AccountInfo> notpaidList = accountDao.selectByMoney();
		Gson gson = new Gson();
		String result = gson.toJson(notpaidList);
		logger.info(result);
		return result;
	}
	
	
	
	
	/** 전체 상품내역 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_total_list", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String PXController_total_list(HttpServletRequest request)
	{
		logger.info("api_total_item_list");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		List<PxItemsInfo> pxiteminfo= pxItemsDao.selectAll();
		Gson gson = new Gson();
		String result = gson.toJson(pxiteminfo);
		logger.info(result);
		return result;
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
			, @RequestParam("pxItemsCount") int count
			, @RequestParam("pxItemsDescription") String description){
		logger.info("api_pxAddItem");
		
		pxItemsDao.create(name, code, price, description, count);
		
		return "200";
	}
	
}
