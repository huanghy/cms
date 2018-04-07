package com.cqunis.cms.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cqunis.cms.dao.IExtensionDao;
import com.cqunis.cms.entity.Extension;
import com.cqunis.cms.service.IExtensionService;
import com.cqunis.dao.support.IBaseDao;
import com.cqunis.service.support.impl.BaseServiceImpl;
@Service("extensionServiceImpl")
public class ExtensionServiceImpl extends BaseServiceImpl<Extension,String> implements IExtensionService {
	
	@Resource(name="extensionDaoImpl")
	IExtensionDao extensionDao;
	
	 public IBaseDao<Extension, String> getBaseDao()
	   {
	      return this.extensionDao;
	   }
}
