package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.secsm.idao.AccountIDao;
import com.secsm.info.AccountInfo;

public class AccountDao implements AccountIDao {
	private static final Logger logger = LoggerFactory.getLogger(AccountDao.class);
	
	private int temp;
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void create(String name, String email, String pw, String phone){
		jdbcTemplate.update("insert into account (name, email, pw, phone) values (?, ?, ?, ?)", new Object[] { name, email, pw, phone });
	}
	
	public List<AccountInfo> selectAll() {
		return jdbcTemplate.query("select * from account", new Object[] {  },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"));
					}
				});
	}

	public List<AccountInfo> select(String email) {
		return jdbcTemplate.query("select * from account where email = ?", new Object[] { email },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"));
					}
				});
	}
	
	
	public int CheckAmount(int id){
		return jdbcTemplate.queryForInt("select Px_amount from account where id = ?", new Object[]{ id });
	}
	public void usePxAmount(int id, int price){
		jdbcTemplate.update("update account set "
				+ " Px_amount = Px_amount - ?"
			+ " where id = ?", 
			new Object[]  { price, id});
	}
	
	public void refund_usePxAmount(int id, int price){
		jdbcTemplate.update("update account set "
				+ " Px_amount = Px_amount + ?"
			+ " where id = ?", 
			new Object[]  { price, id});
	}
	
	public void updateAccount(AccountInfo info){
		jdbcTemplate.update("update account set "
				+ " name = ?,"
				+ " email = ?,"
				+ " pw = ?,"
				+ " phone = ?,"
				+ " Px_amount = ?,"
				+ " grade = ?"
			+ " where id = ?", 
			new Object[]  { info.getName(), info.getEmail(), info.getPw(), info.getPhone(), info.getPxAmount(), info.getGrade(), info.getId() });
	}
	
	public void setGrade(int id, int grade){
		jdbcTemplate.update("update account set "
				+ " grade = ?"
			+ " where id = ?", 
			new Object[]  { grade, id});
	}
	
	public void delete(int id){
		
	}
	
	public void deleteAll(){
		
	}
}
