// 手机号码验证 
jQuery.validator.addMethod("isMobile", function(value, element) { 
  var length = value.length; 
  var mobile = /^((1[0-9]{2})+\d{8})$/; 
  return this.optional(element) || (length == 11 && mobile.test(value)); 
}, "请正确填写您的手机号码"); 

// 电话号码验证 
jQuery.validator.addMethod("isTel", function(value, element) { 
  var tel = /^\d{3,4}-?\d{7,9}$/; //电话号码格式010-12345678 
  return this.optional(element) || (tel.test(value)); 
}, "请正确填写您的电话号码"); 
$(document).ready(function(){
	openCrop();
	initValidate();
});


/***
 * 打开裁剪
 */
function openCrop(){
	try{
		$("#_preview").click(function(){
			layer.open({
        	      type: 2,
        	      title: '头像裁剪',
        	      shadeClose:false,
	        	  shade:0.3,
        	      area: ['550px', '450px'],
        	      content:'/admin/common/upload_crop',
	    	      success: function(layero, index){
	    	      },
        	      btn: ['确定', '取消'],
				  btn1:function(index, layero){
					var iframeWin = window[layero.find('iframe')[0]['name']];
					/**执行window方法***/
    				var imageData  = iframeWin.receImgData();
    				imageData=imageData.toDataURL('image/jpg');
    				$("#_preview").attr('src',imageData);
    				$("#imageUrl").val(imageData);
				  },
				  btn2:function(index, layero){
				  	layer.close(index);
				  }
      		 });
		});
	}catch(e){
		console.log('openCrop'+e);
	}
	
}


/***初始化验证方法
 */
function initValidate(){
	try{
		$("#frm").validate({
    	    rules: {
		    	phone:{
	    	        required: true,
	    	        isMobile:true
				},
				officePhone:{
	    	        required: true,
	    	        isTel:true
				},
				email:{
	    	        required: true,
	    	        email:true
				}
			},
    	    messages: {
    	    	email: "请输入一个正确的邮箱"
    	    },
    	    submitHandler:function(form){
    	    	/***取消编辑项**/
    	    	$.ajax({
   	    		   type: "POST",
   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	    		   dataType: "json",
   	    		   url: "/admin/common/up_user_info",
   	    		   data:$(form).serialize(),
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000});
   	    		   }
   	    		});
            }
    	});
	}catch(e){
		console.log(e);
	}
}