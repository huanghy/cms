/*     */ package com.cqunis.cms.service.impl;
/*     */ import java.lang.reflect.InvocationTargetException;
/*     */ import java.util.HashMap;
/*     */ import java.util.LinkedList;
/*     */ import java.util.List;
/*     */ import java.util.Map;

/*     */ import javax.annotation.Resource;
/*     */ import javax.persistence.EntityManager;
/*     */ import javax.persistence.FlushModeType;
/*     */ import javax.persistence.PersistenceContext;
/*     */ import javax.persistence.Query;

/*     */ import org.apache.commons.beanutils.BeanUtils;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.cache.annotation.CacheEvict;
/*     */ import org.springframework.data.domain.Sort;
/*     */ import org.springframework.stereotype.Service;

/*     */ 
/*     */ import com.cqunis.cms.dao.INewSectionDao;
/*     */ import com.cqunis.cms.entity.NewSection;
/*     */ import com.cqunis.cms.service.INewSectionService;
/*     */ import com.cqunis.dao.support.IBaseDao;
/*     */ import com.cqunis.entity.Unit;
/*     */ import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator;
/*     */ import com.cqunis.service.support.impl.BaseServiceImpl;
/*     */ 
/*     */ @Service("newSectionService")
/*     */ public class NewSectionServiceImpl extends BaseServiceImpl<NewSection, String>
/*     */   implements INewSectionService
/*     */ {
/*     */ 
/*     */   @Resource(name="newSectionDao")
/*     */   private INewSectionDao newSectionDao;
/*     */ 
/*     */   @Autowired
/*     */   @PersistenceContext
/*     */   private EntityManager entityManager;
/*     */ 
/*     */   public IBaseDao<NewSection, String> getBaseDao()
/*     */   {
/*  49 */     return this.newSectionDao;
/*     */   }
/*     */ 
/*     */   @CacheEvict({"resourceCache"})
/*     */   public void saveOrUpdate(NewSection obj)
/*     */   {
/*  55 */     if (obj.getId() != null) {
/*  56 */       NewSection obj1 = (NewSection)find(obj.getId());
/*     */       try {
/*  58 */         BeanUtils.copyProperties(obj1, obj);
/*  59 */         update(obj1);
/*     */       } catch (IllegalAccessException|InvocationTargetException e) {
/*  61 */         e.printStackTrace();
/*     */       }
/*     */     } else {
/*  64 */       save(obj);
/*     */     }
/*     */   }
/*     */ 
/*     */   public List<Map<String, Object>> getNewSectionTree(String newsId, List<Unit> currentUnits, Integer newtype, String entCode)
/*     */   {
/*     */     try {
/*  71 */       Sort.Order order = new Sort.Order(Sort.Direction.ASC, "sort");
/*  72 */       Sort sort = new Sort(new Sort.Order[] { order });
/*  73 */       SimpleSpecificationBuilder<NewSection> builder = new SimpleSpecificationBuilder<NewSection>();
/*  74 */       if ((newsId != null) && (!"".equals(newsId))) {
/*  75 */         builder.add("id", SpecificationOperator.Operator.eq.name(), newsId);
/*     */       }
/*  77 */       if ((null != currentUnits) && 
/*  78 */         (currentUnits
/*  78 */         .size() > 0)) {
/*  79 */         builder.add("unitId", SpecificationOperator.Operator.eq.name(), ((Unit)currentUnits.get(0)).getId());
/*  80 */         Integer unitSize = Integer.valueOf(currentUnits.size());
/*  81 */         if (unitSize.intValue() >= 1) {
/*  82 */           for (int unitIndex = 1; unitIndex < unitSize.intValue(); unitIndex++) {
/*  83 */             builder.addOr("unitId", SpecificationOperator.Operator.eq.name(), ((Unit)currentUnits.get(unitIndex)).getId());
/*     */           }
/*     */         }
/*     */       }
/*  87 */       builder.add("newtype", SpecificationOperator.Operator.eq.name(), newtype);
/*  88 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), entCode);
/*  89 */       List<NewSection> list = this.newSectionDao.findAll(builder.generateSpecification(), sort);
/*  90 */       if ((null != list) && (list.size() > 0)) {
/*  91 */         List nodes = new LinkedList();
/*  92 */         if ((newsId != null) && (!"".equals(newsId))) {
/*  93 */           NewSection newsection = (NewSection)list.get(0);
/*  94 */           String id = newsection.getId();
/*  95 */           Map nodeMap = new HashMap();
/*  96 */           nodeMap.put("id", id);
/*  97 */           nodeMap.put("text", newsection.getSecName());
/*  98 */           List childNodes = new LinkedList();
/*  99 */           builder = new SimpleSpecificationBuilder();
/* 100 */           builder.add("newtype", SpecificationOperator.Operator.eq.name(), newtype);
/* 101 */           if ((null != currentUnits) && 
/* 102 */             (currentUnits
/* 102 */             .size() > 0)) {
/* 103 */             builder.add("unitId", SpecificationOperator.Operator.eq.name(), ((Unit)currentUnits.get(0)).getId());
/* 104 */             Integer unitSize = Integer.valueOf(currentUnits.size());
/* 105 */             if (unitSize.intValue() >= 1) {
/* 106 */               for (int unitIndex = 1; unitIndex < unitSize.intValue(); unitIndex++) {
/* 107 */                 builder.addOr("unitId", SpecificationOperator.Operator.eq.name(), ((Unit)currentUnits.get(unitIndex)).getId());
/*     */               }
/*     */             }
/*     */           }
/* 111 */           builder.add("entCode", SpecificationOperator.Operator.eq.name(), entCode);
/* 112 */           List list1 = this.newSectionDao.findAll(builder.generateSpecification(), sort);
/* 113 */           childTree(id, list1, childNodes);
/* 114 */           if ((null != childNodes) && (childNodes.size() > 0)) {
/* 115 */             nodeMap.put("nodes", childNodes);
/*     */           }
/* 117 */           nodes.add(nodeMap);
/*     */         } else {
/* 119 */           for (NewSection newsection : list) {
/* 120 */             if (null == newsection.getParent()) {
/* 121 */               String id = newsection.getId();
/* 122 */               Map nodeMap = new HashMap();
/* 123 */               nodeMap.put("id", id);
/* 124 */               nodeMap.put("text", newsection.getSecName());
/* 125 */               List childNodes = new LinkedList();
/* 126 */               childTree(id, list, childNodes);
/* 127 */               if ((null != childNodes) && (childNodes.size() > 0)) {
/* 128 */                 nodeMap.put("nodes", childNodes);
/*     */               }
/* 130 */               nodes.add(nodeMap);
/*     */             }
/*     */           }
/*     */         }
/*     */ 
/* 135 */         return nodes;
/*     */       }
/*     */     } catch (Exception e) {
/* 138 */       e.printStackTrace();
/*     */     }
/*     */ 
/* 141 */     return null;
/*     */   }
/*     */ 
/*     */   private void childTree(String parentId, List<NewSection> list, List<Map<String, Object>> childNodes)
/*     */   {
/* 151 */     for (NewSection newsection : list)
/* 152 */       if ((newsection.getParent() != null) && (newsection.getParent().getId().equals(parentId))) {
/* 153 */         Map nodeMap = new HashMap();
/* 154 */         String id = newsection.getId();
/* 155 */         nodeMap.put("id", id);
/* 156 */         nodeMap.put("text", newsection.getSecName());
/* 157 */         List tNodes = new LinkedList();
/* 158 */         childTree(id, list, tNodes);
/* 159 */         if ((null != tNodes) && (tNodes.size() > 0)) {
/* 160 */           nodeMap.put("nodes", tNodes);
/*     */         }
/* 162 */         childNodes.add(nodeMap);
/*     */       }
/*     */   }
/*     */ 
/*     */   public List<NewSection> loadNewSection(String pId, Integer newtype, String unitIds, String entCode)
/*     */   {
/* 173 */     String sql = "from NewSection where entCode=:entCode and newtype = :newtype";
/* 174 */     sql = sql + " and unitId in (" + unitIds + ")";
/* 175 */     if ((pId != null) && (!"".equals(pId))) {
/* 176 */       sql = sql + " and parent.id=:pId";
/*     */     }
/* 178 */     sql = sql + " order by sort asc";
/* 179 */     Query query = this.entityManager.createQuery(sql).setFlushMode(FlushModeType.COMMIT);
/* 180 */     if ((pId != null) && (!"".equals(pId))) {
/* 181 */       query.setParameter("pId", pId);
/*     */     }
/* 183 */     query.setParameter("newtype", newtype);
/* 184 */     query.setParameter("entCode", entCode);
/* 185 */     List list = query.getResultList();
/* 186 */     return list;
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.impl.NewSectionServiceImpl
 * JD-Core Version:    0.6.1
 */