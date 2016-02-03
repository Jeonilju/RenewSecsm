package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.EquipmentReqIDao;
import com.secsm.info.EquipmentReqInfo;

public class EquipmentReqDao implements EquipmentReqIDao {
	private static final Logger logger = LoggerFactory.getLogger(EquipmentReqDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int accountId, String title, String context){
		jdbcTemplate.update("insert into equipment_req (accountId, title, context, status) valuse (?, ?, ?, ?)"
				, new Object[]{accountId, title, context, 0});
	}
	
	public List<EquipmentReqInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_req",
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
								, resultSet.getString("title"), resultSet.getString("context")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public List<EquipmentReqInfo> selectByID(int id){
		return jdbcTemplate.query("select * from equipment_req where id = ?", new Object[]{id},
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("id"), resultSet.getInt("accountId")
								, resultSet.getString("title"), resultSet.getString("context")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("status"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_req where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from equipment_req");
	}
}
