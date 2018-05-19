/*为了判断用户是否登录*/

$(document).ready(function(){
	// 判断用户是否登录
	var user = '${sessionScope.user}';
	if( user != null && user != ""){
		$('.unLogin1').attr('style','display: none;');
		$('.unLogin2').css({display:'block'});
	}else{
		$('.unLogin2').attr('style','display: none;');
		$('.unLogin1').css({display:'block'});
	}
	
	// 头像控制
	$('.login-img').on({
		mouseover : function(){  
			$('.popover').show();
        },  
        mouseout : function(){  
        	$('.popover').hide();
        } 
	});
	$('.popover').on({
		mouseover : function(){  
			$(this).show();
        },  
        mouseout : function(){  
        	$(this).hide();
        } 
	});
	
});