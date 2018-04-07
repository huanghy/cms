/*     */ package com.cqunis.cms.entity;
/*     */ 
/*     */ import com.cqunis.entity.support.BaseEntity;
/*     */ import java.sql.Timestamp;
/*     */ import javax.persistence.Column;
/*     */ import javax.persistence.Entity;
/*     */ import javax.persistence.Lob;
/*     */ import javax.persistence.NamedQuery;
/*     */ import javax.persistence.Table;
/*     */ 
/*     */ @Entity
/*     */ @Table(name="cqunis_oa_reply")
/*     */ @NamedQuery(name="Reply.findAll", query="SELECT r FROM Reply r")
/*     */ public class Reply extends BaseEntity
/*     */ {
/*     */   private static final long serialVersionUID = 1L;
/*     */ 
/*     */   @Column(name="bro_count")
/*     */   private int broCount;
/*     */ 
/*     */   @Lob
/*     */   private String content;
/*     */ 
/*     */   @Column(name="human_id")
/*     */   private String humanId;
/*     */ 
/*     */   @Column(name="news_id")
/*     */   private String newsId;
/*     */ 
/*     */   @Column(name="release_date")
/*     */   private Timestamp releaseDate;
/*     */   private int state;
/*     */   private String title;
/*     */ 
/*     */   public int getBroCount()
/*     */   {
/*  50 */     return this.broCount;
/*     */   }
/*     */ 
/*     */   public void setBroCount(int broCount) {
/*  54 */     this.broCount = broCount;
/*     */   }
/*     */ 
/*     */   public String getContent() {
/*  58 */     return this.content;
/*     */   }
/*     */ 
/*     */   public void setContent(String content) {
/*  62 */     this.content = content;
/*     */   }
/*     */ 
/*     */   public String getHumanId() {
/*  66 */     return this.humanId;
/*     */   }
/*     */ 
/*     */   public void setHumanId(String humanId) {
/*  70 */     this.humanId = humanId;
/*     */   }
/*     */ 
/*     */   public String getNewsId() {
/*  74 */     return this.newsId;
/*     */   }
/*     */ 
/*     */   public void setNewsId(String newsId) {
/*  78 */     this.newsId = newsId;
/*     */   }
/*     */ 
/*     */   public Timestamp getReleaseDate() {
/*  82 */     return this.releaseDate;
/*     */   }
/*     */ 
/*     */   public void setReleaseDate(Timestamp releaseDate) {
/*  86 */     this.releaseDate = releaseDate;
/*     */   }
/*     */ 
/*     */   public int getState() {
/*  90 */     return this.state;
/*     */   }
/*     */ 
/*     */   public void setState(int state) {
/*  94 */     this.state = state;
/*     */   }
/*     */ 
/*     */   public String getTitle() {
/*  98 */     return this.title;
/*     */   }
/*     */ 
/*     */   public void setTitle(String title) {
/* 102 */     this.title = title;
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.entity.Reply
 * JD-Core Version:    0.6.1
 */