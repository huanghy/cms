var vm = null;
$(document).ready(function(){
	loadTreeHuman();
	//loadTreePost();
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
			$('#_humanTree').treeview('clearSearch');
			$('#_postTree').treeview('clearSearch');
			var searchText = $("#_searchText").val();
			if(typeof(searchText)!='undefined'
				&&searchText!=''){
				$('#_humanTree').treeview('search',[searchText,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'text'}]);
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
							if(rightObj.roleId==rightId){
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
					$('#_humanTree').treeview('unselectNode',[ nodeId,{silent:true}]);
					$('#_postTree').treeview('unselectNode',[ nodeId,{silent:true}]);
					this.$forceUpdate();
				},
				delRightId:function(id){
					if(typeof(this.rights)!='undefined'
						&&this.rights.length>0){
						var rightLength = this.rights.length;
						for(var rightIndex=0;rightIndex<rightLength;rightIndex++){
							var rightObj = this.rights[rightIndex];
							if(rightObj.roleId==id){
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
 * 加载人员树形
 */
function loadTreeHuman(){
	try{
		if(typeof(treeHumanJson)!=undefined
			&&treeHumanJson.length>0){
			var options = {
		          bootstrap2: false, 
		          showTags: true,
		          showBorder:true,
		          multiSelect:true,
		          badges:true,
		          onhoverColor:'#fff',
		          selectedColor:'#666',
		          selectedBackColor:"#fff",
		          data:treeHumanJson,
		          /***选中**/
		          onNodeSelected: function(event,data){
		          	var rightType = "";
		          	if(typeof(data.unit)!='undefined'
		          		&&data.unit==0){
		          		rightType='2';
		          	}
		          	if(typeof(data.dep)!='undefined'
		          		&&data.dep==0){
		          		rightType='1';
		          	}
		          	if(typeof(data.human)!='undefined'
		          		&&data.human==0){
		          		rightType='0';
		          	}
		          	var dataObj={
							roleId:data.id,
							nodeId:data.nodeId,
							rightType:rightType,
							name:data.text
						}
		          	vm.addRight(dataObj);
				},/**取消选择
				   * **/
				onNodeUnselected:function(event,data){
					vm.delRightId(data.id);
				},/**搜索完成触发**/
				onSearchComplete:function(event, results){
				}
   			 };
  			$('#_humanTree').treeview(options);
		}
	}catch(e){
		console.log('loadTreeHuman'+e);
	}
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
		          		rightType='2';
		          	}
		          	if(typeof(data.dep)!='undefined'
		          		&&data.dep==0){
		          		rightType='1';
		          	}
		          	if(typeof(data.post)!='undefined'
		          		&&data.post==0){
		          		rightType='3';
		          	}
		          	var dataObj={
							roleId:data.id,
							nodeId:data.nodeId,
							rightType:rightType,
							name:data.text
						}
		          	vm.addRight(dataObj);
				},/**取消选择
				   * **/
				onNodeUnselected:function(event,data){
					vm.delRightId(data.id);
				},/**搜索完成触发**/
				onSearchComplete:function(event, results){
				}
   			 };
  			$('#_postTree').treeview(options);
		}
	}catch(e){
		console.log('loadTreePost'+e);
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
function assRights(rights){
	vm.assiRigths(rights);
	selectTreeNode(rights);
}

/***
 * 选中树形并且展开
 * @param {Object} rights
 */
function selectTreeNode(rights){
	try{
		var rigthLength = rights.length;
		var ids = "";
		for(var rightIndex=0;rightIndex<rigthLength;rightIndex++){
			var rightObj = rights[rightIndex];
			ids += rightObj.roleId;
			if((rightIndex+1)<rigthLength){
				ids += "|";
			}
		}
		if(ids!=''){
			$('#_humanTree').treeview('search',[ids,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'id'}]);
			$('#_postTree').treeview('search',[ids,{ignoreCase:true,exactMatch:false,revealResults:true,attr:'id'}]);
		}
	}catch(e){
		console.log('selectTreeNode'+e);
	}
	
}
