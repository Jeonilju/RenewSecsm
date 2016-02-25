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
		jdbcTemplate.update("insert into attendance (cardnum, account_id) values ( (select cardnum from account where id = ?),?)", new Object[] { accountId, accountId });
	}
	
	public void createByCardNum(int cardnum){
		jdbcTemplate.update("insert into attendance (cardnum, account_id) values (?, (select id from account where cardnum = ?))", new Object[] { cardnum , cardnum });
	}
	
	public List<AttendanceInfo> selectAll(){
		return jdbcTemplate.query("select * from attendance",
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getTimestamp("regDate")
								, resultSet.getInt("cardnum"));
					}
				});
	}

	public List<AttendanceInfo> select(int cardnum){
		return jdbcTemplate.query("select * from attendance where cardnum = ?", new Object[] { cardnum },
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getTimestamp("regDate")
								, resultSet.getInt("cardnum"));
					}
				});
		
	}
	
	public List<AttendanceInfo> selectTime(int cardnum,Timestamp startDate, Timestamp endDate){
		return jdbcTemplate.query("select * from attendance where cardnum = ? AND regDate >=  ? AND regDate < ?", 
				new Object[] { cardnum, startDate, endDate },
				new RowMapper<AttendanceInfo>() {
					public AttendanceInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttendanceInfo(resultSet.getTimestamp("regDate")
								, resultSet.getInt("cardnum"));
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
