package com.cqunis.cms.service;

import com.cqunis.cms.entity.Extension;
import com.cqunis.service.support.IBaseService;

public interface IExtensionService extends IBaseService<Extension,String> {

	
	
	/***可用余额
	 * @param humanId
	 * @param entCode
	 * @return
	 */
	public String welcomeBalance(String humanId,String entCode);
}
