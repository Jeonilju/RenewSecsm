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

import com.secsm.idao.EquipmentLogIDao;
import com.secsm.info.EquipmentLogInfo;

public class EquipmentLogDao implements EquipmentLogIDao {
	private static final Logger logger = LoggerFactory.getLogger(EquipmentLogDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int accountId, int equipmentItemId, int type, Timestamp startDate, Timestamp endDate, int status){
		jdbcTemplate.update("insert into equipment_log (Account_id, type, Equipment_itmes_id, StartDate, EndDate, status) values (?, ?, ?, ?, ?, ?)"
				, new Object[] {accountId, type, equipmentItemId, startDate, endDate, status});
	}
	
	public List<EquipmentLogInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_log",
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("type")
								, resultSet.getInt("Equipment_itmes_id"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectByAccountId(int accountId){
		return jdbcTemplate.query("select * from equipment_log where account_id = ?", new Object[] {accountId},
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("type")
								, resultSet.getInt("Equipment_itmes_id"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectByEquipmentId(int Equipment_itmes_id){
		return jdbcTemplate.query("select * from equipment_log where Equipment_itmes_id = ?", new Object[] {Equipment_itmes_id},
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("type")
								, resultSet.getInt("Equipment_itmes_id"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectById(int id){
		return jdbcTemplate.query("select * from equipment_log where id = ?", new Object[] {id},
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("type")
								, resultSet.getInt("Equipment_itmes_id"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectForApply(int accountId, int equipmentId){
		return jdbcTemplate.query("select * from equipment_log where account_id = ? and Equipment_items_id = ? order by regDate DESC", new Object[] {accountId, equipmentId},
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("id"), resultSet.getInt("account_id")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("type")
								, resultSet.getInt("Equipment_itmes_id"), resultSet.getTimestamp("startDate")
								, resultSet.getTimestamp("endDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public void setStatue(int accountId, int equipmentItemId, int status){
		jdbcTemplate.update("update equipment_log set "
				+ " status =  ?,"
			+ " where Account_id = ?"
			+ " and Equipment_itmes_id = ?", 
			new Object[]  { status, accountId, equipmentItemId });
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_log where id = ?", new Object[]{id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from equipment_log");
	}
}
