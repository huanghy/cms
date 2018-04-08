<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>推广类型管理</title>
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
		   .boxtree .folder,.boxtree .flied{height:30px;line-height:30px;}	
		   .boxtree .folder.fa,.boxtree .flied.fa{position:relative;display: block;}
		   .boxtree li{cursor:pointer;padding-left:20px}
		   .fa-plus-square:before{position:absolute;top:0px;left:-17px;}
		   .fa-minus-square:before{position:absolute;top:0px;left:-17px;}
		   .folder.curr,.flied.curr{background:#F8F8F8;}
		   .patree{padding:5px 0px 0px 10px}	
		   .form-group .col-sm-3{width:20%;line-height: 2rem;}	
		   .form-group .col-sm-9{width:80%}	    
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <form class="form-horizontal m-t ui-box" id="frm" method="post">
            	<input type="hidden" id="id" name="id" value="${exType.id}">
                <div class="form-group" style="display: flex;">
                    <label class="col-sm-3 control-label" for="typeName">推广类型名称:</label>
                    <div class="col-sm-9">
                        <input id="typeName" name="typeName" class="form-control"   type="text" value="${exType.typeName}">
                    </div>
                </div>
                <div class="form-group" style="display: flex;">
                    <label class="col-sm-3 control-label">排序:</label>
                    <div class="col-sm-9">
                        <input id="sort" name="sort" class="form-control"   value="<#if exType?exists>${exType.sort}<#else>${sort}</#if>" readonly="readonly">
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
    <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js"></script>
    <!-- jQuery Validation plugin javascript-->
    <script src="${ctx!}/hadmin/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {
    	    	typeName: {
    	        	required: true,
    	        }
    	    },
    	    messages: {
    	    },
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/oa/exty/edit",
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
