$(function(){
    //菜单点击
    $(".J_menuItem").on('click',function(){
        var url = $(this).attr('href');
        $("#J_iframe").attr('src',url);
        return false;
    });
    $(".showpr").on("click",'a',function(){
    	$(".showpr").addClass("none");
    	return true;
    });
  
});

