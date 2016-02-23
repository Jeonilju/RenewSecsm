package com.secsm.main;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.secsm.dao.AccountDao;
import com.secsm.info.AccountInfo;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AccountDao accountDao;
	
	@RequestMapping(value="/admin", method= RequestMethod.GET)
	public String AdminController_index(HttpServletRequest request){
		logger.info("admin Page");
		
		AccountInfo info = com.secsm.conf.Util.getLoginedUser(request);
		if(info != null){
			if(info.getGrade() == 0){
				// 권한 있음
				request.setAttribute("accountInfo", info);
				return "admin";
			}
		}
		
		return "index";
	}
}
