$(document).ready(function(){
	if(typeof(treeJson)!='undefined'
		&&treeJson.length>0){
		loadContactsTree();
	}
	loadContactsTable();
	bindSearch();
});
/***请求对象
 */
var reqObj={
	selectName:'人员展示',
	unitName:'单位',
	unitId:"",
	depName:'部门',
	depId:"",
	postName:'岗位',
	postId:"",
	searchText:"",
}

/***绑定查询方法
 */
function bindSearch(){
	try{
		$("#_search").click(function(){
			/***先清除**/
			$('#_treeHtml').treeview('clearSearch');
			var searchText = $("#_searchText").val();
			if(typeof(searchText)!='undefined'
				&&searchText!=''){
				reqObj.unitId='';
			    reqObj.depId='';
			    reqObj.postId='';
				reqObj.searchText=searchText;
				$('#_treeHtml').treeview('search',[searchText,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'text'}]);
			}
		});
	}catch(e){
		console.log('bindSearch'+e);
	}
}


/***加载树形
 */
function loadContactsTree(){
	try{
		var options = {
	          bootstrap2: false, 
	          showTags: true,
	          showBorder:true,
	          multiSelect:false,
	          data:treeJson,
	          badges:true,
	          onhoverColor:'#fff',
	          selectedColor:'#666',
	          selectedBackColor:"#fff",
	          /***选中**/
	          onNodeSelected: function(event,data){
	          	if(typeof(data.post)!='undefined'
			  			&&data.post==0){
			  			reqObj.postId="'"+data.id+"',";;
			  		}
			  		if(typeof(data.dep)!='undefined'
			  			&&data.dep==0){
			  			reqObj.postId='';
			  			reqObj.depId="'"+data.id+"',";;
			  		}
			  		if(typeof(data.unit)!='undefined'
			  			&&data.unit==0){
			  			reqObj.postId='';
			  			reqObj.depId='';
			  			reqObj.unitId="'"+data.id+"',";;
			  		}
			  		$("#_unitHtml").html(data.text);
			  		$("#humanTable").bootstrapTable('destroy');
			  		loadContactsTable();
			  		return true;
	          },/**取消选择
			   * **/
			  onNodeUnselected:function(event,data){
			  },/**搜索完成触发**/
			  onSearchComplete:function(event, results){
			  	if(typeof(results)!='undefined'
			  		&& JSON.stringify(results) != "{}"){
			  		var nodes = $('#_treeHtml').treeview('getSelected');
			  		if(typeof(nodes)!='undefined'
			  			&&nodes.length>0){
			  			var nodeLength = nodes.length;
			  			for(var nodeIndex=0;nodeIndex<nodeLength;nodeIndex++){
			  				$('#_treeHtml').treeview('unselectNode',[nodes[nodeIndex].nodeId,{silent:true}]);
			  			}
			  		}
			  		reqObj.searchText="";
			  		for(var resultKey in results){
			  			var resultObj=results[resultKey];
			  			$('#_treeHtml').treeview('selectNode',[resultObj.nodeId,{silent:true}]);
				  		if(typeof(resultObj.post)!='undefined'
				  			&&resultObj.post==0){
				  			reqObj.postId += "'"+resultObj.id+"',";
				  		}
				  		if(typeof(resultObj.dep)!='undefined'
				  			&&resultObj.dep==0){
				  			reqObj.postId='';
				  			reqObj.depId +="'"+resultObj.id+"',";
				  		}
				  		if(typeof(resultObj.unit)!='undefined'
				  			&&resultObj.unit==0){
				  			reqObj.postId='';
				  			reqObj.depId='';
				  			reqObj.unitId+="'"+resultObj.id+"',";
				  		}
			  		}
			  		$("#humanTable").bootstrapTable('destroy');
			  		loadContactsTable();
			  		
			  	}/**刷新表格**/
			  	else {
			  		$("#humanTable").bootstrapTable('destroy');
			  		loadContactsTable();
			  	}
			  }
		 };
		$('#_treeHtml').treeview(options);
					
	}catch(e){
		console.log('loadContactsTree'+e);
	}
}


/****
 * 初始化加载table
 * @param {Object} thisObj
 */
function loadContactsTable(){
	try{
		if(reqObj.unitId==""){
			reqObj.unitId = "";
		}else if (reqObj.unitId.lastIndexOf(",")==(reqObj.unitId.length-1)){
			reqObj.unitId=reqObj.unitId.substring(0,reqObj.unitId.lastIndexOf(","));
		}
		if(reqObj.depId==""){
			reqObj.depId = "";
		}else if (reqObj.depId.lastIndexOf(",")==(reqObj.depId.length-1)){
			reqObj.depId=reqObj.depId.substring(0,reqObj.depId.lastIndexOf(","));
		}
		if(reqObj.postId==""){
			reqObj.postId = "";
		}else if (reqObj.postId.lastIndexOf(",")==(reqObj.postId.length-1)){
			reqObj.postId=reqObj.postId.substring(0,reqObj.postId.lastIndexOf(","));
		}
		$("#humanTable").bootstrapTable({
		    //使用get请求到服务器获取数据
		    method: "POST",
		    //必须设置，不然request.getParameter获取不到请求参数
		    contentType: "application/x-www-form-urlencoded",
		    //获取数据的Servlet地址
		    url: "/admin/common/searchHumans",
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
		    		searchText:reqObj.searchText,
			    	unitId:reqObj.unitId,
			    	depId:reqObj.depId,
			    	postId:reqObj.postId,
			    	pageNumber:this.pageNumber,
			    	pageSize:this.pageSize
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
		        title: "姓名",
		        field: "humanName",
		        formatter: function (value, row, index) {
                  return "<a href='javascript:person(\""+row.id+"\")' >"+row.humanName+"</a>";
                }
		    },{
		        title: "岗位",
		        field: "postName"
		    },{
		        title: "手机号码",
		        field: "phone"
		    },{
		        title: "邮箱",
		        field: "email"
		    }]
		});
	}catch(e){
		console.log('loadContactsTable'+e);
	}
}


/***
 * 打开个人详情
 * @param {Object} userid
 */
function person(userid){
	try{
    	layer.open({
    	      type: 2,
    	      title: '个人信息',
    	      shadeClose: true,
    	      skin:"pr-select",
    	      shade: false,
    	      area: ['600px', '400px'],
    	      content: '/admin/common/user_info_id/'+userid,
    	      end:function(index){}
    	    });
	}catch(e){
		console.log('edit'+e);
	}
}