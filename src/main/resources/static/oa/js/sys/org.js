var layerIndex=-1;
$(document).ready(function(){
	loadTreeUnit();
	loadPostTab('','','');
});

/****
 * 单位树形
 */
function loadTreeUnit(){
	try{
		if(typeof(treeUnitJson)!=undefined
			&&treeUnitJson.length>0){
			var options = {
		          bootstrap2: false, 
		          showTags: true,
		          showBorder:true,
		          showMoreButton:true,
		          multiSelect:false,
		          onhoverColor:'#fff',
		          selectedColor: '#666',
		          selectedBackColor:'#D8E4F2',
		          data:treeUnitJson,
		          /***选中**/
		          onNodeSelected: function(event,data){
		          	event.preventDefault();
		          	$(".depart").html(data.text);
		          	$("#postList").bootstrapTable('destroy');
		          	if(typeof(data.unit)!='undefined' 
						&& data.unit==0){
						$("#unitid").val(data.id);
						loadPostTab('',data.id,'');
					}
					if(typeof(data.dep)!='undefined' 
						&& data.dep==0){
						var obj={
							unitId:''
						};
						receUnitId.call(obj,data.parentId);
						var unitId = obj.unitId;
						$("#deptId").val(data.id);
						$("#deptId").attr('unitId',unitId);
						$("#unitid").val(unitId);
						loadPostTab('',unitId,data.id);
					}
		        },/**取消选择
				   * **/
				/**搜索完成触发**/
				 onSearchComplete:function(event, results){
				},
				onMouseDown:function(event,node){
					event.preventDefault();
					var tipsHtml = "";
					if(typeof(node.unit)!='undefined' 
						&& node.unit==0){
						tipsHtml = "<div  class='showdig'>\n" + 
							"      <input type=\"button\" onclick=\"editUnit('"+node.id+"',1,"+node.nodeId+")\" value=\"编辑单位\" />\n" + 
							"      <input type=\"button\" onclick=\"delUnit('"+node.id+"',"+node.nodeId+")\" value=\"删除单位\" />\n" + 
							"      <input type=\"button\" onclick=\"editUnit('"+node.id+"',0,"+node.nodeId+")\" value=\"增加子单位\" />\n" + 
							"      <input type=\"button\" onclick=\"editDep('"+node.id+"','0000',0,"+node.nodeId+")\" value=\"增加部门\" />\n" + 
							"    </div>";
					}
					if(typeof(node.dep)!='undefined' 
						&& node.dep==0){
						var obj={
							unitId:''
						};
						receUnitId.call(obj,node.parentId);
						var unitId = obj.unitId;
						tipsHtml = "<div class='showdig'>\n" +
							"      <input type=\"button\" onclick=\"editDep('"+unitId+"','"+node.id+"',1,"+node.nodeId+")\" value=\"编辑部门\" />\n" + 
							"      <input type=\"button\" onclick=\"delDepart('"+node.id+"',"+node.nodeId+")\" value=\"删除部门\" />\n" + 
							"      <input type=\"button\" onclick=\"editDep('"+unitId+"','"+node.id+"',0,"+node.nodeId+")\" value=\"增加子部门\" />\n" + 
							"    </div>";
					}
					var unit = node.unit;
					var dep = node.dep;
					var nodeTarget = $("li[data-nodeid='"+node.nodeId+"']");
					var offsetTop = offsetTop = nodeTarget[0].offsetTop+nodeTarget[0].clientHeight-$(document).scrollTop()+40+'px';
					var offsetLeft = nodeTarget[0].offsetLeft+nodeTarget[0].clientWidth+'px';
					if(layerIndex!=-1){
						layer.close(layerIndex);
					}
					layerIndex=layer.open({
			    	      type:1,
			    	      shadeClose: true,
			    	      shade:[0.1,'#FFFFF0'],
			    	      closeBtn:0,
			    	      title: false,
			    	      anim:3,
			    	      area:['100px', '100px'],
			    	      offset:[offsetTop,offsetLeft],
			    	      resize:false,
			    	      fixed:false,
			    	      skin:'jg-class',
			    	      content:tipsHtml
			    	    });
                	
           		 }
   			 };
  			$('#treeUnit').treeview(options);
		}
	}catch(e){
		console.log('loadTreeHuman'+e);
	}
}

/****
 *删除单位
 * @param {Object} unitId
 */
function delUnit(unitId,nodeId){
	if(layerIndex!=-1){
		layer.close(layerIndex);
	}
	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
		$.ajax({
    		   type: "POST",
    		   dataType: "json",
    		   url: "/sys/org/delunit/" + unitId,
    		   success: function(msg){
   	    			layer.msg(msg.message,{time:2000},function(){
   	    					/**删除对应节点**/
	 	   					if(msg.code==0){
	 	   						var node = $('#treeUnit').treeview('getNode', nodeId);
	 	   						$("#treeUnit").treeview("deleteNode",[node,{ silent: true }]);
	 	   					}
   					});
    		   }
    	});
	});
}


/***删除部门
 * 
 * @param {Object} departId
 * @param {Object} nodeId
 */
function delDepart(departId,nodeId){
	if(layerIndex!=-1){
		layer.close(layerIndex);
	}
	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
		$.ajax({
    		   type: "POST",
    		   dataType: "json",
    		   url: "/sys/org/deldepart/" + departId,
    		   success: function(msg){
   	    			layer.msg(msg.message,{time:2000},function(){
   	    					/**删除对应节点**/
	 	   					if(msg.code==0){
	 	   						var node = $('#treeUnit').treeview('getNode', nodeId);
	 	   						$("#treeUnit").treeview("deleteNode",[node,{ silent: true }]);
	 	   					}
   					});
    		   }
    	});
	});
}

/***
 * 编辑/增加单位
 * @param {Object} unitId
 * @param {Object} state
 * @param {Object} nodeId
 */
function editUnit(unitId,state,nodeId){
	try{
		if(layerIndex!=-1){
			layer.close(layerIndex);
		}
		var serviceUrl = "";
		/**增加**/
		if(state==0){
			serviceUrl='/sys/org/addunit/' + unitId;
		}/**编辑**/ 
		else {
			serviceUrl='/sys/org/editunit/' + unitId;
		}
        layer.open({
		      type: 2,
		      title: '编辑单位',
		      shadeClose: true,
		      shade: false,
		      area: ['800px', '500px'],
		      content:serviceUrl,
		      success: function(layero, index){
			     var iframeWin = window[layero.find('iframe')[0]['name']];
			     iframeWin.assLayerIndex(index,state,nodeId);
			 }
	    });
	}catch(e){
		console.log('editUnit'+e);
	}
}


/***
 * 部门
 * @param {Object} unitId
 * @param {Object} departmentId
 * @param {Object} state
 * @param {Object} nodeId
 */
function editDep(unitId,departmentId,state,nodeId){
	try{
		if(layerIndex!=-1){
			layer.close(layerIndex);
		}
		var serviceUrl = "";
		/**增加**/
		if(state==0){
			serviceUrl='/sys/org/adddepart/' + unitId+"/"+departmentId;
		}/**编辑**/ 
		else {
			serviceUrl='/sys/org/editdepart/' + departmentId;
		}
        layer.open({
		      type: 2,
		      title: '编辑部门',
		      shadeClose: true,
		      shade: false,
		      area: ['893px', '600px'],
		      content:serviceUrl,
		      success: function(layero, index){
			     var iframeWin = window[layero.find('iframe')[0]['name']];
			     iframeWin.assLayerIndex(index,state,nodeId);
			 }
	    });
	}catch(e){
		console.log('editUnit'+e);
	}
}

/***
 * 编辑树形
 * @param {Object} state
 * @param {Object} obj
 * @param {Object} nodeId
 */
function editTree(state,obj,nodeId,unitState){
	try{
    	 if(state==0){
    	 	var node = null;
    	 	if(nodeId!=""){
    	 		node = $('#treeUnit').treeview('getNode', nodeId);
    	 	}
    	 	var nodeObj =  null;
    	 	if(unitState==0){
    	 		nodeObj = {text:obj.text,id:obj.id,unit:'0'};
    	 	}else {
    	 		nodeObj = {text:obj.text,id:obj.id,dep:'0'};
    	 	}
		    $("#treeUnit").treeview("addNode", [node,{node:nodeObj,silent:true}]);
    	 } else {
    	 	var node = $('#treeUnit').treeview('getNode', nodeId);
			$("#treeUnit").treeview("editNode",[node,{text:obj.text}]);
    	 } 	
	}catch(e){
		console.log('editTree'+e);
	}
}


/***
 * 获取unitId
 * @param {Object} parentId
 *  @param {Object} parentId
 */
function receUnitId(parentId){
	try{
		if(typeof(parentId)!='undefined'){
			var node = $('#treeUnit').treeview('getNode', parentId);
			if(typeof(node.unit)!='undefined' 
				&& node.unit==0){
				this.unitId=node.id;
			} else {
				receUnitId.call(this,node.parentId);
			}
		}
	}catch(e){
		console.log('receUnitId'+e);
	}
}


/***加载表格
 */
function loadPostTab(searchText,unitId,deptId){
	try{
		$("#postList").bootstrapTable({
		    //使用get请求到服务器获取数据
		    method: "POST",
		    //必须设置，不然request.getParameter获取不到请求参数
		    contentType: "application/x-www-form-urlencoded",
		    //获取数据的Servlet地址
		    url: "/sys/org/posts",
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
		    search: false,
		    //是否启用详细信息视图
		    detailView:false,
		    //表示服务端请求
		    sidePagination: "server",
		    queryParams:function(){
		    	return {
		    		searchText:searchText,
			    	unitId:unitId,
			    	deptId:deptId,
			    	pageNumber:this.pageNumber,
			    	pageSize:this.pageSize,
			    	sortName:'sort',
			    	sortOrder:'asc'
		    	}
		    },
		    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
		    //设置为limit可以获取limit, offset, search, sort, order
		    queryParamsType:"undefined",
		    //json数据解析
		    responseHandler: function(res) {
		        return {
		            "rows": res.content,
		            "total": res.totalElements
		        };
		    },
		    //数据列
		    columns: [{
		        title: "岗位",
		        field: "name" 
		    },{
		        title: "部门",
		        field: "depName",
		        formatter: function (value, row, index) {
                  return row.department.name;
                }
		    },{
		        title: "单位",
		        field: "unitName",
		        formatter: function (value, row, index) {
                  return row.unit.unitName;
                }
		    },{
		        title: "排序",
		        field: "sort"
		    },{
		        title: "操作",
		        field: "empty",
	            formatter: function (value, row, index) {
	            	//var operateHtml = '<button class="btn btn-primary btn-xs" type="button" onclick="editPost(1,\''+row.id+'\')" ><i class="fa fa-edit"></i>&nbsp;修改</button> &nbsp;';
	            	//operateHtml = operateHtml + '<button class="btn btn-danger btn-xs" type="button" onclick="delPost(\''+row.id+'\',\''+unitId+'\',\''+deptId+'\')"><i class="fa fa-remove"></i>&nbsp;删除</button>';
	                   operateHtml="<i class='fa fa-edit warter' onclick=editPost(1,'"+row.id+"')></i><i class='fa fa-trash-o warter' onclick=delPost('"+row.id+"','"+unitId+"','"+deptId+"')></i>"
	                return operateHtml;
	            }
	        }]
		});
	}catch(e){
		console.log('loadPostTab'+e);
	}
}


/****
 * 增加部门
 * @param {Object} state
 * @param {Object} postId
 */
function editPost(state,postId){
	try{
		if(layerIndex!=-1){
			layer.close(layerIndex);
		}
		var serviceUrl = "";
		/**增加**/
		if(state==0){
			var unitid = $("#unitid").val();
			var deptId = $("#deptId").val();
			var deptUnitId = $("#deptId").attr('unitId');
			if(typeof(unitid)=='undefined' 
				|| unitid==''){
				layer.msg('请选择部门', {time: 2000});
				return;
			}
			if(typeof(deptId)=='undefined' 
				|| deptId==''){
				layer.msg('请选择部门', {time: 2000});
				return;
			}
			if(unitid!=deptUnitId){
				layer.msg('所选部门与当前所选单位不一致!', {time: 2000});
				return;
			}
			serviceUrl='/sys/org/addpost/' + unitid+"/"+deptId;
		}/**编辑**/ 
		else {
			serviceUrl='/sys/org/editpost/' + postId;
		}
        layer.open({
		      type: 2,
		      title: '编辑岗位',
		      shadeClose: true,
		      shade: false,
		      area: ['800px', '400px'],
		      content:serviceUrl,
		      success: function(layero, index){
			     var iframeWin = window[layero.find('iframe')[0]['name']];
			     iframeWin.assLayerIndex(index);
			 },
			 end: function(index){
    	    	$('#postList').bootstrapTable("refresh");
   	    	  }
	    });
	}catch(e){
		console.log('editUnit'+e);
	}
}

/***
 * 删除岗位
 * @param {Object} postId
 * @param {Object} unitid
 * @param {Object} departmentid
 */
function delPost(postId,unitid,departmentid){
	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
		$.ajax({
    		   type: "POST",
    		   dataType: "json",
    		   url: "/sys/org/delpost/" + postId+"/"+unitid+"/"+departmentid,
    		   success: function(msg){
   	    			layer.msg(msg.message,{time:2000},function(){
   	    					/**删除对应节点**/
	 	   					if(msg.code==0){
	 	   						$('#postList').bootstrapTable("refresh");
	 	   					}
   					});
    		   }
    	});
	});
}