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

import com.secsm.idao.EquipmentReqIDao;
import com.secsm.info.BookItemsInfo;
import com.secsm.info.BookReqInfo;
import com.secsm.info.EquipmentItemsInfo;
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

	public void create(EquipmentReqInfo e){
		jdbcTemplate.update("insert into secsm.equipment_req (account_id, typeKr, typeEn, titleKr, titleEn, brand, link, pay, count, content, regDate) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
				, new Object[]{e.getAccountId(),e.getTypeKr(),e.getTypeEn(),e.getTitleKr(),e.getTitleEn(),e.getBrand(),e.getLink(),e.getPay(),e.getCount(),e.getContent(),e.getRegDate()});
	}

	public void modify(EquipmentReqInfo info){
		jdbcTemplate.update("update equipment_req set typeKr=?, typeEn=?, titleKr=?, titleEn=?,"
				+ " brand=?, link=?, pay=?, count=?, content=?, regDate=? where id=? and account_id=?", 
				new Object[] {info.getTypeKr(),info.getTypeEn(),info.getTitleKr(),info.getTitleEn(),
						info.getBrand(),info.getLink(),info.getPay(),info.getCount(),info.getContent(),info.getRegDate(),info.getId(), info.getAccountId()});
	}
	
	public List<EquipmentReqInfo> selectById(int id, int page){
		return jdbcTemplate.query("select a.*, b.name "
				+ "from secsm.equipment_req a inner join account b ON a.account_id = b.id where b.id=? "
				+ "order by a.regDate desc limit ?,7", new Object[] {id, page},
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.typeKr"), resultSet.getString("a.typeEn"),
								resultSet.getString("a.titleKr"), resultSet.getString("a.titleEn"), 
								resultSet.getString("a.brand"), resultSet.getString("a.link"), 
								resultSet.getInt("a.pay"), resultSet.getInt("a.count"), resultSet.getString("a.content"), 
								resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	public List<EquipmentReqInfo> selectByDate(Timestamp start, Timestamp end){
		return jdbcTemplate.query("select a.*, b.name "
				+ "from secsm.equipment_req a inner join account b ON a.account_id = b.id where a.regDate>=? and a.regDate<? "
				+ "order by a.regDate", new Object[] {start, end},
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.typeKr"), resultSet.getString("a.typeEn"),
								resultSet.getString("a.titleKr"), resultSet.getString("a.titleEn"), 
								resultSet.getString("a.brand"), resultSet.getString("a.link"), 
								resultSet.getInt("a.pay"), resultSet.getInt("a.count"), resultSet.getString("a.content"), 
								resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	public List<EquipmentReqInfo> selectByDate(Timestamp start, Timestamp end, int reqPage){
		return jdbcTemplate.query("select a.*, b.name "
				+ "from secsm.equipment_req a inner join account b ON a.account_id = b.id where a.regDate>=? and a.regDate<? "
				+ "order by a.regDate limit ?,7", new Object[] {start, end, reqPage},
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("a.id"), resultSet.getString("b.name"),
								resultSet.getString("a.typeKr"), resultSet.getString("a.typeEn"),
								resultSet.getString("a.titleKr"), resultSet.getString("a.titleEn"), 
								resultSet.getString("a.brand"), resultSet.getString("a.link"), 
								resultSet.getInt("a.pay"), resultSet.getInt("a.count"), resultSet.getString("a.content"), 
								resultSet.getTimestamp("a.regDate"));
					}
				});
	}
	
	public List<EquipmentReqInfo> selectByIdForModify(int id, int accountId){
		return jdbcTemplate.query("select * from secsm.equipment_req where id=? and account_id=? "
				, new Object[] {id, accountId},
				new RowMapper<EquipmentReqInfo>() {
					public EquipmentReqInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentReqInfo(resultSet.getInt("id"), resultSet.getInt("account_id"),
								resultSet.getString("typeKr"), resultSet.getString("typeEn"),
								resultSet.getString("titleKr"), resultSet.getString("titleEn"), 
								resultSet.getString("brand"), resultSet.getString("link"), 
								resultSet.getInt("pay"), resultSet.getInt("count"), resultSet.getString("content"), 
								resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public void delete(int id, int accountId){
		jdbcTemplate.update("delete from equipment_req where id = ? and account_id = ?", new Object[] {id, accountId});
	}
}
