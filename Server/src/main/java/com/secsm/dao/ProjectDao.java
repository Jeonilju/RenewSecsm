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

import com.secsm.idao.ProjectIDao;
import com.secsm.info.ProjectInfo;

public class ProjectDao implements ProjectIDao {
	private static final Logger logger = LoggerFactory.getLogger(ProjectDao.class);

	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}
	
	public void create(String name, String summary, String discription, String pl, String teamMember, Timestamp startDate, Timestamp endDate){
		jdbcTemplate.update("insert into project (Name, Summary, Description, PL, Team1, status, StartDate, EndDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
				, new Object[] {name, summary, discription, pl, teamMember, 0, startDate, endDate});
	}

	public List<ProjectInfo> selectAll(){
		return jdbcTemplate.query("select * from project", new Object[] {  },
				new RowMapper<ProjectInfo>() {
					public ProjectInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new ProjectInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("summary"), resultSet.getString("description"),
								resultSet.getString("pl"), resultSet.getString("team1"), resultSet.getInt("status"), 
								resultSet.getTimestamp("startDate"), resultSet.getTimestamp("endDate"),
								resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public List<ProjectInfo> selectByPage(int page, int count){
		return jdbcTemplate.query("select * from project order by id limit ?, ?", new Object[] { page, count },
				new RowMapper<ProjectInfo>() {
					public ProjectInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new ProjectInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("summary"), resultSet.getString("description"),
								resultSet.getString("pl"), resultSet.getString("team1"), resultSet.getInt("status"), 
								resultSet.getTimestamp("startDate"), resultSet.getTimestamp("endDate"),
								resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public List<ProjectInfo> select(){
		return jdbcTemplate.query("select * from project", new Object[] {  },
				new RowMapper<ProjectInfo>() {
					public ProjectInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new ProjectInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("summary"), resultSet.getString("description"),
								resultSet.getString("pl"), resultSet.getString("team1"), resultSet.getInt("status"), 
								resultSet.getTimestamp("startDate"), resultSet.getTimestamp("endDate"),
								resultSet.getTimestamp("regDate"));
					}
				});
	}
	
	public ProjectInfo selectById(int id){
		List<ProjectInfo> result = jdbcTemplate.query("select * from project where id = ?", new Object[] { id },
				new RowMapper<ProjectInfo>() {
					public ProjectInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new ProjectInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("summary"), resultSet.getString("description"),
								resultSet.getString("pl"), resultSet.getString("team1"), resultSet.getInt("status"), 
								resultSet.getTimestamp("startDate"), resultSet.getTimestamp("endDate"),
								resultSet.getTimestamp("regDate"));
					}
				});
		
		if(result.size() == 1){
			// 정상
			return result.get(0);
		}
		else if(result.size() < 1){
			// 없는 프로젝트
			logger.error("알수없는 프로젝트 아이디");
			return null;
		}
		else{
			// 있을수 없는일
			logger.error("프로젝트 아이디 중복");
			return result.get(0);
		}
	}
	
	public void updateProject(int id, String name, String summary, String description, String pl, String teamMember, int status, Timestamp startDate, Timestamp endDate){
		jdbcTemplate.update("update project set "
				+ "name = ?,"
				+ " summary = ?,"
				+ " description = ?,"
				+ " pl = ?,"
				+ " team = ?,"
				+ " status = ?,"
				+ " startDate = ?,"
				+ " endDate = ?"
			+ " where id = ?", 
			new Object[]  { name, summary, description, pl, teamMember, status, startDate, endDate , id});
	}
	
	public void setStatus(int id, int status){
		jdbcTemplate.update("update project set "
				+ " status = ?"
			+ " where id=?", 
			new Object[]  { status, id});
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from project where id = ?", new Object[] { id });
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from project");
	}
	
}
