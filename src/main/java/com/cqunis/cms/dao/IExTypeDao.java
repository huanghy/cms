package com.cqunis.cms.dao;

import org.springframework.stereotype.Repository;

import com.cqunis.cms.entity.ExType;
import com.cqunis.dao.support.IBaseDao;
@Repository("exTypeDaoImpl")
public interface IExTypeDao extends IBaseDao<ExType, String> {

}
