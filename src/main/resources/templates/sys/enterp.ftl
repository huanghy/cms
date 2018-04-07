<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>企业设置</title>
		<link rel="shortcut icon" href="favicon.ico">
		<link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/bootstrap-treeview.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/datapicker/datepicker3.css"> 
	    <link href="${ctx!}/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	</head>
	<body class="gray-bg">
		<div class="wrapper wrapper-content cf  animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox">
						<div class="ibox-title">
							<div class="affair-tit">
								企业设置
							</div>
						</div>
						<!--informbox-->
						<div class="informbox">
						<form class="form-horizontal m-t" id="frm" action="javascript:void(0)" >
						<input id="id" name="id" class="form-control" type="hidden" value="<#if enterp?exists>${enterp.id}</#if>" >
						<table>
							<tr>
							   <td valign="top" width="100" class="tr">
							   	logo 上传：
							   </td>
							   <td class="pl20">
							   	 <div class="preview">
							   		    <em style="<#if enterp.logo?length==0 >display:none;</#if>" id="_previewImgShow" class='companyim'>
	                            			<img src="<#if enterp.logo?length==0 >${ctx!}/hadmin/img/uploadimg.png<#else>${enterp.logo}</#if>" id="_preview" width="60px" height="60px">
	                            			<a href="javascript:delImg()" class="imdel">-</a>
	                            		</em>
	                            		<i class="_imagePath" id="_imagePathh" style="<#if enterp.logo?length==0>display:block;</#if>" >
	                            		  <img src="/hadmin/img/upload2.png" id="_imagePath">
	                            		  <input type="hidden" name="logo" id="logo" value="" />
	                            		</i>
	                            		<div class="attrs">
	                            			<div>
	                            				*推荐尺寸60X60px，图片大小不的超过1M，且仅支持.png、.jpg格式图片
	                            			</div>
	                            			<div>
	                            				*如无上传图片，系统将默认为“暂无图片”
	                            			</div>
	                            		</div>
							   	   </div>
							   </td>
							</tr>
							<tr >
							   <td   class="tr">
							   	 <div class="mt20">企业名称：</div>
							   </td>
							   <td>
							   	  <div class="mt20 pl20">
							   	  	<input type="text" name="name" class="form-control wid200" placeholder="请填写企业全称" value="<#if enterp?exists>${enterp.name}</#if>" />
							   	  </div>
							   </td>
							</tr>
							<tr>
							   <td class="tr">
							   	 <div class="mt20">企业简称：</div>
							   </td>
							   <td>
							   	  <div class="mt20 pl20">
							   	  	<input type="text" name="abbrName" class="form-control wid200" placeholder="请填写企业简称" value="<#if enterp?exists>${enterp.abbrName}</#if>"/>
							   	  </div>
							   </td>
							</tr>
							<tr>
							   <td class="tr">
							   	 <div class="mt20">企业地址：</div>
							   </td>
							   <td>
							   	  <div class="mt20 pl20">
							   	  	<input type="text" name="address" class="form-control wid200" placeholder="请填写企业地址" value="<#if enterp?exists>${enterp.address}</#if>" />
							   	  </div>
							   </td>
							</tr>
							<tr>
							   <td class="tr">
							   	 <div class="mt20">联系电话：</div>
							   </td>
							   <td>
							   	  <div class="mt20 pl20">
							   	  	<input type="text" name="contNum" class="form-control wid200" placeholder="请填写企业电话" value="<#if enterp?exists>${enterp.contNum}</#if>"/>
							   	  </div>
							   </td>
							</tr>
							<tr>
							   <td class="tr">
							   	 <div class="mt20"> </div>
							   </td>
							   <td>
							   	  <div class="mt20 pl20">
							   	  	  <button class="btn btn-primary subbut"  type="submit" >保存</button>
							   	  </div>
							   </td>
							</tr>
						</table>
						</form>	
					</div>
					<!--informbox end-->
					</div>	
				</div>
			</div>	
		</div>
	</body>
<!-- 全局js -->
<#include "/admin/common/common.ftl">
<script type="text/javascript" src="${ctx!}/oa/js/sys/enterp.js"></script>
</html>