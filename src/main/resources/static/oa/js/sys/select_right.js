var vm = null;
$(document).ready(function(){
	loadTreePost();
	initVm();
	bindSearch();
});


/***
 * 绑定查询方法
 */
function bindSearch(){
	try{
		$("#_search").click(function(){
			/***先清除**/
			$('#_postTree').treeview('clearSearch');
			var searchText = $("#_searchText").val();
			if(typeof(searchText)!='undefined'
				&&searchText!=''){
				$('#_postTree').treeview('search',[searchText,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'text'}]);
			}
		});
	}catch(e){
		console.log('bindSearch'+e);
	}
}

/***初始化渲染函数
 */
function initVm(){
	var rights = new Array();
	vm = new Vue(
			{
			el:'#_selectbox',
			data:{rights:rights},
			methods:{
				/**判断是否存在**/
				existsRight:function(rightId){
					if(typeof(this.rights)!='undefined' 
						&& this.rights.length>0){
						var rightLength = this.rights.length;
						for(var rightIndex=0;rightIndex<rightLength;rightIndex++){
							var rightObj = this.rights[rightIndex];
							if(rightObj.postId==rightId){
								return true;
								break;
							}
						}
					}
					return false;
				},
				addRight:function(dataObj){
					if(!this.existsRight(dataObj.roleId)){
						this.rights[this.rights.length++]=dataObj;
						this.$forceUpdate();
					}
				},
				delRight:function(index,nodeId){
					this.rights.splice(index,1);
					$('#_postTree').treeview('unselectNode',[ nodeId,{silent:true}]);
					this.$forceUpdate();
				},
				delRightId:function(id){
					if(typeof(this.rights)!='undefined'
						&&this.rights.length>0){
						var rightLength = this.rights.length;
						for(var rightIndex=0;rightIndex<rightLength;rightIndex++){
							var rightObj = this.rights[rightIndex];
							if(rightObj.postId==id){
								this.rights.splice(rightIndex,1);
								this.$forceUpdate();
								break;
							}
						}
					}
				},
				receRights:function(){
					return this.rights;
				},
				assiRigths:function(rights){
					this.rights=rights;
				}
			}
			}
		);
}

/****
 * 岗位树形
 */
function loadTreePost(){
	try{
		if(typeof(treePostJson)!=undefined
			&&treePostJson.length>0){
			var options = {
		          bootstrap2: false, 
		          showTags: true,
		          showBorder:true,
		          multiSelect:true,
		          data:treePostJson,
		          onNodeSelected: function(event,data){		          	
		          	var rightType = "";
		          	if(typeof(data.unit)!='undefined'
		          		&&data.unit==0){
		          		layer.msg("只能选择岗位",{time: 2000});
		          		$('#_postTree').treeview('unselectNode',[data.nodeId,{silent:true}]);
		          		return;
		          	}
		          	if(typeof(data.dep)!='undefined'
		          		&&data.dep==0){
		          		layer.msg("只能选择岗位",{time: 2000});
		          		$('#_postTree').treeview('unselectNode',[data.nodeId,{silent:true}]);
		          		return;
		          	}
		          	if(typeof(data.post)!='undefined'
		          		&&data.post==0){
		          		var obj={
		          				unitId:'',
		          				names:[]
		          			};
		          		obj.names[obj.names.length++]=data.text;
		          		var parentId = data.parentId;
		          		var node = $('#_postTree').treeview('getNode', parentId);
		          		var departmentId  = node.id;
		          		receUnitId.call(obj,parentId);
		          		inveSort.call(obj);
						var unitId = obj.unitId;
		          		var dataObj={
		          			departmentId:departmentId,
							postId:data.id,
							nodeId:data.nodeId,
							unitId:unitId,
							humanId:userId,
							names:obj.names
						}
		          		vm.addRight(dataObj);
		          	}
				},/**取消选择
				   * **/
				onNodeUnselected:function(event,data){
					vm.delRightId(data.id);
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
				  		for(var resultKey in results){
				  			var resultObj=results[resultKey];
				  			$('#_postTree').treeview('selectNode',[resultObj.nodeId,{silent:false}]);
				  		}
				  	}
				}
   			 };
  			$('#_postTree').treeview(options);
		}
	}catch(e){
		console.log('loadTreePost'+e);
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
			var node = $('#_postTree').treeview('getNode', parentId);
			if(typeof(node.unit)!='undefined' 
				&& node.unit==0){
				this.unitId=node.id;
				this.names[this.names.length++]=node.text;
			} else {
				this.names[this.names.length++]=node.text;
				receUnitId.call(this,node.parentId);
			}
		}
	}catch(e){
		console.log('receUnitId'+e);
	}
}


/***
 * 倒排数组
 * @param {Object} arrs
 */
function inveSort(){
	try{
		if(typeof(this.names)!='undefined' 
			&& this.names.length>0){
			var namesLength = this.names.length;
			var names = new Array();
			for(var nameIndex=(namesLength-1);nameIndex>=0;nameIndex--){
				names[names.length++]= this.names[nameIndex];
			}
			this.names=names;
		}
		
	}catch(e){
		console.log('inveSort'+e);
	}
}

/***
 * 返回数据集合
 */
function receRights(){
	return vm.receRights();
}

/***
 * 赋值
 * @param {Object} rights
 */
function assRights(){
	selectTreeNode();
}

/***
 * 选中树形并且展开
 */
function selectTreeNode(){
	try{
		if(typeof(postHumanJson)!='undefined' 
			&& postHumanJson.length>0){
			var rigthLength = postHumanJson.length;
			var ids = "";
			for(var rightIndex=0;rightIndex<rigthLength;rightIndex++){
				var rightObj = postHumanJson[rightIndex];
				ids += rightObj.postId;
				if((rightIndex+1)<rigthLength){
					ids += "|";
				}
			}
			if(ids!=''){
				$('#_postTree').treeview('search',[ids,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'id'}]);
			}
		}
	}catch(e){
		console.log('selectTreeNode'+e);
	}
	
}
