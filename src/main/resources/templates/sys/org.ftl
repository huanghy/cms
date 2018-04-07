<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>组织架构</title>
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
			.treeview .list-group .list-group-item:hover{background:#D8E4F2}
			.taids{padding:10px 18px 10px 10px;margin-top:15px;}
			#tree1 .list-group-item:last-child{border-radius:0px;}
			.bootstrap-table .comm>thead>tr>th{border-left:none;}
			.fixed-table-container tbody td{border-left:none !important}
			.fixed-table-container thead th{border-left:none!important}
			table.tablist tr td a{color:#666;}
			.nav.nav-tabd li{width:100%;}
			#tree1 .list-group,#tree2 .list-group{height:260px;}
			.ys{float:right}
	    </style>
	</head>
	<body class="gray-bg">
			<input type="hidden" id="unitid" name="unitid" value="">
			<input type="hidden" id="deptId" unitId="" name="deptId" value="">
		<div class="wrapper wrapper-content cf  animated fadeInRight">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox">
						<div class="ibox-title">
							<div class="affair-tit">
								组织架构
							</div>
						</div>
						<div class="row pb20">
							<div class="col-sm-3">
								 <div class="ulbox ulboxc">
							       <ul  class="nav nav-tabd">
										<li class="active">
											<a href="#home" data-toggle="tab">
												单位管理
											</a>
										</li>				
									</ul>
									<div  class="tab-content">
										<div class="tab-pane fade newlist in active" id="home">
											<div id="treeUnit"></div>											
										</div>										
									</div>
									<a class="addbtn" href="javascript:void(0)" onclick="editUnit('0000',0)">+添加</a>
								</div>								
							</div>
							<div class="col-sm-9">
								<div class="departbox cf">
									<span class="depart" ></span>
									<a href="javascript:void(0)"  class="addpost" onclick="editPost(0,'')"  >+添加岗位</a>
								</div>
								<div class="p10">
								 <table id="postList"></table>
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
		<#if treeUnitJson?exists >
			var treeUnitJson = ${treeUnitJson};
		</#if>
	</script>	
	<script type="text/javascript" src="${ctx!}/oa/js/sys/org.js"></script>    
</html>