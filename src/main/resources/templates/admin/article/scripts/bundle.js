bg").val(text);
	       	    jquery(".bankshow").addClass("none");
	       });
	       jquery(".texbg").click(function(){
	       	   jquery(".bankshow").removeClass("none");
	       	   autocomplete.clearadd();
	       	   autocomplete.databind();
	       });
		}catch(e){
			console.log('upAccount'+e);
		}
	}
	
	/***返回方法 
	 */
	return {
		initLoad:initLoad
   } 
})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         