package com.cqunis.cms.dao;

import com.cqunis.cms.entity.News;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public abstract interface INewDaoCustom
{
  public abstract Page<News> findAll(String paramString1, Integer paramInteger, String paramString2, String paramString3, Pageable paramPageable);

  public abstract List<News> findAll(String paramString1, Integer paramInteger1, String paramString2, Integer paramInteger2, Integer paramInteger3);

  public abstract void audNews(String paramString1, String paramString2);
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.INewDaoCustom
 * JD-Core Version:    0.6.1
 */