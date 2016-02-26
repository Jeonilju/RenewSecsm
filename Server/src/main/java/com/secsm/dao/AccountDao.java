package com.secsm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource ds) {
		dataSource = ds;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		logger.info("Updated DataSource ---> " + ds);
		logger.info("Updated jdbcTemplate ---> " + jdbcTemplate);
	}

	public void modifyGrade(int id, int grade){
		jdbcTemplate.update("update account set grade=? where id=?", 
				new Object[] {grade, id});
	}
	
	public void modify(int id, String pw, String name, String gender, String phone){
		jdbcTemplate.update("update account set pw=?, name=?, gender=?, phone=? where id=?", 
				new Object[] {pw, name, gender, phone, id});
	}
	
	public void create(String name, String email, String pw, String phone,int grade,int gender, int cardnum){
		jdbcTemplate.update("insert into account (name, email, pw, phone,Grade,gender, cardnum) values (?, ?, ?, ?, ?, ?, ?)", new Object[] { name, email, pw, phone,grade,gender, cardnum });
	}
	
	public int duplicate_check(String email){
		int count = jdbcTemplate.queryForInt("select count(*) from account where email = ? and grade!=10",new Object[]  { email});
		return count;
	}
	
	public int nameDuplicate_check(String name){
		int count = jdbcTemplate.queryForInt("select count(*) from account where name = ? and grade!=10",new Object[]  { name});
		return count;
	}
	
	public List<AccountInfo> selectAll() {
		return jdbcTemplate.query("select * from account", new Object[] {  },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
					}
				});
	}
	
	public List<AccountInfo> selectNotIn(int id) {
		return jdbcTemplate.query("select * from account where id not in (?)", new Object[] { id },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
					}
				});
	}
	
	
	public List<AccountInfo> selectByPage(int page) {
		return jdbcTemplate.query("select * from account where grade!=10 order by grade limit ?,7", new Object[] { page },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender"), resultSet.getInt("cardnum"));
					}
				});
}
				
	public List<AccountInfo> selectByMoney() {
		return jdbcTemplate.query("select * from account order by Px_amount asc", new Object[] {  },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender"), resultSet.getInt("cardnum"));
					}
				});
	}

	public List<AccountInfo> selectById(int id) {
		return jdbcTemplate.query("select * from account where id = ?", new Object[] { id },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender"), resultSet.getInt("cardnum"));
					}
				});
	}
	
	public List<AccountInfo> selectByName(String name) {
		return jdbcTemplate.query("select * from account where name = ?", new Object[] { name },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender"), resultSet.getInt("cardnum"));
					}
				});
	}
	
	public List<AccountInfo> select(String email) {
		return jdbcTemplate.query("select * from account where email = ? and grade!=10 and grade!=-1", new Object[] { email },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
					}
				});
	}
	
	public List<AccountInfo> selectByEmailNGrade(String email, int grade) {
		return jdbcTemplate.query("select * from account where email = ? and grade =?", new Object[] { email, grade },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
					}
				});
	}
	
	//Duty 구현할때 사용
	public List<AccountInfo> selectDuty(String name) {
		return jdbcTemplate.query("select * from account where name = ? and gender = 1", new Object[] { name },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
					}
				});
	}
	
	//Duty 구현할때 사용
	public List<AccountInfo> selectAllException(String query) {
		return jdbcTemplate.query("select * from account where" + query + " order by name asc", new Object[] {  },
				new RowMapper<AccountInfo>() {
					public AccountInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new AccountInfo(resultSet.getInt("id"), resultSet.getString("name"),
								resultSet.getString("email"), resultSet.getString("pw"),
								resultSet.getString("phone"), resultSet.getInt("grade")
								, resultSet.getInt("Px_amount"), resultSet.getInt("gender")
								, resultSet.getInt("cardnum"));
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
	
	public void deleteAll(){
		
	}
}
