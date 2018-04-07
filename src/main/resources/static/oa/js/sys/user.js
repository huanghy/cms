$(document).ready(function(){
	loadUserTable();
});


/***增加用户
 */
function addUser(){
	try{
		layer.open({
		      type: 2,
		      title: '新建用户',
		      shadeClose: true,
		      shade: false,
		      area: ['700px', '600px'],
		      content: '/admin/user/add',
		      end: function(index){
		    	  $('#table_list').bootstrapTable("refresh");
	    	  }
	    });
	}catch(e){
		console.log('addUser'+e);
	}
}

/***
 * 编辑用户
 * @param {Object} id
 */
function editUser(id){
	try{
		layer.open({
		      type: 2,
		      title: '用户修改',
		      shadeClose: true,
		      shade: false,
		      area: ['893px', '600px'],
		      content: '/admin/user/edit/' + id,
		      end: function(index){
		    	  $('#table_list').bootstrapTable("refresh");
	    	  }
	    });
	}catch(e){
		console.log('editUser'+e);
	}
}


/***
 * 删除用户
 * @param {Object} id
 */
function delUser(id){
	try{
    	layer.confirm('确定要删除该员工吗?', {icon: 3, title:'提示'}, function(index){
    		$.ajax({
	    		   type: "POST",
	    		   dataType: "json",
	    		   url: "/admin/user/deluser/" + id,
	    		   success: function(msg){
 	   	    			layer.msg(msg.message, {time: 2000},function(){
 	   	    				$('#table_list').bootstrapTable("refresh");
 	   	    				layer.close(index);
 	   					});
	    		   }
	    	});
   		});
	}catch(e){
		console.log('delUser'+e);
	}
}

/***
 * 关联角色
 * @param {Object} id
 */
function grant(id){
	try{
		layer.open({
		      type: 2,
		      title: '关联角色',
		      shadeClose: true,
		      shade: false,
		      area: ['680px', '440px'],
		      content: '/admin/user/grant/'  + id,
		      end: function(index){
		    	  $('#table_list').bootstrapTable("refresh");
	    	  }
	    });
	}catch(e){
		console.log('grant'+e);
	}	
}

/****
 * 重置密码
 * @param {Object} id
 */
function reset(id){
	try{
		layer.confirm(('提示:该用户密码重置!</br>是否恢复初始密码:'+userPassword), {icon:0, title:'用户密码重置'}, function(index){
    		$.ajax({
	    		   type: "POST",
	    		   dataType: "json",   
	    		   url: "/admin/user/resetuserpwd/" + id,
	    		   success: function(msg){
 	   	    			layer.msg(msg.message, {time: 2000},function(){
 	   	    				layer.close(index);
 	   					});
	    		   }
	    	});
		});
	}catch(e){
		console.log(e);
	}
}

/***
 * 赋值组织架构
 * @param {Object} id
 */
function grantpower(id){
		try{
			layer.open({
			      type: 2,
			      title: '选择岗位',
			      shade:false,
			      skin: 'showclass',
			      btn:['确定','取消'],
			      area: ['800px', '500px'],
			      shade: [0.8, '#393D49'],
			      skin:"pr-select",
			      content: '/admin/user/select_right/'+id,
			      end: function(index){},
			      success: function(layero, index){
			      	var iframeWin = window[layero.find('iframe')[0]['name']];
			      	if(typeof(iframeWin.assRights)!='undefined' 
			      		&& typeof(iframeWin.assRights)=='function'){
			      		iframeWin.assRights();
			      	}
			      },
				  yes:function(index, layero){
					  	var iframeWin = window[layero.find('iframe')[0]['name']];
						/**执行window方法***/
						var rights  = iframeWin.receRights();
						/***设置岗位
						 * **/
						grantPost(rights,id,function(){
							layer.close(index);		
						});  	
					},
				      zIndex:19891015
				    });
		}catch(e){
			console.log('grantUser'+e);
		}
}


/***
 * 设置岗位
 * @param {Object} rights
 * @param {Object} humanId
 * @param {Object} sussceBack
 */
function grantPost(rights,humanId,sussceBack){
	try{
		if(typeof(rights)!='undefined' 
			&& rights.length>0){
			var data={
				rightJson:encodeURIComponent(JSON.stringify(rights)),
				humanId:humanId
			}
			$.ajax({
	    		   type: "POST",
	    		   dataType: "json",
	    		   url: "/admin/user/grantpost",
	    		   data:data,
	    		   success: function(msg){
 	   	    			layer.msg(msg.message, {time: 2000},function(){
 	   	    				if(msg.code==0
 	   	    					&&typeof(sussceBack)=='function'){
 	   	    					sussceBack();
 	   	    				}
 	   					});
	    		   }
	    	});
		}
	}catch(e){
		console.log('grantPost'+e);
	}
}

/***
 * 设置部门负责人
 * @param {Object} id
 */
function dephuman(id){
	try{
		layer.open({
		      type: 2,
		      title: '设置部门负责人',
		      shadeClose: true,
		      shade: false,
		      area: ['800px', '440px'],
		      content: '/admin/user/dephuman/'  + id
	   });
	}catch(e){
		console.log('dephuman'+e);
	}
}
