/**
 *******************************************************************************
 * 
 * (c) Copyright 2011 
 *
 * @文件名 VoiceJob.java
 * @系统名称 intespeech
 * @模块名称 (请更改成该模块名称)
 * @创建人 huanghy
 * @创建日期 2018年2月11日 上午11:17:47
 * @修改人 (修改了该文件，请填上修改人的名字)
 * @修改日期 (请填上修改该文件时的日期)  
 * @版本 V1.0.0
 *******************************************************************************  
 */
package com.cqunis.cms.job;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cqunis.cms.entity.ExRecord;
import com.cqunis.cms.entity.Extension;
import com.cqunis.cms.service.IExRecordService;
import com.cqunis.cms.service.IExtensionService;
import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator.Operator;

/** VoiceJob概要说明：
 * @author huanghy
 */
@Component("extJob")
@Lazy(false)
public class ExtJob {
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/***企业号
	 */
	String entCode="pzhsw";
	@Resource(name="extensionServiceImpl")
	IExtensionService extensionService;
	@Resource(name="exRecordServiceImpl")
	IExRecordService exRecordService; 
	Timer timer = new Timer();
	
	
	
	/****
	 * translateVoice方法慨述:定时扫描处理
	 *  void
	 * @创建人 huanghy
	 * @创建时间 2018年2月11日 下午12:17:48
	 * @修改人 (修改了该文件，请填上修改人的名字)
	 * @修改日期 (请填上修改该文件时的日期)
	 */
	@Scheduled(cron = "${job.ext.cron}")
	public  synchronized void cronExtension() {
		try{
			SimpleSpecificationBuilder<Extension> builder = new SimpleSpecificationBuilder<Extension>();
			builder.add("taskState",Operator.eq.name(),"0");
			builder.add("exeState",Operator.eq.name(),"-1");
			builder.add("entCode",Operator.eq.name(),entCode);
			List<Extension> extensions = extensionService.findList(builder.generateSpecification(), null);
			if(null != extensions 
					&& extensions.size()>0){
				for(Extension extension:extensions){
					if(extension.getPeriod()==0
							||extension.getDelay()==0){
						continue;
					}
					/***先跟新状态**/
					extension.setExeState(0);
					extensionService.update(extension);
					String id = extension.getId();
					int period = extension.getPeriod();
					int delay = extension.getDelay();
					Random random = new Random();
					/***可用金额**/
					String invAmount = extension.getInvAmount();
					BigDecimal bigInvAmount = new BigDecimal(invAmount);
			        timer.schedule(new TimerTask() {
			            @Override
			            public void run() {
			            	/***数量**/
							int alrAd = extension.getAlrAd();
							int randomNum = extension.getRandomNum();
							int randomNumt=random.nextInt(randomNum);
							/***可用金额**/
							String actualAmount = extension.getActualAmount();
							BigDecimal actAmount = new BigDecimal(actualAmount);
							BigDecimal bigDecimal = new BigDecimal(extension.getUnitPrice());
							bigDecimal=bigDecimal.multiply(new BigDecimal(randomNumt)).add(actAmount);
							if(bigInvAmount.compareTo(bigDecimal)>=0){
								BigDecimal scale = bigDecimal.setScale(2,BigDecimal.ROUND_HALF_UP);
								extension.setActualAmount(scale.toString());
								extension.setAlrAd(alrAd+randomNumt);
								/***启动记录***/
								ExRecord exRecord = new ExRecord();
								exRecord.setExtId(id);
								exRecord.setEndTime(new Date());
								exRecord.setHumanId(extension.getHumanId());
								exRecord.setUnitPrice(extension.getUnitPrice());
								exRecordService.save(exRecord);
								extension.setExeState(-1);
								extensionService.update(extension);
								this.cancel();
								timer.purge();
							} else {
								this.cancel();
								timer.purge();
							}
			            }
			        },delay*60*1000,period*60*1000);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
