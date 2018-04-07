$(document).ready(function(){
	initfullCalendar();
});


/****初始化日历插件
 */
function initfullCalendar(){
	try{
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay,listWeek'
			},
			defaultDate:currentDate(),
			navLinks: true, // can click day/week names to navigate views
			editable: true,
			eventLimit: true, // allow "more" link when too many events
		});
	}catch(e){
		console.log('initfullCalendar'+e);
	}
}


/****当前日期
 */
function currentDate() {
	try{
		var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	    return currentdate;
	}catch(e){
		console.log('currentDate'+e);
	}
} 