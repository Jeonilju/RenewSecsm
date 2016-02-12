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

import com.secsm.info.QuestionTimeInfo;

@Repository
public class QuestionTimeDao {
	private static final Logger logger = LoggerFactory.getLogger(QuestionTimeDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int questionId, String problom){
		jdbcTemplate.update("insert into question_time (question_id, problom) values (?, ?)"
				, new Object[] {questionId, problom});
	}
	
	public List<QuestionTimeInfo> selectAll(){
		return jdbcTemplate.query("select * from question_time",
				new RowMapper<QuestionTimeInfo>() {
					public QuestionTimeInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionTimeInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getString("problom"), resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public List<QuestionTimeInfo> select(int id){
		return jdbcTemplate.query("select * from question_time where id = ?", new Object[] {id},
				new RowMapper<QuestionTimeInfo>() {
					public QuestionTimeInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionTimeInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getString("problom"), resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from question_time where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from question_time");
	}
}
