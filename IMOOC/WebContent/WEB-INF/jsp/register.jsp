<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-注册页面</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- me页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	<script type="text/javascript">
		//返回注册信息
		function message(){	
			var message = '${requestScope.message}';		//如果不等于空，说明返回来时的注册结果
			if( message != null && message != "" ){
				alert(message);
			}
		}
		window.onload = message;
	</script>
</head>

<body>
	<div class="index">
		<!-- 头部导航栏 -->
		<jsp:include   page="header.jsp" flush="true"/>

		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			<div class="types-block clearfix" style="text-align: center;">
				<h3 class="types-title">注册</h3>
				<form id="registerForm" method="post" action="registerCheck" class="oc-form" style="text-align: center;border: 1px solid #CCC;width: 600px;margin:0 auto;padding:20px;">
						<li><label>账号</label> 
							<input maxlength="20" id="account" name="account" type="text"  maxlength="16" class="form-control input-text" placeholder="请输入用户名（英文数字）">
						</li>
						<li><label>密码</label> 
							<input maxlength="20" id="password" name="password" type="password" maxlength="16" class="form-control input-text" placeholder="请输入密码" autocomplete="off">
						</li>
						<%-- <li><label>验证码</label> 
						<input id="identiryCode" name="identiryCode" maxlength="6" class="input-text" type="text" style="width: 150px;" placeholder="请输入验证码">
						<a class="vali-base"><img onclick="reloadIndityImg('indeityImgRegister');" id="indeityImgRegister" src="<%=request.getContextPath() %>/static/images/code.png" style="width:80px;height:40px;float:left;margin-left:10px;"></a>
						</li> --%>
						<li id="errorMsg" class="clearfix" style="display: none;color:red;"></li>
						<li class="clearfix" style="margin-top: 30px;">
							<input type="submit" value="注册保存" class="btn">
						</li>
						<li>
							<a style="float: left;" href="login">已有账号，去登录</a>
						</li>
					</form>
			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<!-- 可选: 包含 jQuery 库 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<!-- 可选: 合并了 Bootstrap JavaScript 插件 -->
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript">
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
	</script>
</html>