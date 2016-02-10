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

import com.secsm.conf.Util;
import com.secsm.dao.AccountDao;
import com.secsm.info.AccountInfo;

@Controller
public class SecsmController {
	private static final Logger logger = LoggerFactory.getLogger(SecsmController.class);

	@Autowired
	private AccountDao accountDao;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String MainController_main(HttpServletRequest request) {
		logger.info("index Page");

		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			// 비로그인 
			return "index";
		}
		else{
			// 로그인
			return "attendance";
		}
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String MainController_index(HttpServletRequest request) {
		logger.info("index Page");

		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			// 비로그인 
			return "index";
		}
		else{
			// 로그인
			return "attendance";
		}
	}
	
	/** 로그인  */
	@RequestMapping(value = "/api_login", method = RequestMethod.POST)
	@ResponseBody
	public String MainController_api_login(HttpServletRequest request
			, @RequestParam("login_email") String login_email
			, @RequestParam("login_password") String login_password) {
		logger.info("api_login");
		
		String result = "0";

		if(login_email.length() > 50)
			return "email";
		else if(login_password.length() > 16)
			return "password";
		
		// 세션 객체 생성
		HttpSession session = request.getSession();
		List<AccountInfo> accountList = accountDao.select(login_email);

		// 이메일이 존재하지 않을 때
		if (accountList == null || accountList.isEmpty()) {
			result = "email not found"; // no email
		} 
		else {
			if (accountList.get(0).getPw().equals(login_password)) // password unequal
			{
				result = "200";
				session.setAttribute("currentmember", accountList.get(0));
			} else {
				result = "password is woung";
			}
		}
		
		return result;
	}
	
}
