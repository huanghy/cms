<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑用户</title>
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
               <form class="form-horizontal m-t ui-box" id="frm" method="post" action="${ctx!}/admin/user/edit">
                	<input type="hidden" id="id" name="id" value="${user.id}">
                	<input type="hidden" id="deleteStatus" name="deleteStatus" value="<#if user?exists>${user.deleteStatus}<#else>0</#if>">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">用户名：</label>
                        <div class="col-sm-8">
                            <input id="userName" name="userName" class="form-control" type="text" value="${user.userName}" <#if user?exists>readonly="readonly"</#if>  >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">姓名：</label>
                        <div class="col-sm-8">
                            <input id="humanName" name="humanName" class="form-control" type="text" value="${user.humanName}" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">年龄：</label>
                        <div class="col-sm-8">
                            <input id="age" name="age" class="form-control" type="text" value="${user.age}" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">性别：</label>
                        <div class="col-sm-8">
                        	<select name="sex" class="form-control">
                        		<option value="0" <#if user.sex == 0>selected="selected"</#if> >女</option>
                        		<option value="1" <#if user.sex == 1>selected="selected"</#if> >男</option>
                        	</select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">出生日期：</label>
                        <div class="col-sm-8">
                            <input id="birthday" name="birthday" readonly="readonly" class="laydate-icon form-control layer-date" value="${user.birthday}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-8">
                            <input id="phone" name="phone" class="form-control" value="${user.phone}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">办公电话：</label>
                        <div class="col-sm-8">
                            <input id="officePhone" name="officePhone" class="form-control" value="${user.officePhone}">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-sm-4 control-label">E-mail：</label>
                        <div class="col-sm-8">
                            <input id="email" name="email" class="form-control" value="${user.email}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">地址：</label>
                        <div class="col-sm-8">
                            <input id="address" name="address" class="form-control" value="${user.address}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">状态：</label>
                        <div class="col-sm-8">
                        	<select name="locked" class="form-control">
                        		<option value="0" <#if user.locked == 0>selected="selected"</#if>>未锁定</option>
                        		<option value="1" <#if user.locked == 1>selected="selected"</#if>>锁定</option>
                        	</select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">禁用：</label>
                        <div class="col-sm-8">
                        	<select name="daisble" class="form-control">
                        		<option value="0" <#if user.daisble == 0>selected="selected"</#if>>启用</option>
                        		<option value="1" <#if user.daisble == 1>selected="selected"</#if>>禁用</option>
                        	</select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">描述：</label>
                        <div class="col-sm-8">
                            <input id="remark" name="remark" class="form-control" value="${user.remark}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">排序：</label>
                        <div class="col-sm-8">
                            <input id="sort" name="sort" class="form-control" type="text" value="<#if user?exists >${user.sort}<#else>${sort}</#if>"  >
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12 text-center">
                        	<button class="btn btn-danger cel mr10">取消</button>
                            <button class="btn btn-primary subbut" type="submit">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <script type="text/javascript">
    	// 手机号码验证 
		jQuery.validator.addMethod("isMobile", function(value, element) { 
		  var length = value.length; 
		  var mobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
		  return this.optional(element) || (length == 11 && mobile.test(value)); 
		}, "请正确填写您的手机号码"); 	
		// 电话号码验证 
		jQuery.validator.addMethod("isTel", function(value, element) { 
			//电话号码格式010-12345678 
		  var tel = /^\d{3,4}-?\d{7,9}$/; 
		  return this.optional(element) || (tel.test(value)); 
		}, "请正确填写您的电话号码");
    	$(document).ready(function () {
			  	//外部js调用
			    laydate({
			    elem: '#birthday',
			        event: 'focus'
			    });
			    $("#frm").validate({
		    	    rules: {
			    	    	userName: {
				    	        required: true,
				    	        minlength: 2,
				    	    	maxlength: 10
				    	    	<#if user?exists>
				    	    		,remote:{
									  url:"/admin/user/verifyUserName",
									  type : "get",
									  dataType:"json",
									  data : {
										  "userName":function(){
										  		return $("#userName").val();
										  }
									  }
								}
							</#if>
			    	      },
			    	      humanName: {
			    	        required: true,
			    	        minlength: 2,
			    	    	maxlength: 10
			    	      },
			    	      sex: {
			    	        required: true
			    	      },
			    	      birthday: {
			    	      	date:true,
			    	        required: true
			    	      },
			    	      officePhone: {
			    	      	required: true,
			    	        isTel:true
			    	      },
			    	      phone: {
			    	      	required: true,
			    	        isMobile:true
			    	      },
			    	      email: {
			    	      	required: true
			    	      },
			    	      address: {
			    	        required: true,
			    	        maxlength: 40
			    	      },
			    	      locked: {
			    	        required: true
			    	      }
			    	    },
			    	    messages:{
								userName:{remote:"账户名已存在，请重新输入！"}
						},
			    	    submitHandler:function(form){
			    	    	$.ajax({
			   	    		   type: "POST",
			   	    		   dataType: "json",
			   	    		   url: "${ctx!}/admin/user/edit",
			   	    		   data: $(form).serialize(),
			   	    		   success: function(msg){
				   	    			layer.msg(msg.message,{time: 2000},function(){
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
