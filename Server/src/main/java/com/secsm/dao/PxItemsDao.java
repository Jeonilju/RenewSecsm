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
import com.secsm.info.DutyInfo;
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

	public void create(PxItemsInfo info){
		jdbcTemplate.update("insert info px_items (name, code, price, description, count) values (?, ?, ?, ?, ?)"
				, new Object[] {info.getName(), info.getCode(), info.getPrice(), info.getDescription(), info.getCount()});
	}
	
	public List<DutyInfo> selectAll(){
		return jdbcTemplate.query("select * from duty",
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
								, resultSet.getInt("accountId3"));
					}
				});
	}
	
	public List<DutyInfo> select(int id){
		return jdbcTemplate.query("select * from duty where id = ?", new Object[id],
				new RowMapper<DutyInfo>() {
					public DutyInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new DutyInfo(resultSet.getInt("id"), resultSet.getTimestamp("dytyDate")
								, resultSet.getInt("accountId1"), resultSet.getInt("accountId2")
								, resultSet.getInt("accountId3"));
					}
				});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from duty where id = ?", new Object[id]);
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from duty");
	}
}
