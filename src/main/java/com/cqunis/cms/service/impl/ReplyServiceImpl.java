/*    */ package com.cqunis.cms.service.impl;
/*    */ 
/*    */ import com.cqunis.cms.dao.IReplyDao;
/*    */ import com.cqunis.cms.entity.Reply;
/*    */ import com.cqunis.cms.service.IReplyService;
/*    */ import com.cqunis.dao.support.IBaseDao;
/*    */ import com.cqunis.service.support.impl.BaseServiceImpl;
/*    */ import javax.annotation.Resource;
/*    */ import org.springframework.stereotype.Service;
/*    */ 
/*    */ @Service("replyServiceImpl")
/*    */ public class ReplyServiceImpl extends BaseServiceImpl<Reply, String>
/*    */   implements IReplyService
/*    */ {
/*    */ 
/*    */   @Resource(name="replyDaol")
/*    */   IReplyDao replyDao;
/*    */ 
/*    */   public IBaseDao<Reply, String> getBaseDao()
/*    */   {
/* 41 */     return this.replyDao;
/*    */   }
/*    */ }

/* Location:           C:\Users\huanghy\Desktop\soft\WEB-INF\classes\
 * Qualified Name:     com.cqunis.cms.service.impl.ReplyServiceImpl
 * JD-Core Version:    0.6.1
 */