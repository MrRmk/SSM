<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-登录页面</title>

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
		function Reset(){
			//调用form表单的reset()函数
			document.getElementById("login").reset();
			//获取获取错误显示信息对象
			var errMsg = document.getElementById("errMsg");
			//重置错误信息对象内容
			errMsg.innerHTML = "";
		}
	</script>
</head>

<body>
	<div class="index">
		<!-- 头部导航栏 -->
 		<jsp:include   page="header.jsp" flush="true"/>
 		
		<!-- 主要内容  -->
		<div class="main clearfix">
			<div class="types-block clearfix" style="text-align: center;">
				<h3 class="types-title">登录</h3>
				<form class="oc-form" id="login" style="text-align: center;border: 1px solid #CCC;width: 600px;margin:0 auto;padding:20px;" method="post" action="<%=request.getContextPath() %>/loginCheck">
						<li>请用：14201109/1 登录</li>
						<li><label>账号</label> 
							<input name="account" value="" type="text" class="input-text form-control" placeholder="请输入账号">
						</li>
						<li><label>密码</label> 
							<input id="password" name="password"  type="password" class="input-text form-control" placeholder="请输入密码" autocomplete="off">
						</li>
						<%-- <li><label>验证码</label> 
							<input id="identiryCode" name="identiryCode" maxlength="6" class="input-text" type="text" style="width: 150px;" placeholder="请输入验证码">
							<a class="vali-base">
								<img onclick="reloadIndityImg('indeityImgLogin');" id="indeityImgLogin" src="<%=request.getContextPath() %>/static/images/code.png" style="width:80px;height:40px;float:left;margin-left:10px;">
							</a>
						</li> --%>
						<li>
							<label style="background-color:#FFF;">
								<input type="checkbox" value="1" class="checkbox1" id="checkbox1" name="rememberMe">
                           		<span class="text">下次自动登录</span>
							</label> 
                           	<span class="text" id="errMsg" style="float: left;margin-left:5px; color:red;">${errMsg}</span>
                      	</li>
						<li class="clearfix" style="margin-top: 20px;">
							<label style="background-color:#FFF;">
								<a href="register">还没有账号，点我注册</a>
								<!-- <div class="btn" onclick="window.location.href='register'">注册</div> -->
							</label>
							<input type="submit" value="登录" class="btn" style="margin-right:20px;">
							
							<input type="button" value="重置" class="btn" onclick = "Reset()" style="margin-right:20px;">
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
			// 设置头部导航栏样式
			$(".nav .item:eq(4)").addClass('on');
			
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