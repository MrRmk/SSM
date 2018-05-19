<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-程序员的梦工厂</title>
	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<!-- home页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/home.css"> 
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>
<body>
	<div class="index">
		<%-- <%
			Cookie cookie = new Cookie("headerCSS", "1");
		%> --%>
		<!-- 头部导航栏 -->
		<jsp:include   page="header.jsp" flush="true"/>
		
		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			<div class="content">
				
				<!-- 课程分类 start -->
				<div class="content-wrap">
					<div class="menuwrap">
					<c:choose>
						<c:when test="${!empty sortsOneList}">
							<c:forEach items="${sortsOneList }" var="s1" varStatus="loopOne">
							
								<div class="submenu a" data-id="a" style="display: none;">
									<div class="innerBox clearfix">
										<div class="subinnerBox">
											<div class="cates-box">
												<div class="fe-base-box clearfix">
													<div class="banner-line">
														<span class="bold mr10 l small-title">全部</span>
													</div>
													<div class="tag-box l">
														<c:choose>
															<c:when test="${!empty sortsTwoList}">
																<c:forEach items="${sortsTwoList }" var="s2" varStatus="loopTwo">
																	<c:if test="${s1.oneId eq s2.oneId }">
																		<a target="_blank" href="<%=request.getContextPath() %>/course/total?c=${s2.twoCode}">${s2.twoName }</a>
																	</c:if>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<span>${s1.oneName }分类下暂时没有二级分类数据！！</span>
															</c:otherwise>
														</c:choose>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="recomment-box">
										
										<%
											int index = 1;
										%>
										<!-- 循环显示 课程信息 start -->
										<c:choose>
											<c:when test="${!empty courseDtoList}">
												<c:forEach items="${courseDtoList }" var="courseDto" varStatus="loopCourse">
													<c:if test="${ s1.oneId == courseDto.oneId }">
														<%
															if( index <= 4 ){
																index++;
														%>
														<div class="l banner-course-card">
															<a href="<%=request.getContextPath() %>/course/learn?courseId=${courseDto.course.courseId }" target="_blank" title="${courseDto.course.courseName }" class="clearfix">
															    <img src="<%=request.getContextPath() %>/static/images/Carousel-<%=index %>.png" class="l">
															    <div class="l course-card">
										        					<h3 class="course-card-name">${courseDto.course.courseName }</h3>
										        					<div class="course-card-info">
										        						<c:if test="${courseDto.course.courseIsProject == 1 }">
										        							<span>实战</span>
										        						</c:if>
											                            <span>${courseDto.course.courseGrade }</span>
																		<span class="glyphicon glyphicon-user" style="color: rgb(32, 30, 60); margin-right:0;padding-right:0;"></span>&nbsp;${courseDto.number }
																	</div>
																	<c:if test="${courseDto.course.courseIsProject == 1 }">
									        							<div class="course-card-price"><span style="color: red">￥${courseDto.course.coursePrice }</span></div>
									        						</c:if>
																</div>
															</a>
														</div>
														<%
															}
														%>
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<div class="l banner-course-card">
													<a class="clearfix">
														<div class="course-card-info">
															<span>${s1.oneName }分类下暂时课程数据！！</span>
														</div>
													</a>
												</div>
											</c:otherwise>
										</c:choose>
										<!-- 循环显示 课程信息 end -->
									
									</div>    			
								</div>
								
							</c:forEach>
						</c:when>
						<c:otherwise>
							<span>一级分类暂时没有数据！！</span>
						</c:otherwise>
					</c:choose>
						
						<!-- 一级分类内容导航 -->
						<div class="menuContent">
							<c:choose>
								<c:when test="${!empty sortsOneList}">
									<c:forEach items="${sortsOneList }" var="s1" varStatus="loop">
										<div class="item" data-id="a">
											<a href="<%=request.getContextPath() %>/course/total?c=${s1.oneCode}" target="_blank">
												<span class="group">${s1.oneName }</span>
												<i class="icon-right2">&gt;</i>
											</a>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 一级分类数据表没有数据 -->
								</c:otherwise>
							</c:choose>

							
						</div>

						<!-- 轮播效果 start -->
						<div class="g-banner-content">
							<div id="myCarousel" class="carousel slide">
								<!-- 轮播（Carousel）指标 -->
								<ol class="carousel-indicators">
									<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
									<li data-target="#myCarousel" data-slide-to="1"></li>
									<li data-target="#myCarousel" data-slide-to="2"></li>
									<li data-target="#myCarousel" data-slide-to="3"></li>
									<li data-target="#myCarousel" data-slide-to="4"></li>
									<li data-target="#myCarousel" data-slide-to="5"></li>
								</ol>   
								<!-- 轮播（Carousel）项目 -->
								<div class="carousel-inner">
									<div class="item active">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-1.jpg" alt="First slide">
									</div>
									<div class="item">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-2.jpg" alt="Second slide">
									</div>
									<div class="item">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-3.jpg" alt="Third slide">
									</div>
									<div class="item">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-4.jpg" alt="Fourth slide">
									</div>
									<div class="item">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-5.jpg" alt="Fifth slide">
									</div>
									<div class="item">
										<img src="<%=request.getContextPath() %>/static/images/Carousel-6.png" alt="Sixth slide">
									</div>
								</div>
								<!-- 轮播（Carousel）导航 -->
								<a class="carousel-control left" href="#myCarousel" data-slide="prev">
									<!-- &lsaquo; -->
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
								<a class="carousel-control right" href="#myCarousel" data-slide="next">
									<!-- &rsaquo; -->
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div> 
						</div>
					    <!-- 轮播效果 end -->
					</div>
				</div>
				<!-- 课程分类 end -->

				<!-- 实战推荐 start -->
				<div class="bgfff">
					<div class="types-block clearfix">
						<h3 class="types-title">
							<img src="<%=request.getContextPath() %>/static/images/title1-left.png"/>   
							实战推荐
							<img src="<%=request.getContextPath() %>/static/images/title1-right.png"/>   
						</h3>
						<div class="types-content">
							<!-- 循环显示 课程信息 start -->
							<c:choose>
								<c:when test="${!empty courseProjectFirstFiveDtoList}">
									<c:forEach items="${courseProjectFirstFiveDtoList }" var="courseProjectFiveDto" varStatus="loopCourseProjectFive">
										<a href="<%=request.getContextPath() %>/course/learn?courseId=${courseProjectFiveDto.course.courseId }" target="_black">
											<c:choose>
												<c:when test="${loopCourseProjectFive.count == 5 }">
													<!-- 如果div有第五个，要设置样式 为card-right -->
													<div class="course-card-container card-right">
														<div class="course-card-top green-bg">
												</c:when>
												<c:otherwise>
													<c:if test="${loopCourseProjectFive.count == 1 }">
														<div class="course-card-container">
															<div class="course-card-top brown-bg">
													</c:if>
													<c:if test="${loopCourseProjectFive.count == 2 }">
														<div class="course-card-container">
															<div class="course-card-top gray-bg">
													</c:if>
													<c:if test="${loopCourseProjectFive.count == 3 }">
														<div class="course-card-container">
															<div class="course-card-top purple-bg">
													</c:if>
													<c:if test="${loopCourseProjectFive.count == 4 }">
														<div class="course-card-container">
															<div class="course-card-top pink-bg">
													</c:if>
												</c:otherwise>
											</c:choose>
													<span>${courseProjectFiveDto.sortsTwoName }</span>
												</div>
												<div class="course-card-content">
													<h3 class="course-card-name" title="${courseProjectFiveDto.course.courseName }">${courseProjectFiveDto.course.courseName }</h3>
													<p class="course-card-brief" title="${courseProjectFiveDto.course.courseSummary }">${courseProjectFiveDto.course.courseSummary }</p>
													<div class="course-card-bottom">
														<div class="course-card-info">${courseProjectFiveDto.number }人在学</div>
														<div class="course-card-price">￥${courseProjectFiveDto.course.coursePrice }</div>
													</div>
												</div>
											</div>
										</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<h3>实战推荐暂时没有课程数据！！</h3>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<!-- 实战推荐 end -->

				<!-- 免费好课 start -->
				<div class="bg000">
					<div class="types-block clearfix">
						<h3 class="types-title">
							<img src="<%=request.getContextPath() %>/static/images/title2-left.png"/>   
							免费好课
							<img src="<%=request.getContextPath() %>/static/images/title2-right.png"/> 
						</h3>
						<div class="types-content">
							<!-- 循环显示 课程信息 start -->
							<c:choose>
								<c:when test="${!empty courseFirstFiveDtoList}">
									<c:forEach items="${courseFirstFiveDtoList }" var="courseFiveDto" varStatus="loopCourseFive">
										<a href="<%=request.getContextPath() %>/course/learn?courseId=${courseFiveDto.course.courseId }" target="_black">
											<c:choose>
												<c:when test="${loopCourseFive.count == 5 }">
													<!-- 如果div有第五个，要设置样式 为card-right -->
													<div class="course-card-container card-right">
														<div class="course-card-top green-bg">
												</c:when>
												<c:otherwise>
													<c:if test="${loopCourseFive.count == 1 }">
														<div class="course-card-container">
															<div class="course-card-top brown-bg">
													</c:if>
													<c:if test="${loopCourseFive.count == 2 }">
														<div class="course-card-container">
															<div class="course-card-top gray-bg">
													</c:if>
													<c:if test="${loopCourseFive.count == 3 }">
														<div class="course-card-container">
															<div class="course-card-top purple-bg">
													</c:if>
													<c:if test="${loopCourseFive.count == 4 }">
														<div class="course-card-container">
															<div class="course-card-top pink-bg">
													</c:if>
												</c:otherwise>
											</c:choose>
													<span>${courseFiveDto.sortsTwoName }</span>
												</div>
												<div class="course-card-content">
													<h3 class="course-card-name" title="${courseFiveDto.course.courseName }">${courseFiveDto.course.courseName }</h3>
													<p class="course-card-brief" title="${courseFiveDto.course.courseSummary }">${courseFiveDto.course.courseSummary }</p>
													<div class="course-card-bottom">
														<div class="course-card-info">
														${courseFiveDto.course.courseGrade }<span>·</span>${courseFiveDto.number }人在学
														</div>
													</div>
												</div>
											</div>
										</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<h3>免费好课暂时没有课程数据！！</h3>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<!-- 免费好课 end -->

				<!-- Java开发工程师 start -->
				<div class="bgfff">
					<div class="types-block clearfix">
						<h3 class="types-title">
							<img src="<%=request.getContextPath() %>/static/images/title3-left.png"/>   
							Java开发工程师
							<img src="<%=request.getContextPath() %>/static/images/title3-right.png"/> 
						</h3>
						
						<!-- Java开发工程师(入门课程) left start -->
						<c:choose>
							<c:when test="${!empty javaCourseLowDtoList}">
								<c:forEach items="${javaCourseLowDtoList }" var="javaCourseLowDto" varStatus="loop">
									<c:if test="${loop.count == 1 }">
										<a href="<%=request.getContextPath() %>/course/learn?courseId=${javaCourseLowDto.course.courseId }" target="_black">
											<div class="types-content-left " style="background-image: url(<%=request.getContextPath() %>/static/images/Java-background.png);">
												<div class="course-card-container-fix">
													<div class="course-card-content">
														<h3 class="course-card-name" title="${javaCourseLowDto.course.courseName }">${javaCourseLowDto.course.courseName }</h3>
														<p class="color-fff" title="${javaCourseLowDto.course.courseSummary }">${javaCourseLowDto.course.courseSummary }</p>
														<div class="course-card-bottom" style="margin-top: 50px;">
															<div class="course-card-info color-fff">了解详情 →</div>
														</div>
													</div>
												</div>
											</div>
										</a>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								暂时没有Java入门课程数据
							</c:otherwise>
						</c:choose>
						<!-- Java开发工程师(入门课程) left end -->
						

						<!-- Java开发工程师 right start -->
						<div class="types-content-right ">
							<!-- Java开发工程师(高级课程) start -->
							<div class="types-content-banner ">
								<c:choose>
									<c:when test="${!empty javaCourseHighDtoList}">
										<c:forEach items="${javaCourseHighDtoList }" var="javaCourseHighDto" varStatus="loop">
											<c:if test="${loop.count == 1 }">
												<a href="<%=request.getContextPath() %>/course/learn?courseId=${javaCourseHighDto.course.courseId }" target="_black" title="${javaCourseHighDto.course.courseName }">
													<div class="types-content-banner-block green-bg" style="margin-right:20px;">
														${javaCourseHighDto.course.courseName }
													</div>
												</a>
											</c:if>
											<c:if test="${loop.count == 2 }">
												<a href="<%=request.getContextPath() %>/course/learn?courseId=${javaCourseHighDto.course.courseId }" target="_black" title="${javaCourseHighDto.course.courseName }">
													<div class="types-content-banner-block blue-bg">
														${javaCourseHighDto.course.courseName }
													</div>
												</a>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										暂时没有Java高级课程数据
									</c:otherwise>
								</c:choose>
							</div>
							<!-- Java开发工程师(高级课程) end -->
							
							<!-- Java开发工程师(初级+中级课程) start -->
							<div class="clearfix">
							
								<c:choose>
									<c:when test="${!empty javaCourseMidDtoList}">
										<c:forEach items="${javaCourseMidDtoList }" var="javaCourseMidDto" varStatus="loop">
											<c:if test="${loop.count <= 3 }">
												<a href="<%=request.getContextPath() %>/course/learn?courseId=${javaCourseMidDto.course.courseId }" target="_black">
													<div class="course-card-container">
														<div class="course-card-top green-bg">
															<span>${javaCourseMidDto.sortsTwoName }</span>
														</div>
							
														<div class="course-card-content">
															<h3 class="course-card-name" title="${javaCourseMidDto.course.courseName }">${javaCourseMidDto.course.courseName }</h3>
															<p class="course-card-brief" title="${javaCourseMidDto.course.courseSummary }">${javaCourseMidDto.course.courseSummary }</p>
															<div class="course-card-bottom">
																<div class="course-card-info">
																${javaCourseMidDto.course.courseGrade }
																<span>·</span>${javaCourseMidDto.number }人在学
																</div>
															</div>
														</div>
													</div>
												</a> 
											</c:if>
											<c:if test="${loop.count == 4 }">
												<a href="<%=request.getContextPath() %>/course/learn?courseId=${javaCourseMidDto.course.courseId }" target="_black">
													<div class="course-card-container card-right">
														<div class="course-card-top green-bg">
															<span>${javaCourseMidDto.sortsTwoName }</span>
														</div>
							
														<div class="course-card-content">
															<h3 class="course-card-name" title="${javaCourseMidDto.course.courseName }">${javaCourseMidDto.course.courseName }</h3>
															<p class="course-card-brief" title="${javaCourseMidDto.course.courseSummary }">${javaCourseMidDto.course.courseSummary }</p>
															<div class="course-card-bottom">
																<div class="course-card-info">
																${javaCourseMidDto.course.courseGrade }
																<span>·</span>${javaCourseMidDto.number }人在学
																</div>
															</div>
														</div>
													</div>
												</a> 
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										暂时没有Java初级+中级课程数据
									</c:otherwise>
								</c:choose>
							</div>
							<!-- Java开发工程师(初级+中级课程) end -->
							
						</div>
						<!-- Java开发工程师 right end -->
					</div>
				</div>
				<!-- Java开发工程师 end -->

				<!-- 名校讲师 start -->
				<div class="bg000">
					<div class="types-block clearfix">
						<h3 class="types-title">
							<img src="<%=request.getContextPath() %>/static/images/title4-left.png"/>   
							名校讲师
							<img src="<%=request.getContextPath() %>/static/images/title4-right.png"/> 
						</h3>
						<div class="lecturer-card-container">
							<div class="lecturer-item">
								<img class="lecturer-uimg" src="<%=request.getContextPath() %>/static/images/header1.png">
								<span class="lecturer-name">王阳明</span>
								<span class="lecturer-title">家里蹲大学 · 博士</span>
								<span class="lecturer-p">高级讲师，</span>
							</div>
						</div>
						<div class="lecturer-card-container">
							<div class="lecturer-item">
								<img class="lecturer-uimg" src="<%=request.getContextPath() %>/static/images/header2.png">
								<span class="lecturer-name">李四</span>
								<span class="lecturer-title">华东大学 · 本科</span>
								<span class="lecturer-p">特级讲师，擅长人工智能算法</span>
							</div>
						</div>
						<div class="lecturer-card-container">
							<div class="lecturer-item">
								<img class="lecturer-uimg" src="<%=request.getContextPath() %>/static/images/header2.png">
								<span class="lecturer-name">赵六</span>
								<span class="lecturer-title">华中大学 · 本科</span>
								<span class="lecturer-p">特级讲师，擅长C语言</span>
							</div>
						</div>
						<div class="lecturer-card-container">
							<div class="lecturer-item">
								<img class="lecturer-uimg" src="<%=request.getContextPath() %>/static/images/header2.png">
								<span class="lecturer-name">王五</span>
								<span class="lecturer-title">华南大学 · 硕士</span>
								<span class="lecturer-p">高级讲师，擅长PHP</span>
							</div>
						</div>
						<div class="lecturer-card-container card-right">
							<div class="lecturer-item">
								<img class="lecturer-uimg" src="<%=request.getContextPath() %>/static/images/header2.png">
								<span class="lecturer-name">周八</span>
								<span class="lecturer-title">华中大学 · 博士</span>
								<span class="lecturer-p">特级讲师，擅长C、Java、PHP</span>
							</div>
						</div>
					</div>
				</div>
				<!-- 名校讲师 end -->

			</div>
		</div>

		<!-- 底部 页面 start -->
		<div class="f-footer clearfix">
			<div class="f-footer-box">
				<div class="footer-link">
					<a href="javascript:void(0);" target="_blank" title="企业合作">企业合作</a> 
					<a href="javascript:void(0);" target="_blank" title="联系我们">联系我们</a> 
					<a href="javascript:void(0);" target="_blank" title="人才招聘">人才招聘</a> 
					<a href="javascript:void(0);" target="_blank" title="联系我们">联系我们</a> 
					<a href="javascript:void(0);" target="_blank" title="常见问题">常见问题</a> 
					<a href="javascript:void(0);" target="_blank" title="意见反馈">意见反馈</a> 
					<a href="https://www.icourse163.org/" target="_blank" title="慕课大学">慕课大学</a> 
					<a href="javascript:void(0);" target="_blank" title="友情链接">友情链接</a> 
				</div>
				<div class="footer-copyright">
					<p>Copyright © 2018 南昌航空大学 软件学院 | 14201109 &nbsp;&nbsp;&nbsp;&nbsp;tel:1827917543</p>
				</div>
			</div>
		</div>
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
			$(".nav .item:eq(0)").addClass('on');
			
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
			
			// 轮播面板 导航栏控制
		  	$(".menuContent .item").on({  
		        mouseover : function(){  
			        var index=$(this).index('.menuContent .item');
			        $('.menuwrap > .submenu').eq(index).show();
		        },  
		        mouseout : function(){  
		        	var index=$(this).index('.menuContent .item');
			        $('.menuwrap > .submenu').eq(index).hide();
		        }   
		   	});
		  	// submenu也要控制自身显示隐藏
		   	$(".menuwrap > .submenu").on({  
		        mouseenter : function(){  
		        	$(this).show();
		        	var index=$(this).index('.menuwrap > .submenu');
			        $('.menuContent .item').eq(index).addClass('item-on');
		        },  
		        mouseleave : function(){  
		        	$(this).hide();
		        	var index=$(this).index('.menuwrap > .submenu');
			        $('.menuContent .item').eq(index).removeClass('item-on');
		        }   
		   	});
		   	
		});
		
	</script>
</html>