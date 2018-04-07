/*     */ package com.cqunis.cms.entity;
/*     */ 
/*     */ import com.cqunis.entity.support.BaseEntity;
/*     */ import javax.persistence.Column;
/*     */ import javax.persistence.Entity;
/*     */ import javax.persistence.NamedQuery;
/*     */ import javax.persistence.Table;
/*     */ 
/*     */ @Entity
/*     */ @Table(name="cqunis_oa_news_annex")
/*     */ @NamedQuery(name="NewsAnnex.findAll", query="SELECT n FROM NewsAnnex n")
/*     */ public class NewsAnnex extends BaseEntity
/*     */ {
/*     */   private static final long serialVersionUID = 1L;
/*     */ 
/*     */   @Column(name="ch_name", length=30)
/*     */   private String chName;
/*     */ 
/*     */   @Column(name="file_path", length=50)
/*     */   private String filePath;
/*     */ 
/*     */   @Column(name="file_size", length=50)
/*     */   private String fileSize;
/*     */ 
/*     */   @Column(name="news_id", length=50)
/*     */   private String newsId;
/*     */   private int sort;
/*     */ 
/*     */   @Column(length=25)
/*     */   private String suffix;
/*     */ 
/*     */   @Column(name="path_name", length=50)
/*     */   private String pathName;
/*     */ 
/*     */   public String getChName()
/*     */   {
/*  46 */     return this.chName;
/*     */   }
/*     */ 
/*     */   public void setChName(String chName) {
/*  50 */     this.chName = chName;
/*     */   }
/*     */ 
/*     */   public String getFilePath() {
/*  54 */     return this.filePath;
/*     */   }
/*     */ 
/*     */   public void setFilePath(String filePath) {
/*  58 */     this.filePath = filePath;
/*     */   }
/*     */ 
/*     */   public String getNewsId() {
/*  62 */     return this.newsId;
/*     */   }
/*     */ 
/*     */   public void setNewsId(String newsId) {
/*  66 */     this.newsId = newsId;
/*     */   }
/*     */ 
/*     */   public int getSort() {
/*  70 */     return this.sort;
/*     */   }
/*     */ 
/*     */   public void setSort(int sort) {
/*  74 */     this.sort = sort;
/*     */   }
/*     */ 
/*     */   public String getSuffix() {
/*  78 */     return this.suffix;
/*     */   }
/*     */ 
/*     */   public void setSuffix(String suffix) {
/*  82 */     this.suffix = suffix;
/*     */   }
/*     */ 
/*     */   public String getPathName()
/*     */   {
/*  90 */     return this.pathName;
/*     */   }
/*     */ 
/*     */   public void setPathName(String pathName)
/*     */   {
/*  98 */     this.pathName = pathName;
/*     */   }
/*     */ 
/*     */   public String getFileSize()
/*     */   {
/* 106 */     return this.fileSize;
/*     */   }
/*     */ 
/*     */   public void setFileSize(String fileSize)
/*     */   {
/* 114 */     this.fileSize = fileSize;
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.entity.NewsAnnex
 * JD-Core Version:    0.6.1
 */