package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.EquipmentItemsIDao;
import com.secsm.info.BookItemsInfo;
import com.secsm.info.EquipmentItemsInfo;
import com.secsm.info.EquipmentLogInfo;

public class EquipmentItemsDao implements EquipmentItemsIDao {
	private static final Logger logger = LoggerFactory.getLogger(EquipmentItemsDao.class);

	@Autowired
	private EquipmentLogDao equipmentLogDao;
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(EquipmentItemsInfo e){
		jdbcTemplate.update("insert into equipment_items (code, name, manufacturer, imageURL, type, regDate, count, totalCount) values (?,?,?,?,?,?,?,?)"
				, new Object[] {e.getCode(),e.getName(),e.getManufacturer(),e.getImageURL(),e.getType(),e.getRegDate(),e.getCount(),e.getTotalCount()});
	}
	
	
	
	public void modify(EquipmentItemsInfo info){
		jdbcTemplate.update("update equipment_items set code=?, name=?, manufacturer=?, imageURL=?, type=?, regDate=?, count=?, totalCount=? where id=?", 
				new Object[] {info.getCode(),info.getName(),info.getManufacturer(),info.getImageURL(),info.getType(),info.getRegDate()
						,info.getCount(),info.getTotalCount(),info.getId()});
	}
	
	public void downCount(String id){
		jdbcTemplate.update("update secsm.equipment_items set count = count-1 where id=?", new Object[]  {id});
	}
	
	public void upCount(int id){
		jdbcTemplate.update("update secsm.equipment_items set count = count+1 where id=? and count<totalCount", new Object[]  {id});
	}
	
	public List<EquipmentItemsInfo> select(int id){
		return jdbcTemplate.query("select * from secsm.equipment_items where id = ?", new Object[] {id},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByPage(int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items order by regDate limit ?, 7", new Object[] {searchPage},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectById(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items a inner join secsm.equipment_category b on a.type=b.id "
								+ "where b.name = ? and a.id = ? order by regDate limit ?, 7"
				, new Object[] {category, keyword,searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByName(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items a inner join secsm.equipment_category b on a.type=b.id "
								+ "where b.name = ? and a.name regexp ? order by regDate limit ?, 7"
				, new Object[] {category, keyword,searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByCode(String category, String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items a inner join secsm.equipment_category b on a.type=b.id "
								+ "where b.name = ? and a.code = ? order by regDate limit ?, 7"
				, new Object[] {category, keyword,searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByCategory(String category, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items a inner join secsm.equipment_category b on a.type=b.id "
								+ "where b.name = ? order by regDate limit ?, 7"
				, new Object[] {category, searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	
	public List<EquipmentItemsInfo> selectByIdNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items where id = ? order by regDate limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByNameNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items where name regexp ? order by regDate limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByCodeNoCategory(String keyword, int searchPage){
		return jdbcTemplate.query("select * from secsm.equipment_items where code = ? order by regDate limit ?, 7"
				, new Object[] {keyword, searchPage}
				, new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code"),
								resultSet.getString("name"), resultSet.getString("manufacturer"),
								resultSet.getString("imageURL"), resultSet.getInt("type"), resultSet.getTimestamp("regDate"),
								resultSet.getInt("count"), resultSet.getInt("totalCount"));
					}
				});
	}
	
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_items where id = ?", new Object[] { id });
	}
}
