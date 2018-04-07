<!DOCTYPE html>
<html>
	 <head>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>
		    回复管理
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
			 		回复管理
			 	</div>
				<div class="col-sm-12">
				   <div class="ibox">
					<div class="ibox-title">
						<div class="affair-tit">
							发布回复
						</div>
					</div>
					<form class="form-horizontal m-t" id="frm" method="post" action="javascript:void(0)" >
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10">标题:</label>
							 <div class="col-sm-4 control-label tr">
							 	<input type="text" class="form-control" name="title" id="title" placeholder="标题长度限定为30个字标题" value="<#if reply?exists >${reply.title}</#if>" />
							 	<input type="hidden" name="id" id="id" value="<#if reply?exists >${reply.id}</#if>" />
							 	<input type="hidden" name="content" id="content" value="" />
	                             <input type="hidden" name="newsId" id="newsId" value="${newsId}" />
							 </div>
							 <div class="col-sm-2 nopadding"><!--<span class="caption">*文字标题已超过30个字符长度</span>--></div>
						</div>	
						<div class="form-group">
							 <label class="col-sm-1 control-label ml10">新闻详情:</label>
							 <div class="col-sm-9 control-label tl">
							 	<script type="text/plain" id="_content" style="width:100%;height:240px;">
								</script>
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
    	<#if reply?exists >
    		var contentHtml = "${reply.content}";
    	</#if>
	</script>
	<script src="${ctx!}/oa/js/new/reply.js"></script>
	</body>
</html>