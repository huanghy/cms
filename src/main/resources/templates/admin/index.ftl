<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>个人推广后台系统V1.5</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.min.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=${version!}" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper" class="whitebg">
        <!--左侧导航开始-->
         <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <a class="logoa" href="javascript:">
                    	<span class="imlf">个人推广</span>
                    </a>
                    <!--<ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-user"></i> <span class="label label-primary"></span>【<@shiro.principal type="com.cqunis.entity.User" property="humanName"/>】
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                    <a href="${ctx!}/admin/logout">
                                        <div>
                                            <i class="fa fa-remove"></i> 注销
                                            <span class="pull-right text-muted small"><@shiro.principal type="com.cqunis.entity.User" property="userName"/></span>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>-->
                    <div class="pull-right personal">                    	
                    	 <span class="parsp">
                    	 	<em class="im">
                    	 	 <img   width="40" height="39"  src="<#if currentUser.imageUrl?exists>${currentUser.imageUrl}<#else>${ctx!}/hadmin/img/header.png</#if>"/>
                    	 	</em>
                    	 	<ul class="showpr none">
                    	 		<li class="name"><@shiro.principal type="com.cqunis.entity.User" property="humanName"/></li>
                    	 		<li><a href="${ctx!}/admin/common/user_info" target="J_iframe" >个人资料</a></li>
                    	 		<li><a href="${ctx!}/admin/common/personal_pass"   target="J_iframe">修改密码</a></li>
                    	 	</ul>
                    	 </span>
                    	 <a href="javascript:" class="switch" >
                    	 	<i class="fa fa-power-off"></i>
                    	 </a>
                    </div>
               </nav>        
        	<nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li>
                        <a class="J_menuItem" href="${ctx!}/admin/welcome">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">首页</span>
                        </a>
                    </li>
                    <!--<@shiro.hasPermission name="oa:new:index">
						<li>
	                        <a href="#">
	                            <i class="fa fa-file-text"></i>
	                            <span class="nav-label">企业新闻</span>
	                            <span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level">
	                         <@shiro.hasPermission name="oa:newsection:index">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/oa/newsection/index/0">新闻类型</a>
	                            </li>
	                         </@shiro.hasPermission>
	                          <@shiro.hasPermission name="oa:new:edit">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/oa/new/edit/0">发布新闻</a>
	                            </li>
	                         </@shiro.hasPermission>
	                         <@shiro.hasPermission name="oa:new:list">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/oa/new/index/0">新闻列表</a>
	                            </li>
	                         </@shiro.hasPermission>
	                        </ul>
	                    </li>
                    </@shiro.hasPermission>-->
					<@shiro.hasPermission name="oa:exte:index">
						<li>
	                        <a href="#">
	                            <i class="fa fa-file-text"></i>
	                            <span class="nav-label">推广管理</span>
	                            <span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level">
	                         <@shiro.hasPermission name="oa:exte:index">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/oa/exte/index">推广任务</a>
	                            </li>
	                         </@shiro.hasPermission>
							<@shiro.hasPermission name="oa:exty:index">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/oa/exty/index">广告类型</a>
	                            </li>
	                         </@shiro.hasPermission>
	                        </ul>
	                    </li>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="system:index">
	                    <li>
	                        <a href="javascript:void(0)">
	                            <i class="fa fa-sitemap"></i>
	                            <span class="nav-label">系统管理</span>
	                            <span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level">
	                        	<!--<@shiro.hasPermission name="system:org:index">
		                        	<li>
		                               <a class="J_menuItem" href="${ctx!}/sys/org/index">组织架构</a>
		                            </li>
	                            </@shiro.hasPermission>
								<@shiro.hasPermission name="system:enterp:index">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/sys/enterp/index">企业设置</a>
	                            </li>
	                            </@shiro.hasPermission>-->
	                         <@shiro.hasPermission name="system:user:index">
	                            <li>
	                               <a class="J_menuItem" href="${ctx!}/admin/user/index">用户管理</a>
	                            </li>
	                         </@shiro.hasPermission>
	                         <@shiro.hasPermission name="system:role:index">
	                            <li>
	                                <a class="J_menuItem" href="${ctx!}/admin/role/index">角色管理</a>
	                            </li>
	                         </@shiro.hasPermission>
	                         <!--<@shiro.hasPermission name="system:group:index">
	                            <li>
	                                <a class="J_menuItem" href="${ctx!}/admin/group/index">分组管理</a>
	                            </li>
	                         </@shiro.hasPermission>
	                         <@shiro.hasPermission name="system:commpost:index">
	                            <li>
	                                <a class="J_menuItem" href="${ctx!}/admin/commpost/index">职位管理</a>
	                            </li>
	                         </@shiro.hasPermission>-->
	                         <@shiro.hasPermission name="system:resource:index">
	                            <li>
	                                <a class="J_menuItem" href="${ctx!}/admin/resource/index">资源管理</a>
	                            </li>
	                         </@shiro.hasPermission>
	                        </ul>
	                    </li>
					</@shiro.hasPermission>             
                    <li class="line dk"></li>
                </ul>
            </div>
            <div class="navbtn">
            	<a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#">
            		<i class="fa fa-outdent"></i><span>收起导航</span>
            	</a>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">               
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe id="J_iframe" name="J_iframe" width="100%" height="100%" src="${ctx!}/admin/welcome" frameborder="0" data-id="index_v1.html" seamless></iframe>
            </div>
        </div>
        <!--右侧部分结束-->
    </div>
    <!-- 全局js -->
    <script src="${ctx!}/hadmin/js/jquery.min.js"></script>
    <script src="${ctx!}/hadmin/js/bootstrap.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="${ctx!}/hadmin/js/plugins/layer/layer.min.js?v=${version!}"></script>
    <!-- 自定义js -->
    <script src="${ctx!}/hadmin/js/hAdmin.js"></script>
    <script type="text/javascript" src="${ctx!}/hadmin/js/index.js?v=${version!}"></script>
    <script type="text/javascript">
         $(".switch .fa").on('click',function(){
			layer.confirm('确定退出吗?', {icon: 3, title:'提示'}, function(index){
			   window.location.href="${ctx!}/admin/logout";		
			 })
		})
    </script>
</body>
</html>
