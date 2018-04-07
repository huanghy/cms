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
				content:null,
				news:null,
				replys:null,
				replysize:null
			},
			created:function(){
				this.initload();
			},
			methods:{
				initload:function(){
					var newsid = this.receParam("newsid");
					var vmObj = this;
					$.ajax({
		   	    		   type: "POST",
		   	    		   contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	    		   dataType: "json",
		   	    		   url: "/web/detail/"+newsid,
		   	    		   data:{},
		   	    		   success: function(data){
		   	    		   		if(typeof(data.data)!='undefined'){
		   	    		   			var dataObj = data.data;
		   	    		   			vmObj.news=dataObj.new;
		   	    		   			if(typeof(dataObj.content)!='undefined' 
		   	    		   				&&  null != dataObj.content){
		   	    		   				vmObj.content=decodeURIComponent(dataObj.content);
		   	    		   			}
		   	    		   			vmObj.replys=dataObj.replys;
		   	    		   			vmObj.replysize=dataObj.replysize;
		   	    		   			
		   	    		   		}/**暂无结果**/ 
		   	    		   }
		   	    	});
				},//获取参数
				receParam:function(name)
				{
				     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
				     var r = window.location.search.substr(1).match(reg);
				     if(r!=null)return  unescape(r[2]); return null;
				}
			}
			}
		);
}