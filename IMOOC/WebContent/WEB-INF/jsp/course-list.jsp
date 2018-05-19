<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>全部课程_IT培训精品课程-慕课网</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
</head>
<body>
				
		<!-- 课程列表 start -->
		<div class="types-block clearfix">
			<h3 style="margin-bottom: 20px;">	
				<span class="types-title" style="margin-right:40px;">课程列表</span>
				<a href="javascript:void(0)" style="display: inline-block;margin-right:20px;" onclick="_queryPage(1,undefined,'last')">
				<span class="color-oc">最新</span>
				</a>
				<a href="javascript:void(0)" style="display: inline-block;" onclick="_queryPage(1,undefined,'pop')">
				<span>最热</span>
				</a>
			</h3>
			<div class="types-content clearfix" style="margin-bottom: 20px;">
				
				<div>
					<c:choose>
						<c:when test="${!empty courseDtoList}">
							<c:forEach items="${courseDtoList }" var="cDto" varStatus="loop">
								<a href="<%=request.getContextPath() %>/course/learn?courseId=${cDto.course.courseId}" target="_black">
									<div class="course-card-container">
										<div class="course-card-top brown-bg">
											<span>${cDto.sortsTwoName }</span>
										</div>
			
										<div class="course-card-content">
											<h3 class="course-card-name" title="${cDto.course.courseName }">${cDto.course.courseName }</h3>
											<p class="course-card-brief" title="${cDto.course.courseSummary }">${cDto.course.courseSummary }</p>
											<div class="course-card-bottom">
												<div class="course-card-info">
												${cDto.course.courseGrade }
												<span>·</span>${cDto.number }人在学
												</div>
											</div>
										</div>
									</div>
								</a>
							</c:forEach>
						</c:when>
						<c:otherwise>
							课程列表暂无数据！！！
						</c:otherwise>
					</c:choose>
					
				</div>
			
				<!-- <div>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top brown-bg">
								<span>Java</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="Java高并发秒杀API之高并发优化">Java高并发秒杀API之高并发优化</h3>
								<p class="course-card-brief" title="Java实现高并发秒杀API的第四门课，小伙伴一定可以从中受益">Java实现高并发秒杀API的第四门课，小伙伴一定可以从中受益</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									初级
									<span>·</span>1552人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top gray-bg">
								<span>Java</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="JAVA生成二维码">JAVA生成二维码</h3>
								<p class="course-card-brief" title="二维码无处不在，自己动手用Java生成二维码，三种生成方式任你选">二维码无处不在，自己动手用Java生成二维码，三种生成方式任你选</p>
								<div class="course-card-bottom">
									<div class="course-card-info">1452人在学</div>
									<div class="course-card-price">￥299</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top purple-bg">
								<span>Java</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="Java实现邮箱验证">Java实现邮箱验证</h3>
								<p class="course-card-brief" title="本视频教程主要介绍如何使用JavaMail进行邮箱验证，由浅入深">本视频教程主要介绍如何使用JavaMail进行邮箱验证，由浅入深</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									初级
									<span>·</span>1300人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top pink-bg">
								<span>Java</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="Java眼中的XML  文件写入">Java眼中的XML  文件写入</h3>
								<p class="course-card-brief" title="举例说明JAVA程序如何生成XML文档，多种生成方式任你选择">举例说明JAVA程序如何生成XML文档，多种生成方式任你选择</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									初级
									<span>·</span>1552人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container" style="margin-right: 0px;">
							<div class="course-card-top green-bg">
								<span>Java</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="基于SSH实现员工管理系统之框架整合篇">基于SSH实现员工管理系统之框架整合篇</h3>
								<p class="course-card-brief" title="本教程主要介绍环境搭建和SSH框架整合，逐层深入理解学习">本教程主要介绍环境搭建和SSH框架整合，逐层深入理解学习</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									初级
									<span>·</span>1300人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top purple-bg">
								<span>C语言</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="RBAC打造通用web管理权限">RBAC打造通用web管理权限</h3>
								<p class="course-card-brief" title="RBAC为商业系统安全防范手段，结合理论和实战介绍RBAC">RBAC为商业系统安全防范手段，结合理论和实战介绍RBAC</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									高级
									<span>·</span>1300人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top brown-bg">
								<span>C语言</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="JS实现人机大战之五子棋（UI篇）">JS实现人机大战之五子棋（UI篇）</h3>
								<p class="course-card-brief" title="利用js及canvas绘图知识，实现程序界面编写和交互逻辑处理">利用js及canvas绘图知识，实现程序界面编写和交互逻辑处理</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									中级
									<span>·</span>1552人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top pink-bg">
								<span>C语言</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="JS+CSS3实现“粽情端午”">JS+CSS3实现“粽情端午”</h3>
								<p class="course-card-brief" title="用JS和CSS3技术实现3D效果粽子特效动画，掌握动画制作过程">用JS和CSS3技术实现3D效果粽子特效动画，掌握动画制作过程</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									初级
									<span>·</span>1452人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container">
							<div class="course-card-top purple-bg">
								<span>python</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="Dwr实现JAVA服务器端向客户端推送消息">Dwr实现JAVA服务器端向客户端推送消息</h3>
								<p class="course-card-brief" title="dwr轻松帮你实现server push。">dwr轻松帮你实现server push。</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									高级
									<span>·</span>1300人在学
									</div>
								</div>
							</div>
						</div>
					</a>
					<a href="course/learn" target="_black">
						<div class="course-card-container" style="margin-right: 0px;">
							<div class="course-card-top green-bg">
								<span>C语言</span>
							</div>

							<div class="course-card-content">
								<h3 class="course-card-name" title="微信授权登录">微信授权登录</h3>
								<p class="course-card-brief" title="教你如何用Java实现微信授权登录，最后介绍公众号和开发平台如何关联">教你如何用Java实现微信授权登录，最后介绍公众号和开发平台如何关联</p>
								<div class="course-card-bottom">
									<div class="course-card-info">
									高级
									<span>·</span>1452人在学
									</div>
								</div>
							</div>
						</div>
					</a>
				</div>
				 -->
				 
				<!-- 分页 -->
				<div class="page-box clearfix">
					<ul class="pagination">
						<li><a href="#">首页</a></li>
						<li><a href="#">&laquo;</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">&raquo;</a></li>
						<li><a href="#">末页</a></li>
					</ul>
				</div>
				
			</div>
		</div>
		<!-- 课程列表 end -->

			
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript">
	// 设置头部导航栏样式
	$(".nav .item:eq(1)").addClass('on');
	</script>
</html>