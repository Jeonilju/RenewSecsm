package com.secsm.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.secsm.dao.AttendanceDao;
import com.secsm.info.AccountInfo;

@Controller
public class SecsmController {
	private static final Logger logger = LoggerFactory.getLogger(SecsmController.class);

	@Autowired
	private AccountDao accountDao;

	@Autowired
	private AttendanceDao attendanceDao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String MainController_main(HttpServletRequest request) {
		logger.info("index Page");
		return resultIndex(request);
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String MainController_index(HttpServletRequest request) {
		logger.info("index Page");
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if(accountInfo == null){
			// 비로그인
			return resultIndex(request);			
		}
		else{
			return LivingController.resultAttendance(request, attendanceDao);
		}
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String MainController_logout(HttpServletRequest request) {
		logger.info("logout Page");

		HttpSession session = request.getSession();
		session.setAttribute("currentmember", null);
		
		return resultIndex(request);
	}
	
	public static String resultIndex(HttpServletRequest request){
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			// 비로그인 
			logger.info("비로그인상태");
			request.setAttribute("isLogined", null);
			return "index";
		}
		else{
			// 로그인
			logger.info("로그인상태");
			request.setAttribute("isLogined", true);
			return "index";
		}
	}
	
	/** 로그인  */
	@RequestMapping(value = "/api_login", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String MainController_api_login(HttpServletRequest request
			, @RequestParam("login_email") String login_email
			, @RequestParam("login_password") String login_password) {
		logger.info("api_login");
		
		String result = "";
		
		if(login_email.length() > 50)
			return "email";
		else if(login_password.length() > 16)
			return "password";
		
		// 세션 객체 생성
		HttpSession session = request.getSession();
		List<AccountInfo> accountList = accountDao.select(login_email);
		List<AccountInfo> confirmAccountList = accountDao.selectByEmailNGrade(login_email, -1);
		List<AccountInfo> graduateAccountList = accountDao.selectByEmailNGrade(login_email, 10);
		
		
		if(!confirmAccountList.isEmpty()){
			// 비 인증 유저
			result = "승인되지 않은 사용자입니다. 승인 후에 사용해주세요.";
		}
		else if(!graduateAccountList.isEmpty()){
			result = "탈퇴 유저입니다. 관리자에게 문의해주세요.";
		}
		else if (accountList == null || accountList.isEmpty()) {
			result = "존재하지 않는 이메일입니다."; // no email
		}
		else {
			if (accountList.get(0).getPw().equals(login_password)) // password unequal
			{
				result = "200";
				session.setAttribute("currentmember", accountList.get(0));
			} else {
				result = "잘못된 비밀번호 입니다.";
			}
		}
		
		return result;
	}
	
	/** 회원가입  */
	@RequestMapping(value = "/api_signup", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_signup(HttpServletRequest request
			, @RequestParam("User_mail") String User_mail
			, @RequestParam("User_password") String User_password
			, @RequestParam("re_User_password") String re_User_password
			, @RequestParam("User_name") String User_name
			, @RequestParam("User_gender") int User_gender
			, @RequestParam("User_phone") String User_phone
			, @RequestParam("User_cardnum") int User_cardnum) {
		logger.info("api_signup");
		accountDao.create(User_name, User_mail, User_password, User_phone, -1, User_gender, User_cardnum);
		
		return "200";
		
	}
	
	/** 중복체크  */
	@RequestMapping(value = "/api_duplicate_check", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_duplicate_Check(HttpServletRequest request
			, @RequestParam("User_mail") String User_mail
			) {
		logger.info("api_duplicate_check");
		
		int chk =accountDao.duplicate_check(User_mail);
		if(chk ==0){
			return "200";
		}
		else{
			return "400";
		}
	}
	
	/** 이름 중복체크  */
	@RequestMapping(value = "/api_nameDuplicate_check", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_nameDuplicate_check(HttpServletRequest request
			, @RequestParam("User_name") String User_name
			) {
		logger.info("api_nameDuplicate_check");
		
		int chk =accountDao.nameDuplicate_check(User_name);
		if(chk ==0){
			return "200";
		}
		else{
			return "400";
		}
	}
	
	/** 회원 정보 가져오기*/
	@RequestMapping(value = "/api_accountForModify", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String MainController_api_accountForModify(HttpServletRequest request
			) {
		logger.info("api_accountForModify");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		Gson obj = new Gson();
		String result = obj.toJson(info);
		return result;
	}
	
	
	/** 정보 수정 */
	@RequestMapping(value = "/api_modifyAccount", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_modifyAccount(HttpServletRequest request
			, @RequestParam("User_password") String pw
			, @RequestParam("User_name") String name
			, @RequestParam("User_gender") String gender
			, @RequestParam("User_phone") String phone
			) {
		logger.info("api_modifyAccount");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		accountDao.modify(info.getId(),pw,name,gender,phone);
		
		HttpSession session = request.getSession();
		List<AccountInfo> accountList = accountDao.select(info.getEmail());
		session.setAttribute("currentmember", accountList.get(0));
		
		return "200";
	}
	
	/** 회원 리스트*/
	@RequestMapping(value = "/api_accountList", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String MainController_api_accountList(HttpServletRequest request
			, @RequestParam("page") int page
			) {
		logger.info("api_accountList");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		List<AccountInfo> list =accountDao.selectByPage(page);
		
		Gson obj = new Gson();
		String result = obj.toJson(list);
		return result;
	}
	
	/** 계정 삭제 */
	@RequestMapping(value = "/api_adminDeleteAccount", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_adminDeleteAccount(HttpServletRequest request
			, @RequestParam("id") int id
			) {
		logger.info("adminDeleteAccount");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		accountDao.modifyGrade(id, 10);
		if(id==info.getId()){
			HttpSession session = request.getSession();
			session.setAttribute("currentmember", null);
			return "201";
		}
		
		return "200";
	}
	
	/** 계정 권한수정 */
	@RequestMapping(value = "/api_adminModifyAccount", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_adminModifyAccount(HttpServletRequest request
			, @RequestParam("id") int id
			, @RequestParam("grade") int grade
			) {
		logger.info("adminModifyAccount");
		
		AccountInfo info = Util.getLoginedUser(request);
		if (info == null) {
			return "401";
		}
		
		accountDao.modifyGrade(id, grade);
		if(id==info.getId()){
			HttpSession session = request.getSession();
			session.setAttribute("currentmember", null);
			return "201";
		}
		return "200";
	}
}
