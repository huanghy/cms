<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--360浏览器优先以webkit内核解析-->
    <title> - 主页示例</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
    <link href='${ctx!}/fullcalendar/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${ctx!}/fullcalendar/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    	<div class="row">   
	        <label class="col-sm-2 control-label">可用余额：<#if welcomeBalance?exists>${welcomeBalance}</#if></label>
	        <label class="col-sm-2 control-label">今日消费：<font color="red" ><#if dayConsume?exists>${dayConsume}</#if></font></label>
            	
	        <label class="col-sm-2 control-label">账户状态：正常</label>
        </div>
</div>
<!-- 全局js -->
<script src="${ctx!}/hadmin/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx!}/hadmin/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
 <!-- 全局js -->
<#include "/admin/common/fullcalendar_common.ftl">
<!-- Flot -->
<!--<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.js"></script>-->
<!--<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.resize.js"></script>
<script src="${ctx!}/hadmin/js/plugins/flot/jquery.flot.pie.js"></script>-->
<!--flotdemo-->
</body>
</html>