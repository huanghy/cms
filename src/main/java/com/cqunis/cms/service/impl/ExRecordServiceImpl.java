package com.cqunis.cms.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cqunis.cms.dao.IExRecordDao;
import com.cqunis.cms.entity.ExRecord;
import com.cqunis.cms.service.IExRecordService;
import com.cqunis.dao.support.IBaseDao;
import com.cqunis.service.support.impl.BaseServiceImpl;
@Service("exRecordServiceImpl")
public class ExRecordServiceImpl extends BaseServiceImpl<ExRecord,String> implements IExRecordService {
	
	
	@Resource(name="exRecordDaoImpl")
	IExRecordDao exRecordDao;
	
	 public IBaseDao<ExRecord, String> getBaseDao()
	   {
	      return this.exRecordDao;
	   }
	 
	 
	 
	 /***
	  * 查询当前用户今日消费
	  */
	 public String dayConsume(String humanId,String entCode,String startTime,String endTime){
		 return exRecordDao.dayConsume(humanId, entCode, startTime, endTime);
	 }
}
