package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.secsm.info.ProjectInfo;
import com.secsm.info.QuestionInfo;

@Repository
public class QuestionDao {
	private static final Logger logger = LoggerFactory.getLogger(QuestionDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public int create(int accountId, String title, String content, Timestamp startDate, Timestamp endDate){
		jdbcTemplate.update("insert into question (accountId, title, content, startDate, endDate) values (?, ?, ?, ?, ?)"
				, new Object[] {accountId, title, content, startDate, endDate});
		
		int questionId = jdbcTemplate.queryForInt("select id from question where "
				+ "accountId = " + accountId + " and " 
				+ "title = '" + title + "' and " 
				+ "content = '" + content + "';");
		
		return questionId;
	}

	public int create(int accountId, String title, String content, Timestamp startDate, Timestamp endDate, String code){
		jdbcTemplate.update("insert into question (accountId, title, content, startDate, endDate, code) values (?, ?, ?, ?, ?, ?)"
				, new Object[] {accountId, title, content, startDate, endDate, code});
		
		int questionId = jdbcTemplate.queryForInt("select id from question where "
				+ "accountId = " + accountId + " and " 
				+ "title = '" + title + "' and " 
				+ "content = '" + content + "';");
		
		return questionId;
	}

	
	public List<QuestionInfo> selectAll(){
		return jdbcTemplate.query("select * from question",
				new RowMapper<QuestionInfo>() {
					public QuestionInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
								, resultSet.getString("title"), resultSet.getString("content")
								, resultSet.getTimestamp("regDate"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getString("code"));
					}
				});
	}
	
	public List<QuestionInfo> selectByPage(int page, int count){
		return jdbcTemplate.query("select * from question, account where question.accountID = account.id order by question.id desc limit ?, ?", new Object[] { page, count },
				new RowMapper<QuestionInfo>() {
					public QuestionInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionInfo(resultSet.getInt("question.id"), resultSet.getInt("question.accountId")
								, resultSet.getString("question.title"), resultSet.getString("question.content")
								, resultSet.getTimestamp("question.regDate"), resultSet.getTimestamp("question.startDate")
								, resultSet.getTimestamp("question.endDate"), resultSet.getString("question.code")
								, resultSet.getString("account.name"));
					}
				});
	}
	
	public List<QuestionInfo> select(int id){
		return jdbcTemplate.query("select * from question where id = ?", new Object[] {id},
				new RowMapper<QuestionInfo>() {
					public QuestionInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
								, resultSet.getString("title"), resultSet.getString("content")
								, resultSet.getTimestamp("regDate"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getString("code"));
					}
				});
	}
	
	public QuestionInfo selectById(int id){
		
		List<QuestionInfo> result = jdbcTemplate.query("select * from question where id = ?", new Object[] {id},
				new RowMapper<QuestionInfo>() {
			public QuestionInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
				return new QuestionInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
						, resultSet.getString("title"), resultSet.getString("content")
						, resultSet.getTimestamp("regDate"), resultSet.getTimestamp("startDate")
						, resultSet.getTimestamp("endDate"), resultSet.getString("code"));
			}
		});
		
		if(result.size() == 1){
			return result.get(0);
		}
		else if(result.size() > 1){
			// 1개 이상의 중복된 id를 같는 question 존재
			logger.error("중복된 id 존재");
			return result.get(0);
		}
		else{
			// 해당하는 id를 갖는 question 없음
			return null;
		}
	}
	
	/** 해당 ID에 Start - End 사이에 있는 설문을 반환 */
	public QuestionInfo selectByIdNTimestamp(int id, Timestamp currentTimestamp){
		
		List<QuestionInfo> result = jdbcTemplate.query("select * from question where id = ?"
				+ " and startDate < ?"
				+ " and endDate > ?", new Object[] {id, currentTimestamp, currentTimestamp},
				new RowMapper<QuestionInfo>() {
			public QuestionInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
				return new QuestionInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
						, resultSet.getString("title"), resultSet.getString("content")
						, resultSet.getTimestamp("regDate"), resultSet.getTimestamp("startDate")
						, resultSet.getTimestamp("endDate"), resultSet.getString("code"));
			}
		});
		
		if(result.size() == 1){
			return result.get(0);
		}
		else if(result.size() > 1){
			// 1개 이상의 중복된 id를 같는 question 존재
			logger.error("중복된 id 존재");
			return result.get(0);
		}
		else{
			// 해당하는 id를 갖는 question 없음
			return null;
		}
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from question where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from question");
	}
}
