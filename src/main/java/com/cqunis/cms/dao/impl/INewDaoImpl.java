/*     */ package com.cqunis.cms.dao.impl;
/*     */ 
/*     */ import com.cqunis.cms.dao.INewDaoCustom;
/*     */ import com.cqunis.cms.entity.News;
/*     */ import java.util.List;
/*     */ import javax.persistence.EntityManager;
/*     */ import javax.persistence.FlushModeType;
/*     */ import javax.persistence.PersistenceContext;
/*     */ import javax.persistence.Query;
/*     */ import javax.persistence.TypedQuery;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.PageImpl;
/*     */ import org.springframework.data.domain.Pageable;
/*     */ 
/*     */ public class INewDaoImpl
/*     */   implements INewDaoCustom
/*     */ {
/*     */ 
/*     */   @Autowired
/*     */   @PersistenceContext
/*     */   private EntityManager entityManager;
/*     */ 
/*     */   public List<News> findAll(String sectionId, Integer state, String entCode, Integer firstNum, Integer maxSize)
/*     */   {
/*  53 */     StringBuffer tempSql = new StringBuffer(50);
/*  54 */     tempSql.append("SELECT nw\n  FROM News nw\n WHERE nw.entCode = :entCode\n AND nw.state = 1\n");
/*     */ 
/*  58 */     tempSql.append(" and exists (select 1 from NewSection ns where ns.newtype=:state and nw.entCode = ns.entCode and ns.id=nw.newSection.id)");
/*  59 */     if ((null != sectionId) && 
/*  60 */       (sectionId
/*  60 */       .trim().length() > 0)) {
/*  61 */       tempSql.append("\tand nw.newSection.id = :sectionId");
/*     */     }
/*  63 */     tempSql.append(" order by nw.releaseDate desc");
/*  64 */     Query query = this.entityManager.createQuery(tempSql.toString(), News.class).setFlushMode(FlushModeType.COMMIT);
/*  65 */     query.setParameter("entCode", entCode);
/*  66 */     query.setParameter("state", state);
/*  67 */     if ((null != sectionId) && 
/*  68 */       (sectionId
/*  68 */       .trim().length() > 0)) {
/*  69 */       query.setParameter("sectionId", sectionId);
/*     */     }
/*  71 */     query.setFirstResult(firstNum.intValue());
/*  72 */     query.setMaxResults(maxSize.intValue());
/*  73 */     return query.getResultList();
/*     */   }
/*     */ 
/*     */   public Page<News> findAll(String searchText, Integer newtype, String sectionId, String entCode, Pageable pageable)
/*     */   {
/*  81 */     StringBuffer tempSql = new StringBuffer(50);
/*  82 */     tempSql.append("SELECT nw\n  FROM News nw\n WHERE nw.entCode = :entCode\n");
/*     */ 
/*  85 */     if ((null != searchText) && 
/*  86 */       (searchText
/*  86 */       .trim().length() > 0)) {
/*  87 */       tempSql.append("   AND nw.\n title LIKE '%" + searchText + "%'\n");
/*     */     }
/*     */ 
/*  90 */     tempSql.append(" and exists (select 1 from NewSection ns where ns.newtype=:state and nw.entCode = ns.entCode and ns.id=nw.newSection.id)");
/*  91 */     if ((null != sectionId) && 
/*  92 */       (sectionId
/*  92 */       .trim().length() > 0) && 
/*  93 */       (!sectionId
/*  93 */       .equals("-1")))
/*     */     {
/*  94 */       tempSql.append(" AND nw.newSection.id = :sectionId");
/*     */     }
/*  96 */     tempSql.append(" order by nw.releaseDate desc");
/*  97 */     Query query = this.entityManager.createQuery(tempSql.toString(), News.class).setFlushMode(FlushModeType.COMMIT);
/*  98 */     query.setParameter("entCode", entCode);
/*  99 */     query.setParameter("state", newtype);
/* 100 */     if ((null != sectionId) && 
/* 101 */       (sectionId
/* 101 */       .trim().length() > 0) && 
/* 102 */       (!sectionId
/* 102 */       .equals("-1")))
/*     */     {
/* 103 */       query.setParameter("sectionId", sectionId);
/*     */     }
/* 105 */     query.setFirstResult(pageable.getOffset());
/* 106 */     long count = count(searchText, newtype, sectionId, entCode);
/* 107 */     query.setMaxResults(pageable.getPageSize());
/* 108 */     return new PageImpl(query.getResultList(), pageable, count);
/*     */   }
/*     */ 
/*     */   private long count(String searchText, Integer state, String sectionId, String entCode)
/*     */   {
/* 127 */     StringBuffer tempSql = new StringBuffer(50);
/* 128 */     tempSql.append("SELECT count(1)\n  FROM News nw\n WHERE nw.entCode = :entCode\n");
/*     */ 
/* 131 */     if ((null != searchText) && 
/* 132 */       (searchText
/* 132 */       .trim().length() > 0)) {
/* 133 */       tempSql.append("   AND nw.\n title LIKE '%" + searchText + "%'\n");
/*     */     }
/*     */ 
/* 136 */     tempSql.append(" and exists (select 1 from NewSection ns where ns.newtype=:state and nw.entCode = ns.entCode and ns.id=nw.newSection.id)");
/* 137 */     if ((null != sectionId) && 
/* 138 */       (sectionId
/* 138 */       .trim().length() > 0) && 
/* 139 */       (!sectionId
/* 139 */       .equals("-1")))
/*     */     {
/* 140 */       tempSql.append(" AND nw.newSection.id = :sectionId");
/*     */     }
/* 142 */     Query query = this.entityManager.createQuery(tempSql.toString(), Object.class).setFlushMode(FlushModeType.COMMIT);
/* 143 */     query.setParameter("entCode", entCode);
/* 144 */     query.setParameter("state", state);
/* 145 */     if ((null != sectionId) && 
/* 146 */       (sectionId
/* 146 */       .trim().length() > 0) && 
/* 147 */       (!sectionId
/* 147 */       .equals("-1")))
/*     */     {
/* 148 */       query.setParameter("sectionId", sectionId);
/*     */     }
/* 150 */     return Long.parseLong(query.getSingleResult().toString());
/*     */   }
/*     */ 
/*     */   public void audNews(String id, String entCode)
/*     */   {
/* 157 */     StringBuffer tempSql = new StringBuffer(50);
/* 158 */     tempSql.append("UPDATE\n  News\nSET\n  state = 1\nWHERE id = :id\n  AND entCode = :entCode");
/*     */ 
/* 164 */     Query query = this.entityManager.createQuery(tempSql.toString()).setFlushMode(FlushModeType.COMMIT);
/* 165 */     query.setParameter("id", id);
/* 166 */     query.setParameter("entCode", entCode);
/* 167 */     query.executeUpdate();
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.dao.impl.INewDaoImpl
 * JD-Core Version:    0.6.1
 */