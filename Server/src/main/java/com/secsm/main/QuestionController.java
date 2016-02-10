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
}
