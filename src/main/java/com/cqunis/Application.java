/*    */ package com.cqunis;
/*    */ 
/*    */ import com.cqunis.dao.support.impl.IBaseRepositoryFactoryBean;
/*    */ import javax.servlet.MultipartConfigElement;
/*    */ import org.slf4j.Logger;
/*    */ import org.slf4j.LoggerFactory;
/*    */ import org.springframework.boot.SpringApplication;
/*    */ import org.springframework.boot.actuate.autoconfigure.ManagementWebSecurityAutoConfiguration;
/*    */ import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
/*    */ import org.springframework.boot.autoconfigure.SpringBootApplication;
/*    */ import org.springframework.boot.builder.SpringApplicationBuilder;
/*    */ import org.springframework.boot.web.servlet.MultipartConfigFactory;
/*    */ import org.springframework.boot.web.support.SpringBootServletInitializer;
/*    */ import org.springframework.cache.annotation.EnableCaching;
/*    */ import org.springframework.context.annotation.Bean;
/*    */ import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
/*    */ 
/*    */ @SpringBootApplication
/*    */ @EnableCaching
/*    */ @EnableAutoConfiguration(exclude={org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration.class, org.activiti.spring.boot.SecurityAutoConfiguration.class, ManagementWebSecurityAutoConfiguration.class})
/*    */ @EnableJpaRepositories(basePackages={"com.cqunis"}, repositoryFactoryBeanClass=IBaseRepositoryFactoryBean.class)
/*    */ public class Application extends SpringBootServletInitializer
/*    */ {
/* 32 */   private static Logger logger = LoggerFactory.getLogger(Application.class);
/*    */ 
/*    */   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
/* 35 */     return application.sources(new Class[] { Application.class });
/*    */   }
/*    */   public static void main(String[] args) {
/* 38 */     SpringApplication.run(Application.class, args);
/* 39 */     logger.debug("启动成功");
/*    */   }
/*    */ 
/*    */   @Bean
/*    */   public MultipartConfigElement multipartConfigElement()
/*    */   {
/* 49 */     MultipartConfigFactory factory = new MultipartConfigFactory();
/*    */ 
/* 51 */     factory.setMaxFileSize("100MB");
/*    */ 
/* 53 */     factory.setMaxRequestSize("100MB");
/* 54 */     return factory.createMultipartConfig();
/*    */   }
/*    */ }