package com.cqunis.cms.dao;

import org.springframework.stereotype.Repository;

import com.cqunis.cms.entity.Extension;
import com.cqunis.dao.support.IBaseDao;
@Repository("extensionDaoImpl")
public interface IExtensionDao extends IBaseDao<Extension,String> {

}
