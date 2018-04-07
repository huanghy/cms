<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑岗位</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
    <style>
		   *{padding:0px;margin:0px;}
		   ul li{list-style: none;}
		   .boxtree .depart{display: block;}
		   .boxtree .none{display:none;}
		   .boxtree .folder,.boxtree .flied{height:25px;line-height:25px;}	
		   .boxtree .folder.fa,.flied.fa{position:relative;display: block;}
		   .boxtree li{cursor:pointer;padding-left:20px}
		   .fa-plus-square:before{position:absolute;top:0px;left:-17px;}
		   .fa-minus-square:before{position:absolute;top:0px;left:-17px;}
		    
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                    <div class="col-sm-12">
                        <form class="form-horizontal m-t" id="frm" method="post" action="${ctx!}/sys/org/editpost">
                        	<input type="hidden" id="id" name="id" value="${post.id}">
                            <input id="unitid" name="unitid" type="hidden" value="${unitid}">
                            <input id="deptId" name="deptId" type="hidden" value="${deptId}">
                            <input type="hidden" id="layerIndex"  value="">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">岗位名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" class="form-control" type="text" value="${post.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">排序：</label>
                                <div class="col-sm-8">
                                    <input id="sort" name="sort" class="form-control" value="<#if post?exists>${post.sort}<#else>${sort}</#if>" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注：</label>
                                <div class="col-sm-8">
                                    <input id="remark" name="remark" class="form-control" value="${post.remark}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12 text-center">
                                    <button class="btn btn-primary subbut" type="submit">保存</button>
                                </div>
                            </div>
                        </form>
                	</div>
               </div>
        </div>
    </div>
 	<!--全局js-->
    <#include "/admin/common/common.ftl">
    <script type="text/javascript">
    /***设置层ID ***/
	function assLayerIndex(layerIndex){
		$("#layerIndex").val(layerIndex);
	}
	
	/***初始化加载**/
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {
    	      	unitid:{
    	      	required: true
    	      },deptId:{
    	      	required: true
    	      },name:{
    	      	required: true,
    	      	maxlength:15,
				remote:{
				  url:"/admin/post/verifyPostName",
				  type : "get",
				  dataType:"json",
				  data : {
					  "postName":function(){
					  	return $("#name").val();
					  },
					  "deptId":function(){
					  	return $("#deptId").val();
					  },
					  "unitid":function(){
					  	return $("#unitid").val();
					  }
				  }
				}
    	      },remark:{
    	      	 maxlength:40
    	      }
    	    },
    	    messages: {name:{maxlength:"请输入{0}个汉字！",remote:"该单位、部门下已存在您输入的岗位！"},remark:{maxlength:"请输入{0}个汉字！"}},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/sys/org/editpost",
   	    		   data: $(form).serialize(),
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000},function(){
	   						if(msg.code==0){
		   	    				var layerIndex = $("#layerIndex").val();
		   						parent.layer.close(layerIndex);
	   	    				}
	   					});
   	    		   }
   	    		});
            }
    	});
    });
    </script>
</body>
</html>
