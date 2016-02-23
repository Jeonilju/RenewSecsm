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
import com.secsm.info.AnswerDateInfo;

@Repository
public class AnswerDateDao {
	private static final Logger logger = LoggerFactory.getLogger(AnswerDateDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int accountId, int questionId, String answer){
		jdbcTemplate.update("insert into answer_date (account_id, question_id, answer) values (?, ?, ?)"
				, new Object[] {accountId, questionId, answer});
	}
	
	public List<AnswerDateInfo> selectAll(){
		return jdbcTemplate.query("select * from answer_date",
				new RowMapper<AnswerDateInfo>() {
					public AnswerDateInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerDateInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getString("answer"));
					}
				});
	}
	
	public List<AnswerDateInfo> select(int id){
		return jdbcTemplate.query("select * from answer_date where id = ?", new Object[] {id},
				new RowMapper<AnswerDateInfo>() {
					public AnswerDateInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerDateInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getString("answer"));
					}
				});
	}

	public List<AnswerDateInfo> selectByQuestionId(int question_id){
		return jdbcTemplate.query("select * from answer_date where question_id = ?", new Object[] {question_id},
				new RowMapper<AnswerDateInfo>() {
					public AnswerDateInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerDateInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getString("answer"));
					}
				});
	}
	
	public List<AnswerContentInfo> selectByQuestionIdToContent(int question_id){
		return jdbcTemplate.query("select * from answer_date, account where question_id = ? and answer_date.account_id = account.id", new Object[] {question_id},
				new RowMapper<AnswerContentInfo>() {
					public AnswerContentInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerContentInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getInt("account_id"), "" + resultSet.getString("answer"), resultSet.getString("name"));
					}
				});
	}
	
	public boolean isExistAnswer(int id, int accountId){
		List<AnswerDateInfo> result = jdbcTemplate.query("select * from answer_date where "
				+ "question_id = ?"
				+ " and account_id = ? ", new Object[] {id, accountId},
				new RowMapper<AnswerDateInfo>() {
					public AnswerDateInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerDateInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getString("answer"));
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
		jdbcTemplate.update("delete from answer_date where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from answer_date");
	}
}
