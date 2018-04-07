/*     */ package com.cqunis.cms.controller.web;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Date;
/*     */ import java.util.HashMap;
/*     */ import java.util.List;
/*     */ import java.util.Map;

/*     */ import javax.annotation.Resource;

/*     */ import org.apache.commons.lang3.StringUtils;
/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.Sort;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.ModelMap;
/*     */ import org.springframework.web.bind.annotation.PathVariable;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;

/*     */ 
/*     */ import com.cqunis.cms.entity.NewSection;
/*     */ import com.cqunis.cms.entity.News;
/*     */ import com.cqunis.cms.service.INewSectionService;
/*     */ import com.cqunis.cms.service.INewService;
/*     */ import com.cqunis.cms.service.IReplyService;
/*     */ import com.cqunis.common.JsonResult;
/*     */ import com.cqunis.controller.BaseController;
/*     */ import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator;
/*     */ 
/*     */ @Controller("webNewsController")
/*     */ @RequestMapping({"/web"})
/*     */ public class WebIndexController extends BaseController
/*     */ {
/*     */ 
/*     */   @Resource(name="newServiceImpl")
/*     */   INewService newService;
/*     */ 
/*     */   @Resource(name="newSectionService")
/*     */   INewSectionService newSectionService;
/*     */ 
/*     */   @Resource(name="replyServiceImpl")
/*     */   IReplyService replyService;
/*     */ 
/*     */   @RequestMapping({"/index"})
/*     */   @ResponseBody
/*     */   public JsonResult index()
/*     */   {
/*  74 */     Map responseMap = new HashMap();
/*     */     try {
/*  76 */       SimpleDateFormat starttimesdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
/*  77 */       SimpleDateFormat endtimesdf = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
/*  78 */       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
/*  79 */       List sections = this.newSectionService.findAll();
/*  80 */       if ((null != sections) && 
/*  81 */         (sections
/*  81 */         .size() > 0)) {
/*  82 */         String sectionId = ((NewSection)sections.get(0)).getId();
/*  83 */         responseMap.put("sections", sections);
/*  84 */         List newsList = this.newService.findAll(sectionId, Integer.valueOf(0), this.entCode, Integer.valueOf(0), Integer.valueOf(6));
/*  85 */         responseMap.put("newsList", newsList);
/*     */       }
/*  87 */       List notice = this.newService.findAll("", Integer.valueOf(1), this.entCode, Integer.valueOf(0), Integer.valueOf(1));
/*  88 */       if ((null != notice) && 
/*  89 */         (notice
/*  89 */         .size() > 0)) {
/*  90 */         responseMap.put("notice", notice.get(0));
/*     */       }
/*  92 */       SimpleSpecificationBuilder builderNews = new SimpleSpecificationBuilder();
/*  93 */       String starttime = starttimesdf.format(new Date());
/*  94 */       String endtime = endtimesdf.format(new Date());
/*     */ 
/*  96 */       if ((StringUtils.isNotBlank(starttime)) && 
/*  97 */         (StringUtils.isNotBlank(endtime)))
/*     */       {
/*  98 */         Date[] args = { starttimesdf.parse(starttime), sdf.parse(endtime) };
/*  99 */         builderNews.add("releaseDate", SpecificationOperator.Operator.between.name(), args);
/*     */       }
/* 101 */       builderNews.add("state", SpecificationOperator.Operator.eq.name(), Integer.valueOf(1));
/* 102 */       builderNews.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 103 */       Sort sort = new Sort(new Sort.Order[] { new Sort.Order(Sort.Direction.DESC, "releaseDate") });
/* 104 */       List twfourNews = this.newService.findList(builderNews.generateSpecification(), sort);
/* 105 */       if ((null != twfourNews) && 
/* 106 */         (twfourNews
/* 106 */         .size() > 0)) {
/* 107 */         responseMap.put("twfourNews", twfourNews);
/*     */       }
/* 109 */       return JsonResult.success(responseMap);
/*     */     } catch (Exception e) {
/* 111 */       e.printStackTrace();
/* 112 */       return JsonResult.failure(-1, e.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/section/{sectionId}"})
/*     */   @ResponseBody
/*     */   public JsonResult section(@PathVariable String sectionId)
/*     */   {
/* 128 */     Map responseMap = new HashMap();
/*     */     try {
/* 130 */       List newsList = this.newService.findAll(sectionId, Integer.valueOf(0), this.entCode, Integer.valueOf(0), Integer.valueOf(6));
/* 131 */       responseMap.put("newsList", newsList);
/* 132 */       return JsonResult.success(responseMap);
/*     */     } catch (Exception e) {
/* 134 */       e.printStackTrace();
/* 135 */       return JsonResult.failure(-1, e.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/list/{sectionId}"})
/*     */   @ResponseBody
/*     */   public Page<News> list(@PathVariable String sectionId)
/*     */   {
/* 152 */     Page page = null;
/*     */     try {
/* 154 */       SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/* 155 */       String searchText = this.request.getParameter("searchText");
/* 156 */       if (StringUtils.isNotBlank(searchText)) {
/* 157 */         builder.add("title", SpecificationOperator.Operator.likeAll.name(), searchText);
/*     */       }
/* 159 */       builder.add("newSection", SpecificationOperator.Operator.eq.name(), this.newSectionService.find(sectionId));
/* 160 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 161 */       return this.newService.findAll(builder.generateSpecification(), getPageRequest());
/*     */     } catch (Exception e) {
/* 163 */       e.printStackTrace();
/*     */     }
/* 165 */     return page;
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/detail/{id}"})
/*     */   @ResponseBody
/*     */   public JsonResult detail(@PathVariable String id, ModelMap map)
/*     */   {
/* 182 */     Map responseMap = new HashMap();
/*     */     try
/*     */     {
/* 185 */       if ((null != id) && 
/* 186 */         (id
/* 186 */         .trim().length() > 0)) {
/* 187 */         News newObj = (News)this.newService.find(id);
/* 188 */         String content = newObj.getContent();
/* 189 */         responseMap.put("content", content);
/* 190 */         responseMap.put("new", newObj);
/* 191 */         SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/* 192 */         builder.add("newsId", SpecificationOperator.Operator.eq.name(), id);
/* 193 */         builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 194 */         Sort sort = new Sort(new Sort.Order[] { new Sort.Order(Sort.Direction.ASC, "createDate") });
/* 195 */         List replys = this.replyService.findList(builder.generateSpecification(), sort);
/* 196 */         if ((null != replys) && 
/* 197 */           (replys
/* 197 */           .size() > 0)) {
/* 198 */           Integer replysize = Integer.valueOf(replys.size());
/* 199 */           responseMap.put("replys", replys);
/* 200 */           responseMap.put("replysize", replysize);
/*     */         }
/*     */       }
/* 203 */       return JsonResult.success(responseMap);
/*     */     } catch (Exception e) {
/* 205 */       e.printStackTrace();
/* 206 */       return JsonResult.failure(e.getMessage());
/*     */     }
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.web.WebIndexController
 * JD-Core Version:    0.6.1
 */