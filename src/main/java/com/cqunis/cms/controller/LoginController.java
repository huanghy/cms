/*     */ package com.cqunis.cms.controller;
/*     */ 
/*     */ import com.alibaba.fastjson.JSONObject;
/*     */ import com.cqunis.common.CustomUsernamePasswordToken;
/*     */ import com.cqunis.common.WebUtils;
/*     */ import com.cqunis.common.utils.ClientApiUtil;
/*     */ import com.cqunis.controller.BaseController;
/*     */ import com.cqunis.entity.User;
/*     */ import com.cqunis.service.IUnitHumanService;
/*     */ import com.cqunis.service.IUnitService;
/*     */ import com.cqunis.service.RedisService;
/*     */ import java.io.PrintStream;
/*     */ import javax.annotation.Resource;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import javax.servlet.http.HttpSession;
/*     */ import org.apache.shiro.SecurityUtils;
/*     */ import org.apache.shiro.authc.IncorrectCredentialsException;
/*     */ import org.apache.shiro.authc.UnknownAccountException;
/*     */ import org.apache.shiro.subject.Subject;
/*     */ import org.springframework.beans.factory.annotation.Autowired;
/*     */ import org.springframework.stereotype.Controller;
/*     */ import org.springframework.ui.Model;
/*     */ import org.springframework.ui.ModelMap;
/*     */ import org.springframework.web.bind.annotation.RequestMapping;
/*     */ import org.springframework.web.bind.annotation.RequestParam;
/*     */ 
/*     */ @Controller("oaLoginController")
/*     */ public class LoginController extends BaseController
/*     */ {
/*     */ 
/*     */   @Autowired
/*     */   public IUnitHumanService unitHumanService;
/*     */ 
/*     */   @Autowired
/*     */   public IUnitService unitService;
/*     */ 
/*     */   @Resource(name="redisServiceImpl")
/*     */   RedisService redisService;
/*     */ 
/*     */   @RequestMapping(value={"/admin/login"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String login()
/*     */   {
/*  68 */     return "admin/login";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/admin/login"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
/*     */   public String submitLoginForm(User user, HttpServletRequest request, Model model)
/*     */   {
/*  84 */     String errorClassName = (String)request.getAttribute("shiroLoginFailure");
/*  85 */     String authticationError = null;
/*  86 */     if (UnknownAccountException.class.getName().equals(errorClassName))
/*  87 */       authticationError = "用户名/密码错误";
/*  88 */     else if (IncorrectCredentialsException.class.getName().equals(errorClassName))
/*     */     {
/*  90 */       authticationError = "用户名/密码错误";
/*  91 */     } else if (errorClassName != null) {
/*  92 */       authticationError = "未知错误：" + errorClassName;
/*     */     }
/*  94 */     model.addAttribute("errMsg", authticationError);
/*  95 */     return "admin/login";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/admin/auto_login"}, method={org.springframework.web.bind.annotation.RequestMethod.POST, org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String autoLogin(@RequestParam("code") String code, ModelMap model)
/*     */   {
/*     */     try
/*     */     {
/* 113 */       String sessionId = WebUtils.getCookie(this.request, "_currentSessionId");
/* 114 */       String accessToken = "";
/* 115 */       if ((null != sessionId) && 
/* 116 */         (sessionId
/* 116 */         .trim().length() > 0)) {
/* 117 */         accessToken = this.redisService.get(sessionId);
/*     */       }
/* 119 */       String serviceUrl = "";
/* 120 */       boolean isReceUser = false;
/*     */ 
/* 122 */       if ((null != accessToken) && 
/* 123 */         (accessToken
/* 123 */         .trim().length() > 0)) {
/* 124 */         if ("http://192.168.2.188:888/api/user_info?access_token=#access_token".indexOf("#access_token") != -1) {
/* 125 */           serviceUrl = "http://192.168.2.188:888/api/user_info?access_token=#access_token".replace("#access_token", accessToken);
/* 126 */           isReceUser = true;
/*     */         }
/*     */       }
/*     */       else {
/* 130 */         if ("http://192.168.2.188:888/oauth/token?client_id=#appId&client_secret=#appSecret&grant_type=authorization_code&code=#code&redirect_uri=http://222.180.162.200:16080/admin/auto_login".indexOf("#code") != -1)
/*     */         {
/* 133 */           serviceUrl = "http://192.168.2.188:888/oauth/token?client_id=#appId&client_secret=#appSecret&grant_type=authorization_code&code=#code&redirect_uri=http://222.180.162.200:16080/admin/auto_login"
/* 132 */             .replace("#appId", "pzhswxtaaaaaaa")
/* 133 */             .replace("#appSecret", "791698A253913D0F2B8DFEC0219C81F9")
/* 133 */             .replace("#code", code);
/*     */         }
/*     */ 
/* 136 */         JSONObject jsonobject = ClientApiUtil.sendByPost(serviceUrl, null, null);
/* 137 */         if (null != jsonobject) {
/* 138 */           if (jsonobject.containsKey("value")) {
/* 139 */             accessToken = jsonobject.getString("value");
/* 140 */             sessionId = this.request.getSession().getId();
/* 141 */             this.redisService.set(sessionId, accessToken);
/* 142 */             WebUtils.addCookie(this.request, this.response, "_currentSessionId", sessionId);
/* 143 */             if ("http://192.168.2.188:888/api/user_info?access_token=#access_token".indexOf("#access_token") != -1) {
/* 144 */               serviceUrl = "http://192.168.2.188:888/api/user_info?access_token=#access_token".replace("#access_token", accessToken);
/* 145 */               isReceUser = true;
/*     */             }
/*     */           } else {
/* 148 */             System.out.println("=============" + jsonobject.toString());
/*     */           }
/*     */         }
/*     */       }
/*     */ 
/* 153 */       if (isReceUser) {
/* 154 */         JSONObject jsonobject = ClientApiUtil.sendByGet(serviceUrl, null);
/* 155 */         if ((null != jsonobject) && 
/* 156 */           (jsonobject
/* 156 */           .containsKey("username")))
/*     */         {
/* 157 */           String username = jsonobject.getString("username");
/*     */ 
/* 159 */           Subject subject = SecurityUtils.getSubject();
/* 160 */           CustomUsernamePasswordToken token = new CustomUsernamePasswordToken(username, true);
/* 161 */           subject.login(token);
/* 162 */           return redirect("/admin/index");
/*     */         }
/*     */ 
/* 165 */         System.out.println("======jsonobject=====" + jsonobject.toString());
/*     */       }
/*     */ 
/*     */     }
/*     */     catch (Exception e)
/*     */     {
/* 171 */       e.printStackTrace();
/* 172 */       model.put("message", e.getMessage());
/*     */     }
/* 174 */     return "admin/login";
/*     */   }
/*     */ 
/*     */   @RequestMapping(value={"/admin/logout"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
/*     */   public String logout()
/*     */   {
/* 189 */     Subject subject = SecurityUtils.getSubject();
/* 190 */     subject.logout();
/* 191 */     return redirect("/admin/login");
/*     */   }
/*     */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.controller.LoginController
 * JD-Core Version:    0.6.1
 */