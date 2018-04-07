<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
		<#if newtype==0>
			新闻列表
		<#else>
			公告列表
		</#if>
	</title>
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
	<input type="hidden" name="humanId" id="humanId" value="${currentUser.id}" />
	<input type="hidden" name="newtype" id="newtype" value="${newtype}" />
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                    	<div class="row">
                    		<div class="col-sm-8">
                    			<div class="affair-tit">
								<#if newtype==0>
									新闻列表
								<#else>
									公告列表
								</#if>
						       </div>
                    		</div>
	                        <div class="col-sm-4">
	                        	<div class="txtbox txtlist">
									<i class="fa fa-search"></i> 
									<input type="text" id="_searchText"  placeholder="搜索名称/发布人/类型" class="input">
									<a href="javascript:void(0)" class="seachbtn" onclick="searchText()" >搜索</a>
							   </div>
	                        </div>							
					  </div>
                    </div>
                    <div class="ibox-content">
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
    	function searchText(){
    			$("#table_list").bootstrapTable('destroy');
    			loadTable();
    	}
    	
        $(document).ready(function () {
        	loadTable();
        });
        
        <!--加载表格-->
        function loadTable(){
        	//初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址
			    url: "${ctx!}/oa/new/list/${newtype}",
			    classes: "table table-hover filelist",
			    //表格显示条纹
			    striped: true,
			    //启动分页
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
			    detailView:false,
			    //表示服务端请求
			    sidePagination: "server",
			    queryParams:function(){
				    	return {
				    		searchText:$("#_searchText").val(),
					    	pageNumber:this.pageNumber,
					    	pageSize:this.pageSize
				    	}
				    },
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
			        title: "新闻标题",
			        field: "title"
			    },
			    {
			        title: "发布时间",
			        field: "releaseDate"
			    },
			    {
			        title: "发布人",
			        field: "createUser"
			    },
			    {
			        title: "类型",
			        field: "newSection",
			        formatter: function(value, row, index) {
                    	return row.newSection.secName;
                    }
			    },
			    {
			        title: "状态",
			        sortable: true,
			        field: "state",
                    formatter: function (value, row, index) {
                        if (value == '0')
                        	return '<span class="label label-info">未审核</span>';
                        return '<span class="label label-danger">已审核</span>';
                    }
			    },{
			        title: "操作",
			        field: "empty",
                    formatter: function (value, row, index) {
                    	var operateHtml="";
                    	if(row.state==0){
                    		operateHtml = '<@shiro.hasPermission name="oa:new:aud"><button class="btn btn-primary btn-xs" type="button" onclick="audNews(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;审核</button> &nbsp;</@shiro.hasPermission>';
                    	}
                    	var humanId = $("#humanId").val();
                    	if(row.humanId==humanId
                    		&&row.state==0){
                    		operateHtml += '<@shiro.hasPermission name="tran:ins_form:view_process"><button class="btn btn-primary btn-xs" type="button" onclick="editNews(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;编辑新闻</button> &nbsp;</@shiro.hasPermission>';
                    		operateHtml += '<@shiro.hasPermission name="tran:ins_form:view_process"><button class="btn btn-primary btn-xs" type="button" onclick="editReply(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;添加回复</button> &nbsp;</@shiro.hasPermission>';
                    		operateHtml += '<@shiro.hasPermission name="tran:ins_form:view_process"><button class="btn btn-primary btn-xs" type="button" onclick="replys(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;回复列表</button> &nbsp;</@shiro.hasPermission><i class="fa fa-trash-o warter" onclick=del(\''+row.id+'\')></i>';
                    	}
                        return operateHtml;
                    }
			    }]
			});
        }
        
        
       <!--编辑新闻-->
       function editNews(id){
       		try{
       			window.location.href="${ctx!}/oa/new/edit/${newtype}?id="+id;
       		}catch(e){
       			console.log('process'+e);
       		}
       }
       
       
       <!--添加回复-->
       function editReply(id){
       		try{
       			window.location.href="${ctx!}/oa/reply/add/"+id;
       		}catch(e){
       			console.log('process'+e);
       		}
       }
       
       <!--回复列表-->
       function replys(id){
       		try{
       			window.location.href="${ctx!}/oa/reply/index/"+id;
       		}catch(e){
       			console.log('process'+e);
       		}
       }
       
       
       
       <!--审核新闻-->
       function audNews(id){
        	layer.confirm('确定审核此新闻吗?', {icon: 3, title:'新闻审核'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/oa/new/aud/" + id,
    	    		   success: function(msg){
	 	   	    			layer.msg(msg.message, {time: 2000},function(){
	 	   	    				$('#table_list').bootstrapTable("refresh");
	 	   	    				layer.close(index);
	 	   					});
    	    		   }
    	    	});
       		});
        }
        
        <!--删除新闻-->
        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/oa/new/delete/" + id,
    	    		   success: function(msg){
	 	   	    			layer.msg(msg.message, {time: 2000},function(){
	 	   	    				 $('#table_list').bootstrapTable("refresh");
	 	   	    				layer.close(index);
	 	   					});
    	    		   }
    	    	});
       		});
        }
    </script>
</body>
</html>