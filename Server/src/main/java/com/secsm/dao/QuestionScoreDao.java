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

import com.secsm.info.QuestionScoreInfo;

@Repository
public class QuestionScoreDao {
	private static final Logger logger = LoggerFactory.getLogger(QuestionScoreDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int questionId, String problom){
		jdbcTemplate.update("insert into question_score (question_id, problom) values (?, ?)"
				, new Object[] {questionId, problom});
	}
	
	public List<QuestionScoreInfo> selectAll(){
		return jdbcTemplate.query("select * from question_score",
				new RowMapper<QuestionScoreInfo>() {
					public QuestionScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionScoreInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getString("problom"));
					}
				});
	}
	
	public List<QuestionScoreInfo> select(int id){
		return jdbcTemplate.query("select * from question_score where id = ?", new Object[] {id},
				new RowMapper<QuestionScoreInfo>() {
					public QuestionScoreInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new QuestionScoreInfo(resultSet.getInt("id"), resultSet.getInt("question_id")
								, resultSet.getString("problom"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from question_score where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from question_score");
	}
}
