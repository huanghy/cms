//显示天气详情
(function () {
    var weather = document.querySelector('#weather');
    var details = document.querySelector('#w_details');
    weather.onmouseover = function () {
        details.style.display = 'block';
        weather.onmouseout = function () {
            details.style.display = 'none';
        }
    }
})();
//固定channel
(function () {
    var channel = document.querySelector('#channel');
    var height = channel.offsetTop;
    window.onscroll = function () {
        if(this.pageYOffset-34 > height) {
            channel.classList.add('channel-fixed');
        }
        else {
            channel.className = 'channel';
        }
    };
})();





///轮播
var t;
var index = 0;
/////自动播放
t = setInterval(play, 3000)

function play() {
    index++;
    if (index > 5) {
        index = 0
    }
    // console.log(index)
    $("#lunbobox ul li").eq(index).addClass(
        "tabs-active"
    ).siblings().removeClass(
        "tabs-active"
    )

    $(".lunbo a ").eq(index).fadeIn(1000).siblings().fadeOut(1000);
};

///鼠标选择 图片切换
$("#lunbobox ul li").mouseover(function() {

    //添加 移除样式
    //$(this).addClass("lito").siblings().removeClass("lito"); //给当前鼠标移动到的li增加样式 且其余兄弟元素移除样式   可以在样式中 用hover 来对li 实现
    $(this).addClass(
        "tabs-active"
    ).siblings().removeClass(
        "tabs-active"
    )
    var index = $(this).index(); //获取索引 图片索引与按钮的索引是一一对应的
    // console.log(index);

    $(".lunbo a ").eq(index).fadeIn(1000).siblings().fadeOut(1000); // siblings  找到 兄弟节点(不包括自己）
});


///////鼠标移进  移出
$("#lunbobox ul li,.lunbo a img").hover(
    ////////鼠标移进
    function() {
        clearInterval(t);
    },
    ///////鼠标移开
    function() {
        //$('#toright,#toleft').hide()
        //alert('aaa')
        t = setInterval(play, 3000);

        function play() {
            index++;
            if (index > 4) {
                index = 0
            }
            $("#lunbobox ul li").eq(index).addClass(
                "tabs-active"
            ).siblings().removeClass(
                "tabs-active"
            )
            $(".lunbo a ").eq(index).fadeIn(1000).siblings().fadeOut(1000);
        }
    });



//回顶点
$(window).scroll(function () {
    if($(window).scrollTop()>500) {
        $('#goTop').css('display','block');
    }
    else {
        $('#goTop').css('display','none');
    }
});

$('#goTop').bind('click', function () {
    $(window).scrollTop(0);
});