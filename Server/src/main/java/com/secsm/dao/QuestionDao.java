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
				+ "accountId = '" + accountId + " and " 
				+ "title = '" + title + " and " 
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
								, resultSet.getTimestamp("endDate"));
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
								, resultSet.getTimestamp("endDate"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from question where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from question");
	}
}
