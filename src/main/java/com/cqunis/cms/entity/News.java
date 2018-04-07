/*     */ package com.cqunis.cms.entity;
/*     */ 
/*     */ import com.alibaba.fastjson.annotation.JSONField;
/*     */ import com.cqunis.entity.Department;
/*     */ import com.cqunis.entity.Unit;
/*     */ import com.cqunis.entity.support.BaseEntity;
/*     */ import java.util.Date;
/*     */ import javax.persistence.Column;
/*     */ import javax.persistence.Entity;
/*     */ import javax.persistence.FetchType;
/*     */ import javax.persistence.JoinColumn;
/*     */ import javax.persistence.ManyToOne;
/*     */ import javax.persistence.NamedQuery;
/*     */ import javax.persistence.Table;
/*     */ import javax.persistence.Temporal;
/*     */ import javax.persistence.TemporalType;
/*     */ import javax.persistence.Transient;
/*     */ 
/*     */ @Entity
/*     */ @Table(name="cqunis_oa_news")
/*     */ @NamedQuery(name="News.findAll", query="SELECT n FROM News n")
/*     */ public class News extends BaseEntity
/*     */ {
/*     */   private static final long serialVersionUID = 1L;
/*     */ 
/*     */   @Column(name="bro_count")
/*     */   private int broCount;
/*     */ 
/*     */   @JSONField(serialize=false)
/*     */   private String content;
/*     */   private String title;
/*     */ 
/*     */   @ManyToOne(fetch=FetchType.LAZY)
/*     */   @JoinColumn(name="department_id")
/*     */   private Department department;
/*     */ 
/*     */   @Transient
/*     */   private String departmentName;
/*     */ 
/*     */   @Transient
/*     */   private String attState;
/*     */ 
/*     */   @Transient
/*     */   private String readState;
/*     */ 
/*     */   @Column(name="human_id", length=50)
/*     */   private String humanId;
/*     */ 
/*     */   @Column(name="image_path", length=50)
/*     */   private String imagePath;
/*     */ 
/*     */   @JSONField(format="yyyy-MM-dd HH:mm:ss")
/*     */   @Temporal(TemporalType.TIMESTAMP)
/*     */   @Column(name="release_date", nullable=false)
/*     */   private Date releaseDate;
/*     */ 
/*     */   @ManyToOne(fetch=FetchType.LAZY)
/*     */   @JoinColumn(name="section_id")
/*     */   private NewSection newSection;
/*     */   private int state;
/*     */ 
/*     */   @ManyToOne(fetch=FetchType.LAZY)
/*     */   @JoinColumn(name="unit_id")
/*     */   private Unit unit;
/*     */ 
/*     */   public News()
/*     */   {
/*     */   }
/*     */ 
/*     */   public News(String id, String title, String imagePath, Date releaseDate, String departmentName)
/*     */   {
/*  97 */     super.setId(id);
/*  98 */     this.title = title;
/*  99 */     if (null != imagePath) {
/* 100 */       this.imagePath = imagePath;
/*     */     }
/* 102 */     this.releaseDate = releaseDate;
/* 103 */     this.departmentName = departmentName;
/*     */   }
/*     */ 
/*     */   public News(String id, String title, String imagePath, Date releaseDate, String departmentName, long attState, long readState)
/*     */   {
/*     */     try
/*     */     {
/* 118 */       super.setId(id);
/* 119 */       this.title = title;
/* 120 */       if (null != imagePath) {
/* 121 */         this.imagePath = imagePath;
/*     */       }
/* 123 */       this.releaseDate = releaseDate;
/* 124 */       this.departmentName = departmentName;
/* 125 */       this.attState = String.valueOf(attState);
/* 126 */       this.readState = String.valueOf(readState);
/*     */     } catch (Exception e) {
/* 128 */       e.printStackTrace();
/*     */     }
/*     */   }
/*     */ 
/*     */   public int getBroCount() {
/* 133 */     return this.broCount;
/*     */   }
/*     */ 
/*     */   public void setBroCount(int broCount) {
/* 137 */     this.broCount = broCount;
/*     */   }
/*     */ 
/*     */   public String getContent() {
/* 141 */     return this.content;
/*     */   }
/*     */ 
/*     */   public void setContent(String content) {
/* 145 */     this.content = content;
/*     */   }
/*     */ 
/*     */   public String getHumanId() {
/* 149 */     return this.humanId;
/*     */   }
/*     */ 
/*     */   public void setHumanId(String humanId) {
/* 153 */     this.humanId = humanId;
/*     */   }
/*     */ 
/*     */   public String getImagePath() {
/* 157 */     return this.imagePath;
/*     */   }
/*     */ 
/*     */   public void setImagePath(String imagePath) {
/* 161 */     this.imagePath = imagePath;
/*     */   }
/*     */ 
/*     */   public Date getReleaseDate() {
/* 165 */     return this.releaseDate;
/*     */   }
/*     */ 
/*     */   public void setReleaseDate(Date releaseDate) {
/* 169 */     this.releaseDate = releaseDate;
/*     */   }
/*     */ 
/*     */   public int getState() {
/* 173 */     return this.state;
/*     */   }
/*     */ 
/*     */   public void setState(int state) {
/* 177 */     this.state = state;
/*     */   }
/*     */ 
/*     */   public Department getDepartment()
/*     */   {
/* 184 */     return this.department;
/*     */   }
/*     */ 
/*     */   public void setDepartment(Department department)
/*     */   {
/* 191 */     this.department = department;
/*     */   }
/*     */ 
/*     */   public Unit getUnit()
/*     */   {
/* 198 */     return this.unit;
/*     */   }
/*     */ 
/*     */   public void setUnit(Unit unit)
/*     */   {
/* 205 */     this.unit = unit;
/*     */   }
/*     */ 
/*     */   public String getTitle()
/*     */   {
/* 212 */     return this.title;
/*     */   }
/*     */ 
/*     */   public void setTitle(String title)
/*     */   {
/* 219 */     this.title = title;
/*     */   }
/*     */ 
/*     */   public NewSection getNewSection()
/*     */   {
/* 226 */     return this.newSection;
/*     */   }
/*     */ 
/*     */   public void setNewSection(NewSection newSection)
/*     */   {
/* 233 */     this.newSection = newSection;
/*     */   }
/*     */ 
/*     */   public String getDepartmentName()
/*     */   {
/* 241 */     return this.departmentName;
/*     */   }
/*     */ 
/*     */   public void setDepartmentName(String departmentName)
/*     */   {
/* 249 */     this.departmentName = departmentName;
/*     */   }
/*     */ 
/*     */   public String getAttState()
/*     */   {
/* 257 */     return this.attState;
/*     */   }
/*     */ 
/*     */   public void setAttState(String attState)
/*     */   {
/* 265 */     this.attState = attState;
/*     */   }
/*     */ 
/*     */   public String getReadState()
/*     */   {
/* 273 */     return this.readState;
/*     */   }
/*     */ 
/*     */   public void setReadState(String readState)
/*     */   {
/* 281 */     this.readState = readState;
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.entity.News
 * JD-Core Version:    0.6.1
 */