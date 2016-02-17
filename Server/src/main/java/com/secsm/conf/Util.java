package com.secsm.conf;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.secsm.info.AccountInfo;

public class Util {

	public static Timestamp getTimestamp(String date){

		Timestamp result = null;

		try{
			int year = Integer.parseInt(date.substring(6, 10)) - 1900;
			int month = Integer.parseInt(date.substring(0,2)) - 1;
			int day = Integer.parseInt(date.substring(3,5));
			java.util.Date mDate = new java.util.Date(year, month, day);
			result = new Timestamp(mDate.getTime());
		}
		catch(Exception e){
			result = new Timestamp(System.currentTimeMillis());
		}

		return result;
	}
	
	public static String getTimestempStr(Timestamp time){
		if(time != null)
			return "" + (time.getYear() + 1900) + "." + (time.getMonth() + 1) + "." + time.getDate();
		else
			return "????";
	}
	
	public static AccountInfo getLoginedUser(HttpServletRequest request){
		HttpSession session = request.getSession();
		AccountInfo member = (AccountInfo) session.getAttribute("currentmember");
		
		return member;
	}
}
