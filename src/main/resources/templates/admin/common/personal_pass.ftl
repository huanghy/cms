<!DOCTYPE html>
<html>
	<head>
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
	</head>
	<body class="gray-bg">
		<div class="wrapper cf  animated fadeInRight">
			<div class="row">
				<div class="col-lg-12 fttit">
					设置>修改密码
				</div>
				<div class="col-sm-12 passbox">
					<div class="ibox">
						<div class="passfirst">
							<i class="fa fa-lock"></i><span>修改密码</span>
						</div>
						<div class="tip">*为了保证账户安全，建议密码采用字母和数字组合</div>
						<form class="form-horizontal m-t" id="frm"  method="post" action="javascript:void(0)" >
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">登录账号:</label>
								<div class="col-sm-4 control-label tl dark">
									${currentUser.userName}
								</div>
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">旧密码:</label>
								<div class="col-sm-2 control-label tl">
									<input type="password" id="oldPassword" name="oldPassword"  class="form-control"/>
								</div>								
							</div>	
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">新密码:</label>
								<div class="col-sm-2 control-label tl">
									<input type="password"  id="newPassword" name="newPassword"  class="form-control"/>
								</div>
								<div class="col-sm-4">
									<span class="caption gray">*必须是6-20个英文字母、数字或符号</span>
								</div>
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray">确认密码:</label>
								<div class="col-sm-2 control-label tl">
									<input type="password" id="confirmPassword" name="confirmPassword" class="form-control"/>
								</div>
								<div class="col-sm-2">
									<span class="caption">&nbsp;</span>
								</div>
							</div>
							<div class="form-group">							
							    <label class="col-sm-1 control-label ml10 lgray"></label>
								<div class="col-sm-2 control-label tl">
								   <button class="btn btn-primary subbut wid100" type="submit">确认并提交</button>	
								</div>								
							</div>
						</form>	
					</div>					
				</div>	
			</div>
		</div>		
	</body>
	<#include "/admin/common/common.ftl">
	<script type="text/javascript">
    	$(document).ready(function(){
				initValidate();
		});
		
		/***初始化验证方法
		*/
		function initValidate(){
			try{
				$("#frm").validate({
		    	    rules: {
				    	oldPassword:{
			    	        required: true,
			    	        minlength:6,
			    	        maxlength:20
						},
						newPassword:{
			    	        required: true,
			    	        minlength:6,
			    	        maxlength:20
						},
						confirmPassword:{
			    	        required: true,
			    	        minlength:6,
			    	        maxlength:20
						}
					},
		    	    messages: {
		    	    },
		    	    submitHandler:function(form){
		    	    	var newPassword = $("#newPassword").val();
		    	    	var confirmPassword = $("#confirmPassword").val();
		    	    	if(newPassword!=confirmPassword){
		    	    		layer.msg("两次密码不一致!", {time: 2000});
		    	    		$("#confirmPassword").focus();
		    	    		return;
		    	    	}
		    	    	/***取消编辑项**/
		    	    	$.ajax({
		   	    		   type: "POST",
		   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	    		   dataType: "json",
		   	    		   url: "/admin/common/up_personal_pass",
		   	    		   data:$(form).serialize(),
		   	    		   success: function(msg){
			   	    			layer.msg(msg.message, {time: 2000});
			   	    			if(msg.code==-2){
			   	    				$("#oldPassword").focus();
			   	    			}
		   	    		   }
		   	    		});
		            }
		    	});
			}catch(e){
				console.log(e);
			}
		}
	</script>
</html>