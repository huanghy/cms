/*    */ package com.cqunis.cms.service.impl;
/*    */ 
/*    */ import com.cqunis.cms.dao.INewsAnnexDao;
/*    */ import com.cqunis.cms.entity.NewsAnnex;
/*    */ import com.cqunis.cms.service.INewsAnnexService;
/*    */ import com.cqunis.dao.support.IBaseDao;
/*    */ import com.cqunis.service.support.impl.BaseServiceImpl;
/*    */ import javax.annotation.Resource;
/*    */ import org.springframework.stereotype.Service;
/*    */ 
/*    */ @Service("newsAnnexServiceImpl")
/*    */ public class NewsAnnexServiceImpl extends BaseServiceImpl<NewsAnnex, String>
/*    */   implements INewsAnnexService
/*    */ {
/*    */ 
/*    */   @Resource(name="newsAnnexDaoImpl")
/*    */   INewsAnnexDao newsAnnexDao;
/*    */ 
/*    */   public IBaseDao<NewsAnnex, String> getBaseDao()
/*    */   {
/* 41 */     return this.newsAnnexDao;
/*    */   }
/*    */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.impl.NewsAnnexServiceImpl
 * JD-Core Version:    0.6.1
 */