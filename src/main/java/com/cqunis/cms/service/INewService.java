package com.cqunis.cms.service;

import com.cqunis.cms.entity.News;
import com.cqunis.cms.entity.NewsAnnex;
import com.cqunis.common.exception.UserBusinessException;
import com.cqunis.service.support.IBaseService;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public abstract interface INewService extends IBaseService<News, String>
{
  public abstract void editNews(News paramNews, List<NewsAnnex> paramList, String paramString)
    throws UserBusinessException;

  public abstract void audNews(String paramString1, String paramString2)
    throws UserBusinessException;

  public abstract Page<News> findAll(String paramString1, Integer paramInteger, String paramString2, String paramString3, Pageable paramPageable);

  public abstract Long searchNewsCount(String paramString1, String paramString2);

  public abstract List<News> findAll(String paramString1, Integer paramInteger1, String paramString2, Integer paramInteger2, Integer paramInteger3);
}

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.INewService
 * JD-Core Version:    0.6.1
 */