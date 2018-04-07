<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <title> - 登录</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/login.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>
        if (window.top !== window.self) {
            window.top.location = window.location;
        }
    </script>

</head>

<body class="signind">
	<div class="logoim">
		<img src="${ctx!}/hadmin/img/logind.png"/>
	</div>
	<div class="eash">
	  <img src="${ctx!}/hadmin/img/shougd.png"/>
	</div>
	<div class="loginbig">
		<img src="${ctx!}/hadmin/img/login-big.png"/>
	</div>
    <div class="signinpanel">        
    	<#if message?exists >
        	<div class="alert alert-danger">
                ${message!}
            </div>
        </#if>
        <form method="post" action="${ctx!}/admin/login" id="frm">
            <h4 class="no-margins">
            	<strong>欢迎,</strong>
            	<span>登录办公oa系统</span>
            </h4>
            <div class="titd">用户名/user:</div>
            <input type="text" class="form-control uname" name="username" id="username" placeholder="用户名" />
            <div class="titd">密码/KEY:</div>
            <input type="password" class="form-control pword m-b" name="password" id="password"  placeholder="密码" />
            <div class="forget text-right">*忘记密码,请联系管理员</div>
            <button class="btn loginbtn btn-success btn-block">登录</button>
        </form>
    </div>

     <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js?v=3.3.6"></script>

    <!-- 自定义js -->
    <script src="${ctx!}/hadmin/js/content.js?v=1.0.0"></script>

    <!-- jQuery Validation plugin javascript-->
    <script src="${ctx!}/hadmin/js/plugins/validate/jquery.validate.min.js"></script>
    <!-- layer -->
	<script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/validate/messages_zh.min.js"></script>
	<script type="text/javascript">
    $().ready(function() {
		<#if errMsg?exists >
			var errMsg = "${errMsg}";
			layer.msg(errMsg, {time: 2000});
		</#if>
    	// 在键盘按下并释放及提交后验证提交表单
    	  $("#frm").validate({
    	    rules: {
    	      username: {
    	        required: true,
    	        minlength: 2
    	      },
    	      password: {
    	        required: true,
    	        minlength: 5
    	      }
    	    },
    	    messages: {
    	      username: {
    	        required: "请输入用户名",
    	        minlength: "用户名必需由两个字母组成"
    	      },
    	      password: {
    	        required: "请输入密码",
    	        minlength: "密码长度不能小于 6 个字母"
    	      }
    	    },
    	    submitHandler:function(form){
                form.submit();
            }
    	});
    });
    </script>
</body>

</html>
