/*     */ package com.cqunis.cms.service.impl;
/*     */ import java.util.List;

/*     */ import javax.annotation.Resource;

/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.Pageable;
/*     */ import org.springframework.stereotype.Service;
/*     */ import org.springframework.transaction.annotation.Transactional;

/*     */ 
/*     */ import com.cqunis.cms.dao.INewDao;
/*     */ import com.cqunis.cms.dao.INewsAnnexDao;
/*     */ import com.cqunis.cms.entity.News;
/*     */ import com.cqunis.cms.entity.NewsAnnex;
/*     */ import com.cqunis.cms.service.INewService;
/*     */ import com.cqunis.common.exception.UserBusinessException;
/*     */ import com.cqunis.dao.support.IBaseDao;
/*     */ import com.cqunis.service.support.impl.BaseServiceImpl;
/*     */ 
/*     */ @Service("newServiceImpl")
/*     */ public class NewServiceImpl extends BaseServiceImpl<News, String>
/*     */   implements INewService
/*     */ {
/*     */ 
/*     */   @Resource(name="newDaoImpl")
/*     */   INewDao newDao;
/*     */ 
/*     */   @Resource(name="newsAnnexDaoImpl")
/*     */   INewsAnnexDao newsAnnexDao;
/*     */ 
/*     */   public IBaseDao<News, String> getBaseDao()
/*     */   {
/*  49 */     return this.newDao;
/*     */   }
/*     */ 
/*     */   @Transactional(rollbackFor={UserBusinessException.class})
/*     */   public void audNews(String id, String entCode) throws UserBusinessException
/*     */   {
/*     */     try
/*     */     {
/*  57 */       this.newDao.audNews(id, entCode);
/*     */     } catch (Exception e) {
/*  59 */       e.printStackTrace();
/*  60 */       throw new UserBusinessException(e.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   @Transactional(rollbackFor={UserBusinessException.class})
/*     */   public void editNews(News news, List<NewsAnnex> newsAnnexs, String entCode)
/*     */     throws UserBusinessException
/*     */   {
/*     */     try
/*     */     {
/*  80 */       if ((null != news.getId()) && 
/*  81 */         (news
/*  81 */         .getId().trim().length() > 0))
/*     */       {
/*  83 */         String newsspec = " newsId='" + news.getId() + "'";
/*  84 */         this.newsAnnexDao.del(NewsAnnex.class.getName(), newsspec, entCode);
/*  85 */         this.newDao.saveAndFlush(news);
/*     */       } else {
/*  87 */         this.newDao.save(news);
/*     */       }
/*  89 */       String newsId = news.getId();
/*     */ 
/*  91 */       if ((null != newsAnnexs) && 
/*  92 */         (newsAnnexs
/*  92 */         .size() > 0))
/*  93 */         for (NewsAnnex newsAnnex : newsAnnexs) {
/*  94 */           newsAnnex.setNewsId(newsId);
/*  95 */           this.newsAnnexDao.save(newsAnnex);
/*     */         }
/*     */     }
/*     */     catch (Exception e)
/*     */     {
/*  99 */       e.printStackTrace();
/* 100 */       throw new UserBusinessException(e.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   @Transactional(rollbackFor={UserBusinessException.class})
/*     */   public Page<News> findAll(String searchText, Integer newtype, String sectionId, String entCode, Pageable pageable)
/*     */   {
/* 122 */     return this.newDao.findAll(searchText, newtype, sectionId, entCode, pageable);
/*     */   }
/*     */ 
/*     */   public Long searchNewsCount(String sectionId, String entCode)
/*     */   {
/* 129 */     return this.newDao.searchNewsCount(sectionId, entCode);
/*     */   }
/*     */ 
/*     */   public List<News> findAll(String sectionId, Integer state, String entCode, Integer firstNum, Integer maxSize)
/*     */   {
/* 145 */     return this.newDao.findAll(sectionId, state, entCode, firstNum, maxSize);
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.impl.NewServiceImpl
 * JD-Core Version:    0.6.1
 */