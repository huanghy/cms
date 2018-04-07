<!DOCTYPE html>
<html>
	 <head>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>
		    <#if newtype==0>
				新闻管理
			<#else>
				公告管理
			</#if>
	    </title>
	    <meta name="keywords" content="">
	    <meta name="description" content="">
	    <link rel="shortcut icon" href="favicon.ico">
	    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/bootstrap-treeview.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/datapicker/datepicker3.css"> 
	    <link href="${ctx!}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	    <style>
    	.preview{position:relative;}
    	.preview em{font-style:normal;color:#666;float:left;width:86px;height:63px;position: relative;}
    	.preview .fa{position:absolute;top:-4px;left:13px;font-size:30px;}
    	.preim{width:100%;}
    	.preim img{width:100%;}
    </style>
	 </head>
	<body class="gray-bg">
		<div class="wrapper cf  animated fadeInRight">
			 <div class="row">
			 	<div class="col-lg-12 fttit">
			 	 <#if newtype==0>
					新闻管理>发布新闻
				<#else>
					公告管理>发布公告
				</#if>
			 	</div>
				<div class="col-sm-12">
				   <div class="ibox">
					<div class="ibox-title">
						<div class="affair-tit">
						<#if newtype==0>
							发布新闻
						<#else>
							发布公告
						</#if>
						</div>
					</div>					
					<input type="hidden" name="dir" id="dir" value="news" />
					<input type="hidden" name="unitId" id="unitId" value="0000" />
					<input type="hidden" name="departmentId" id="departmentId" value="0000" />
					<form class="form-horizontal m-t" id="frm" method="post" action="javascript:void(0)" >
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10">标题:</label>
							 <div class="col-sm-4 control-label tr">
							 	<input type="text" class="form-control" name="title" id="title" placeholder="标题长度限定为30个字标题" value="<#if new?exists >${new.title}</#if>" />
							 	<input type="hidden" name="id" id="id" value="<#if new?exists >${new.id}</#if>" />
							 	<input type="hidden" name="content" id="content" value="" />
							 	<input type="hidden" name="imagePath" id="imagePath" value="<#if new?exists >${new.imagePath}</#if>" />
							 	<input type="hidden" name="newsAnnexJson" id="newsAnnexJson" value="" />
	                             <input type="hidden" name="newtype" id="newtype" value="${newtype}" />
							 </div>
							 <div class="col-sm-2 nopadding"><!--<span class="caption">*文字标题已超过30个字符长度</span>--></div>
						</div>	
						<#if newtype==0>
							<div class="form-group" >
	                            <label class="col-sm-1  control-label ml10">缩略图:</label>
	                            <div class="col-sm-9 control-label tl">
	                                <div class="preview" >
	                            		<em style="<#if new?exists ><#else>display:none;</#if>" id="_previewImgShow" >
	                            			<img src="<#if new?exists&&new.imagePath?exists>${ctx!}/download?filePath=${new.imagePath}&fileName=${new.imagePath}<#else>${ctx!}/hadmin/img/uploadimg.png</#if>" id="_preview"  width='86' height="63"/>
	                            			<a href="javascript:delImg()"  class="imdel">-</a>
	                            		</em>
	                            		<i class="_imagePath" id="_imagePathh" style="<#if new?exists >display:none;</#if>" >
	                            		  <img src="${ctx!}/hadmin/img/upload.png" id="_imagePath"/>
	                            		</i>
	                            		<div class="propt" >
	                            			<div>
	                            				*推荐尺寸400X300px，图片大小不的超过1M，且仅支持.png、.jpg格式图片
	                            			</div>
	                            			<div>
	                            				*如无上传图片，系统将默认为“暂无图片”
	                            			</div>
	                            		</div>
	                            	</div>
	                            </div>
	                        </div>
						</#if>
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10">新闻详情:</label>
							 <div class="col-sm-9 control-label tl">
							 	<script type="text/plain" id="_content" style="width:100%;height:240px;">
								</script>
							 </div>
						</div>
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10">相关附件:</label>	
							 <div class="col-sm-4 tl">
							 	<a href="javascript:" class="fa fa-paperclip fjxg" id="_newsAnnex" >上传附件</a>
							 </div>	
						</div>
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10"></label>	
							 <div class="col-sm-4 tl" id="_annexTable" >
								 <#if newsAnnexs?exists >
										<#list newsAnnexs as newsAnnex >
											<div class="fjjs">
										 	  <span>${newsAnnex.chName}</span>
										 	  <em>${newsAnnex.fileSize}</em>
										 	  <i class="fa fa-close del" fileIndex=${newsAnnex_index} filePath="${newsAnnex.filePath}" onclick="delFile(this)"  ></i>
										 	</div>
										</#list>
									</#if>
							 	
							 </div>	
						</div>
						<div class="form-group">
						      <label class="col-sm-1 control-label ml5">新闻类型:</label>
							  <div class="col-sm-4 control-label tl">  
							  <#if newSections?exists >
							  		<select  name="sectionId" class="form-control" id="_sectionId"  >
								  		<#list newSections as newSection >
								  				<option  value="${newSection.id}" <#if new?exists&&new.newSection.id==newSection.id >selected="selected"</#if> >${newSection.secName}</option>
								  		</#list>
									 </select>
							  </#if>
							  </div>
						</div> 
						<div class="mt10 mb10">
							<div class="row">
								<div class="col-sm-8 tr sumbit">
							        <button class="btn btn-danger cel" type="button">取消</button>
							        <button class="btn btn-primary subbut" type="submit">提交</button>					        
								</div>
							</div>
							
						</div>
					</form>
				</div>	
			  </div>
		  </div>
		</div>
	 <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <#include "/admin/common/ume_common.ftl">
    <script type="text/javascript">
    	<#if new?exists >
    		var contentHtml = "${new.content}";
    	</#if>
    	<#if newsAnnexs?exists >
    		var newsAnnexs = ${newsAnnexJson};
    	</#if>
	</script>
	<script src="${ctx!}/oa/js/new/news.js"></script>
	</body>
</html>