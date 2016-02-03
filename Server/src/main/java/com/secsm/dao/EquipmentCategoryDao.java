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

	public void create(EquipmentCategoryInfo info){
		jdbcTemplate.update("insert into equipment_category (name, isBook) values (?, ?)", new Object[] {info.getName(), info.getIsBook()});
	}
	
	public List<EquipmentCategoryInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_category",
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"), resultSet.getString("name")
								, resultSet.getInt("isBook"));
					}
				});
	}
	
	public List<EquipmentCategoryInfo> selectById(int id){
		return jdbcTemplate.query("select * from equipment_category where id = ?", new Object[] {id},
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"), resultSet.getString("name")
								, resultSet.getInt("isBook"));
					}
				});
	}
	
	public List<EquipmentCategoryInfo> selectIsBook(int isBook){
		return jdbcTemplate.query("select * from equipment_category where isBook=?", new Object[] {isBook},
				new RowMapper<EquipmentCategoryInfo>() {
					public EquipmentCategoryInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentCategoryInfo(resultSet.getInt("id"), resultSet.getString("name")
								, resultSet.getInt("isBook"));
					}
				});
	}
	
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_category where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from equipment_category");
	}
}
