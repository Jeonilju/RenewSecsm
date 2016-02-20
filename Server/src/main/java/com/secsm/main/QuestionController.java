package com.secsm.main;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.secsm.conf.Util;
import com.secsm.dao.AnswerChoiceDao;
import com.secsm.dao.AnswerDateDao;
import com.secsm.dao.AnswerEssayDao;
import com.secsm.dao.AnswerScoreDao;
import com.secsm.dao.AnswerTimeDao;
import com.secsm.dao.QuestionChoiceDao;
import com.secsm.dao.QuestionDao;
import com.secsm.dao.QuestionDateDao;
import com.secsm.dao.QuestionEssayDao;
import com.secsm.dao.QuestionScoreDao;
import com.secsm.dao.QuestionTimeDao;
import com.secsm.info.AccountInfo;
import com.secsm.info.AnswerInfo;
import com.secsm.info.QuestionChoiceInfo;
import com.secsm.info.QuestionContentInfo;
import com.secsm.info.QuestionDateInfo;
import com.secsm.info.QuestionEssayInfo;
import com.secsm.info.QuestionInfo;
import com.secsm.info.QuestionScoreInfo;
import com.secsm.info.QuestionTimeInfo;

@Controller
public class QuestionController {
	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);

	@Autowired
	private QuestionDao questionDao;
	
	@Autowired
	private QuestionChoiceDao questionChoiceDao;
	
	@Autowired
	private QuestionDateDao questionDateDao;
	
	@Autowired
	private QuestionEssayDao questionEssayDao;
	
	@Autowired
	private QuestionScoreDao questionScoreDao;
		
	@Autowired
	private QuestionTimeDao questionTimeDao;
	
	@Autowired
	private AnswerChoiceDao answerChoiceDao;
	
	@Autowired
	private AnswerDateDao answerDateDao;
	
	@Autowired
	private AnswerEssayDao answerEssayDao;
	
	@Autowired
	private AnswerScoreDao answerScoreDao;
	
	@Autowired
	private AnswerTimeDao answerTimeDao;
	
	@RequestMapping(value = "/question", method = RequestMethod.GET)
	public String QuestionController_index(HttpServletRequest request) {
		logger.info("question Page");

		AccountInfo info = Util.getLoginedUser(request);
		if(info == null){
			// 비로그인
			return "index";
		}
		else{
			// 로그인
			List<QuestionInfo> questionList = questionDao.selectAll();
			request.setAttribute("questionList", questionList);
			request.setAttribute("accountInfo", info);
			return "question";	
		}
	}
	
	@RequestMapping(value = "/questionResult/{id}", method = RequestMethod.GET)
	public String QuestionController_result(HttpServletRequest request
			, @PathVariable("id")int questionId) {
		logger.info("questionResult Page");

		AccountInfo info = Util.getLoginedUser(request);
		QuestionInfo questionInfo = questionDao.selectById(questionId);
		
		if(info == null){
			// 비로그인
			return "index";
		}
		else{
			if(questionInfo == null){
				// TODO 등록된 프로젝트가 없음
				return "";
			}
			else if (info.getId() == questionInfo.getAccountId()){
				// 정상 접근
				List<QuestionChoiceInfo> choiceList = questionChoiceDao.selectByQuestionId(questionInfo.getId());
				List<QuestionEssayInfo> essayList = questionEssayDao.selectByQuestionId(questionInfo.getId());
				List<QuestionDateInfo> dateList = questionDateDao.selectByQuestionId(questionInfo.getId());
				List<QuestionTimeInfo> timeList = questionTimeDao.selectByQuestionId(questionInfo.getId());
				List<QuestionScoreInfo> scoreList = questionScoreDao.selectByQuestionId(questionInfo.getId());
				setAnswerList(choiceList, essayList, dateList, timeList, scoreList);
				
				request.setAttribute("questionInfo", questionInfo);
				request.setAttribute("choiceList", choiceList);
				request.setAttribute("essayList", essayList);
				request.setAttribute("dateList", dateList);
				request.setAttribute("timeList", timeList);
				request.setAttribute("scoreList", scoreList);
				
				return "questionResult";
			}
			else{
				// 비정상 접근 
				return "";
			}
		}

	}
	
	private void setAnswerList(
			List<QuestionChoiceInfo> choiceList
			, List<QuestionEssayInfo> essayList
			, List<QuestionDateInfo> dateList
			, List<QuestionTimeInfo> timeList
			, List<QuestionScoreInfo> scoreList){
		
			for(QuestionChoiceInfo info : choiceList){
				info.setAnswerList(answerChoiceDao.selectByQuestionId(info.getId()));
			}
			
			for(QuestionEssayInfo info : essayList){
				info.setAnswerList(answerEssayDao.selectByQuestionId(info.getId()));
			}
			
			for(QuestionDateInfo info : dateList){
				info.setAnswerList(answerDateDao.selectByQuestionId(info.getId()));
			}
			
			for(QuestionTimeInfo info : timeList){
				info.setAnswerList(answerTimeDao.selectByQuestionId(info.getId()));
			}
			
			for(QuestionScoreInfo info : scoreList){
				info.setAnswerList(answerScoreDao.selectByQuestionId(info.getId()));
			}
	}
	
	/** 설문 생성 */
	@ResponseBody
	@RequestMapping(value = "/api_questionAdd", method = RequestMethod.POST)
	public String QuestionController_addQuestion(HttpServletRequest request, HttpServletResponse response 
			, @RequestParam("questionAddTitle") String questionAddTitle
			, @RequestParam("questionAddContent") String questionAddContent
			, @RequestParam("questionAddStartDate") String questionAddStartDate
			, @RequestParam("questionAddEndDate") String questionAddEndDate
			, @RequestParam("questionAddQuestions") String questionAddQuestions) {
		logger.info("api add Question");
		
		AccountInfo info = Util.getLoginedUser(request);
		if(info  == null){
			response.setStatus(401);
			return "권한없음";
		}
		else{
			Timestamp startDate = Util.getTimestamp(questionAddStartDate, true);
			Timestamp endDate = Util.getTimestamp(questionAddEndDate, false);
			ArrayList<QuestionContentInfo> questionContentList = new ArrayList<QuestionContentInfo>();
			try {

	    	    Object obj = JSONValue.parseWithException(questionAddQuestions);
	    	    JSONArray array = (JSONArray)obj;
	    	    JSONObject jobj = null;

	    	    Gson gson = new Gson();

	    	    for(int i=0;i<array.size();i++) {
	    	    	jobj = (JSONObject)array.get(i);
	    	    	questionContentList.add(gson.fromJson(jobj.toString(), QuestionContentInfo.class));
	    	    }
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
			
			int questionId =questionDao.create(info.getId(), questionAddTitle, questionAddContent, startDate, endDate);
			createQuestionContents(questionContentList, questionId);
		}		
		return "200";
	}
	
	/** 설문지 항목 생성 */
	private void createQuestionContents(ArrayList<QuestionContentInfo> questionContentList, int questionId){
		
		logger.debug("설문지 ID: " + questionId);
		
		for(QuestionContentInfo info : questionContentList){
			switch (info.qType) {
			case 0:
				// 객관식
				logger.debug("객관식 생성: " + info.qTitle);
				questionChoiceDao.create(questionId, info.qTitle, info.q1, info.q2, info.q3, info.q4, info.q5);
				break;
			case 1:
				// 주관식
				logger.debug("주관식 생성: " + info.qTitle);
				questionEssayDao.create(questionId, info.qTitle);
				break;
			case 2:
				// 날짜
				logger.debug("날짜 생성: " + info.qTitle);
				questionDateDao.create(questionId, info.qTitle);
				break;
			case 3:
				// 시간
				logger.debug("시간 생성: " + info.qTitle);
				questionTimeDao.create(questionId, info.qTitle);
				break;
			case 4:
				// 점수
				logger.debug("점수 생성: " + info.qTitle);
				questionScoreDao.create(questionId, info.qTitle);
				break;
			default:
				break;
			}
		}
	}
	
	/** 설문지 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGet", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String QuestionController_getQuestion(HttpServletRequest request, HttpServletResponse response 
			, @RequestParam("id") int id) {
		logger.info("api get Question (설문지 조회)");
		
		QuestionInfo info = questionDao.selectById(id);
		ArrayList<QuestionContentInfo> totalQuestionList = new ArrayList<QuestionContentInfo>();
		List<QuestionChoiceInfo> choiceList = questionChoiceDao.selectByQuestionId(info.getId());
		List<QuestionEssayInfo> essayList = questionEssayDao.selectByQuestionId(info.getId());
		List<QuestionDateInfo> dateList = questionDateDao.selectByQuestionId(info.getId());
		List<QuestionTimeInfo> timeList = questionTimeDao.selectByQuestionId(info.getId());
		List<QuestionScoreInfo> scoreList = questionScoreDao.selectByQuestionId(info.getId());

		logger.debug("객관식수: " + choiceList.size());
		logger.debug("주관식수: " + essayList.size());
		logger.debug("날짜수: " + dateList.size());
		logger.debug("시간수: " + timeList.size());
		logger.debug("점수수: " + scoreList.size());
		
		for(QuestionChoiceInfo qInfo : choiceList){
			QuestionContentInfo newQuestion = new QuestionContentInfo();
			newQuestion.id = qInfo.getId();
			newQuestion.qType = 0;
			newQuestion.qTitle = qInfo.getProblom();
			newQuestion.q1 = qInfo.getP1();
			newQuestion.q2 = qInfo.getP2();
			newQuestion.q3 = qInfo.getP3();
			newQuestion.q4 = qInfo.getP4();
			newQuestion.q5 = qInfo.getP5();
			
			totalQuestionList.add(newQuestion);
		}

		for(QuestionEssayInfo qInfo : essayList){
			QuestionContentInfo newQuestion = new QuestionContentInfo();
			newQuestion.id = qInfo.getId();
			newQuestion.qType = 1;
			newQuestion.qTitle = qInfo.getProblom();
			totalQuestionList.add(newQuestion);
		}

		for(QuestionDateInfo qInfo : dateList){
			QuestionContentInfo newQuestion = new QuestionContentInfo();
			newQuestion.id = qInfo.getId();
			newQuestion.qType = 2;
			newQuestion.qTitle = qInfo.getProblom();
			totalQuestionList.add(newQuestion);
		}
		
		for(QuestionTimeInfo qInfo : timeList){
			QuestionContentInfo newQuestion = new QuestionContentInfo();
			newQuestion.id = qInfo.getId();
			newQuestion.qType = 3;
			newQuestion.qTitle = qInfo.getProblom();
			totalQuestionList.add(newQuestion);
		}

		for(QuestionScoreInfo qInfo : scoreList){
			QuestionContentInfo newQuestion = new QuestionContentInfo();
			newQuestion.id = qInfo.getId();
			newQuestion.qType = 4;
			newQuestion.qTitle = qInfo.getProblom();
			totalQuestionList.add(newQuestion);
		}
		Collections.sort(totalQuestionList);
		
		QuestionContentInfo newQuestion = new QuestionContentInfo();
		newQuestion.qTitle = info.getTitle();
		newQuestion.qContent = info.getContent();
		totalQuestionList.add(0, newQuestion);
		
		Gson gson = new Gson();
		String result = gson.toJson(totalQuestionList);
//		logger.info(result);
//		try {
//			URLEncoder.encode(result , "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
		return result;
	}
	
	/** 설문지 결과 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_questionResult", method = RequestMethod.GET)
	public String QuestionController_resultQuestion(HttpServletRequest request, HttpServletResponse response 
			, @RequestParam("id") int id) {
		logger.info("api result Question");
		
		AccountInfo info = Util.getLoginedUser(request);
		
		if(info == null){
			// 비로그인
			return "401";
		}
		else{
			// 로그인
			QuestionInfo questionInfo = questionDao.selectById(id);
			int questionId = questionInfo.getId();
			int questionAccountId = questionInfo.getAccountId();
			
			if(info.getId() == questionAccountId) {
				// 자신이 올린 설문
				return "200";
			}
			else{
				// 다른사람이 올린 설문
				return "403";
			}
		}
	}
	
	/**설문 응답 */
	@ResponseBody
	@RequestMapping(value = "/api_questionRespons", method = RequestMethod.POST)
	public String QuestionController_responsQuestion(HttpServletRequest request, HttpServletResponse response
			, @RequestParam("id") int id
			, @RequestParam("questionResQuestions") String questionResQuestions) {
		logger.info("api_questionRespons");
		String result = "";
		
		AccountInfo accountInfo = Util.getLoginedUser(request);
		if(accountInfo == null){
			return "401";
		}
		
		try {
			ArrayList<AnswerInfo> answerContentList = new ArrayList<AnswerInfo>();
			Object obj = JSONValue.parseWithException(questionResQuestions);
			JSONArray array = (JSONArray)obj;
		    JSONObject jobj = null;

		    Gson gson = new Gson();

		    for(int i=0;i<array.size();i++) {
		    	jobj = (JSONObject)array.get(i);
		    	answerContentList.add(gson.fromJson(jobj.toString(), AnswerInfo.class));
		    }
		    
		    return responseQuestions(answerContentList, id, accountInfo.getId());
		    
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
		return result;
	}
	
	private String responseQuestions(ArrayList<AnswerInfo> answerContentList, int questionId, int accountId){
		QuestionInfo info = questionDao.selectByIdNTimestamp(questionId, new Timestamp(System.currentTimeMillis()));
		
		if(info == null)
			return "408";
		
		List<QuestionChoiceInfo> choiceList = questionChoiceDao.selectByQuestionId(info.getId());
		List<QuestionEssayInfo> essayList = questionEssayDao.selectByQuestionId(info.getId());
		List<QuestionDateInfo> dateList = questionDateDao.selectByQuestionId(info.getId());
		List<QuestionTimeInfo> timeList = questionTimeDao.selectByQuestionId(info.getId());
		List<QuestionScoreInfo> scoreList = questionScoreDao.selectByQuestionId(info.getId());
		
		for(AnswerInfo answerInfo : answerContentList){
			if(answerInfo.qType.equals("0")){
				// 객관식
				for (QuestionChoiceInfo qInfo : choiceList) {
					if(answerInfo.qId.equals("" + qInfo.getId())){
						if(answerChoiceDao.isExistAnswer(qInfo.getId(), accountId)){
							// 이미 답한경우
							logger.info("이미 설문에 참여한 유저");
						}
						else{
							logger.info("답변 완료(객관식): " + qInfo.getId());
							answerChoiceDao.create(accountId, qInfo.getId(), Integer.parseInt(answerInfo.qanswer));
						}
						break;
					}
				}
			}
			else if(answerInfo.qType.equals("1")){
				// 주관식
				for (QuestionEssayInfo qInfo : essayList) {
					if(answerInfo.qId.equals("" + qInfo.getId())){
						if(answerEssayDao.isExistAnswer(qInfo.getId(), accountId)){
							// 이미 답한경우
							logger.info("이미 설문에 참여한 유저");
						}
						else{
							logger.info("답변 완료(주관식): " + qInfo.getId());
							answerEssayDao.create(accountId, qInfo.getId(), answerInfo.qanswer);
						}
						break;
					}
				}
			}
			else if(answerInfo.qType.equals("2")){
				// 날짜
				for (QuestionDateInfo qInfo : dateList) {
					if(answerInfo.qId.equals("" + qInfo.getId())){
						if(answerDateDao.isExistAnswer(qInfo.getId(), accountId)){
							// 이미 답한경우
							logger.info("이미 설문에 참여한 유저");
						}
						else{
							logger.info("답변 완료(날짜): " + qInfo.getId());
							answerDateDao.create(accountId, qInfo.getId(), answerInfo.qanswer);
						}
						break;
					}
				}
			}
			else if(answerInfo.qType.equals("3")){
				// 시간
				for (QuestionTimeInfo qInfo : timeList) {
					if(answerInfo.qId.equals("" + qInfo.getId())){
						if(answerTimeDao.isExistAnswer(qInfo.getId(), accountId)){
							// 이미 답한경우
							logger.info("이미 설문에 참여한 유저");
						}
						else{
							logger.info("답변 완료(시간): " + qInfo.getId());
							answerTimeDao.create(accountId, qInfo.getId(), answerInfo.qanswer);
						}
						break;
					}
				}
			}
			else if(answerInfo.qType.equals("4")){
				// 점수
				for (QuestionScoreInfo qInfo : scoreList) {
					if(answerInfo.qId.equals("" + qInfo.getId())){
						if(answerScoreDao.isExistAnswer(qInfo.getId(), accountId)){
							// 이미 답한경우
							logger.info("이미 설문에 참여한 유저");
						}
						else{
							logger.info("답변 완료(점수): " + qInfo.getId());
							answerScoreDao.create(accountId, qInfo.getId(), Integer.parseInt(answerInfo.qanswer));
						}
						break;
					}
				}
			}
		}
		
		return "200";
	}
	
	/**객관식 양식 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGetChoice", method = RequestMethod.GET)
	public String QuestionController_questionGetChoice(HttpServletRequest request, HttpServletResponse response) {
		logger.info("api questionGetChoice");
		String result = "";
		
		return result;
	}
	
	/** 주관식 양식 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGetEssay", method = RequestMethod.GET)
	public String QuestionController_questionGetEssay(HttpServletRequest request, HttpServletResponse response) {
		logger.info("api questionGetEssay");
		String result = "";
		
		return result;
	}
	
	/** 점수 양식 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGetScore", method = RequestMethod.GET)
	public String QuestionController_questionGetScore(HttpServletRequest request, HttpServletResponse response) {
		logger.info("api questionGetScore");
		String result = "";
		
		return result;
	}
	
	/** 시간 양식 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGetTime", method = RequestMethod.GET)
	public String QuestionController_questionGetTime(HttpServletRequest request, HttpServletResponse response) {
		logger.info("api questionGetTime");
		String result = "";
		
		return result;
	}
	
	/**날짜 양식 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGetDate", method = RequestMethod.GET)
	public String QuestionController_questionGetDate(HttpServletRequest request, HttpServletResponse response) {
		logger.info("api questionGetDate");
		String result = "";
		
		return result;
	}
	
}
