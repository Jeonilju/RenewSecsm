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

import com.secsm.info.AccountInfo;
import com.secsm.info.BookLogInfo;

public class BookLogDao {
	
	private static final Logger logger = LoggerFactory.getLogger(AccountDao.class);
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(BookLogInfo info){
		jdbcTemplate.update("insert into secsm.book_log (account_id, book_items_id, startDate, endDate, status) values (?, ?, ?, ?, ?)", 
				new Object[] {info.getAccountId(),info.getBookItemsId(),info.getStartDate(),info.getEndDate(),info.getStatus()});
	}
	
	public void rentBack(int id){
		jdbcTemplate.update("update secsm.book_log set status = 0 where id=?", new Object[]  {id});
	}
	
	public void updateEndDate(int id, Timestamp endDate){
		jdbcTemplate.update("update secsm.book_log set endDate = ? where id=?", new Object[]  {endDate,id});
	}
	
	public List<BookLogInfo> selectAll() {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id", new Object[] {},
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectAllStatus() {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where status = 1", new Object[] {},
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectById(int id) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where book_items_id = ? and status=1",
				new Object[] { id },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectAllById(int id) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where book_items_id = ?",
				new Object[] { id },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectByName(String name) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where status=1 and c.name regexp ?",
				new Object[] { name },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectAllByName(String name) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where c.name regexp ?",
				new Object[] { name },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectByCode(String code) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where code = ? and status=1",
				new Object[] { code },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectAllByCode(String code) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where code = ?",
				new Object[] { code },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectByAccountName(String accountName) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where b.name = ? and status=1",
				new Object[] { accountName },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<BookLogInfo> selectAllByAccountName(String accountName) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.book_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.book_items c on a.book_items_id=c.id where b.name = ?",
				new Object[] { accountName },
				new RowMapper<BookLogInfo>() {
					public BookLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new BookLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.book_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from book_log where book_items_id = ?", new Object[] { id });
	}
}
