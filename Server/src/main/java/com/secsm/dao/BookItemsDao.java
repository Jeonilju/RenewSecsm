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

import com.secsm.info.BookItemsInfo;


public class BookItemsDao {
	private static final Logger logger = LoggerFactory.getLogger(AccountDao.class);
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(BookItemsInfo info){
		jdbcTemplate.update("insert into book_items (code, name, publisher, author, imageURL, type, regDate, count, totalCount) values (?, ?, ?, ?, ?, ?, ?, ?, ?)", 
				new Object[] {info.getCode(),info.getName(),info.getPublisher(),info.getAuthor(),info.getImageURL(),info.getType(),info.getRegDate()
						,info.getCount(),info.getTotalCount()});
	}
	
	public void modify(BookItemsInfo info){
		jdbcTemplate.update("update book_items set code=?, name=?, publisher=?, author=?, imageURL=?, type=?, regDate=?, count=?, totalCount=? where id=?", 
				new Object[] {info.getCode(),info.getName(),info.getPublisher(),info.getAuthor(),info.getImageURL(),info.getType(),info.getRegDate()
						,info.getCount(),info.getTotalCount(),info.getId()});
	}
	
	public void downCount(String id){
		jdbcTemplate.update("update secsm.book_items set count = count-1 where id=?", new Object[]  {id});
	}
	
	public void upCount(int id){
		jdbcTemplate.update("update secsm.book_items set count = count+1 where id=? and count<totalCount", new Object[]  {id});
	}
	
	public List<BookItemsInfo> select(int id){
		return jdbcTemplate.query("select * from secsm.book_items where id = ?", new Object[] {id},
				new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByPage(int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items order by regDate desc limit ?, 7", new Object[] {searchPage},
				new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectById(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items a inner join secsm.book_category b on a.type=b.id "
								+ "where b.name = ? and a.id = ? order by regDate desc limit ?, 7"
				, new Object[] {category, keyword,searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByName(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items a inner join secsm.book_category b on a.type=b.id "
								+ "where b.name = ? and a.name regexp ? order by regDate desc limit ?, 7"
				, new Object[] {category, keyword, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByCode(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items a inner join secsm.book_category b on a.type=b.id "
								+ "where b.name = ? and a.code = ? order by regDate desc limit ?, 7"
				, new Object[] {category, keyword, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByCategory(String category, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items a inner join secsm.book_category b on a.type=b.id "
								+ "where b.name = ? order by regDate desc limit ?, 7"
				, new Object[] {category, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByIdNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items where id = ? order by regDate desc limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByNameNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items where name regexp ? order by regDate desc limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<BookItemsInfo> selectByCodeNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.book_items where code = ? order by regDate desc limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<BookItemsInfo>() {
					public BookItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("publisher"), resultSet.getString("author"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from book_items where id = ?", new Object[] { id });
	}
}
