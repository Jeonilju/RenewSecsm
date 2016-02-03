package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.PxLogIDao;
import com.secsm.info.PxLogInfo;

public class PxLogDao implements PxLogIDao {
	private static final Logger logger = LoggerFactory.getLogger(PxLogDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	public void create(int accountId, int pxItemsId, int type, int count){
		jdbcTemplate.update("insert into px_log (Account_id, Px_Items_id, Type, Count) values (?, ?, ?, ?)"
				, new Object[] {accountId, pxItemsId, type, count});
	}
	
	public List<PxLogInfo> selectAll(){
		return jdbcTemplate.query("select * from px_log",
				new RowMapper<PxLogInfo>() {
					public PxLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxLogInfo(resultSet.getInt("id"), resultSet.getInt("Account_id")
								, resultSet.getInt("Px_Items_id"), resultSet.getTimestamp("RegDate")
								, resultSet.getInt("Type"), resultSet.getInt("Count"));
					}
				});
	}
	
	public List<PxLogInfo> selectById(int id){
		return jdbcTemplate.query("select * from px_log where id = ?", new Object[] {id},
				new RowMapper<PxLogInfo>() {
					public PxLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxLogInfo(resultSet.getInt("id"), resultSet.getInt("Account_id")
								, resultSet.getInt("Px_Items_id"), resultSet.getTimestamp("RegDate")
								, resultSet.getInt("Type"), resultSet.getInt("Count"));
					}
				});
	}
	
	public List<PxLogInfo> selectByAccountId(int id){
		return jdbcTemplate.query("select * from px_log as log, px_items as item where log.Account_id = ? AND item.id = log.px_items_id"
				+ "", new Object[] {id},
				new RowMapper<PxLogInfo>() {
					public PxLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxLogInfo(resultSet.getInt("log.id"), resultSet.getInt("log.Account_id")
								, resultSet.getInt("log.Px_Items_id"), resultSet.getTimestamp("log.RegDate")
								, resultSet.getInt("log.Type"), resultSet.getInt("log.Count")
								, resultSet.getString("item.name"), resultSet.getInt("item.price") * resultSet.getInt("log.count"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from px_log where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from px_log");
	}
}
