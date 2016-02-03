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

import com.secsm.idao.DutyIDao;
import com.secsm.info.AttendanceInfo;
import com.secsm.info.DutyInfo;

public class DutyDao implements DutyIDao {
	private static final Logger logger = LoggerFactory.getLogger(DutyDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(DutyInfo info){
		jdbcTemplate.update("insert into duty (dutyDate, accountId1, accountId2, accountId3) values (?, ?, ?, ?)"
				, new Object[]{info.getDutyDate(), info.getAccountId1(), info.getAccountId2(), info.getAccountId3()});
	}
	
	public List<DutyInfo> selectAll(){
		return jdbcTemplate.query("select * from duty",
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
								, resultSet.getInt("accountId3"));
					}
				});
	}
	
	public List<DutyInfo> select(int id){
		return jdbcTemplate.query("select * from duty where id = ?", new Object[id],
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
								, resultSet.getInt("accountId3"));
					}
				});
	}
	
	// TODO 날짜 Where 문 채우
	public List<DutyInfo> select(Timestamp date){
		return jdbcTemplate.query("select * from duty where dutyDate = ?",
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
								, resultSet.getInt("accountId3"));
					}
				});
	}
	
	
	public void delete(int id){
		jdbcTemplate.update("delete from duty where id = ?", new Object[id]);
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from duty");
	}

}
