<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑部门</title>
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
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="frm" method="post" action="${ctx!}/sys/org/editdepart">
                        	<input type="hidden" id="id" name="id" value="${department.id}">
                        	<input type="hidden" id="unitid" name="unitid" value="${unitid}">
                        	<input type="hidden" id="departmentId" name="departmentId" value="${departmentId}">
                    		<input type="hidden" id="layerIndex"  value="">
                    		<input type="hidden" id="nodeId"  value="">
                    		<input type="hidden" id="state"  value="">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">部门名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" class="form-control" type="text" value="${department.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">部门电话：</label>
                                <div class="col-sm-8">
                                    <input id="phone" name="phone" class="form-control" value="${department.phone}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">部门传真：</label>
                                <div class="col-sm-8">
                                    <input id="fax" name="fax" class="form-control" value="${department.fax}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">排序：</label>
                                <div class="col-sm-8">
                                    <input id="sort" name="sort" class="form-control" value="<#if department?exists>${department.sort}<#else>${sort}</#if>" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注：</label>
                                <div class="col-sm-8">
                                    <input id="remark" name="remark" class="form-control" value="${department.remark}">
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
    	/***设置层ID ***/
    	function assLayerIndex(layerIndex,state,nodeId){
    		$("#layerIndex").val(layerIndex);
    		$("#state").val(state);
    		$("#nodeId").val(nodeId);
    	}
	    $(document).ready(function () {			
		    $("#frm").validate({
	    	    rules: {
	    	    	name: {
	    	        required: true,
	    	        maxlength:15,
					remote:{
					  url:"/admin/department/verifyDeptName",
					  type : "get",
					  dataType:"json",
					  data : {
						  "deptName":function(){
						  	return jQuery("#name").val();
						  },
						  "unitId":function(){
						  	return $("#unitid").val();
						  }
					  }
					}
	    	      },
	    	      	abbrevName: {
	    	        required: true
	    	      },
	    	      	address: {
	    	        required: true
	    	      },
	    	      	phone: {
	    	        required: false,
	    	        isTel:true
	    	      },
	    	      	fax: {
	    	        required: false,
	    	        isTel:true
	    	      },
	    	      	sort: {
	    	      	number:true,
	    	        required: true
	    	      }
	    	    },
	    	    messages: {phone:{isTel:"电话号码格式不对"},fax:{isTel:"传真格式不对"},name:{maxlength:"请输入{0}个汉字！",remote:"部门名称已存在！"}},
	    	    submitHandler:function(form){
	    	    	$.ajax({
	   	    		   type: "POST",
	   	    		   dataType: "json",
	   	    		   url: "${ctx!}/sys/org/editdepart",
	   	    		   data: $(form).serialize(),
	   	    		   success: function(msg){
		   	    			layer.msg(msg.message, {time: 2000},function(){
		   						if(msg.code==0){
			   	    					$("#id").val(msg.data.id);
				   	    				var layerIndex = $("#layerIndex").val();
				   	    				var obj = {
							    			id:$("#id").val(),
							    			text:$("#name").val()
							    		}
							    		var state = $("#state").val();
							    		var nodeId = $("#nodeId").val();
							    		parent.editTree(state,obj,nodeId,1)
				   						parent.layer.close(layerIndex);
	   	    					}
		   					});
	   	    		   }
	   	    		});
	            }
	    	});
	    	
	    	// 电话号码验证 
			jQuery.validator.addMethod("isTel", function(value, element) { 
			  var tel = /^\d{3,4}-?\d{7,9}$/; //电话号码格式010-12345678 
			  return this.optional(element) || (tel.test(value)); 
			}, "请正确填写您的电话号码"); 
			
	    });
    </script>
</body>
</html>
