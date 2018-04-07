var vm = null;
$(document).ready(function(){
    initVm();
});

/***初始化渲染函数
 */
function initVm(){
	vm = new Vue(
			{
			el:'#_container',
			data:{
				notice:null,
				twfourNews:null,
				sections:null,
				newsList:null,
				arrayindex:0,
				sectionId:'',
				pageNumber:1,
				pageSize:10,
				total:0,
				totalPages:0
			},
			created:function(){
				this.initload();
				this.moreData();
			},
			methods:{
				initload:function(){
					var vmObj = this;
					$.ajax({
		   	    		   type: "POST",
		   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	    		   dataType: "json",
		   	    		   url: "/web/index",
		   	    		   data:{},
		   	    		   success: function(data){
		   	    		   		if(typeof(data.data)!='undefined'){
		   	    		   			var dataObj = data.data;
		   	    		   			vmObj.notice=dataObj.notice;
		   	    		   			vmObj.twfourNews=dataObj.twfourNews;
		   	    		   			vmObj.sections=dataObj.sections;
		   	    		   			vmObj.newsList=dataObj.newsList;
		   	    		   			vmObj.sectionId=dataObj.sectionId;
		   	    		   		}/**暂无结果**/ 
		   	    		   }
		   	    	});
				},
				moreData:function(){
					var vmObj = this;
					var winH = $(window).height(); //页面可视区域高度
			        $(window).scroll(function() {
			        	vmObj.pageNumber++;
			            if (vmObj.pageNumber < vmObj.totalPages 
			            		&& vmObj.totalPages!=0) { // 当滚动的页数小于总页数的时候，继续加载
			                var pageH = $(document.body).height();
			                var scrollT = $(window).scrollTop(); //滚动条top
			                var aa = (pageH - winH - scrollT) / winH;
			                if (aa < 0.01) {
			                    vmObj.pageData();
			                }
			            }
			        });
				},
				pageData:function(){
					var vmObj = this;
					$.ajax({
		   	    		   type: "POST",
		   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	    		   dataType: "json",
		   	    		   url: "/web/list/"+vmObj.sectionId,
		   	    		   data:{
		   	    		   	pageNumber:vmObj.pageNumber,
		   	    		   	pageSize:vmObj.pageSize
		   	    		   },
		   	    		   success: function(data){
		   	    		   		if(typeof(data.content)!='undefined'
		   	    		   			&&data.content.length>0){
		   	    		   			vmObj.newsList=vmObj.newsList.concat(data.content);
		   	    		   			vmObj.totalPages=data.totalPages;
		   	    		   			vmObj.total=data.totalElements;
		   	    		   		}
		   	    		   }
		   	    	});
				},
				selectSec:function(sectionId,index){
					var vmObj = this;
					vmObj.arrayindex=index;
					vmObj.sectionId=sectionId;
					$.ajax({
		   	    		   type: "POST",
		   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	    		   dataType: "json",
		   	    		   url: "/web/list/"+vmObj.sectionId,
		   	    		   data:{
		   	    		   	pageNumber:1,
		   	    		   	pageSize:vmObj.pageSize
		   	    		   },
		   	    		   success: function(data){
		   	    		   		if(typeof(data.content)!='undefined'
		   	    		   			&&data.content.length>0){
		   	    		   			vmObj.newsList=data.content;
		   	    		   			vmObj.totalPages=data.totalPages;
		   	    		   			vmObj.total=data.totalElements;
		   	    		   		}
		   	    		   }
		   	    	});
				},
				detail:function(newsId){
					window.location.href="/cms/detail.html?newsid="+newsId;
				}
			}
			}
		);
}