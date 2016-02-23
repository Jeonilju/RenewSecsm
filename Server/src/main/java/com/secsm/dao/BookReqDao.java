package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.info.BookItemsInfo;
import com.secsm.info.BookReqInfo;
import com.secsm.info.EquipmentReqInfo;


public class BookReqDao {
	private static final Logger logger = LoggerFactory.getLogger(AccountDao.class);
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(BookReqInfo info){
		jdbcTemplate.update("insert into book_req (account_id, title, publisher, author, link, imageURL, pay, regDate) values (?, ?, ?, ?, ?, ?, ?, ?)", 
				new Object[] {info.getAccountId(), info.getTitle(), info.getPublisher(), info.getAuthor(), info.getLink(), info.getImageURL(), info.getPay(), info.getRegDate()});
	}
	
	public void modify(BookReqInfo info){
		jdbcTemplate.update("update book_req set title=?, publisher=?, author=?, link=?, imageURL=?, pay=?, regDate=? where id=? and account_id=?", 
				new Object[] {info.getTitle(),info.getPublisher(),info.getAuthor(),info.getLink(),info.getImageURL(),info.getPay(),info.getRegDate(),info.getId(),info.getAccountId()});
	}
	
	public List<BookReqInfo> selectById(int id, int page){
		return jdbcTemplate.query("select a.id, a.title, a.publisher, a.author, a.link, a.imageURL, a.pay, a.regDate, b.name "
				+ "from secsm.book_req a inner join account b ON a.account_id = b.id where b.id=? "
				+ "order by a.regDate desc limit ?,7", new Object[] {id, page},
				new RowMapper<BookReqInfo>() {
					public BookReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.title"), resultSet.getString("a.publisher"),
								resultSet.getString("a.author"), resultSet.getString("a.link"), resultSet.getString("a.imageURL"),
								resultSet.getInt("a.pay"), resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	//엑셀로 뽑을때 사용
	public List<BookReqInfo> selectByDate(Timestamp start, Timestamp end){
		return jdbcTemplate.query("select a.id, a.title, a.publisher, a.author, a.link, a.imageURL, a.pay, a.regDate, b.name "
				+ "from secsm.book_req a inner join account b ON a.account_id = b.id where a.regDate>=? and a.regDate<? "
				+ "order by a.regDate", new Object[] {start, end},
				new RowMapper<BookReqInfo>() {
					public BookReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.title"), resultSet.getString("a.publisher"),
								resultSet.getString("a.author"), resultSet.getString("a.link"), resultSet.getString("a.imageURL"),
								resultSet.getInt("a.pay"), resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	public List<BookReqInfo> selectByDate(Timestamp start, Timestamp end, int reqPage){
		return jdbcTemplate.query("select a.id, a.title, a.publisher, a.author, a.link, a.imageURL, a.pay, a.regDate, b.name "
				+ "from secsm.book_req a inner join account b ON a.account_id = b.id where a.regDate>=? and a.regDate<? "
				+ "order by a.regDate limit ?,7", new Object[] {start, end, reqPage},
				new RowMapper<BookReqInfo>() {
					public BookReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.title"), resultSet.getString("a.publisher"),
								resultSet.getString("a.author"), resultSet.getString("a.link"), resultSet.getString("a.imageURL"),
								resultSet.getInt("a.pay"), resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	public List<BookReqInfo> selectByIdForModify(int id, int accountId){
		return jdbcTemplate.query("select * from secsm.book_req where id=? and account_id=? "
				, new Object[] {id, accountId},
				new RowMapper<BookReqInfo>() {
					public BookReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookReqInfo(resultSet.getInt("id"), resultSet.getInt("account_id"),
								resultSet.getString("title"), resultSet.getString("publisher"),
								resultSet.getString("author"), resultSet.getString("link"), 
								resultSet.getString("imageURL"), resultSet.getInt("pay"), resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public void delete(int id, int accountId){
		jdbcTemplate.update("delete from book_req where id = ? and account_id = ?", new Object[] {id, accountId});
	}

	
}
