package com.cqunis.cms.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cqunis.cms.dao.IExTypeDao;
import com.cqunis.cms.entity.ExType;
import com.cqunis.cms.service.IExTypeService;
import com.cqunis.dao.support.IBaseDao;
import com.cqunis.service.support.impl.BaseServiceImpl;
@Service("exTypeServiceImpl")
public class ExTypeServiceImpl extends BaseServiceImpl<ExType,String> implements IExTypeService {
	
	@Resource(name="exTypeDaoImpl")
	IExTypeDao exTypeDao;
	
	 public IBaseDao<ExType, String> getBaseDao()
	   {
	      return this.exTypeDao;
	   }
	 
	 
}
