package com.cqunis.cms.dao;

import com.cqunis.cms.entity.NewSection;
import com.cqunis.dao.support.IBaseDao;
import org.springframework.stereotype.Repository;

@Repository("newSectionDao")
public abstract interface INewSectionDao extends IBaseDao<NewSection, String>, INewSectionDaoCustom
{
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.INewSectionDao
 * JD-Core Version:    0.6.1
 */