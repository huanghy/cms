package com.cqunis.cms.service;

import com.cqunis.cms.entity.ExRecord;
import com.cqunis.service.support.IBaseService;

public interface IExRecordService extends IBaseService<ExRecord,String> {

	
	/***今日消费
	 * @param humanId
	 * @param entCode
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public String dayConsume(String humanId,String entCode,String startTime,String endTime);
}
