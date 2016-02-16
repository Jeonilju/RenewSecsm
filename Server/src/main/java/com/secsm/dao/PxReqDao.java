package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.PxReqIDao;
import com.secsm.info.PxReqInfo;
import com.secsm.info.PxReqInfo;

public class PxReqDao implements PxReqIDao {
	private static final Logger logger = LoggerFactory.getLogger(PxReqDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(int accountId, String title, String context){
		jdbcTemplate.update("insert into px_req (Account_id, title, context, status) values (?, ?, ?, ?)" 
				, new Object[] {accountId, title, context, 0});
	}
	
	public List<PxReqInfo> selectAll(){
		return jdbcTemplate.query("select * from px_req",
				new RowMapper<PxReqInfo>() {
					public PxReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxReqInfo(resultSet.getInt("id"), resultSet.getInt("Account_id")
								, resultSet.getString("Title"), resultSet.getString("Context")
								, resultSet.getTimestamp("RegDate"), resultSet.getInt("Status"));
					}
				});
	}
	
	public List<PxReqInfo> select(int id){
		return jdbcTemplate.query("select * from px_req where Account_id = ?", new Object[]{id},
				new RowMapper<PxReqInfo>() {
					public PxReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxReqInfo(resultSet.getInt("id"), resultSet.getInt("Account_id")
								, resultSet.getString("Title"), resultSet.getString("Context")
								, resultSet.getTimestamp("RegDate"), resultSet.getInt("Status"));
					}
				});
	}
	
	public void accept_item(int id){
		jdbcTemplate.update("update px_req set" + "Status = 1" + "where id = ?",
				new Object[]{ id });
	}
	
	public void Accept(int id){
		jdbcTemplate.update("update px_req set "
				+ " status = status + 1"
			+ " where id = ?", 
			new Object[]  { id});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from px_req where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from px_req");
	}
}
