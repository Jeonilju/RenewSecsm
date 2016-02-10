package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.PxItemsIDao;
import com.secsm.info.PxItemsInfo;
import com.secsm.info.PxItemsInfo;

public class PxItemsDao implements PxItemsIDao {
	private static final Logger logger = LoggerFactory.getLogger(PxItemsDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(String name, String code, int price, String description, int count){
		jdbcTemplate.update("insert into px_items (name, code, price, description, count) values (?, ?, ?, ?, ?)"
				, new Object[] {name, code, price, description, count});
	}
	
	public List<PxItemsInfo> selectAll(){
		return jdbcTemplate.query("select * from px_items",
				new RowMapper<PxItemsInfo>() {
					public PxItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxItemsInfo(resultSet.getInt("id"), resultSet.getString("Name")
								, resultSet.getString("Code"), resultSet.getInt("Price")
								, resultSet.getString("Description"), resultSet.getInt("Count"));
					}
				});
	}
	
	public List<PxItemsInfo> selectByCode(String code){
		return jdbcTemplate.query("select * from px_items where code = ?", new Object[]{code},
				new RowMapper<PxItemsInfo>() {
					public PxItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxItemsInfo(resultSet.getInt("id"), resultSet.getString("Name")
								, resultSet.getString("Code"), resultSet.getInt("Price")
								, resultSet.getString("Description"), resultSet.getInt("Count"));
					}
				});
	}
	
	public List<PxItemsInfo> selectByName(String name){
		return jdbcTemplate.query("select * from px_items where name = ?", new Object[]{name},
				new RowMapper<PxItemsInfo>() {
					public PxItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxItemsInfo(resultSet.getInt("id"), resultSet.getString("Name")
								, resultSet.getString("Code"), resultSet.getInt("Price")
								, resultSet.getString("Description"), resultSet.getInt("Count"));
					}
				});
	}
	
	public List<PxItemsInfo> select(int id){
		return jdbcTemplate.query("select * from px_items where id = ?", new Object[]{id},
				new RowMapper<PxItemsInfo>() {
					public PxItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new PxItemsInfo(resultSet.getInt("id"), resultSet.getString("Name")
								, resultSet.getString("Code"), resultSet.getInt("Price")
								, resultSet.getString("Description"), resultSet.getInt("Count"));
					}
				});
	}
	
	public void useItems(int id, int count){
		jdbcTemplate.update("update px_items set "
				+ " Count = Count - ?"
			+ " where id = ?", 
			new Object[]  { count, id});
	}
	
	
	public void refund_useItems(int id, int count){
		jdbcTemplate.update("update px_items set "
				+ " Count = Count + ?"
			+ " where id = ?", 
			new Object[]  { count, id});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from px_items where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from px_items");
	}
}
