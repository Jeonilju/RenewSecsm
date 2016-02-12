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
	
//	public void create(DutyInfo info){
//		jdbcTemplate.update("insert into duty (dutyDate, accountId1, accountId2, accountId3) values (?, ?, ?, ?)"
//				, new Object[]{info.getDutyDate(), info.getAccountId1(), info.getAccountId2(), info.getAccountId3()});
//	}
//	
	public void create1(Timestamp dutyDate, int accountId1){
		jdbcTemplate.update("insert into duty (dutyDate, account_Id1) values (?, ?)"
				, new Object[]{dutyDate, accountId1});
	}
	
	public void create2(Timestamp dutyDate, int accountId1, int accountId2){
		jdbcTemplate.update("insert into duty (dutyDate, account_Id1, account_Id2) values (?, ?, ?)"
				, new Object[]{dutyDate, accountId1, accountId2});
	}
	
	public void create3(Timestamp dutyDate, int accountId1, int accountId2, int accountId3){
		jdbcTemplate.update("insert into duty (dutyDate, account_Id1, account_Id2, account_Id3) values (?, ?, ?, ?)"
				, new Object[]{dutyDate, accountId1, accountId2, accountId3});
	}

//	
//	public List<DutyInfo> selectAll(){
//		return jdbcTemplate.query("select * from duty",
//				new RowMapper<DutyInfo>() {
//					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
//						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
//								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
//								, resultSet.getInt("accountId3"));
//					}
//				});
//	}
//	
//	public List<DutyInfo> select(int id){
//		return jdbcTemplate.query("select * from duty where id = ?", new Object[id],
//				new RowMapper<DutyInfo>() {
//					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
//						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
//								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
//								, resultSet.getInt("accountId3"));
//					}
//				});
//	}
	
	// TODO 날짜 Where 문 채우
//	public List<DutyInfo> select(Timestamp date){
//		return jdbcTemplate.query("select * from duty where dutyDate = ?",
//				new RowMapper<DutyInfo>() {
//					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
//						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
//								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
//								, resultSet.getInt("accountId3"));
//					}
//				});
//	}
	
	public List<DutyInfo> selectTimeName(Timestamp startDate, Timestamp endDate){
		return jdbcTemplate.query("select duty.id, duty.dutyDate, a1.name, a2.name, a3.name from duty "
				+ "LEFT OUTER JOIN account a1 ON duty.account_id1 = a1.id "
				+ "LEFT OUTER JOIN account a2 ON duty.account_id2 = a2.id "
				+ "LEFT OUTER JOIN account a3 ON duty.account_id3 = a3.id "
				+ "WHERE dutyDate >= ? AND dutyDate < ?", 
				new Object[] { startDate, endDate },
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("duty.id"), resultSet.getTimestamp("duty.dutyDate"),
								resultSet.getString("a1.name"), resultSet.getString("a2.name"), resultSet.getString("a3.name"));
					}
				});
	}
	
	public List<DutyInfo> selectTimeId(Timestamp startDate, Timestamp endDate){
		return jdbcTemplate.query("select * from duty where dutyDate >= ? AND dutyDate < ?", 
				new Object[] { startDate, endDate },
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dutyDate")
								, resultSet.getInt("account_Id1"), resultSet.getInt("account_Id2")
								, resultSet.getInt("account_Id3"));
					}
				});
	}
	
	public List<DutyInfo> selectTimeAndId(int userId, Timestamp startDate, Timestamp endDate){
		return jdbcTemplate.query("select * from duty "
				+ "where dutyDate >= ? AND dutyDate < ? AND (account_id1=? OR account_id2=? OR account_id3=?)", 
				new Object[] {startDate, endDate,userId,userId,userId},
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dutyDate")
								, resultSet.getInt("account_Id1"), resultSet.getInt("account_Id2")
								, resultSet.getInt("account_Id3"));
					}
				});
	}
	
	public void deleteAccount1(int id){
		jdbcTemplate.update("update duty set account_id1=NULL where id=?", new Object[] {id});
	}
	
	public void deleteAccount2(int id){
		jdbcTemplate.update("update duty set account_id2=NULL where id=?", new Object[] {id});
	}
	
	public void deleteAccount3(int id){
		jdbcTemplate.update("update duty set account_id3=NULL where id=?", new Object[] {id});
	}
	
	public void insertAccount1(int userId, int id){
		jdbcTemplate.update("update duty set account_id1=? where id=?", new Object[] {userId, id});
	}
	
	public void insertAccount2(int userId, int id){
		jdbcTemplate.update("update duty set account_id2=? where id=?", new Object[] {userId, id});
	}
	
	public void insertAccount3(int userId, int id){
		jdbcTemplate.update("update duty set account_id3=? where id=?", new Object[] {userId, id});
	}
	public void deleteDate(Timestamp startDate, Timestamp endDate){
		jdbcTemplate.update("delete from duty where dutydate>=? AND dutydate<?", new Object[] {startDate, endDate });
	}
	
//	public void delete(int id){
//		jdbcTemplate.update("delete from duty where id = ?", new Object[id]);
//	}
//	
//	public void deleteAll(){
//		jdbcTemplate.update("delete from duty");
//	}

}
