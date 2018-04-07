<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--360浏览器优先以webkit内核解析-->
    <title> - 主页示例</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
    <link href='${ctx!}/fullcalendar/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${ctx!}/fullcalendar/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-8" > 
        	 <div class="ibox float-e-margins">
                <div class="ibox-title">
                	<div class="pbord cf">
                      <img class="pull-left titim" src="${ctx!}/hadmin/img/daiban.png"/> 
                      <h5 class="pull-left">待办事务</h5>
                      <a href="${ctx!}/oa/tran/mytran" class="pull-right more">更多>></a>
                    </div>  
                </div>
                <div class="ibox-content minht330 nopad">
                   <ul class="newbox">
                   <#if insForms?exists >
	                   <#list insForms as insForm>
	                   		<li class="cf">
		                   	 	<a class="cf" href="${ctx!}/oa/tran/handle_pend/${insForm.id}/${insForm.boxId}">
			                   	 	<span class="im">
			                   	 		<img  src="${ctx!}/hadmin/img/header.png"/>
			                   	 	</span>
			                   	 	<div class="name">			                   	 	  
			                   	 	    <span>[${insForm.createUser}]<i>提出了申请</i></span>
			                   	 	    <em class="pull-right">${handleDate(insForm.applyDate,0)}</em>
			                   	 	</div>
			                   	 	<div class="pl15 sw">
			                   	 		<span>${insForm.title}</span>
			                   	 		<em class="wait">已等待：${handleDate(insForm.createDate,1)}</em>
			                   	 	</div>
		                   	 	</a>
		                   	 </li>
	                   </#list>
                   </#if>
                   </ul>
                </div>
            </div>
        	 <div class="ibox float-e-margins">
            	<div class="ibox-title padn">
            		<div class="pbord cf">
            			<img class="pull-left titim ml10" src="${ctx!}/hadmin/img/iconnew.png"/> 
	                    <h5>新闻资讯</h5>
                    </div>
                </div>
                <div class="ibox-content minht330 nopadding">
                	<div class="row">
                		<div class="col-sm-2">
                			<div class="new-bg">
		                 	<div class="new-tab">
		                 		<div class="hots"></div>
		                 		<ul class="new-ul">
		                 			<#if sections?exists >
		                 				<#list sections as sectionObj>
					                 		<#if sectionObj?exists >
					                 			<#list sectionObj?keys as itemKey>
					         						   <#if itemKey=="sec_name">
					         						   		<li class="<#if sectionObj_index==0 >curr</#if>"  >${sectionObj[itemKey]}</li>
					         						   </#if>
					                 			</#list>
					                 		</#if>	
				                 		</#list>   
		                 			</#if>	      		
		                		</ul>
		                	</div>
		                  </div>	
		                 </div>
		                 <div class="col-sm-10">
			                 <#if sections?exists >
	             				<#list sections as sectionObj>
			                 		<#if sectionObj?exists >
			                 			<#list sectionObj?keys as itemKey>
			         						   <#if itemKey=="id" >
			         						   	<#assign moreIndex=0>
			         						   		<ul class="newbox newboxs <#if sectionObj_index!=0>none</#if>">
			         						   				<#if newsList?exists >
												                   <#list newsList as news>
												                  		<#if news.newSection.id==sectionObj[itemKey] >
												                  		<#assign moreIndex=moreIndex+1 >
												                   		<li class="cf">
													                   	 	<a href="${ctx!}/oa/new/detail?id=${news.id}" class="cf">
													                   	 		<div class="row">
													                   	 			<div class="pull-left">
													                   	 				<img class="pull-left" width="112" height="85"  src="<#if news.imagePath?exists>${ctx!}/download?filePath=${news.imagePath}&fileName=${news.imagePath}<#else>${ctx!}/hadmin/img/default.png</#if>"/>
													                   	 			</div>
													                   	 			<div class="pull-left">
													                   	 				<div class="ncont">
													                   	 					<div class="cf">
													                   	 						<span class="titles">${news.title}</span>
													                   	 					</div>
													                   	 					<div class="mt10">
													                   	 						<span class="gray">发布人:${news.createUser}</span>
													                   	 						<em>${news.releaseDate}</em>
													                   	 					</div>
													                   	 				</div>													                   	 				
													                   	 			</div>	
													                   	 		</div>
													                   	 	</a>	
													                   	 </li>
													                  </#if>
												                </#list>
											             </#if>
			         						   		</ul>
			         						   		<a class="allbtn" <#if moreIndex==4>style="display:block;"</#if> href="${ctx!}/oa/new/center_index/0/${sectionObj[itemKey]}">查看全部</a>
			         						   </#if>
			                 			</#list>
			                 		</#if>	
		                 		</#list>   
	             			</#if>
                      </div> 
                	</div>                              	
                </div>	
            </div>	          
        </div>
        <div class="col-sm-4">
        	 <div class="ibox float-e-margins">
            	<div class="ibox-title">
            		<div class="pbord cf">
            		  <img class="pull-left titim" src="${ctx!}/hadmin/img/gonggao.png"/> 
                      <h5>通知公告</h5>
                      <a href="${ctx!}/oa/new/center_index/1/-1" class="pull-right more">更多</a>
                   </div>
                </div>
                	<#if noticeList?exists >
		                   <#list noticeList as notice>
                				<div class="ibox-content notic" onclick="window.location.href='${ctx!}/oa/new/detail?id=${notice.id}'" >
		                   		 <div class="noticetit">${notice.title}</div>
			                	 <div class="issue cf">
			                	 	<div class="pull-left">${notice.createUser}</div>
			                	 	<div class="pull-right">${notice.releaseDate}</div>
			                	 </div>
			                	 <div class="content">
			                	 	${urlencod(notice.content)}
			                	 </div>
		                  </#list>
						</#if>
                </div>	
            </div>	
            <div class="ibox float-e-margins">
            	<div class="ibox-title">
            		<div class="pbord cf">
            		  <img class="pull-left titim" src="${ctx!}/hadmin/img/flie.png"/> 
                      <h5>文件中心</h5>
                      <a href="${ctx!}/oa/resfile/index" class="pull-right more">更多>></a>
                   </div>
                </div>
                <div class="ibox-content minht330">
                	<ul class="newbox">
	                	<#if resourceFiles?exists >
			                   <#list resourceFiles as resourceFile>
			                   		<li>
				                   	 	<a class="cf" href="${ctx!}/oa/resfile/download?filePath=${resourceFile.resourcePath}" >
					                   	 	<span class="files">
					                   	 		<img  src="${ctx!}/hadmin/img/icon-pdf.png"/>
					                   	 	</span>
					                   	 	<div class="filenm">
					                   	 	    <span>${resourceFile.resourceName}</span>
					                   	 	    <em class="pull-right">${resourceFile.createDate?string('yyyy-MM-dd')}</em>
					                   	 	</div>
					                   	 	<div class="pl15 size">
					                   	 		<span>文件大小：${resourceFile.resourceSize}</span>
					                   	 	</div>
				                   	 	</a>
				                   	 </li>
			                   </#list>
		                   </#if>
                	</ul>	
                </div>	
            </div> 
            <div   class="ibox float-e-margins" id='calendar' >
        	</div>          
        </div>
    </div>
</div>
<!-- 全局js -->
<script src="${ctx!}/hadmin/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx!}/hadmin/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
 <!-- 全局js -->
<#include "/admin/common/fullcalendar_common.ftl">
<!-- Flot -->
<!--<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.js"></script>-->
<!--<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.resize.js"></script>
<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.pie.js"></script>-->
<!-- 自定义js -->
<!--<script src="${ctx!}/hadmin/js/content.js"></script>-->
<!--flotdemo-->
</body>
<script>
	var star=$(".new-tab li").position().top;
	$(".hots").stop().animate({"top":star},500);
   $(".new-tab li").click(function(){
    	var index=$(this).index();
    	star=$(this).position().top;
    	$(".new-tab li").removeClass("curr");
    	$(this).addClass("curr");
    	$(".newboxs").addClass("none");
    	$(".newboxs").eq(index).removeClass("none");    	
   });
   $(".new-tab li").hover(function(){
       var top=$(this).position().top;
	   $(".hots").stop().animate({"top":top},500);
   },
   function(){   
	  $(".hots").stop().animate({"top":star},500);
   })
</script>
</html>