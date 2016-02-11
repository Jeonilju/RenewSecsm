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

	public void create(String code, String name, int type, int count, String description){
		jdbcTemplate.update("insert into equipment_items (code, name, type, count, totalCount, description) values (?,?,?,?,?)"
				, new Object[] {code, name, type, count, count, description});
	}
	
	public List<EquipmentItemsInfo> selectAll(){
		return jdbcTemplate.query("select * from equipment_items",
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
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
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}
	
	public List<EquipmentItemsInfo> selectByCategory(int type, String name){
		
		if(type == -1){
			return jdbcTemplate.query("select * from equipment_items where name LIKE ?", new Object[]{name + "%"},
					new RowMapper<EquipmentItemsInfo>() {
						public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
							return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
									, resultSet.getString("name"), resultSet.getInt("Type")
									, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
									, resultSet.getInt("status"), resultSet.getString("description"));					}
					});
		}
		else{
			return jdbcTemplate.query("select * from equipment_items where type = ? and name LIKE ?", new Object[]{type, name + "%"},
					new RowMapper<EquipmentItemsInfo>() {
						public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
							return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
									, resultSet.getString("name"), resultSet.getInt("Type")
									, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
									, resultSet.getInt("status"), resultSet.getString("description"));					}
					});
			
		}
	}

	/** 도서 리스트 반환 */
	public List<EquipmentItemsInfo> selectByBook(String name){
		// TODO 도서 리스트 반환
		String querey = "select * from equipment_items where name = ?";
		
		return jdbcTemplate.query("select * from equipment_items where name = ?", new Object[]{name},
				new RowMapper<EquipmentItemsInfo>() {
					public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
						return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
								, resultSet.getString("name"), resultSet.getInt("Type")
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
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
								, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
								, resultSet.getInt("status"), resultSet.getString("description"));					}
				});
	}
	
	/** 바코드 또는 이름으로 검색 */
	public List<EquipmentItemsInfo> selectByType(int type, String name){
		if(type == 0){
			// 바코드
			return jdbcTemplate.query("select * from equipment_items where code ?", new Object[]{name},
					new RowMapper<EquipmentItemsInfo>() {
						public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
							return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
									, resultSet.getString("name"), resultSet.getInt("Type")
									, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
									, resultSet.getInt("status"), resultSet.getString("description"));					}
					});
		
		}
		else if(type == 1){
			// 이름
			return jdbcTemplate.query("select * from equipment_items where name LIKE ?", new Object[]{name + "%"},
					new RowMapper<EquipmentItemsInfo>() {
						public EquipmentItemsInfo mapRow(ResultSet resultSet, int rowNum) throws SQLException {
							return new EquipmentItemsInfo(resultSet.getInt("id"), resultSet.getString("code")
									, resultSet.getString("name"), resultSet.getInt("Type")
									, resultSet.getTimestamp("regDate"), resultSet.getInt("count"), resultSet.getInt("totalCount")
									, resultSet.getInt("status"), resultSet.getString("description"));					}
					});
		}
		else{
			return null;
		}
	}

	/** 대여 혹은 반납 
	 * @return 0이면 대여 1이면 반납
	 * */
	public int apply(int accountId, int type, String code){
		
		//TODO 대여 혹은 반납
		List<EquipmentItemsInfo> itemsList = selectByType(type, code);
		if(itemsList.size() == 1){
			// 1개
			List<EquipmentLogInfo> result = equipmentLogDao.selectForApply(accountId, itemsList.get(0).getId());
			if(result.size() == 0){
				// 대여한적 없음 -> 대여
				rent(accountId, itemsList.get(0).getId());
				return 0;
			}
			else if (result.get(0).getStatus() == 1) {
				// 반납
				reRent(accountId, itemsList.get(0).getId());
				return 1;
			}
			else{
				// 대여
				rent(accountId, itemsList.get(0).getId());
				return 0;
			}
		}
		else if(itemsList.size() < 1){
			// 장비가 없는 경우
			
		}
		else{
			// 장비가 여러개...
			
		}
		
		
		return -1;
	}
	
	// 대여
	// 아이템 수 -1
	// 로그 생성
	private void rent(int accountId, int equipmentItemId){
		jdbcTemplate.update("update equipment_items set "
				+ " Count =  Count - 1,"
			+ " where id = ?", 
			new Object[]  { equipmentItemId });
		
		Calendar startDateCal = Calendar.getInstance( );
		Timestamp startDate = new Timestamp( startDateCal.getTime().getTime());

		Calendar endDateCal = Calendar.getInstance( );
		endDateCal.add(Calendar.DATE, 14);
		Timestamp endDate = new Timestamp( endDateCal.getTime().getTime());

		equipmentLogDao.create(accountId, equipmentItemId, 0, startDate, endDate, 0);
	}
	
	// 반납 
	// 아이템 수  +1
	// 로그 업데이트
	private void reRent(int accountId, int equipmentItemId ){
		jdbcTemplate.update("update equipment_items set "
				+ " Count =  Count + 1,"
			+ " where id = ?", 
			new Object[]  { equipmentItemId });

		equipmentLogDao.setStatue(accountId, equipmentItemId, 1);
	}
	
	public void delete(int id){
		jdbcTemplate.update("delete from equipment_items where id = ?", new Object[]{id});
	}
	
	public void deleteAll(){
		jdbcTemplate.update("delete from equipment_items");
	}
}
