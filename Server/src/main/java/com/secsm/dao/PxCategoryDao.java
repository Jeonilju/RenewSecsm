package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.info.PxCategoryInfo;

public class PxCategoryDao {
	private static final Logger logger = LoggerFactory.getLogger(PxCategoryDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(PxCategoryInfo info){
		jdbcTemplate.update("insert into px_category (name) values (?)", new Object[] {info.getName()});
	}
	
	public List<PxCategoryInfo> selectAll(){
		return jdbcTemplate.query("select * from px_category",
				new RowMapper<PxCategoryInfo>() {
					public PxCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxCategoryInfo(resultSet.getInt("id"), resultSet.getString("name"));
					}
				});
	}
	
	public List<PxCategoryInfo> selectById(int id){
		return jdbcTemplate.query("select * from px_category where id = ?", new Object[id],
				new RowMapper<PxCategoryInfo>() {
					public PxCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxCategoryInfo(resultSet.getInt("id"), resultSet.getString("name"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from px_category where id = ?", new Object[id]);
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from px_category");
	}
}
