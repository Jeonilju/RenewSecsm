package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.info.EquipmentCategoryInfo;

public class EquipmentCategoryDao {
	private static final Logger logger = LoggerFactory.getLogger(EquipmentCategoryDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(String name){
		jdbcTemplate.update("insert into equipment_category (name) values (?)", new Object[] {name});
	}
	
	public List<EquipmentCategoryInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_category",
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"), resultSet.getString("name"));
					}
				});
	}
	
	public List<EquipmentCategoryInfo> select(String name) {
		return jdbcTemplate.query("SELECT * FROM secsm.equipment_category where name=? order by id limit 0, 1",
				new Object[] {name},
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"),resultSet.getString("name"));
					}
				});
	}
	
	public List<EquipmentCategoryInfo> select(int id) {
		return jdbcTemplate.query("SELECT * FROM secsm.equipment_category where id=? order by id limit 0, 1",
				new Object[] {id},
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"),resultSet.getString("name"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_category where id = ?", new Object[] {id});
	}
}
