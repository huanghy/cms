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
                        <form class="form-horizontal m-t" id="frm" method="post" action="${ctx!}/admin/other/oauth_client_details/edit">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">应用ID：</label>
                                <div class="col-sm-8">
                                
                                    <input id="isEdit" name="isEdit" class="form-control" type="hidden" value="${isEdit}" >
                                    <input id="clientId" name="clientId" class="form-control" type="text" value="${oauthClientDetails.clientId}" <#if oauthClientDetails?exists> readonly="readonly"</#if> >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">权限：</label>
                                <div class="col-sm-8">
                                	<input type="checkbox" id="scopea" <#if oauthClientDetails?exists&&oauthClientDetails.scope?index_of("read")!=-1 > checked="checked" </#if> />读
									<input type="checkbox" id="scopeb" <#if oauthClientDetails?exists&&oauthClientDetails.scope?index_of("write")!=-1 > checked="checked" </#if> />写
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">验证类型：</label>
                                <div class="col-sm-8">
                                	<input type="checkbox" id="authorizedGrantTypesa" <#if oauthClientDetails?exists&&oauthClientDetails.authorizedGrantTypes?index_of("password")!=-1 > checked="checked" </#if> />password
									<input type="checkbox" id="authorizedGrantTypesb" <#if oauthClientDetails?exists&&oauthClientDetails.authorizedGrantTypes?index_of("refresh_token")!=-1 > checked="checked" </#if> />refresh_token
									<input type="checkbox" id="authorizedGrantTypesc" <#if oauthClientDetails?exists&&oauthClientDetails.authorizedGrantTypes?index_of("authorization_code")!=-1 > checked="checked" </#if> />authorization_code
									<input type="checkbox" id="authorizedGrantTypesd" <#if oauthClientDetails?exists&&oauthClientDetails.authorizedGrantTypes?index_of("implicit")!=-1 > checked="checked" </#if> />implicit
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">回调地址：</label>
                                <div class="col-sm-8">
                                    <input id="webServerRedirectUri" name="webServerRedirectUri" class="form-control" value="${oauthClientDetails.webServerRedirectUri}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">是否归档：</label>
                                <div class="col-sm-8">
	                                  	<input type="radio" id="archiveda" name="archived" <#if oauthClientDetails?exists&&oauthClientDetails.archived > checked="checked" </#if> />是
										<input type="radio" id="archivedb" name="archived" <#if oauthClientDetails?exists&&!oauthClientDetails.archived > checked="checked" </#if> />否
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
    	    	clientId: {
    	        required: true,
    	        minlength: 10,
    	    	maxlength: 20,
    	    	/***异步调用**/
    	    	remote: {
				    url: "${ctx!}/admin/other/oauth_client_details/checkclientId",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				        clientId: function() {
				            return $("#clientId").val();
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
	                        layer.msg("应用ID已经存在", {time: 2000});
	                        return false;
                        }
                    }
				}
    	      },
    	      webServerRedirectUri: {
    	        required: true,
    	        url:true,
    	        minlength: 10,
    	    	maxlength: 50
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	        var scope = ($('#scopea').is(':checked')?"read":"")+","+($('#scopeb').is(':checked')?"write":"");
    	        var authorizedGrantTypes = ($('#authorizedGrantTypesa').is(':checked')?"password":"")+","+($('#authorizedGrantTypesb').is(':checked')?"refresh_token":"")+","+($('#authorizedGrantTypesc').is(':checked')?"authorization_code":"")+","+($('#authorizedGrantTypesd').is(':checked')?"implicit":"");
    	    	var archived = $('input:radio[name="archived"]').attr("checked")?"true":"false";
    	    	var clientDetails = {
    	    			clientId:$("#clientId").val(),
    	    			scope:scope,
    	    			authorizedGrantTypes:authorizedGrantTypes,
    	    			webServerRedirectUri:$("#webServerRedirectUri").val(),
    	    			archived:archived
    	    	};
    	    	var clientDetailsJson = {
    	    		clientDetailsJson:JSON.stringify(clientDetails),
    	    		isEdit:$("#isEdit").val()
    	    	};
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/other/oauth_client_details/edit",
   	    		   data:clientDetailsJson,
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