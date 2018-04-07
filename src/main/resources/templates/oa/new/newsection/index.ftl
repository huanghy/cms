<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新闻类型列表</title>
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
	<input type="hidden" name="newtype" id="newtype" value="${newtype}" />
    <div class="wrapper  cf animated fadeInRight">
        <div class="row">
        	<div class="col-sm-12 fttit">			 		
			 		<#if newtype==0>
						企业新闻>新闻类型
					<#else>
						企业公告>公告类型
					</#if>
			 </div>
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <div class="affair-tit">                        	
                        	<#if newtype==0>
								新闻类型
							<#else>
								公告类型
							</#if>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <p class="pr">
                        	<@shiro.hasPermission name="oa:newsection:add">
                        		<!--<button class="btn btn-success " type="button" onclick="add();"><i class="fa fa-plus"></i>&nbsp;添加</button>-->
                        	   <button class="btn btn-success btnnews" type="button" onclick="add();">
					   					<i class="fa fa-plus"></i>
					   					 新增类型
					   			</button>
                        	</@shiro.hasPermission>
                        </p>
                          <div class="row row-lg">
		                    <!--<div class="col-sm-2">
		                        <div class="example-wrap">
		                            <div class="example">
		                            	<ul class="boxtree cf" id="newsectiontree"></ul>
		                            </div>
		                        </div>
		                    </div>-->
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
    <!-- 自定义js -->
    <script src="${ctx!}/hadmin/js/content.js?v=${version!}"></script>
    <script>
        $(document).ready(function () {
        	var newtype = $("#newtype").val();
			//初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址
			    url:"${ctx!}/oa/newsection/list/"+newtype,
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
			    onClick:function(row){
			    	
			    },
			    //json数据解析
			    responseHandler: function(res) {
			        return {
			            "rows": res.content,
			            "total": res.totalElements
			        };
			    },
			    //数据列
			    columns: [{
			        checkbox:true
			    },
			    {
			        title: <#if newtype==0>"新闻类型名称"<#else>"公告类型名称"</#if>,
			        field: "secName"
			    },{
			        title: "所属父级",
			        field: "parent",
			        formatter: function(value, row, index){
			        	if(row.parent!=null){
			        		return row.parent.secName;
			        	}else{
			        		return '--';
			        	}
			        }
			    },{
			        title: "排序",
			        field: "sort"
			    },{
			        title: "操作",
			        field: "empty",
                    formatter: function (value, row, index) {
//                    	var operateHtml = '<@shiro.hasPermission name="oa:newsection:add"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;修改</button> &nbsp;</@shiro.hasPermission>';
//                    	operateHtml = operateHtml + '<@shiro.hasPermission name="oa:newsection:deleteBatch"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+row.id+'\')"><i class="fa fa-remove"></i>&nbsp;删除</button></@shiro.hasPermission>';
//                        return operateHtml;
                        var operateHtml="<@shiro.hasPermission name='oa:newsection:add'><i class='fa fa-edit warter' onclick=edit('"+row.id+"')></i></@shiro.hasPermission>"+"<i class='fa fa-trash-o warter' onclick=del('"+row.id+"')></i>"
						return operateHtml;                      
                    }
			    }]
			});
        });


        function edit(id){
        	var newtype = $("#newtype").val();
        	layer.open({
        	      type: 2,
        	      title: '新闻类型修改',
        	      shadeClose: true,
				  shade: [0.8,'#393D49'],
        	      area: ['800px', '400px'],
        	      content: '${ctx!}/oa/newsection/edit/' + id+"/"+newtype,
        	      end: function(index){
        	      	 $('#table_list').bootstrapTable("refresh");
        	      }
        	    });
        }
        function add(){
        	var newtype = $("#newtype").val();
        	layer.open({
        	      type: 2,
        	      title: '新闻类型添加',
        	      shadeClose: true,
				  shade:[0.8,'#393D49'],
        	      area: ['800px', '400px'],
        	      content: '${ctx!}/oa/newsection/add/'+newtype,
        	      end: function(index){
        	      	$('#table_list').bootstrapTable("refresh");
        	      }
        	    });
        }
        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/oa/newsection/delete/" + id,
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
