<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>选择岗位</title>
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
		    .treeview .list-group{height:240px;}
           .selectbox .seleul{height:243px;}
		</style>
	</head>
	<body class="fo">
		<div class="row">
			<div class="col-sm-7">
				<div class="txtbox">
					<i class="fa fa-search" id="_search" ></i>
					<input class="input" type="text" id="_searchText" placeholder="搜索联系人/部门/单位/岗位2"/>
				</div>
			</div>
			<div class="col-sm-5"></div>
		</div>
		<div class="row">

			<div class="col-sm-7">
				<div class="ulbox">
					<ul class="nav nav-tabd" >
						<li class="active">
							<a href="#home" data-toggle="tab">
								单位/部门/人员
							</a>
						</li>
						<!--<li>
							<a href="#ios" data-toggle="tab">单位/部门/岗位</a>
						</li>-->
					</ul>
					<div   class="tab-content">
						<div class="newlist tab-pane fade in active" id="home">
							<div id="_humanTree"></div>
						</div>	
						<!--<div class="newlist tab-pane fade  " id="ios">
							<div id="_postTree"></div>						
						</div>-->
					</di>	
			    </div>
			   </div> 
		   </div>
		   <div class="col-sm-5">
		   	  <div class="selectbox" id="_selectbox" >
		   	  	  <div class="title">
		   	  	  	  <span>已选对像</span>
		   	  	  </div>
		   	  	  <ul class="seleul">
		   	  	  	<li  v-for="(right, index) in rights" :key="index" v-model="rights[index]" >
		   	  	  		<span>{{right.name}}</span>		   	  	  		
		   	  	  		<i class="del"  v-on:click="delRight(index,right.nodeId)" >-</i>
		   	  	  	</li>
		   	  	  </ul>
		   	  </div>    
		   </div>
		</div>
	</body>
	<!-- 全局js -->
	<#include "/admin/common/common.ftl">
	<script type="text/javascript" >
			<#if treeHumanJson?exists >
    			var treeHumanJson = ${treeHumanJson};
    		</#if>
			<#if treePostJson?exists >
    			var treePostJson = ${treePostJson};
    		</#if>
	</script>
	<script type="text/javascript" src="${ctx!}/hadmin/js/vue.js"></script>
	<script type="text/javascript" src="${ctx!}/oa/js/common/select_right.js"></script>
</html>