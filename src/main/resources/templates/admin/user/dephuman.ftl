<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设置部门负责人</title>
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
            	<div class="lgray pl20">将用户[${user.humanName}]，设置为部门负责人2</div>                  
                <form class="form-horizontal ui-box" id="frm" method="post" >
                    <!--<table class="role">
                    	<#if departmentHumans?exists>
                    		<#list departmentHumans as departmentHuman>
                      			<#if departmentHuman_index%2==0>
                    				<tr>
                    			</#if>
								<td width="50%">
										<select  id="${departmentHuman.id}mainDep" name="mainDep" >
											<option  value="-1" >--请选择--</option>
											<option  value="0" <#if departmentHuman?exists&&departmentHuman.mainDep==0&&departmentHuman.perInCharge==0 >selected="selected"</#if> >主负责人</option>
											<option  value="1" <#if departmentHuman?exists&&departmentHuman.mainDep==1&&departmentHuman.perInCharge==0 >selected="selected"</#if> >副负责人</option>
									    </select>
										${departmentHuman.unitName}>>${departmentHuman.depName}</td>
                    			<#if (departmentHuman_index+1)%2==0 || (departmentHuman_index+1)==departmentHumans?size >
                    				</tr>
                    			</#if>
                    		</#list>
                    	</#if>
                    </table>-->
                    <#list departmentHumans as departmentHuman>
                    <div class="form-group">
                    	<div class="row">
                    	   <label class="col-sm-2 control-label ml10">所在部门:</label>
                    	   <div class="col-sm-8 control-label tl ldark">
                    	   	 ${departmentHuman.unitName}/${departmentHuman.depName}
                    	   </div>
                    	</div>
                    	<div class="row">
                    	   <label class="col-sm-2 control-label ml10">负责人类型:</label>
                    	   <div class="col-sm-4 control-label tl">
                    	   	 <select  id="${departmentHuman.id}mainDep" name="mainDep" class="form-control valid ldark">
									<option  value="-1" >--请选择--</option>
									<option  value="0" <#if departmentHuman?exists&&departmentHuman.mainDep==0&&departmentHuman.perInCharge==0 >selected="selected"</#if> >主负责人</option>
									<option  value="1" <#if departmentHuman?exists&&departmentHuman.mainDep==1&&departmentHuman.perInCharge==0 >selected="selected"</#if> >副负责人</option>
							 </select>
                    	   </div>
                    	</div>
                    </div>
                    </#list>
                    <div class="form-group">
                        <div class="col-sm-12 text-center mt50">
                        	<button class="btn btn-danger cel mr10" type="button">取消</button>
                            <button class="btn btn-primary subbut" type="submit">确定</button>
                        </div>
                    </div>
                </form>                 
        </div>
    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <script type="text/javascript">
    <#if departmentHumanJson?exists>
    	var departmentHumanJson = ${departmentHumanJson};
    </#if>
    $(document).ready(function () {
	    $("#frm").validate({
    	    rules: {},
    	    messages: {},
    	    submitHandler:function(form){
    	    	/***获取负责人***/
    	    	if(typeof(departmentHumanJson)!='undefined' 
    	    		&& departmentHumanJson.length>0){
    	    		var departLength = departmentHumanJson.length;
    	    		for(var departIndex=0;departIndex<departLength;departIndex++){
    	    			var attrId=departmentHumanJson[departIndex].id+"mainDep";
    	    			departmentHumanJson[departIndex].mainDep=$("#"+attrId+" option:selected").val();
    	    		}
    	    	}
    	    	var data={
					dephumanJson:encodeURIComponent(JSON.stringify(departmentHumanJson))
				}
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/user/dephuman",
   	    		   data:data,
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
