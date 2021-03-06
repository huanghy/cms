<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 表单验证 jQuery Validation</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=${version!}" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">                 
                    <form class="form-horizontal m-t ui-box" id="frm" method="post" action="${ctx!}/admin/role/edit">
                    	<input type="hidden" id="id" name="id" value="${role.id}">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色key：</label>
                            <div class="col-sm-8">
                                <input id="roleKey" name="roleKey" class="form-control" type="text" value="${role.roleKey}" <#if role?exists> readonly="readonly"</#if> >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色名称：</label>
                            <div class="col-sm-8">
                                <input id="name" name="name" class="form-control" type="text" value="${role.name}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">状态：</label>
                            <div class="col-sm-8">
                            	<select name="status" class="form-control">
                            		<option value="0" <#if role.status == 0>selected="selected"</#if>>正常</option>
                            		<option value="1" <#if role.status == 1>selected="selected"</#if>>禁用</option>
                            	</select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">描述：</label>
                            <div class="col-sm-8">
                                <input id="description" name="description" class="form-control" value="${role.description}">
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
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {
    	    	roleKey: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 30
    	      },
    	        name: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 30
    	      },
    	        status: {
    	        required: true
    	      },
    	      	description: {
    	        required: true,
    	        maxlength: 40
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/role/edit",
   	    		   data: $(form).serialize(),
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
