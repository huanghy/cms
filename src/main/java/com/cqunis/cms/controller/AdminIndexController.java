/*    */ package com.cqunis.cms.controller;
/*    */ 
/*    */ import com.cqunis.controller.BaseController;
/*    */ import com.cqunis.service.IDepartmentService;
/*    */ import com.cqunis.service.IEnterpService;
/*    */ import com.cqunis.service.IUnitService;
/*    */ import java.util.List;
/*    */ import javax.annotation.Resource;
/*    */ import org.springframework.beans.factory.annotation.Autowired;
/*    */ import org.springframework.stereotype.Controller;
/*    */ import org.springframework.ui.ModelMap;
/*    */ import org.springframework.web.bind.annotation.RequestMapping;
/*    */ 
/*    */ @Controller("adminIndexController")
/*    */ public class AdminIndexController extends BaseController
/*    */ {
/*    */ 
/*    */   @Autowired
/*    */   IUnitService unitService;
/*    */ 
/*    */   @Autowired
/*    */   IDepartmentService departmentService;
/*    */ 
/*    */   @Resource(name="enterpServiceImpl")
/*    */   IEnterpService enterpService;
/*    */ 
/*    */   @RequestMapping({"/admin/index"})
/*    */   public String index(ModelMap model)
/*    */   {
/*    */     try
/*    */     {
/* 44 */       super.initCurrentUser();
/* 45 */       model.put("currentUser", this.currentUser);
/* 46 */       List enterps = this.enterpService.findAll();
/* 47 */       if ((null != enterps) && 
/* 48 */         (enterps
/* 48 */         .size() > 0))
/* 49 */         model.put("enterp", enterps.get(0));
/*    */     }
/*    */     catch (Exception e) {
/* 52 */       e.printStackTrace();
/*    */     }
/* 54 */     return "admin/index";
/*    */   }
/*    */ 
/*    */   @RequestMapping({"/admin/welcome"})
/*    */   public String welcome(ModelMap map)
/*    */   {
/*    */     try
/*    */     {
/* 64 */       super.initCurrentUser();
/* 65 */       StringBuffer unitIds = new StringBuffer(50);
/* 66 */       StringBuffer deparIds = new StringBuffer(50);
/* 67 */       StringBuffer postIds = new StringBuffer(50);
/* 68 */       super.receUnitIds(unitIds);
/* 69 */       super.receDeparIds(deparIds);
/* 70 */       super.recePostIds(postIds);
/*    */     } catch (Exception e) {
/* 72 */       e.printStackTrace();
/*    */     }
/* 74 */     return "admin/welcome";
/*    */   }
/*    */ 
/*    */   @RequestMapping({"/admin/", "/admin/common/upload"})
/*    */   public String commonUpload(ModelMap model)
/*    */   {
/* 89 */     return "admin/common/upload";
/*    */   }
/*    */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.AdminIndexController
 * JD-Core Version:    0.6.1
 */