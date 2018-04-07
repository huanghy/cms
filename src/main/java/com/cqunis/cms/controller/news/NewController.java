/*     */ package com.cqunis.cms.controller.news;
/*     */ import java.net.URLDecoder;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ import java.util.List;

/*     */ import javax.annotation.Resource;

/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.Sort;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.ModelMap;
/*     */ import org.springframework.web.bind.annotation.PathVariable;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;

/*     */ 
/*     */ import com.cqunis.cms.entity.NewSection;
/*     */ import com.cqunis.cms.entity.News;
/*     */ import com.cqunis.cms.entity.NewsAnnex;
/*     */ import com.cqunis.cms.service.INewSectionService;
/*     */ import com.cqunis.cms.service.INewService;
/*     */ import com.cqunis.cms.service.INewsAnnexService;
/*     */ import com.cqunis.cms.service.IReplyService;
/*     */ import com.cqunis.common.JsonResult;
/*     */ import com.cqunis.common.JsonUtils;
/*     */ import com.cqunis.controller.BaseController;
/*     */ import com.cqunis.service.IDepartmentService;
/*     */ import com.cqunis.service.IUnitService;
/*     */ import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator;
/*     */ 
/*     */ @Controller("newController")
/*     */ @RequestMapping({"/oa/new"})
/*     */ public class NewController extends BaseController
/*     */ {
/*     */ 
/*     */   @Resource(name="newServiceImpl")
/*     */   INewService newService;
/*     */ 
/*     */   @Resource(name="newsAnnexServiceImpl")
/*     */   INewsAnnexService newsAnnexService;
/*     */ 
/*     */   @Resource(name="newSectionService")
/*     */   INewSectionService newSectionService;
/*     */ 
/*     */   @Autowired
/*     */   IUnitService unitService;
/*     */ 
/*     */   @Autowired
/*     */   IDepartmentService departmentService;
/*     */ 
/*     */   @Resource(name="replyServiceImpl")
/*     */   IReplyService replyService;
/*     */ 
/*     */   @RequestMapping({"/edit/{newtype}"})
/*     */   public String edit(@PathVariable Integer newtype, @RequestParam(value="id", required=false) String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/*  94 */       super.initCurrentUser();
/*     */ 
/*  96 */       if ((null != id) && 
/*  97 */         (id
/*  97 */         .trim().length() > 0)) {
/*  98 */         News newObj = (News)this.newService.find(id);
/*     */ 
/* 100 */         List orders = new ArrayList();
/* 101 */         Sort.Order order = new Sort.Order(Sort.Direction.ASC, "sort");
/* 102 */         orders.add(order);
/* 103 */         Sort sort = new Sort(orders);
/* 104 */         SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/* 105 */         builder.add("newsId", SpecificationOperator.Operator.eq.name(), id);
/* 106 */         builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 107 */         List newsAnnexs = this.newsAnnexService.findList(builder.generateSpecification(), sort);
/* 108 */         if ((null != newsAnnexs) && 
/* 109 */           (newsAnnexs
/* 109 */           .size() > 0)) {
/* 110 */           map.put("newsAnnexs", newsAnnexs);
/* 111 */           map.put("newsAnnexJson", JsonUtils.objectToJsonStr(newsAnnexs));
/*     */         }
/*     */ 
/* 114 */         map.put("new", newObj);
/*     */       }
/*     */ 
/* 118 */       Sort sort = new Sort(new Sort.Order[] { new Sort.Order(Sort.Direction.ASC, "sort") });
/* 119 */       SimpleSpecificationBuilder sectionBuilder = new SimpleSpecificationBuilder();
/* 120 */       sectionBuilder.add("newtype", SpecificationOperator.Operator.eq.name(), newtype);
/* 121 */       sectionBuilder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 122 */       List newSections = this.newSectionService.findList(sectionBuilder.generateSpecification(), sort);
/* 123 */       if (null != newSections) {
/* 124 */         map.put("newSections", newSections);
/*     */       }
/* 126 */       map.put("newtype", newtype);
/* 127 */       map.put("currentUser", this.currentUser);
/*     */     } catch (Exception e) {
/* 129 */       e.printStackTrace();
/*     */     }
/* 131 */     return "oa/new/edit";
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/", "/index/{newtype}"})
/*     */   public String index(@PathVariable Integer newtype, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 147 */       super.initCurrentUser();
/* 148 */       map.put("currentUser", this.currentUser);
/* 149 */       map.put("currentUnits", this.currentUnits);
/* 150 */       map.put("newtype", newtype);
/*     */     } catch (Exception e) {
/* 152 */       e.printStackTrace();
/*     */     }
/* 154 */     return "oa/new/index";
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/list/{newtype}"})
/*     */   @ResponseBody
/*     */   public Page<News> list(@PathVariable Integer newtype)
/*     */   {
/* 166 */     Page page = null;
/*     */     try {
/* 168 */       super.initCurrentUser();
/* 169 */       String searchText = this.request.getParameter("searchText");
/* 170 */       page = this.newService.findAll(searchText, newtype, "-1", this.entCode, getPageRequest());
/*     */     } catch (Exception e) {
/* 172 */       e.printStackTrace();
/*     */     }
/* 174 */     return page;
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/edit_news"})
/*     */   @ResponseBody
/*     */   public JsonResult editNews(@RequestParam(value="id", required=false) String id, @RequestParam(value="content", required=false) String content, @RequestParam(value="title", required=false) String title, @RequestParam(value="imagePath", required=false) String imagePath, @RequestParam(value="unitId", required=false) String unitId, @RequestParam(value="departmentId", required=false) String departmentId, @RequestParam(value="sectionId", required=false) String sectionId, @RequestParam(value="newsAnnexJson", required=false) String newsAnnexJson, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 208 */       if ((null != sectionId) && 
/* 209 */         (sectionId
/* 209 */         .trim().length() > 0)) {
/* 210 */         NewSection newSection = (NewSection)this.newSectionService.find(sectionId);
/* 211 */         List newsAnnexs = null;
/* 212 */         if ((null != newsAnnexJson) && 
/* 213 */           (!newsAnnexJson
/* 213 */           .equalsIgnoreCase("%7B%7D")) && 
/* 214 */           (newsAnnexJson
/* 214 */           .trim().length() > 0)) {
/* 215 */           newsAnnexs = JsonUtils.strJsonToList(URLDecoder.decode(newsAnnexJson, "utf-8"), NewsAnnex.class);
/*     */         }
/* 217 */         News news = null;
/* 218 */         if ((null != id) && 
/* 219 */           (id
/* 219 */           .trim().length() > 0)) {
/* 220 */           news = (News)this.newService.find(id);
/* 221 */           news.setUnit(null);
/* 222 */           news.setDepartment(null);
/* 223 */           news.setNewSection(newSection);
/* 224 */           news.setContent(content);
/* 225 */           news.setTitle(title);
/* 226 */           news.setImagePath(imagePath);
/*     */         }
/*     */         else {
/* 229 */           super.initCurrentUser();
/* 230 */           news = new News();
/* 231 */           news.setHumanId(this.currentUser.getId());
/* 232 */           news.setUnit(null);
/* 233 */           news.setDepartment(null);
/* 234 */           news.setNewSection(newSection);
/* 235 */           news.setContent(content);
/* 236 */           news.setTitle(title);
/* 237 */           news.setImagePath(imagePath);
/* 238 */           news.setState(0);
/* 239 */           news.setReleaseDate(new Date());
/*     */         }
/* 241 */         this.newService.editNews(news, newsAnnexs, this.entCode);
/*     */       }
/*     */       else {
/* 244 */         return JsonResult.failure("请选择发布版块!");
/*     */       }
/*     */     } catch (Exception e) {
/* 247 */       e.printStackTrace();
/* 248 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 250 */     return JsonResult.success();
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/aud/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult audNews(@PathVariable String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 268 */       this.newService.audNews(id, this.entCode);
/*     */     } catch (Exception e) {
/* 270 */       e.printStackTrace();
/* 271 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 273 */     return JsonResult.success();
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/delete/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult delete(@PathVariable String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 291 */       SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/* 292 */       builder.add("newsId", SpecificationOperator.Operator.eq.name(), id);
/* 293 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 294 */       List newsAnnexs = this.newsAnnexService.findList(builder.generateSpecification(), null);
/* 295 */       if ((null != newsAnnexs) && 
/* 296 */         (newsAnnexs
/* 296 */         .size() > 0)) {
/* 297 */         this.newsAnnexService.delete(newsAnnexs);
/*     */       }
/* 299 */       SimpleSpecificationBuilder builderReply = new SimpleSpecificationBuilder();
/* 300 */       builderReply.add("newsId", SpecificationOperator.Operator.eq.name(), id);
/* 301 */       builderReply.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 302 */       List replys = this.replyService.findList(builderReply.generateSpecification(), null);
/* 303 */       if ((null != replys) && 
/* 304 */         (replys
/* 304 */         .size() > 0)) {
/* 305 */         this.replyService.delete(replys);
/*     */       }
/* 307 */       this.newService.delete(id);
/*     */     } catch (Exception e) {
/* 309 */       e.printStackTrace();
/* 310 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 312 */     return JsonResult.success();
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.news.NewController
 * JD-Core Version:    0.6.1
 */