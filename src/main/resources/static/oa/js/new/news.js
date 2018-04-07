var vm = null;
$(document).ready(function(){
	initUM();
	uploadFile();
	uploadImg();
	initValidate();
	initNewsAnnexs();
});

/****初始化附件
 */
function initNewsAnnexs(){
	try{
		if(typeof(newsAnnexs)!="undefined" 
			&& newsAnnexs.length>0){
			var annexLength = newsAnnexs.length;
			var files = new Array();
			for(var annexIndex=0;annexIndex<annexLength;annexIndex++){
				var newsAnnex=newsAnnexs[annexIndex];
				var fileObj = {
            		filePath:newsAnnex.filePath,
            		chName:newsAnnex.chName,
            		sort:newsAnnex.sort,
            		suffix:newsAnnex.suffix,
            		pathName:newsAnnex.pathName
            	};
                files[files.length++]= fileObj; 
			}
			$("#newsAnnexJson").val(encodeURIComponent(JSON.stringify(files)));
		}
	}catch(e){
		console.log(e);
	}
}

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


/****上传图片
 */
function uploadImg(){
	try{
	    $("#_imagePath").click(function(){
				layer.open({
	        	      type: 2,
	        	      title: '图片上传',
	        	      shadeClose:false,
		        	  shade:0.3,
	        	      area: ['400px', '450px'],
	        	      content:'/admin/common/upload_img',
		    	      success: function(layero, index){
		    	      },
	        	      btn: ['确定', '取消'],
					  btn1:function(index, layero){
						var iframeWin = window[layero.find('iframe')[0]['name']];
						/**执行window方法***/
	    				var files  = iframeWin.receFiles();
	    				if(typeof(files)!="undefined" 
	    					&& files.length>0){
	    					receImg(files);
	    				}
					  },
					  btn2:function(index, layero){
					  	layer.close(index);
					  }
	        });
	    });
	}catch(e){
		console.log('uploadImg'+e);
	}
}

/****图片上传
 * @param {Object} files
 */
function receImg(files){
	try{
		var fileLength = files.length;
		var imgHtml = "";
		var imagePath="";
		for(var fileIndex=0;fileIndex<fileLength;fileIndex++){
			imagePath=files[fileIndex].filePath;
		}
		var imgUrl="/download?filePath="+imagePath+"&fileName="+imagePath;
		$("#_preview").attr('src',imgUrl);
		$("#imagePath").val(imagePath);
		$("#_previewImgShow").show();
		$("#_imagePathh").hide();
	}catch(e){
		console.log('receImg'+e);
	}
}

/***
 * 删除图片
 * @param {Object} imagePath
 */
function delImg(){
	try{
		var imagePath = $("#imagePath").val();
		var url="/delfile";
		$.ajax({
		   type: "POST",
		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   dataType: "json",
		   url:url,
		   data:{filePath:imagePath},
		   success: function(msg){
				/**删除对应节点**/
				$("#_previewImgShow").hide();
				$("#_imagePathh").show();
		   }
		});
	}catch(e){
		console.log('delImg'+e);
	}
}

/***
 * 删除文件
 * @param {Object} obj
 */
function delFile(obj){
	try{
		var filePath = $(obj).attr('filePath');
		var url="/delfile";
		$.ajax({
		   type: "POST",
		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   dataType: "json",
		   url:url,
		   data:{filePath:filePath},
		   success: function(msg){
				/**删除对应节点**/
				var files=JSON.parse(decodeURIComponent($("#newsAnnexJson").val()));
				if(typeof(files)!="undefined"
					&&files.length>0){
				    var fileIndex=$(obj).attr('fileIndex');
					files.splice(fileIndex,1);
					$("#newsAnnexJson").val(encodeURIComponent(JSON.stringify(files)));
				}
				$(obj).parent().remove();
		   }
		});
	}catch(e){
		console.log('delFile'+e);
	}
}



/****上传文件
 */
function uploadFile(){
	try{
		$("#_newsAnnex").click(function(){
			layer.open({
        	      type: 2,
        	      title: '文件上传',
        	      shadeClose:false,
	        	  shade:0.3,
        	      area: ['400px', '450px'],
        	      content:'/admin/common/upload',
	    	      success: function(layero, index){
					     var iframeWin = window[layero.find('iframe')[0]['name']];
					     var newsAnnexJson = $("#newsAnnexJson").val();
						 if(typeof(newsAnnexJson)!='undefined' 
							&& newsAnnexJson != ""){
							iframeWin.assFiles(JSON.parse(decodeURIComponent(newsAnnexJson)));
						 }
				  },
        	      btn: ['确定', '取消'],
				  btn1:function(index, layero){
					var iframeWin = window[layero.find('iframe')[0]['name']];
					/**执行window方法***/
    				var files  = iframeWin.receFiles();
    				if(typeof(files)!="undefined" 
    					&& files.length>0){
    					receFiles(files);
    				}
				  },
				  btn2:function(index, layero){
				  	layer.close(index);
				  }
        	});
		});
	}catch(e){
		console.log('uploadFile'+e);
	}
}

/****设置文件
 * @param {Object} files
 */
function receFiles(files){
	try{
		var fileLength = files.length;
		var tableHtml = "";
		 for(var fileIndex=0;fileIndex<fileLength;fileIndex++){
		 		tableHtml　+= "<div class=\"fjjs\">\n" +
								"   <span>"+files[fileIndex].chName+"</span>\n" + 
								"   <em>"+files[fileIndex].fileSize+"</em>\n" + 
								"   <i class=\"fa fa-close del\"  fileIndex="+fileIndex+"  filePath="+files[fileIndex].filePath+" onclick=\"delFile(this)\"  ></i>\n" + 
								" </div>";
		 }
		 $("#_annexTable").html(tableHtml);
		 $("#newsAnnexJson").val(encodeURIComponent(JSON.stringify(files)));
	}catch(e){
		console.log('receFiles'+e);
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
				},
				departmentId:{
	    	        required: true
				},
				unitId:{
	    	        required: true
				},
				sectionId:{
					required: true
				}
			},
    	    messages: {},
    	    submitHandler:function(form){
    	    	var sectionId = $("#_sectionId  option:selected").val();
    	    	if(null == sectionId 
    	    		|| typeof(sectionId)=='undefined' 
    	    		|| sectionId == ""){
    	    		layer.msg('请选择发布版块!', {time: 2000});
    	    		return;
    	    	}
    	    	var newtype = $("#newtype").val();
    	    	if(newtype==0){
    	    		$("#content").val(encodeURIComponent(um.getContent()));
    	    	} else {
    	    		/****公告获取存文本***/
    	    		$("#content").val(encodeURIComponent(um.getContentTxt()));
    	    	}
    	    	/***取消编辑项**/
    	    	$.ajax({
   	    		   type: "POST",
   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	    		   dataType: "json",
   	    		   url: "/oa/new/edit_news",
   	    		   data:$(form).serialize(),
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000});
 	   					/**删除对应节点**/
 	   					if(msg.code==0){
 	   						window.location.href="/oa/new/index/"+newtype;
 	   					}
   	    		   }
   	    		});
            }
    	});
	}catch(e){
		console.log(e);
	}
}
