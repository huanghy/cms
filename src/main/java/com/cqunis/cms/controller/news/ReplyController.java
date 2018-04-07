/*     */ package com.cqunis.cms.controller.news;
/*     */ 
/*     */ import com.cqunis.cms.entity.Reply;
/*     */ import com.cqunis.cms.service.IReplyService;
/*     */ import com.cqunis.common.JsonResult;
/*     */ import com.cqunis.controller.BaseController;
/*     */ import com.cqunis.entity.User;
/*     */ import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator;
/*     */ import com.cqunis.service.specification.SpecificationOperator.Operator;
/*     */ import javax.annotation.Resource;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import org.apache.commons.lang3.StringUtils;
/*     */ import org.springframework.data.domain.Page;
/*     */ import org.springframework.data.domain.PageRequest;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.ModelMap;
/*     */ import org.springframework.web.bind.annotation.PathVariable;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ import org.springframework.web.bind.annotation.ResponseBody;
/*     */ 
/*     */ @Controller("replyController")
/*     */ @RequestMapping({"/oa/reply"})
/*     */ public class ReplyController extends BaseController
/*     */ {
/*     */ 
/*     */   @Resource(name="replyServiceImpl")
/*     */   IReplyService replyService;
/*     */ 
/*     */   @RequestMapping({"/index/{newsId}"})
/*     */   public String index(@PathVariable String newsId, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/*  62 */       super.initCurrentUser();
/*  63 */       map.put("currentUser", this.currentUser);
/*  64 */       map.put("newsId", newsId);
/*     */     } catch (Exception e) {
/*  66 */       e.printStackTrace();
/*     */     }
/*  68 */     return "oa/new/reply/index";
/*     */   }
/*     */ 
/*     */   @RequestMapping({"/list/{newsId}"})
/*     */   @ResponseBody
/*     */   public Page<Reply> list(@PathVariable String newsId)
/*     */   {
/*  80 */     Page page = null;
/*     */     try {
/*  82 */       SimpleSpecificationBuilder builder = new SimpleSpecificationBuilder();
/*  83 */       String searchText = this.request.getParameter("searchText");
/*  84 */       if (StringUtils.isNotBlank(searchText)) {
/*  85 */         builder.add("secName", SpecificationOperator.Operator.likeAll.name(), searchText);
/*     */       }
/*  87 */       builder.add("newsId", SpecificationOperator.Operator.eq.name(), newsId);
/*  88 */       builder.add("entCode", SpecificationOperator.Operator.eq.name(), this.entCode);
/*  89 */       PageRequest pageRequest = getPageRequest();
/*  90 */       page = this.replyService.findAll(builder.generateSpecification(), pageRequest);
/*     */     } catch (Exception e) {
/*  92 */       e.printStackTrace();
/*     */     }
/*  94 */     return page;
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/add/{newsId}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String add(@PathVariable String newsId, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 110 */       map.put("newsId", newsId);
/*     */     } catch (Exception e) {
/* 112 */       e.printStackTrace();
/*     */     }
/* 114 */     return "oa/new/reply/edit";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/edit/{newsId}/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String edit(@PathVariable String newsId, @PathVariable String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 132 */       Reply reply = (Reply)this.replyService.find(id);
/* 133 */       map.put("newsId", newsId);
/* 134 */       map.put("reply", reply);
/*     */     } catch (Exception e) {
/* 136 */       e.printStackTrace();
/*     */     }
/* 138 */     return "oa/new/reply/edit";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/edit"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult edit(@RequestParam(value="id", required=false) String id, @RequestParam(value="content", required=false) String content, @RequestParam(value="newsId", required=false) String newsId, @RequestParam(value="title", required=false) String title, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 158 */       Reply reply = null;
/* 159 */       if ((null != id) && 
/* 160 */         (id
/* 160 */         .trim().length() > 0)) {
/* 161 */         reply = (Reply)this.replyService.find(id);
/* 162 */         reply.setContent(content);
/* 163 */         reply.setNewsId(newsId);
/* 164 */         reply.setTitle(title);
/* 165 */         this.replyService.update(reply);
/*     */       }
/*     */       else {
/* 168 */         super.initCurrentUser();
/* 169 */         reply = new Reply();
/* 170 */         reply.setHumanId(this.currentUser.getId());
/* 171 */         reply.setNewsId(newsId);
/* 172 */         reply.setContent(content);
/* 173 */         reply.setTitle(title);
/* 174 */         reply.setState(0);
/* 175 */         this.replyService.save(reply);
/*     */       }
/*     */     } catch (Exception e) {
/* 178 */       e.printStackTrace();
/* 179 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 181 */     return JsonResult.success();
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/delete/{id}"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   @ResponseBody
/*     */   public JsonResult delete(@PathVariable String id, ModelMap map)
/*     */   {
/*     */     try
/*     */     {
/* 200 */       this.replyService.delete(id);
/*     */     } catch (Exception e) {
/* 202 */       e.printStackTrace();
/* 203 */       return JsonResult.failure(e.getMessage());
/*     */     }
/* 205 */     return JsonResult.success();
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.news.ReplyController
 * JD-Core Version:    0.6.1
 */