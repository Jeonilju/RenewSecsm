package com.secsm.main;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.secsm.dao.*;
import com.secsm.info.*;

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
			
			return "question";	
		}
	}
	
	/** 설문 추가 */
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
			Timestamp startDate = Util.getTimestamp(questionAddStartDate);
			Timestamp endDate = Util.getTimestamp(questionAddEndDate);
			
			int questionId =questionDao.create(info.getId(), questionAddTitle, questionAddContent, startDate, endDate);
			
			
		}		
		return "200";
	}
	
	/** 설문지 조회 */
	@ResponseBody
	@RequestMapping(value = "/api_questionGet", method = RequestMethod.GET)
	public String QuestionController_getQuestion(HttpServletRequest request, HttpServletResponse response 
			, @RequestParam("id") int id) {
		logger.info("api get Question");
		
		QuestionInfo info = questionDao.selectById(id);
		Gson gson = new Gson();
		return gson.toJson(info);
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
			
		}
		else{
			// 로그인
			QuestionInfo questionInfo = questionDao.selectById(id);
			int questionId = questionInfo.getId();
			int questionAccountId = questionInfo.getAccountId();
			
			if(info.getId() == questionAccountId) {
				// 자신이 올린 설문
				answerChoiceDao.selectByQuestionId(questionId);
				answerDateDao.selectByQuestionId(questionId);
				answerEssayDao.selectByQuestionId(questionId);
				answerScoreDao.selectByQuestionId(questionId);
				answerTimeDao.selectByQuestionId(questionId);
				
				
			}
			else{
				// 다른사람이 올린 설문
				
			}
		}
		
		Gson gson = new Gson();
		return gson.toJson(info);
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
