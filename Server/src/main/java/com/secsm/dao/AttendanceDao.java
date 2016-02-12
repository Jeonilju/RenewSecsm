package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.AttendanceIDao;
import com.secsm.info.AttendanceInfo;

public class AttendanceDao implements AttendanceIDao {
	private static final Logger logger = LoggerFactory.getLogger(AttendanceDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(int accountId){
		jdbcTemplate.update("insert into attendance (accountId) values (?)", new Object[] { accountId });
	}
	
	public List<AttendanceInfo> selectAll(){
		return jdbcTemplate.query("select * from attendance",
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getInt("accountId"), resultSet.getTimestamp("regDate"));
					}
				});
	}

	public List<AttendanceInfo> select(int accountId){
		return jdbcTemplate.query("select * from attendance where account_Id = ?", new Object[] { accountId },
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getInt("account_Id"), resultSet.getTimestamp("regDate"));
					}
				});
		
	}
	
	public List<AttendanceInfo> selectTime(int accountId,Timestamp startDate, Timestamp endDate){
		return jdbcTemplate.query("select * from attendance where account_Id = ? AND regDate >=  ? AND regDate < ?", 
				new Object[] { accountId, startDate, endDate },
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getInt("account_Id"), resultSet.getTimestamp("regDate"));
					}
				});
		
	}
	
	public void delete(int accountId){
		jdbcTemplate.update("delete from attendance where accountId = ?", new Object[] { accountId });
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from attendance");
	}
	
}
