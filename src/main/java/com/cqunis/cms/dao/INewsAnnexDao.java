package com.cqunis.cms.dao;

import com.cqunis.cms.entity.NewsAnnex;
import com.cqunis.dao.support.IBaseDao;
import org.springframework.stereotype.Repository;

@Repository("newsAnnexDaoImpl")
public abstract interface INewsAnnexDao extends IBaseDao<NewsAnnex, String>
{
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.INewsAnnexDao
 * JD-Core Version:    0.6.1
 */