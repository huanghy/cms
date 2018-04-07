package com.cqunis.cms.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cqunis.cms.entity.Extension;
import com.cqunis.dao.support.IBaseDao;
@Repository("extensionDaoImpl")
public interface IExtensionDao extends IBaseDao<Extension,String> {

	
	
	/***
	 * 获取可用余额
	 * @param humanId
	 * @param entCode
	 * @return
	 */
	@Query(value="SELECT\n" +
					"  SUM(et.invAmount) - SUM(et.actualAmount)\n" + 
					"FROM\n" + 
					"  Extension et\n" + 
					"WHERE et.humanId = :humanId\n" + 
					"  AND et.entCode = :entCode")
	public String welcomeBalance(@Param("humanId")String humanId,@Param("entCode")String entCode);
}
