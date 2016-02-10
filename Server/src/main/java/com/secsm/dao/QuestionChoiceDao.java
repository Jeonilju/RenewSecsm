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

import com.secsm.info.QuestionChoiceInfo;

@Repository
public class QuestionChoiceDao {
	private static final Logger logger = LoggerFactory.getLogger(QuestionChoiceDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int questionId, String problom, String p1, String p2, String p3, String p4, String p5){
		jdbcTemplate.update("insert into question_choice (question_id, problom, p1, p2, p3, p4, p5) values (?, ?, ?, ?, ?, ?, ?)"
				, new Object[] {questionId, problom, p1, p2, p3, p4, p5});
	}
	
	public List<QuestionChoiceInfo> selectAll(){
		return jdbcTemplate.query("select * from question_choice",
				new RowMapper<QuestionChoiceInfo>() {
					public QuestionChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionChoiceInfo(resultSet.getInt("id") , resultSet.getInt("question_id")
								, resultSet.getString("problom"), resultSet.getString("content")
								, resultSet.getString("regDate"), resultSet.getString("startDate")
								, resultSet.getString("endDate"), resultSet.getString("endDate"));
					}
				});
	}
	
	public List<QuestionChoiceInfo> select(int id){
		return jdbcTemplate.query("select * from question_choice where id = ?", new Object[] {id},
				new RowMapper<QuestionChoiceInfo>() {
					public QuestionChoiceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionChoiceInfo(resultSet.getInt("id") , resultSet.getInt("question_id")
								, resultSet.getString("problom"), resultSet.getString("content")
								, resultSet.getString("regDate"), resultSet.getString("startDate")
								, resultSet.getString("endDate"), resultSet.getString("endDate"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from question_choice where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from question_choice");
	}
}
