<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>推广类型管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css?v=${version!}" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=${version!}" rel="stylesheet">
	<style>
		   *{padding:0px;margin:0px;}
		   ul li{list-style: none;}
		   .boxtree .depart{display: block;}
		   .boxtree .none{display:none;}
		   .boxtree .folder,.boxtree .flied{height:30px;line-height:30px;}	
		   .boxtree .folder.fa,.boxtree .flied.fa{position:relative;display: block;}
		   .boxtree li{cursor:pointer;padding-left:20px}
		   .fa-plus-square:before{position:absolute;top:0px;left:-17px;}
		   .fa-minus-square:before{position:absolute;top:0px;left:-17px;}
		   .folder.curr,.flied.curr{background:#F8F8F8;}		   	    
	</style>
</head>
<body class="gray-bg">
    <div class="wrapper  cf animated fadeInRight">
        <div class="row">
        	<div class="col-sm-12 fttit">			 		
			 		推广类型管理
			 </div>
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <div class="affair-tit">                        	
                        	推广类型管理
                        </div>
                    </div>
                    <div class="ibox-content">
                        <p class="pr">
                    		<button class="btn btn-success btnnews" type="button" onclick="add();">
				   					<i class="fa fa-plus"></i>
				   					 添加
				   			</button>
                        </p>
                          <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <div class="example-wrap">
		                            <div class="example">
		                            	<table id="table_list"></table>
		                            </div>
		                        </div>
		                    </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 全局js -->
	<#include "/admin/common/common.ftl">
    <script>
        $(document).ready(function () {
			//初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址
			    url:"${ctx!}/oa/exty/list",
			    classes:"table table-hover filelist",
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
			    //detailView:true,
			    //detailFormatter:detailFormatter,
			    //表示服务端请求
			    sidePagination: "server",
			    queryParams:function(){
				    	return {
					    	pageNumber:this.pageNumber,
					    	pageSize:this.pageSize
				    	}
				    },
			    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
			    //设置为limit可以获取limit, offset, search, sort, order
			    queryParamsType: "undefined",
			    clickToSelect:true,
			    //json数据解析
			    responseHandler: function(res) {
			        return {
			            "rows": res.content,
			            "total": res.totalElements
			        };
			    },
			    //数据列
			    columns: [{
			        title:"序号",
			        field: "sort"
			    },
			    {
			        title:"推广类型",
			        field: "typeName"
			    },{
			        title: "操作",
			        field: "empty",
                    formatter: function (value, row, index) {
                     		var operateHtml = "";
	                        operateHtml = '<button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;修改</button> &nbsp;';
	                        operateHtml += '<button class="btn btn-primary btn-xs" type="button" onclick="del(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;删除</button> &nbsp;';
						return operateHtml;                      
                    }
			    }]
			});
        });


		<!--推广类型修改-->
        function edit(id){
        	layer.open({
        	      type: 2,
        	      title: '推广类型修改',
        	      shadeClose: true,
				  shade: [0.8,'#393D49'],
        	      area: ['800px', '300px'],
        	      content: '${ctx!}/oa/exty/edit/' + id,
        	      end: function(index){
        	      	 $('#table_list').bootstrapTable("refresh");
        	      }
        	    });
        }
        
       <!--推广类型添加-->
        function add(){
        	layer.open({
        	      type: 2,
        	      title: '推广类型添加',
        	      shadeClose: true,
				  shade:[0.8,'#393D49'],
        	      area: ['550px', '300px'],
        	      content: '${ctx!}/oa/exty/add',
        	      end: function(index){
        	      	$('#table_list').bootstrapTable("refresh");
        	      }
        	    });
        }
        
        
        <!--删除-->
        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/oa/exty/delete/" + id,
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
