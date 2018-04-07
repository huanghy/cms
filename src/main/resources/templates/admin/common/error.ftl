<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 错误页面</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1><img src="/hadmin/img/error.png"/></h1>
        <h3 class="font-bold"><#if errMsg?exists>${errMsg}<#else>页面未找到！</#if></h3>
    </div>
    <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js?v=3.3.6"></script>
</body>
</html>