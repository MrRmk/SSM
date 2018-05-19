<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

			<!-- 左边导航栏 start -->
			<div class="sidebar-nav">
			    <a href="#dashboard-menu" class="nav-header" data-toggle="collapse">
			   		<span style="font-weight: bold;font-size: 16px;">工作区</span>
			    </a>
			    <ul id="dashboard-menu" class="nav nav-list collapse in">
			        <li>
						<a target="_self" href="<%=request.getContextPath() %>/manager/index">主 页</a>
					</li>
					<li>
						<a href="<%=request.getContextPath() %>/manager/course">课程管理</a>
					</li>
					<%-- <li>
						<a href="<%=request.getContextPath() %>/manager/carousel">轮播配置</a>
					</li> --%>
					<li>
						<a href="<%=request.getContextPath() %>/manager/classify">课程分类管理</a>
					</li>
					<li>
						<a href="<%=request.getContextPath() %>/manager/user">用户管理</a>
					</li>
			    </ul>
			    
			    <a href="#accounts-menu" class="nav-header" data-toggle="collapse">
			    	<span style="font-weight: bold;font-size: 16px;">我的账号</span>
			    </a>
			    <ul id="accounts-menu" class="nav nav-list collapse in">
			    	<li><a href="<%=request.getContextPath() %>/manager/personal">个人信息</a></li>
			        <li><a href="<%=request.getContextPath() %>/manager/layout">退出</a></li>
			    </ul>
			</div>

	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
</script>