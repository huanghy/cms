<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文件上传</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/hadmin/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/hadmin/css/style.css?v=${version}" rel="stylesheet">
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<div id="default" class="text-center">
    			<img src="${ctx!}/hadmin/img/nodatas.png" id="_nodatas" />
    			<p>
    			   点击文件上传按钮，从本地上传文件	
    			</p>
    	</div>
        <div class="row">
            <div class="col-sm-12">
                <div id="uploadDIv"></div>
            </div>
        </div>
    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <#include "/admin/common/uploadimage_common.ftl">
    <script type="text/javascript">
    var files = new Array();
    $(document).ready(function () {
    	var dir = parent.$("#dir").val();
    	if(typeof(dir)=='undefined'
    		||dir==""){
    		dir="img";
    	}
        //上传照片
        $('#uploadDIv').diyUpload({
            url:'${ctx}/html5/upload.html/'+dir,
            success:function(data) {   
            	var fileObj = {
            		filePath:data.serviceUrl,
            		chName:data.fileName,
            		sort:files.length,
            		suffix:data.contentType,
            		fileSize:data.fileSize,
            		pathName:data.pathName
            	};
                files[files.length++]= fileObj; 
            },
            error:function( err ) {
                console.info( err );
            },
            buttonText:'图片上传',
            chunked:true,
            accept:{
				title:"Images",
				extensions:"gif,jpg,jpeg,bmp,png",
				mimeTypes:"image/*"
			},
            // 分片大小
            chunkSize:1024 * 1024*2,
            //最大上传的文件数量, 总文件大小,单个文件大小(单位字节);
            fileNumLimit:1,
            fileSizeLimit:100 * 1024*1024,
            fileSingleSizeLimit:100 * 1024*1024,
            accept: {}
        });
    });
    
    <!--设置初始化文件-->
    function assFiles(files){
    	try{
    	 	this.files=files;
    	}catch(e){
    		console.log('assFiles'+e);
    	}
    }
    
    <!--获取文件列表-->
    function receFiles(){
    	return files;
    }
    </script>
</body>
</html>