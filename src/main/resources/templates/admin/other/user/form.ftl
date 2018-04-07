<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 表单验证 jQuery Validation</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>jQuery Validate 简介</h5>
                    </div>
                    <div class="ibox-content">
                        <p>jquery.validate.js 是一款优秀的jQuery表单验证插件。它具有如下特点：</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>完整验证表单</h5>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="frm" method="post" action="${ctx!}/admin/other/user/edit">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户账号：</label>
                                <div class="col-sm-8">
                                	<input id="guid" name="guid" class="form-control" type="hidden" value="${user.guid}" >
                                    <input id="isEdit" name="isEdit" class="form-control" type="hidden" value="${isEdit}" >
                                    <input id="username" name="username" class="form-control" type="text" value="${user.username}" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                 	<input id="password" name="password" class="form-control" type="password" value="${user.password}" >
                                 </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">电话：</label>
                                <div class="col-sm-8">
                                	<input id="phone" name="phone" class="form-control" type="text" value="${user.phone}" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">邮箱：</label>
                                <div class="col-sm-8">
                                    <input id="email" name="email" class="form-control" type="text" value="${user.email}" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">是否归档：</label>
                                <div class="col-sm-8">
	                                  	<input type="radio" id="archiveda" name="archived" <#if user?exists&&user.archived > checked="checked" </#if> />是
										<input type="radio" id="archivedb" name="archived" <#if user?exists&&!user.archived > checked="checked" </#if> />否
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-3">
                                    <button class="btn btn-primary" type="submit">提交</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <script type="text/javascript">
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {
    	    	username: {
    	        required: true,
    	    	/***异步调用**/
    	    	remote: {
				    url: "${ctx!}/admin/other/user/check_username",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        keyValue: function() {
				            return $("#username").val();
				        },
				        isEdit:function(){
				        	return $("#isEdit").val();
				        }
				    },
				    dataFilter: function(data, type) { //返回结果
                        if (data == "true"){
                        	return true;
                        }
                        else{
	                        layer.msg("用户名已经存在", {time: 2000});
	                        return false;
                        }
                    }
				}
    	      },
    	      password: {
    	        required: true,
    	        minlength: 10,
    	    	maxlength: 50
    	      },
    	      phone: {
    	        required: true,
    	        number:true,
    	        /***异步调用**/
    	    	remote: {
				    url: "${ctx!}/admin/other/user/check_username",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        keyValue: function() {
				            return $("#phone").val();
				        },
				        isEdit:function(){
				        	return $("#isEdit").val();
				        },
				        isChecked:function(){
				        	return 0;
				        }
				    },
				    dataFilter: function(data, type) { //返回结果
                        if (data == "true"){
                        	return true;
                        }
                        else{
	                        layer.msg("电话号码已经存在/输入的电话号码格式不正确", {time: 2000});
	                        return false;
                        }
                    }
				}
    	      },
    	      email: {
    	        required: true,
    	        email:true,
    	        /***异步调用**/
    	    	remote: {
				    url: "${ctx!}/admin/other/user/check_username",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        keyValue: function() {
				            return $("#phone").val();
				        },
				        isEdit:function(){
				        	return $("#isEdit").val();
				        }
				    },
				    dataFilter: function(data, type) { //返回结果
                        if (data == "true"){
                        	return true;
                        }
                        else{
	                        layer.msg("输入的邮件已经存在", {time: 2000});
	                        return false;
                        }
                    }
				}
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	var archived = $('input:radio[name="archived"]').attr("checked")?"true":"false";
    	    	var userObj = {
    	    			guid:$("#guid").val(),
    	    			username:$("#username").val(),
    	    			password:$("#password").val(),
    	    			phone:$("#phone").val(),
    	    			email:$("#email").val(),
    	    			archived:archived
    	    	};
    	    	var userJson = {
    	    		userJson:JSON.stringify(userObj),
    	    		isEdit:$("#isEdit").val()
    	    	};
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/other/user/edit",
   	    		   data:userJson,
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000},function(){
	   						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	   						parent.layer.close(index);
	   					});
   	    		   }
   	    		});
            }
    	});
    });
    </script>
</body>
</html>