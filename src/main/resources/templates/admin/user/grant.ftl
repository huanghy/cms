<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设置角色</title>
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
            	<div class="lgray pl20">为用户[${user.humanName}]，设置关联角色权限</div>                  
                <form class="form-horizontal" id="frm" method="post">
                	<input type="hidden" id="id" name="id" value="${user.id}">
                    <table class="role">
                    	<#if roles?exists>
                    		<#list roles as role>
                    			<#if role_index%2==0>
                    				<tr>
                    			</#if>
								<td width="50%"><input type="checkbox" <#if roleIds?seq_contains(role.id)>checked="checked"</#if> value="${role.id}" name="roleIds"  >${role.name}</td>
                    			<#if (role_index+1)%2==0 || (role_index+1)==roles?size >
                    				<tr>
                    			</#if>
                    		</#list>
                    	</#if>
                    </table>
                    <div class="form-group">
                        <div class="col-sm-12 text-center mt50">
                        	<button class="btn btn-danger cel mr10" type="submit">取消</button>
                            <button class="btn btn-primary subbut" type="submit">确定</button>
                        </div>
                    </div>
                </form>                 
        </div>
    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <script type="text/javascript">
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {},
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/user/grant/" + "${user.id}",
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
