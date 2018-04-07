/*    */ package com.cqunis.cms.entity;
/*    */ 
/*    */ import com.cqunis.entity.support.BaseEntity;
/*    */ import javax.persistence.Column;
/*    */ import javax.persistence.Entity;
/*    */ import javax.persistence.FetchType;
/*    */ import javax.persistence.JoinColumn;
/*    */ import javax.persistence.ManyToOne;
/*    */ import javax.persistence.NamedQuery;
/*    */ import javax.persistence.Table;
/*    */ 
/*    */ @Entity
/*    */ @Table(name="cqunis_oa_new_section")
/*    */ @NamedQuery(name="NewSection.findAll", query="SELECT f FROM NewSection f")
/*    */ public class NewSection extends BaseEntity
/*    */ {
/*    */   private static final long serialVersionUID = 1L;
/*    */ 
/*    */   @Column(name="sec_name")
/*    */   private String secName;
/*    */ 
/*    */   @ManyToOne(fetch=FetchType.LAZY)
/*    */   @JoinColumn(name="parent_id")
/*    */   private NewSection parent;
/*    */   private String sort;
/*    */ 
/*    */   @Column(name="new_type")
/*    */   private Integer newtype;
/*    */ 
/*    */   @Column(name="unit_id")
/*    */   private String unitId;
/*    */ 
/*    */   public String getSecName()
/*    */   {
/* 47 */     return this.secName;
/*    */   }
/*    */ 
/*    */   public void setSecName(String secName) {
/* 51 */     this.secName = secName;
/*    */   }
/*    */ 
/*    */   public String getSort() {
/* 55 */     return this.sort;
/*    */   }
/*    */ 
/*    */   public void setSort(String sort) {
/* 59 */     this.sort = sort;
/*    */   }
/*    */ 
/*    */   public NewSection getParent() {
/* 63 */     return this.parent;
/*    */   }
/*    */ 
/*    */   public void setParent(NewSection parent) {
/* 67 */     this.parent = parent;
/*    */   }
/*    */ 
/*    */   public String getUnitId() {
/* 71 */     return this.unitId;
/*    */   }
/*    */ 
/*    */   public void setUnitId(String unitId) {
/* 75 */     this.unitId = unitId;
/*    */   }
/*    */ 
/*    */   public Integer getNewtype()
/*    */   {
/* 82 */     return this.newtype;
/*    */   }
/*    */ 
/*    */   public void setNewtype(Integer newtype)
/*    */   {
/* 89 */     this.newtype = newtype;
/*    */   }
/*    */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.entity.NewSection
 * JD-Core Version:    0.6.1
 */