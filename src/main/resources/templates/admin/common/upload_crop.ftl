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
    <link href="${ctx!}/hadmin/js/cropper/cropper.min.css" rel="stylesheet">
    <style type="text/css">
	    body {
	  		background-color: #fcfcfc;
		}
		.avatar-view {
		  display: block;
		  margin: 15% auto 5%;
		  height: 220px;
		  width: 220px;
		  border: 3px solid #fff;
		  border-radius: 5px;
		  box-shadow: 0 0 5px rgba(0,0,0,.15);
		  cursor: pointer;
		  overflow: hidden;
		}
		.avatar-view img {
		  width: 100%;
		}
		.avatar-body {
		  padding-right: 15px;
		  padding-left: 15px;
		}
		.avatar-upload {
		  overflow: hidden;
		}
		.avatar-upload label {
		  display: block;
		  float: left;
		  clear: left;
		  width: 100px;
		}
		.avatar-upload input {
		  display: block;
		  margin-left: 110px;
		}
		.avater-alert {
		  margin-top: 10px;
		  margin-bottom: 10px;
		}
		.avatar-wrapper {
		  height: 364px;
		  width: 100%;
		  margin-top: 15px;
		  box-shadow: inset 0 0 5px rgba(0,0,0,.25);
		  background-color: #fcfcfc;
		  overflow: hidden;
		}
		.avatar-wrapper img {
		  display: block;
		  height: auto;
		  max-width: 100%;
		}
		.avatar-preview {
		  float: left;
		  margin-top: 15px;
		  margin-right: 15px;
		  border: 1px solid #eee;
		  border-radius: 4px;
		  background-color: #fff;
		  overflow: hidden;
		}
		.avatar-preview:hover {
		  border-color: #ccf;
		  box-shadow: 0 0 5px rgba(0,0,0,.15);
		}
		.avatar-preview img {
		  width: 100%;
		}
		.preview-lg {
		  height: 184px;
		  width: 184px;
		  margin-top: 15px;
		}
		.preview-md {
		  height: 100px;
		  width: 100px;
		}
		.preview-sm {
		  height: 50px;
		  width: 50px;
		}
		@media (min-width: 992px) {
		  .avatar-preview {
		    float: none;
		  }
		}
		.avatar-btns {
		  margin-top: 30px;
		  margin-bottom: 15px;
		}
		.avatar-btns .btn-group {
		  margin-right: 5px;
		}
</style>
</head>
<body class="white-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div id="uploadDIv"></div>
            </div>
        </div>
        <div class="row">
	      	<div class="col-sm-12">
		        <div class="avatar-wrapper">
		       			 <img src="${ctx!}/hadmin/img/nodatas.png" alt="Picture"> 
		        </div>
		     </div>
	    </div>
       </div>
    </div>
    <!-- 全局js -->
    <#include "/admin/common/common.ftl">
    <#include "/admin/common/uploadimage_common.ftl">
    <script type="text/javascript" src="${ctx!}/hadmin/js/cropper/cropper.min.js?v=${version!}"></script>
    <script type="text/javascript" src="${ctx!}/oa/js/common/crop.js"></script>
    <script type="text/javascript">
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
            		suffix:data.contentType,
            		fileSize:data.fileSize,
            		pathName:data.pathName
            	};
            	var URL = window.URL || window.webkitURL,
            	imgUrl="${ctx}/download?filePath="+fileObj.filePath+"&fileName="+fileObj.filePath;
            	$image.one('built.cropper', function () {
            		URL.revokeObjectURL(imgUrl);
            	}).cropper('reset',true).cropper('replace',imgUrl);
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
            fileSizeLimit:10 * 1024*1024,
            fileSingleSizeLimit:50 * 1024*1024,
            accept: {}
        });
    });
    
    
    	/**获取裁剪后的图片*/
     function receImgData(){
    	 return $image.cropper('getCroppedCanvas');
     }
    </script>
</body>
</html>