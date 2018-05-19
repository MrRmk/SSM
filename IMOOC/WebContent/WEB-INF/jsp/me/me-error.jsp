<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-出错页面</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
</head>
<body>
	<div class="index">
 		
		<!-- 主要内容  -->
		<div class="main clearfix">
			<div class="types-block clearfix" style="text-align: center;">
				<div style="text-align: center; border: 1px solid #CCC; width: 600px; margin: 150px auto; padding: 50px 20px;">
					<h3><font style="color:red;">页面出错了！！！</font></h3>
					<strong>${errorMsg }</strong>
				</div>
			</div>
		</div>

		
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	//设置头部导航栏样式
	$(".nav .item:eq(4)").addClass('on');

</script>
</html>