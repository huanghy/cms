<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
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
		<div class="wrapper cf  animated fadeInRight">
			<div class="row">
				<div class="col-lg-12 fttit">
					设置>个人资料
				</div>
				<div class="col-sm-12 passbox">
					<div class="ibox pb20">
						<div class="passfirst">
							<i class="fa fa-calendar"></i><span>个人资料</span>
						</div>
						<form class="form-horizontal m-t" id="frm" action="javascript:void(0)" >
						    <div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">用户名:</label>
								<div class="col-sm-4 control-label tl dark">
									${currentUser.userName}
								</div>
								<label class="col-sm-1 control-label ml10 lgray">性名:</label>
								<div class="col-sm-4 control-label tl dark">
									<#if currentUser.sex==1>男<#else>女</#if>
								</div>
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">姓名:</label>
								<div class="col-sm-4 control-label tl dark">
								    ${currentUser.humanName}
								</div>							
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">用户头像:</label>
								<div class="col-sm-9 control-label tl">
								    <div class="preview" >
                            		<i class="_imagePath"  >
                            		  <img src="<#if currentUser.imageUrl?exists>${currentUser.imageUrl}<#else>${ctx!}/hadmin/img/upload.png</#if>" id="_preview" />
                            		  <input type="hidden" name="imageUrl" id="imageUrl" value="" />
                            		</i>
                            		<div class="propt">
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
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">手机号码:</label>
								<div class="col-sm-2 control-label tl">
									<input type="text" name="phone"  class="form-control" value="${currentUser.phone}"/>
								</div>								
							</div>	
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">办公号码:</label>
								<div class="col-sm-2 control-label tl">
									<input type="text" name="officePhone" class="form-control" value="${currentUser.officePhone}" />
								</div>								
							</div>	
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">E-mail:</label>
								<div class="col-sm-2 control-label tl">
									<input type="text" name="email" class="form-control" value="${currentUser.email}"/>
								</div>								
							</div>
							<div class="form-group">	
								<label class="col-sm-1 control-label ml10 lgray"></label>
								<div class="col-sm-2 control-label tl">
									<button class="btn btn-primary subbut wid100" type="submit">保存</button>
								</div>							    							
							</div>
					    </form>	
					</div>					
				</div>	
				<div class="col-sm-12 passbox mt10">
					<div class="ibox cf">
						<div class="passfirst">
							<i class="fa fa-sitemap"></i><span>职位信息</span>
						</div>
						<form class="form-horizontal m-t"  method="post" action="javascript:void(0)" >
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">所属单位:</label>
								<div class="col-sm-2 control-label tl">
									<#if currentUnits?exists>
										<#list currentUnits as unit>
											${unit.unitName}
										</#list>
									</#if>
								</div>								
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">所属部门:</label>
								<div class="col-sm-2 control-label tl">
									<#if currentDepartments?exists>
										<#list currentDepartments as department>
											${department.name}
										</#list>
									</#if>
								</div>								
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">所属岗位:</label>
								<div class="col-sm-2 control-label tl">
									<#if currentPosts?exists>
										<#list currentPosts as post>
											${post.name}
										</#list>
									</#if>
								</div>								
							</div>
						</form>
					</div>
				</div>	
			</div>	
		</div>	
	</body>
<!-- 全局js -->
<#include "/admin/common/common.ftl">
<script type="text/javascript" src="${ctx!}/oa/js/common/user_info.js"></script>
</html>
