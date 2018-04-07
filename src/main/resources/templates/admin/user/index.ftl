<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <div class="affair-tit">用户管理</div>
                    </div>
                    <div class="ibox-content">
                        <p>
                        	<@shiro.hasPermission name="system:user:add">
                        		<button class="btn btn-success addbtns" type="button" onclick="addUser();"><i class="fa fa-plus"></i>&nbsp;添加人员</button>
                        	</@shiro.hasPermission>
                        	<button class="btn btn-success export" type="button" onclick="add();"><i class="fa fa-plus"></i>&nbsp;批量导出</button>
                        </p>
                        <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <div class="example">
		                            	<table id="table_list"></table>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 全局js -->
	<#include "/admin/common/common.ftl">
    <!-- Page-Level Scripts -->
    <script type="text/javascript" >
    	<#if userPassword?exists >
			var userPassword = "${userPassword}";
		</#if>
        	/***
        	**加载用户信息
      		*/
        	function loadUserTable(){
        		try{
	        		//初始化表格,动态从服务器加载数据
					$("#table_list").bootstrapTable({
					    //使用get请求到服务器获取数据
					    method: "POST",
					    //必须设置，不然request.getParameter获取不到请求参数
					    contentType: "application/x-www-form-urlencoded",
					    //获取数据的Servlet地址
					    url: "${ctx!}/admin/user/list",
					    //表格显示条纹
					    striped: true,			    
					    //启动分页
					    classes:"table table-hover filelist",
					    pagination: true,
					    //每页显示的记录数
					    pageSize: 10,
					    //当前第几页
					    pageNumber: 1,
					    //记录数可选列表
					    pageList: [5, 10, 15, 20, 25],
					    //是否启用查询
					    search:false,
					    //是否启用详细信息视图
					    //detailView:true,
					    //detailFormatter:detailFormatter,
					    //表示服务端请求
					    sidePagination: "server",
					    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
					    //设置为limit可以获取limit, offset, search, sort, order
					    queryParamsType: "undefined",
					    //json数据解析
					    responseHandler: function(res) {
					        return {
					            "rows": res.content,
					            "total": res.totalElements
					        };
					    },
					    //数据列
					    columns: [{
					        title: "用户名",
					        field: "userName"
					    },{
					        title: "所属角色",
					        field: "roles",
					        formatter: function(value, row, index) {
		                    	var r = "";
		                    	$(value).each(function (index,role){
		                    		r = r + "【" + role.name + "】";
		                    	});
		                    	return r;
		                    }
					    },{
					        title: "姓名",
					        field: "humanName"
					    },{
					        title: "性别",
					        field: "sex",
					        formatter: function(value, row, index) {
		                        if (value == '0')
		                        	return '女';
		                        return '男';
		                    }
					    },{
					        title: "出生日期",
					        field: "birthday"
					    },{
					        title: "电话",
					        field: "phone"
					    },{
					        title: "邮箱",
					        field: "email"
					    },{
					        title: "状态",
					        sortable: true,
					        field: "deleteStatus",
		                    formatter: function (value, row, index) {
		                        if (value == '1'){
		                        	return "已删除";
		                        } else {
		                        	return "";
		                        }
		                    }
					    },{
					        title: "锁定",
					        field: "locked",
					        formatter: function (value, row, index) {
		                        if (value == '1'){
		                        	return "锁定";
		                        }else{
		                        	return "";
		                        }
		                    }
					    },{
					        title: "操作",
					        field: "empty",
					        width:200,
		                    formatter: function (value, row, index) {
		                                   operateHtml="<@shiro.hasPermission name="system:user:edit"><i class='fa fa-edit warter' title='修改' onclick=editUser('"+row.id+"')></i></@shiro.hasPermission>"+
		                        			"<@shiro.hasPermission name="system:user:deleteBatch"><i class='fa fa-trash-o warter' title='删除' onclick=delUser('"+row.id+"')></i></@shiro.hasPermission>"+
		                        			"<@shiro.hasPermission name="system:user:grant"><i class='fa fa-chain warter' title='关联角色' onclick=grant('"+row.id+"') ></i></@shiro.hasPermission>"+
		                        			"<i class='fa fa-unlock warter' onclick=reset('"+row.id+"') title='重置密码'  ></i>"+
		                        			"<i class='fa fa-sitemap warter' title='设置岗位' onclick=grantpower('"+row.id+"') ></i>"+
		                        			"<i class='fa fa-group warter' title='设置部门负责人' onclick=dephuman('"+row.id+"') ></i>";
		                        return operateHtml;
		                    }
					    }]
					});
        		}catch(e){
        			console.log('loadUserTable'+e);
        		}
        	}
</script>
<script src="${ctx!}/oa/js/sys/user.js"></script>
</body>
</html>
