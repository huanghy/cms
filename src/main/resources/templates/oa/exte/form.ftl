<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>推广管理</title>
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
                		<div class="col-sm-12">
		                        <form class="form-horizontal m-t ui-box" id="frm" method="post">
		                        	<input type="hidden" id="id" name="id" value="${extension.id}">
		                        	<input type="hidden" id="taskState" name="taskState" value="<#if extension?exists>${extension.taskState}<#else>-1</#if>">
		                       		<input type="hidden" id="alrAd" name="alrAd" value="<#if extension?exists>${extension.alrAd}<#else>0</#if>">
		                       		<input type="hidden" id="actualAmount" name="actualAmount" value="<#if extension?exists>${extension.actualAmount}<#else>0.00</#if>">
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">推广名称：</label>
		                                <div class="col-sm-8">
		                                    <input id="exName" name="exName" class="form-control" type="text" value="${extension.exName}">
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">广告类型：</label>
		                                <div class="col-sm-8">
		                                	<input type="hidden" id="exTypeName" name="exTypeName" value="${extension.exTypeName}">
		                                    <select  id="exTypeId" name="exTypeId" class="form-control">
											<option  value="0" <#if extension.exTypeId=="0" >selected="selected"</#if> >微信朋友圈</option>
											<option  value="1" <#if extension.exTypeId=="1" >selected="selected"</#if> >微信群</option>
											<option  value="2" <#if extension.exTypeId=="2" >selected="selected"</#if> >QQ群</option>
											<option  value="3" <#if extension.exTypeId=="3" >selected="selected"</#if> >微信公众号</option>
											<option  value="4" <#if extension.exTypeId=="4" >selected="selected"</#if> >综合推广</option>
										</select> 
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">投放金额：</label>
		                                <div class="col-sm-8">
		                                    <input id="invAmount" name="invAmount" class="form-control" type="text" value="<#if extension?exists>${extension.invAmount}<#else>5000</#if>">
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">推广单价：</label>
		                                <div class="col-sm-8">
		                                    <input id="unitPrice" name="unitPrice" class="form-control" type="text" value="<#if extension?exists>${extension.unitPrice}<#else>0.95</#if>">
		                                </div>
		                            </div>
		                             <div class="form-group">
		                                <label class="col-sm-3 control-label">地域：</label>
		                                <div class="col-sm-8">
		                                    <input id="region" name="region" class="form-control" type="text" value="中国" readonly="readonly" >
		                                </div>
		                            </div>
		                             <div class="form-group">
		                                <label class="col-sm-3 control-label">结束时间：</label>
		                                <div class="col-sm-8">
		                                    <input id="endTime" name="endTime" class="laydate-icon form-control layer-date" type="text" value="${extension.endTime}" >
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">广告类型：</label>
		                                <div class="col-sm-8">
		                                	<input type="hidden" id="humanName" name="humanName" value="${extension.humanName}">
		                                    <select  id="humanId" name="humanId" class="form-control">
											<#if users?exists>
												<#list users as user>
													<option  value="${user.id}" <#if extension?exists&&user.id==extension.humanId >selected="selected"</#if> >${user.humanName}</option>
												</#list>
											</#if>
										</select> 
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-3 control-label">排序：</label>
		                                <div class="col-sm-8">
		                                    <input id="sort" name="sort" class="form-control" value="${extension.sort}" readonly="readonly">
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
    <!-- jQuery Validation plugin javascript-->
    <script src="${ctx!}/hadmin/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
    layer.config({extend:'extend/layer.ext.js'});
		 //外部js调用
	    laydate({
		    elem: '#endTime',
		        event: 'focus',
		        istime: true,   
		        format:'YYYY-MM-DD hh:mm:ss'
		    });
    $(document).ready(function () {
    	$("#sort").val(${sort});
	    $("#frm").validate({
    	    rules: {
    	    	exName: {
    	        required: true,
    	      },
    	      	invAmount: {
    	      	number:true,
    	      	min:5000,
    	      	max:100000,
    	        required: true,
    	      },
    	      exTypeId: {
    	        required: true,
    	      },
    	      endTime: {
    	        required: true,
    	      },
    	      unitPrice: {
    	      	number:true,
    	        required: true
    	      }
    	    },
    	    messages: {
    	    },
    	    submitHandler:function(form){
    	    	$("#humanName").val($("#humanId  option:selected").text());
    	    	$("#exTypeName").val($("#exTypeId  option:selected").text());
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/oa/exte/edit",
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
