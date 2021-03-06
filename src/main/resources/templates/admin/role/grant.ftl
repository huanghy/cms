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
    <link href="${ctx!}/hadmin/css/plugins/zTree/zTreeStyle/zTreeStyle.css?v=${version!}" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12"> 
                 <ul id="tree" class="ztree"></ul>
				<div class="col-sm-12 text-center">
					<button class="btn btn-danger cel mr10" type="button">取消</button>
					<button class="btn btn-primary subbut" type="button" id="btnSave">保存</button>
				</div>
            </div>
        </div>
    </div>
    <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js"></script>
    <script src="${ctx!}/hadmin/js/content.js?v=${version!}"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/laydate/laydate.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/zTree/jquery.ztree.all.min.js"></script>
	<script type = "text/javascript">
	var setting = {
		check : {
			enable : true
		},
		data : {
			simpleData : {
				enable : true
			}
		}
	};
	setting.check.chkboxType = {
		"Y" : "ps",
		"N" : "s"
	};
	$(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "${ctx!}/admin/resource/tree/${role.id}",
			dataType : 'json',
			success : function(msg) {
				$.fn.zTree.init($("#tree"), setting, msg);
			}
		});

		$("#btnSave").click(function (){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getCheckedNodes(true);
			var selectIds="";
			for(var index in nodes){
				var item=nodes[index];
				selectIds+=item.id+",";
			}
			$.ajax({
				url : "${ctx!}/admin/role/grant/${role.id}",
				type : "post",
				dataType : "json",
				data : {"resourceIds":selectIds},
				success : function(msg) {
					layer.msg(msg.message, {time: 2000},function(){
   						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
   						parent.layer.close(index);
   					});
				},
				error : function(r,s,m) {
				}
			});

		});
	});
	</script>
</body>
</html>
