package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.secsm.info.AttachInfo;

@Repository
public class AttachDao {
	private static final Logger logger = LoggerFactory.getLogger(AttachDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(int projectId, String path, String tag, String name){
		jdbcTemplate.update("insert into attach (project_id, path, tag, name) values (?, ?, ?, ?)"
				, new Object[] {projectId, path, tag, name});
	}
	
	public List<AttachInfo> selectAll(){
		return jdbcTemplate.query("select * from attach",
				new RowMapper<AttachInfo>() {
					public AttachInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AttachInfo(resultSet.getInt("id"), resultSet.getInt("project_id")
								, resultSet.getString("path"), resultSet.getString("tag")
								, resultSet.getString("name"));
					}
				});
	}
	
	public List<AttachInfo> select(int id){
		return jdbcTemplate.query("select * from attach where id = ?", new Object[] {id},
					new RowMapper<AttachInfo>() {
				public AttachInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
					return new AttachInfo(resultSet.getInt("id"), resultSet.getInt("project_id")
							, resultSet.getString("path"), resultSet.getString("tag")
							, resultSet.getString("name"));
				}
			});
	}
	
	public List<AttachInfo> selectByProjectId(int projectId){
		return jdbcTemplate.query("select * from attach where project_id = ?", new Object[] {projectId},
					new RowMapper<AttachInfo>() {
				public AttachInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
					return new AttachInfo(resultSet.getInt("id"), resultSet.getInt("project_id")
							, resultSet.getString("path"), resultSet.getString("tag")
							, resultSet.getString("name"));
				}
			});
	}

	public void delete(int id){
		jdbcTemplate.update("delete from attach where id = ?", new Object[] {id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from attach");
	}
}
