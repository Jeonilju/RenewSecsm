package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.secsm.info.AnswerContentInfo;
import com.secsm.info.AnswerScoreInfo;

@Repository
public class AnswerScoreDao {
	private static final Logger logger = LoggerFactory.getLogger(AnswerScoreDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int accountId, int questionId, int answer){
		jdbcTemplate.update("insert into answer_score (account_id, question_id, answer) values (?, ?, ?)"
				, new Object[] {accountId, questionId, answer});
	}
	
	public List<AnswerScoreInfo> selectAll(){
		return jdbcTemplate.query("select * from answer_score",
				new RowMapper<AnswerScoreInfo>() {
					public AnswerScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerScoreInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}
	
	public List<AnswerScoreInfo> select(int id){
		return jdbcTemplate.query("select * from answer_score where id = ?", new Object[] {id},
				new RowMapper<AnswerScoreInfo>() {
					public AnswerScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerScoreInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}

	public List<AnswerScoreInfo> selectByQuestionId(int question_id){
		return jdbcTemplate.query("select * from answer_score where question_id = ?", new Object[] {question_id},
				new RowMapper<AnswerScoreInfo>() {
					public AnswerScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerScoreInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}
	
	public List<AnswerContentInfo> selectByQuestionIdToContent(int question_id){
		return jdbcTemplate.query("select * from answer_score, account where question_id = ? and answer_score.account_id = account.id", new Object[] {question_id},
				new RowMapper<AnswerContentInfo>() {
					public AnswerContentInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerContentInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getInt("account_id"), "" + resultSet.getInt("answer"), resultSet.getString("name"));
					}
				});
	}

	public boolean isExistAnswer(int id, int accountId){
		List<AnswerScoreInfo> result = jdbcTemplate.query("select * from answer_score where "
				+ "question_id = ?"
				+ " and account_id = ? ", new Object[] {id, accountId},
				new RowMapper<AnswerScoreInfo>() {
					public AnswerScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerScoreInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
		
		if(result.size() > 0){
			return true;			
		}
		else{
			return false;
		}
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from answer_score where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from answer_score");
	}
}
