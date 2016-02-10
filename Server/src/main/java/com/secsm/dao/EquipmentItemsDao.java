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

import com.secsm.idao.EquipmentItemsIDao;
import com.secsm.info.EquipmentItemsInfo;

public class EquipmentItemsDao implements EquipmentItemsIDao {
	private static final Logger logger = LoggerFactory.getLogger(EquipmentItemsDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int id, String code, String name, int type, int count, int status, String description){
		jdbcTemplate.update("insert into equipment_items (id, code, name, type, count, status, description) values (?,?,?,?,?,?,?)"
				, new Object[] {id, code, name, type, count, status, description});
	}
	
	public List<EquipmentItemsInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_items",
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count")
								, resultSet.getInt("status"), resultSet.getString("description"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> select(int id){
		return jdbcTemplate.query("select * from equipment_items where id = ?", new Object[]{id},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}
	
	public List<EquipmentItemsInfo> select(int type, String name){
		return jdbcTemplate.query("select * from equipment_items where type = ? and name = ?", new Object[]{type, name},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}
		
	
	/** 도서 리스트 반환 */
	public List<EquipmentItemsInfo> selectByBook(String name){
		// TODO 도서 리스트 반환
		String querey = "";
		
		return jdbcTemplate.query("select * from equipment_items where and name = ?", new Object[]{name},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}
	
	/** 장비 리스트 반환 */
	public List<EquipmentItemsInfo> selectByEquipment(String name){
		// TODO 장비 리스트 반환

		return jdbcTemplate.query("select * from equipment_items where name = ?", new Object[]{name},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}

	/** 대여 혹은 반납 
	 * @return 0이면 대여 1이면 반납
	 * */
	public int apply(String code){
		
		//TODO 대여 혹은 반납
		
		return 0;
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_items where id = ?", new Object[]{id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from equipment_items");
	}
}
