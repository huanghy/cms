<!DOCTYPE html>
<html>
	<head>
		<meta name="keywords" content="">
	    <meta name="description" content="">
	    <link rel="shortcut icon" href="favicon.ico">
	    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/bootstrap-treeview.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
		<style>
			.list-group-item:first-child {
				border-radius: 0px!important;
			}
			.list-group-item {
				border: none;
			}
			.treeview .list-group .list-group-item:hover{background:#E8F2FB}
			.treeview .list-group-item:hover .bge{transform: scale(1);display:inline-block;opacity:0.3;transition:all 0.3s ease-in-out;}
			.taids{padding:10px 18px 10px 10px;margin-top:15px;}
			#tree1 .list-group-item:last-child{border-radius:0px;}
			.bootstrap-table .comm>thead>tr>th{border-left:none;}
			.fixed-table-container tbody td{border-left:none !important}
			.fixed-table-container thead th{border-left:none!important}
			table.tablist tr td a{color:#666;}
			.nav.nav-tabd li{width:100%;}
			.treeview .list-group-item .bge{width: 20px;height: 20px;line-height:20px;display: inline-block;background: #1D80D6;border-radius: 50%;float: right;color: #fff;text-align: center;transform: scale(0.1);transition:all 0.3s ease-in-out;opacity:0;}
			.treeview .list-group-item.node-selected .bge{transform: scale(1);display:inline-block;opacity:1;transition:all 0.3s ease-in-out;}
			/*.nav.nav-tabd > li.active > a{width:120px;}*/
		</style>
	</head>
	<body class="gray-bg">
		<div class="wrapper cf  animated fadeInRight" >
			<div class="row mt20">
				<div class="col-sm-12">
				   <div class="ibox">
				   	  <div class="ibox-title">
							<div class="affair-tit">通讯录</div>
						</div>
						<div class="row">
							<div class="col-sm-4">
								<div class="txtbox txtlist">
									<i class="fa fa-search"></i>
									<input class="input" type="text" id="_searchText" placeholder="搜索联系人/部门/单位/岗位"/>
									<a href="javascript:void(0)" class="seachbtn" id="_search" >搜索</a>
								</div>
							</div>
							<div class="col-sm-8"></div>
						</div>
						<div class="row">
							<div class="col-sm-3">
								 <div class="ulbox ulboxc">
							       <ul  class="nav nav-tabd">
										<li class="active">
											<a href="#home" data-toggle="tab">
												组织架构
											</a>
										</li>				
									</ul>
									<div  class="tab-content">
										<div class="tab-pane fade newlist in active" id="home">
											<div id="_treeHtml"></div>
										</div>					
									</div>
								</div> 	
							</div>
							<div class="col-sm-9">
								<div class="mt20 pertab cf">
									<div class="pull-left">
										<i class="fa fa-user"></i>
									    <span id="_unitHtml" >单位人员</span>
									</div>
									<div class="pull-right mr10">
									</div>
								</div>
									<div class="taids">
										<table id="humanTable" class="tablist"></table>
									</div>
								
							</div>
						</div>
				   </div>
				</div>
		   </div>
		</div>
	</body>
	<!-- 全局js -->
	<#include "/admin/common/common.ftl">
	<script type="text/javascript" >
		<#if treeJson?exists >
			var treeJson = ${treeJson};
		</#if>
	</script>
	<script type="text/javascript" src="${ctx!}/oa/js/common/contacts.js"></script>
</html>