package com.secsm.conf;

import java.sql.Timestamp;

public class Util {

	public static Timestamp getTimestamp(String date){
		int year = Integer.parseInt(date.substring(6, 10)) - 1900;
		int month = Integer.parseInt(date.substring(0,2)) - 1;
		int day = Integer.parseInt(date.substring(3,5));
		java.util.Date mDate = new java.util.Date(year, month, day);
		Timestamp result = new Timestamp(mDate.getTime());
		

		System.out.println("year: " + year);
		System.out.println("month: " + month);
		System.out.println("day: " + day);
		

		System.out.println("변환된 시간1: " + mDate.toString());
		
		System.out.println("변환된 시간2: " + result.toString());
		
		return result;
	}
	
	public static String getTimestempStr(Timestamp time){
		if(time != null)
			return "" + (time.getYear() + 1900) + "." + (time.getMonth() + 1) + "." + time.getDate();
		else
			return "????";
	}
}
