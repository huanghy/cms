var vm = null;
$(document).ready(function(){
	initUM();
	initValidate();
});

/****初始化
 */
function initUM(){
	try{
		 um = UM.getEditor('_content',{catchRemoteImageEnable:true});
		 if(typeof(contentHtml)!='undefined' 
		 		&& contentHtml != ""){
		 	um.execCommand('insertHtml',decodeURIComponent(contentHtml));
		 }
	}catch(e){
		console.log('initUM'+e);
	}
}






/***初始化验证方法
 */
function initValidate(){
	try{
		$("#frm").validate({
    	    rules: {
		    	title:{
	    	        required: true
				}
			},
    	    messages: {},
    	    submitHandler:function(form){
    	    	$("#content").val(encodeURIComponent(um.getContent()));
    	    	/***取消编辑项**/
    	    	$.ajax({
   	    		   type: "POST",
   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	    		   dataType: "json",
   	    		   url: "/oa/reply/edit",
   	    		   data:$(form).serialize(),
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000});
 	   					/**删除对应节点**/
 	   					if(msg.code==0){
 	   						window.location.href="/oa/reply/index/"+$("#newsId").val();
 	   					}
   	    		   }
   	    		});
            }
    	});
	}catch(e){
		console.log(e);
	}
}
