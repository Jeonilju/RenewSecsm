package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.info.BookCategoryInfo;
import com.secsm.info.BookItemsInfo;
import com.secsm.info.BookLogInfo;

public class BookCategoryDao {
	private static final Logger logger = LoggerFactory.getLogger(AccountDao.class);
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(String name){
		jdbcTemplate.update("insert into book_category (name) values (?)", 
				new Object[] {name});
	}
	
	public List<BookCategoryInfo> selectALL() {
		return jdbcTemplate.query("SELECT * FROM secsm.book_category",
				new Object[] {},
				new RowMapper<BookCategoryInfo>() {
					public BookCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookCategoryInfo(resultSet.getInt("id"),resultSet.getString("name"));
					}
				});
	}
	
	public List<BookCategoryInfo> select(String name) {
		return jdbcTemplate.query("SELECT * FROM secsm.book_category where name=? order by id limit 0, 1",
				new Object[] {name},
				new RowMapper<BookCategoryInfo>() {
					public BookCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookCategoryInfo(resultSet.getInt("id"),resultSet.getString("name"));
					}
				});
	}
	
	public List<BookCategoryInfo> select(int id) {
		return jdbcTemplate.query("SELECT * FROM secsm.book_category where id=?",
				new Object[] {id},
				new RowMapper<BookCategoryInfo>() {
					public BookCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookCategoryInfo(resultSet.getInt("id"),resultSet.getString("name"));
					}
				});
	}
	
	public void delete(int id) {
		jdbcTemplate.update("delete from secsm.book_category where id = ?", new Object[] { id });
	}

}
