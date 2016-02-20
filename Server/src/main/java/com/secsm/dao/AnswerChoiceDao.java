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

import com.secsm.info.AnswerChoiceInfo;

@Repository
public class AnswerChoiceDao {
	private static final Logger logger = LoggerFactory.getLogger(AnswerChoiceDao.class);

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
	
	public List<AnswerChoiceInfo> selectAll(){
		return jdbcTemplate.query("select * from answer_score",
				new RowMapper<AnswerChoiceInfo>() {
					public AnswerChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerChoiceInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}
	
	public List<AnswerChoiceInfo> select(int id){
		return jdbcTemplate.query("select * from answer_score where id = ?", new Object[] {id},
				new RowMapper<AnswerChoiceInfo>() {
					public AnswerChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerChoiceInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}
	
	public List<AnswerChoiceInfo> selectByQuestionId(int question_id){
		return jdbcTemplate.query("select * from answer_score where question_id = ?", new Object[] {question_id},
				new RowMapper<AnswerChoiceInfo>() {
					public AnswerChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerChoiceInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getInt("question_id"), resultSet.getInt("answer"));
					}
				});
	}

	public boolean isExistAnswer(int id, int accountId){
		List<AnswerChoiceInfo> result = jdbcTemplate.query("select * from answer_score where "
				+ "question_id = ?"
				+ " and account_id = ? ", new Object[] {id, accountId},
				new RowMapper<AnswerChoiceInfo>() {
					public AnswerChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AnswerChoiceInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
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
