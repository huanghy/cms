<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新闻类型from</title>
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
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                 	<div class="row">
                		<!--<div class="col-sm-3">
                			<div class="example-wrap">
	                            <div class="example patree">
	                            	<ul class="boxtree cf" id="objtree"></ul>
	                            </div>
	                        </div>
                		</div>-->
                		<div class="col-sm-12">
		                        <form class="form-horizontal m-t ui-box" id="frm" method="post" action="${ctx!}/oa/obj/edit">
		                        	<input type="hidden" id="id" name="id" value="${obj.id}">
		                        	<input type="hidden" id="createDate" name="createDate" value="${obj.createDate}">
		                        	<input type="hidden" id="createUser" name="createUser" value="${obj.createUser}">
		                        	<input type="hidden" id="entCode" name="entCode" value="${obj.entCode}">
		                        	<input type="hidden" id="pId" name="parent.id" value="${obj.parent.id}">
		                        	<input type="hidden" id="newtype" name="newtype" value="${newtype}">
		                        	<input type="hidden" id="unitId" name="unitId" value="0000">
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">新闻类型名称：</label>
		                                <div class="col-sm-8">
		                                    <input id="secName" name="secName" class="form-control" type="text" value="${obj.secName}">
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">排序：</label>
		                                <div class="col-sm-8">
		                                    <input id="sort" name="sort" class="form-control" value="${obj.sort}" readonly="readonly">
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
        </div>
    </div>

    <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js"></script>

    <!-- 自定义js -->
    <script src="${ctx!}/hadmin/js/content.js?v=${version!}"></script>

    <!-- jQuery Validation plugin javascript-->
    <script src="${ctx!}/hadmin/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
    	$("#sort").val(${sort});
	    $("#frm").validate({
    	    rules: {
    	    	secName: {
    	        required: true,
    	      },
    	      	unitId: {
    	        required: true,
    	      },
    	      	sort: {
    	      	number:true,
    	        required: true
    	      }
    	    },
    	    messages: {
    	    },
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/oa/newsection/edit",
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
