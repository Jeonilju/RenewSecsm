package com.secsm.main;

import java.sql.Timestamp;
import java.util.Calendar;
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

import com.secsm.conf.Util;
import com.secsm.dao.AccountDao;
import com.secsm.dao.AttendanceDao;
import com.secsm.dao.DutyDao;
import com.secsm.info.AccountInfo;
import com.secsm.info.AttendanceInfo;
import com.secsm.info.DutyInfo;


@Controller
public class LivingController {
	private static final Logger logger = LoggerFactory.getLogger(LivingController.class);
	
	@Autowired
	private AccountDao accountDao;

	@Autowired
	private AttendanceDao attendanceDao;
	
	@Autowired
	private DutyDao dutyDao;	
	
	@RequestMapping(value = "/attendance", method = RequestMethod.GET)
	public String MainController_attendance_index(HttpServletRequest request){
		logger.info("attendance Page");
		AccountInfo info = Util.getLoginedUser(request);
		
		//비로그인시 메인페이지로
		if(info == null){
			return "index";
		}
		
		//start, end Date 지정
		Date current = new Date();
		int currentMonth = current.getMonth();
		int pastMonth = currentMonth-3>=0 ? currentMonth-3 : currentMonth+9;
		int pastYear = currentMonth-3>=0 ? current.getYear() : current.getYear()-1;
		Date past = new Date(pastYear,pastMonth,1);
		Timestamp start = new Timestamp(past.getTime());
		Timestamp end = new Timestamp(current.getTime());
		
		List<AttendanceInfo> attendanceList = attendanceDao.selectTime(info.getId(),start,end);
		
		//출석률 계산
		int[] attendanceRate={0,0,0,0,0,0,0,0,0,0,0,0};
		for (AttendanceInfo list : attendanceList) {
			attendanceRate[list.getRegDate().getMonth()]++;
		}
		Date exceptionDate = new Date(); 
		exceptionDate.setMonth(2);
		exceptionDate.setDate(0);
		int exceptionMonth = exceptionDate.getDate();
		int[] maxDate = {31,exceptionMonth,31,30,31,30,31,31,30,31,30,31};
		for(int i=0; i<12; i++){
			if(i==current.getMonth()) attendanceRate[i]=(int)((double)attendanceRate[i]*100/current.getDate());
			else attendanceRate[i]=(int)((double)attendanceRate[i]*100/maxDate[i]);
		}
		
		request.setAttribute("AttendanceInfo", attendanceList);
	    request.setAttribute("AttendanceRate", attendanceRate);
		request.setAttribute("accountInfo", info);

		return "attendance";
	}
	
	@RequestMapping(value = "/duty", method = RequestMethod.GET)
	public String MainController_duty_index(HttpServletRequest request) {
		logger.info("duty Page");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		//비로그인시 메인페이지로
		if(info == null){
			return "index";
		}
		
		//start, end Date 지정
		Date current = new Date();
		int currentMonth = current.getMonth();
		int pastMonth = currentMonth-1>=0 ? currentMonth-1 : currentMonth+11;
		int pastYear = currentMonth-1>=0 ? current.getYear() : current.getYear()-1;
		int futureMonth = currentMonth+2<12 ? currentMonth+2 : currentMonth-10;
		int futureYear = currentMonth+2<12 ? current.getYear() : current.getYear()+1;
		Date past = new Date(pastYear,pastMonth,1);
		Date future = new Date(futureYear,futureMonth,1);
		Timestamp start = new Timestamp(past.getTime());
		Timestamp end = new Timestamp(future.getTime());
		
		List<DutyInfo> dutyList = dutyDao.selectTimeName(start,end);
		
		request.setAttribute("DutyInfo", dutyList);
		request.setAttribute("accountInfo", info);
		
		return "duty";
	}

	
/////////////////////////////////////////////////////////////////////////
//////////////////////								/////////////////////
//////////////////////			Duty APIs			/////////////////////
//////////////////////								/////////////////////
/////////////////////////////////////////////////////////////////////////

	
	@ResponseBody
	@RequestMapping(value = "/dutyInsert", method = RequestMethod.POST)
	public String duty_insert(HttpServletRequest request,
			@RequestParam("title") String title,
			@RequestParam("date") long date) {
		logger.info("dutyInsert");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		if(info == null){
			return "4";
		}
		
		Timestamp timeDate = new Timestamp(date);
		Timestamp start = new Timestamp(timeDate.getYear(),timeDate.getMonth(),timeDate.getDate(),0,0,0,0);
		Timestamp end = new Timestamp(timeDate.getYear(),timeDate.getMonth(),timeDate.getDate()+1,0,0,0,0);
		
		List<AccountInfo> accountList = accountDao.selectDuty(title);
		if(accountList.size() < 1){
			
			return "1";
		}
		
		List<DutyInfo> dutyList = dutyDao.selectTimeId(start,end);
		if(dutyList.size() >= 1) {
			if(dutyList.get(0).getAccountId1() == 0){
				dutyDao.insertAccount1(accountList.get(0).getId(), dutyList.get(0).getId());
				return "0";
			}
			else if(dutyList.get(0).getAccountId2() == 0) {
				dutyDao.insertAccount2(accountList.get(0).getId(), dutyList.get(0).getId());
				return "0";
			}
			else if(dutyList.get(0).getAccountId3() == 0) {
				dutyDao.insertAccount3(accountList.get(0).getId(), dutyList.get(0).getId());
				return "0";
			}
		}
		else if(dutyList.size() == 0){
			if(info.getGrade()==0 || info.getGrade()==3){
				dutyDao.create1(start, accountList.get(0).getId());
				return "0";
			}
			else return "2";
		}
		
		return "3";

	}
	
	@ResponseBody
	@RequestMapping(value = "/dutyDelete", method = RequestMethod.POST)
	public String duty_Delete(HttpServletRequest request,
			@RequestParam("title") String title,
			@RequestParam("date") long date) {
		logger.info("dutyDelete");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "3";
		}
		
		Timestamp timeDate = new Timestamp(date);
		Timestamp start = new Timestamp(timeDate.getYear(),timeDate.getMonth(),timeDate.getDate(),0,0,0,0);
		Timestamp end = new Timestamp(timeDate.getYear(),timeDate.getMonth(),timeDate.getDate()+1,0,0,0,0);
		
		List<AccountInfo> accountList = accountDao.selectDuty(title);
		if(accountList.size() < 1) return "1";
		List<DutyInfo> dutyList = dutyDao.selectTimeAndId(accountList.get(0).getId(),start,end);
		
		if(dutyList.size() >= 1) {
			if(dutyList.get(0).getAccountId3() == accountList.get(0).getId()){
				dutyDao.deleteAccount3(dutyList.get(0).getId());
				return "0";
			}
			else if(dutyList.get(0).getAccountId2() == accountList.get(0).getId()) {
				dutyDao.deleteAccount2(dutyList.get(0).getId());
				return "0";
			}
			else if(dutyList.get(0).getAccountId1() == accountList.get(0).getId()) {
				dutyDao.deleteAccount1(dutyList.get(0).getId());
				return "0";
			}
		}
		
		return "2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/dutyAutoCreate", method = RequestMethod.POST)
	public String dutyAuto_Create(HttpServletRequest request,
			@RequestParam("weekdayStart") String weekdayStart,
			@RequestParam("weekendStart") String weekendStart,
			@RequestParam("dutyDate") String dutyDate,
			@RequestParam("weekdayCount") String weekdayCount,
			@RequestParam("weekendCount") String weekendCount,
			@RequestParam("exceptionDay") String exceptionDay,
			@RequestParam("exceptionPerson") String exceptionPerson
			) {
		logger.info("dutyAutoCreate");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			return "5";
		}
		
	    String[] exceptionPersonArray = exceptionPerson.split("/");
	    String[] exceptionDayArray = exceptionDay.split("/");
	    System.out.println(exceptionPersonArray.length);
	    String query="";
	    for(String person:exceptionPersonArray){
	    	query = query + " name !='" + person + "' AND";
	    }
		query = query + " gender=1";
		System.out.println(query);
		
		List<AccountInfo> accountList = null;
		try{
			accountList = accountDao.selectAllException(query);
		}
		catch(Exception e){
			System.out.println(e);
			return "4";
		}
		
		String[] member = new String[accountList.size()];
		int weekdayIndex=-1, weekendIndex=-1;
		for(int i=0;i<accountList.size();i++){
			System.out.println(accountList.get(i).getName());
			if(weekdayStart.equals(accountList.get(i).getName())) weekdayIndex = i;
			if(weekendStart.equals(accountList.get(i).getName())) weekendIndex = i;
		}
		
		if(weekdayIndex==-1) return "1";
		if(weekendIndex==-1) return "2";
		
		Date exceptionDate = new Date(); 
		exceptionDate.setMonth(2);
		exceptionDate.setDate(0);
		int exceptionMonth = exceptionDate.getDate();
		int[] maxDate = {31,exceptionMonth,31,30,31,30,31,31,30,31,30,31};
		
		Calendar dutyMonth = Calendar.getInstance();
		Date current = new Date();
		if(dutyDate.equals("0")){
			current.setMonth(current.getMonth()+1);
		}
		current = new Date(current.getYear(),current.getMonth(),1);
		dutyMonth.setTime(current);
		Timestamp start = new Timestamp(current.getTime());
		Timestamp end = new Timestamp(current.getTime());
		end.setMonth(end.getMonth()+1);
		
		for(int i=0;i<exceptionDayArray.length;i++){
			int exception = 0;
			try{
				exception = Integer.parseInt(exceptionDayArray[i]);
			}catch(NumberFormatException e){
				System.out.println(e);
				if(i==0 && exceptionDayArray[0].equals(""));
				else return "3";
			}
		}
		
		dutyDao.deleteDate(start, end);
		Date dateForCreate = new Date(current.getTime());
		for(int i=0;i<maxDate[current.getMonth()];i++){
			int j;
			for(j=0;j<exceptionDayArray.length;j++){
				if(j==0 && exceptionDayArray[0].equals("")) continue;
				if(Integer.parseInt(exceptionDayArray[j])==dateForCreate.getDate()) break;
			}
			if(exceptionDayArray.length!=j){
				dateForCreate.setDate(dateForCreate.getDate()+1);
				dutyMonth.setTime(dateForCreate);
				continue;
			}
			
			if(dutyMonth.get(Calendar.DAY_OF_WEEK)==1 || dutyMonth.get(Calendar.DAY_OF_WEEK)==7){
				if(weekendCount.equals("1")){
					dutyDao.create1(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekendIndex++%accountList.size()).getId());
				}
				else if(weekendCount.equals("2")){
					dutyDao.create2(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekendIndex++%accountList.size()).getId(),
							accountList.get(weekendIndex++%accountList.size()).getId());
				}
				else{
					dutyDao.create3(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekendIndex++%accountList.size()).getId(),
							accountList.get(weekendIndex++%accountList.size()).getId(),
							accountList.get(weekendIndex++%accountList.size()).getId());
				}
			}
			
			else{
				if(weekdayCount.equals("1")){
					dutyDao.create1(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekdayIndex++%accountList.size()).getId());
				}
				else if(weekdayCount.equals("2")){
					dutyDao.create2(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekdayIndex++%accountList.size()).getId(),
							accountList.get(weekdayIndex++%accountList.size()).getId());
				}
				else{
					dutyDao.create3(new Timestamp(dateForCreate.getTime()),
							accountList.get(weekdayIndex++%accountList.size()).getId(),
							accountList.get(weekdayIndex++%accountList.size()).getId(),
							accountList.get(weekdayIndex++%accountList.size()).getId());
				}
			}
			
			dateForCreate.setDate(dateForCreate.getDate()+1);
			dutyMonth.setTime(dateForCreate);
		}
		
		return "0";
	}
}
