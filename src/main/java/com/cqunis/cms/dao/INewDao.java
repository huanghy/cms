package com.cqunis.cms.dao;

import com.cqunis.cms.entity.News;
import com.cqunis.dao.support.IBaseDao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository("newDaoImpl")
public abstract interface INewDao extends IBaseDao<News, String>, INewDaoCustom
{
  @Query("SELECT\n  COUNT(1)\nFROM\n  News con\nWHERE con.newSection.id = :sectionId\n  AND con.entCode = :entCode")
  public abstract Long searchNewsCount(@Param("sectionId") String paramString1, @Param("entCode") String paramString2);
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.INewDao
 * JD-Core Version:    0.6.1
 */