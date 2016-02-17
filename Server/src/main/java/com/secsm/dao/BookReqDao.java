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
//	
//	public List<AccountInfo> selectAll() {
//		return jdbcTemplate.query("select * from account", new Object[] {  },
//				new RowMapper<AccountInfo>() {
//					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
//						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
//								resultSet.getString("email"), resultSet.getString("pw"),
//								resultSet.getString("phone"), resultSet.getInt("grade")
//								, resultSet.getInt("Px_amount"));
//					}
//				});
//	}
//	
//	public List<AccountInfo> select(String email) {
//		return jdbcTemplate.query("select * from account where email = ?", new Object[] { email },
//				new RowMapper<AccountInfo>() {
//					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
//						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
//								resultSet.getString("email"), resultSet.getString("pw"),
//								resultSet.getString("phone"), resultSet.getInt("grade")
//								, resultSet.getInt("Px_amount"));
//					}
//				});
//	}
//	
//	public void delete(int id){
//		
//	}
//	
//	public void deleteAll(){
//		
//	}
}
