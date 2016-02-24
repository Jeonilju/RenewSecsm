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

	public void create(EquipmentLogInfo info){
		jdbcTemplate.update("insert into secsm.equipment_log (account_id, equipment_items_id, startDate, endDate, status) values (?, ?, ?, ?, ?)", 
				new Object[] {info.getAccountId(),info.getEquipmentItemsId(),info.getStartDate(),info.getEndDate(),info.getStatus()});
	}
	
	public void rentBack(int id){
		jdbcTemplate.update("update secsm.equipment_log set status = 0 where id=?", new Object[]  {id});
	}
	
	public void updateEndDate(int id, Timestamp endDate){
		jdbcTemplate.update("update secsm.equipment_log set endDate = ? where id=?", new Object[]  {endDate,id});
	}
	
	public List<EquipmentLogInfo> selectAll(int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id order by startDate desc limit ?,7", new Object[] { logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectAllStatus(int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where status = 1 order by startDate desc limit ?,7", new Object[] { logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectById(int id, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where equipment_items_id = ? and status=1 order by startDate desc limit ?,7"
				, new Object[] {id, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectAllById(int id, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where equipment_items_id = ? order by startDate desc limit ?,7"
				, new Object[] {id, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectByName(String name, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where status=1 and c.name regexp ? order by startDate desc limit ?,7"
				, new Object[] {name, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectAllByName(String name, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where c.name regexp ? order by startDate desc limit ?,7"
				, new Object[] {name, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectByCode(String code, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where code = ? and status=1 order by startDate desc limit ?,7"
				, new Object[] {code, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectAllByCode(String code, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where code = ? order by startDate desc limit ?,7"
				, new Object[] {code, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectByAccountName(String accountName, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where b.name = ? and status=1 order by startDate desc limit ?,7"
				, new Object[] {accountName, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public List<EquipmentLogInfo> selectAllByAccountName(String accountName, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where b.name = ? order by startDate desc limit ?,7"
				, new Object[] {accountName, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}

	public List<EquipmentLogInfo> selectOverDate(Timestamp now, int logPage) {
		return jdbcTemplate.query("select a.*, b.name, c.name from secsm.equipment_log a inner join secsm.account b on a.account_id=b.id "
				+ " inner join secsm.equipment_items c on a.equipment_items_id=c.id where status=1 and endDate<=? order by endDate limit ?,7"
				, new Object[] {now, logPage },
				new RowMapper<EquipmentLogInfo>() {
					public EquipmentLogInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentLogInfo(resultSet.getInt("a.id"), resultSet.getInt("a.account_id"),
								resultSet.getString("b.name"), resultSet.getInt("a.equipment_items_id"), resultSet.getString("c.name"),
								resultSet.getTimestamp("a.startDate"), resultSet.getTimestamp("a.endDate"),
								resultSet.getInt("a.status"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_log where equipment_items_id = ?", new Object[]{id});
	}
}
