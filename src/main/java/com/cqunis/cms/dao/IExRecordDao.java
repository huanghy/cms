package com.cqunis.cms.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cqunis.cms.entity.ExRecord;
import com.cqunis.dao.support.IBaseDao;
@Repository("exRecordDaoImpl")
public interface IExRecordDao extends IBaseDao<ExRecord, String> {

	
	
	/***统计今日消费
	 * @param humanId
	 * @param entCode
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@Query(value="SELECT\n" +
					"  SUM(erc.unitPrice)\n" + 
					"FROM\n" + 
					"  ExRecord erc\n" + 
					"WHERE erc.humanId = :humanId\n" + 
					"  AND erc.entCode = :entCode\n" + 
					"  AND erc.endTime BETWEEN str_to_date(:startTime,'%Y-%m-%d %H:%i:%s')\n" + 
					"  AND str_to_date(:endTime,'%Y-%m-%d %H:%i:%s')")
	public String dayConsume(@Param("humanId")String humanId,@Param("entCode")String entCode,@Param("startTime")String startTime,@Param("endTime")String endTime);
}
