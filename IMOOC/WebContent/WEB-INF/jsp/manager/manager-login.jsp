<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-管理员登录页面</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- me页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	<style type="text/css"> 
		/* 验证码 */
		.code {  
		    font-family: Arial;  
		    font-style: italic;  
		    font-weight: bold;  
		    border: 0;  
		    letter-spacing: 3px;  
		    color: blue;  
		    font-size: 19px;
		} 
	</style>
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
		<div class="header">
			<div class="headerContent">
				<a href="<%=request.getContextPath() %>/home" target="_self" title="首页">  
					<img src="<%=request.getContextPath() %>/static/images/logo4.png"/>   
				</a>
				<span>慕课网后台管理</span>
				<a class="item-two" href="<%=request.getContextPath() %>/home" target="_self" title="首页">返回首页</a>
			</div>
		</div>

		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			<div class="types-block clearfix" style="text-align: center;">
				<h3 class="types-title">后台管理登录</h3>
				<form class="oc-form" id="login" method="post" action="<%=request.getContextPath() %>/manager/loginCheck" style="text-align: center;border: 1px solid #CCC;width: 600px;margin:0 auto;padding:20px;" >
						<li>请用: rmk/admin 登录</li>
						<li><label>用户名</label> 
							<input id="account" name="account" value="" type="text" class="input-text form-control" placeholder="请输入用户名">
						</li>
						<li><label>密码</label> 
							<input id="password" name="password" type="password" class="input-text form-control" placeholder="请输入密码" autocomplete="off">
						</li>
						<!-- <li><label>验证码</label> 
						<input id="identiryCode" name="identiryCode" maxlength="6" class="input-text" type="text" style="width: 210px;" placeholder="请输入验证码">
						<a class="vali-base">
							<input type="button" id="checkCode" style="width:80px;height:40px;float:left;margin-left:10px;" class="code" onclick="createCode()" /> 
						</a>
						</li> -->
						<li>
							<label style="background-color:#FFF;">
								<input type="checkbox" value="1" class="checkbox1" id="checkbox1" name="rememberMe">
                           		<span class="text">下次自动登录</span>
							</label> 
                           	<span class="text" id="errMsg" style="float: left;margin-left:5px; color:red;">${errMsg}</span>
                      	</li>
						<li class="clearfix" style="margin-top: 20px;">
							<input type="submit" value="登录" class="btn" style="margin-right:20px;">
							<!-- <input type="submit" value="登录" onclick="validate()" class="btn" style="margin-right:20px;"> -->
							<input type="button" value="重置" class="btn" onclick = "Reset()" style="margin-right:20px;">
						</li>
					</form>
			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<!-- 可选: 包含 jQuery 库 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<!-- 可选: 合并了 Bootstrap JavaScript 插件 -->
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript">
		var code; //在全局定义验证码      
		//产生验证码     
		window.onload = function() {  
		    createCode();  
		}
		var account1;
		var password1;
		function getValue(){
			account1 = document.getElementById("account").value;
			password1 = document.getElementById("password").value;
			alert("accout:"+ account1 +",password:"+ password1);
		}
		function setValue(){
			alert("accout11:"+ account1 +",password:"+ password1);
			//获取获取信息对象
			var account = document.getElementById("account");
			var password = document.getElementById("password");
			//重置信息对象内容
			account.innerHTML = account1;
			password.innerHTML = password1;
		}
		  
		function createCode() {  
		    code = "";  
		    var codeLength = 4; //验证码的长度     
		    var checkCode = document.getElementById("checkCode");  
		    var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',  
		        'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //随机数     
		    for(var i = 0; i < codeLength; i++) { //循环操作     
		        var charIndex = Math.floor(Math.random() * 36); //取得随机数的索引     
		        code += random[charIndex]; //根据索引取得随机数加到code上     
		    }  
		    checkCode.value = code; //把code值赋给验证码     
		}  
		//校验验证码     
		function validate() { 
		    var inputCode = document.getElementById("identiryCode").value.toUpperCase(); //取得输入的验证码并转化为大写           
		    if(inputCode.length <= 0) { //若输入的验证码长度为0   
		    	/* getValue(); */
		        alert("请输入验证码！"); //则弹出请输入验证码  
		        /* setValue(); */
		    } else if(inputCode != code) { //若输入的验证码与产生的验证码不一致时   
		    	/* getValue(); */
		        alert("验证码输入错误！"); //则弹出验证码输入错误     
		        createCode(); //刷新验证码     
		        /* setValue(); */
		    } else { //输入正确时     
		    	account1 = document.getElementById("account").value;
				password1 = document.getElementById("password").value;
		        window.location.href = '<%=request.getContextPath() %>/manager?account=account1:password=password1';
		    }  
		} 
	</script>
</html>