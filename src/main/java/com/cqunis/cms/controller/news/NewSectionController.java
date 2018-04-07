/*     */ package com.cqunis.cms.controller.news;
/*     */ import java.util.List;

/*     */ import javax.annotation.Resource;

/*     */ import org.apache.commons.lang3.StringUtils;
/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.PageRequest;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.ModelMap;
/*     */ import org.springframework.web.bind.annotation.PathVariable;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;

/*     */ 
/*     */ import com.cqunis.cms.entity.NewSection;
/*     */ import com.cqunis.cms.service.INewSectionService;
/*     */ import com.cqunis.cms.service.INewService;
/*     */ import com.cqunis.common.JsonResult;
/*     */ import com.cqunis.common.JsonUtils;
/*     */ import com.cqunis.controller.BaseController;
/*     */ import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator;
/*     */ 
/*     */ @Controller
/*     */ @RequestMapping({"/oa/newsection"})
/*     */ public class NewSectionController extends BaseController
/*     */ {
/*     */ 
/*     */   @Resource(name="newSectionService")
/*     */   private INewSectionService newSectionService;
/*     */ 
/*     */   @Resource(name="newServiceImpl")
/*     */   INewService newService;
/*     */ 
/*     */   @RequestMapping({"/index/{newtype}"})
/*     */   public String index(@PathVariable Integer newtype, ModelMap map)
/*     */   {
/*  47 */     map.put("newtype", newtype);
/*  48 */     return "oa/new/newsection/index";
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/list/{newtype}"})
/*     */   @ResponseBody
/*     */   public Page<NewSection> list(@PathVariable Integer newtype, ModelMap map)
/*     */   {
/*  58 */     Page page = null;
/*     */     try {
/*  60 */       SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/*  61 */       String searchText = this.request.getParameter("searchText");
/*  62 */       if (StringUtils.isNotBlank(searchText)) {
/*  63 */         builder.add("secName", SpecificationOperator.Operator.likeAll.name(), searchText);
/*     */       }
/*  65 */       builder.add("newtype", SpecificationOperator.Operator.eq.name(), newtype);
/*  66 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/*  67 */       map.put("newtype", newtype);
/*  68 */       PageRequest pageRequest = getPageRequest();
/*  69 */       page = this.newSectionService.findAll(builder.generateSpecification(), pageRequest);
/*     */     } catch (Exception e) {
/*  71 */       e.printStackTrace();
/*     */     }
/*  73 */     return page;
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/add/{newtype}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String add(@PathVariable Integer newtype, ModelMap map)
/*     */   {
/*  88 */     Integer sort = this.newSectionService.maxSort(NewSection.class.getName(), "1=1 and newtype=" + newtype + " ");
/*  89 */     sort = Integer.valueOf(sort.intValue() + 1);
/*     */     try {
/*  91 */       super.initCurrentUser();
/*  92 */       if ((null != this.currentUnits) && 
/*  93 */         (this.currentUnits
/*  93 */         .size() > 0)) {
/*  94 */         map.put("currentUnits", this.currentUnits);
/*     */       }
/*  96 */       map.put("sort", sort);
/*     */     } catch (Exception e) {
/*  98 */       e.printStackTrace();
/*     */     }
/* 100 */     return "oa/new/newsection/form";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/edit/{id}/{newtype}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String edit(@PathVariable String id, @PathVariable Integer newtype, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 117 */       NewSection obj = (NewSection)this.newSectionService.find(id);
/* 118 */       super.initCurrentUser();
/* 119 */       if ((null != this.currentUnits) && 
/* 120 */         (this.currentUnits
/* 120 */         .size() > 0)) {
/* 121 */         map.put("currentUnits", this.currentUnits);
/*     */       }
/* 123 */       map.put("newtype", newtype);
/* 124 */       map.put("obj", obj);
/*     */     } catch (Exception e) {
/* 126 */       e.printStackTrace();
/*     */     }
/* 128 */     return "oa/new/newsection/form";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/edit"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult edit(NewSection obj, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 145 */       if ((null == obj.getParent()) || 
/* 146 */         (null == obj
/* 146 */         .getParent().getId())) {
/* 147 */         obj.setParent(null);
/*     */       }
/* 149 */       this.newSectionService.saveOrUpdate(obj);
/*     */     } catch (Exception e) {
/* 151 */       e.printStackTrace();
/* 152 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 154 */     return JsonResult.success();
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/delete/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult delete(@PathVariable String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 171 */       SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/* 172 */       builder.add("parent", SpecificationOperator.Operator.eq.name(), this.newSectionService.find(id));
/* 173 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/* 174 */       long sectionCount = this.newSectionService.count(builder.generateSpecification());
/* 175 */       if (sectionCount > 0L) {
/* 176 */         return JsonResult.failure("请先删除子级!");
/*     */       }
/* 178 */       Long newsCount = this.newService.searchNewsCount(id, this.entCode);
/* 179 */       if (newsCount.intValue() > 0) {
/* 180 */         return JsonResult.failure("存在新闻不允许删除!");
/*     */       }
/* 182 */       this.newSectionService.delete(id);
/*     */     }
/*     */     catch (Exception e) {
/* 185 */       e.printStackTrace();
/* 186 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 188 */     return JsonResult.success();
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/getNewSectionTree/{newtype}"})
/*     */   @ResponseBody
/*     */   public JsonResult getNewSectionTree(@PathVariable Integer newtype)
/*     */   {
/*     */     try
/*     */     {
/* 205 */       super.initCurrentUser();
/* 206 */       String pId = this.request.getParameter("pId");
/* 207 */       List trees = this.newSectionService.getNewSectionTree(pId, this.currentUnits, newtype, this.entCode);
/* 208 */       String treeJson = JsonUtils.objectToJsonStr(trees);
/* 209 */       return JsonResult.success("获取数据成功", treeJson);
/*     */     } catch (Exception e) {
/* 211 */       e.printStackTrace();
/* 212 */       return JsonResult.failure(e.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/loadTree/{newtype}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String loadTree(@PathVariable Integer newtype, ModelMap map)
/*     */   {
/* 229 */     map.put("newtype", newtype);
/* 230 */     return "oa/new/newsection/tree";
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.news.NewSectionController
 * JD-Core Version:    0.6.1
 */