<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>我的动态</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<!-- me页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>
<body>
	<div class="index">
		<!-- 头部导航栏 -->
		<jsp:include   page="../header.jsp" flush="true"/>

		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			<div class="content">
				<div class="content-wrap me-content">
					<!-- 页面左边 start -->
					<jsp:include   page="me-left.jsp" flush="true"/>
					
					<!-- 页面右边 start -->
					<div class="setting-right">
						<div class="setting--all">
							<div><span class="f-16"><strong>最近学习</strong></span></div>
							<!-- 分割线 -->
							<div class="split-line" style="margin: 20px 0px;"></div>
							<!-- 表单 start -->
							<form id="queryPageForm" action="" method="post">
									
								<!-- 循环显示 最近学习课程列表 start -->	
								<c:choose>
									<c:when test="${!empty learnList}">
										<c:forEach items="${learnList }" var="learn" varStatus="loop">
											<div class="comment clearfix">
												<div class="comment-main" style="width: 100%">
													<a href="<%=request.getContextPath() %>/course/learn?courseId=${learn.course.courseId}" target="_blank" class="user-name link-a" style="font-size:20px;">${learn.course.courseName }</a>
													<div class="comment-content">
														<span class="learn-rate">已学0%</span>
														<span>
															<a href="<%=request.getContextPath() %>/course/video?courseId=${learn.course.courseId}&smallChapterId=${learn.smallChapter.smallChapterId}" target="_blank">
																<%-- ${learn.smallChapter.smallChapterTitle } --%>
																${learn.chapter.chapterOrder}-${learn.smallChapter.smallChapterOrder}&nbsp;${learn.smallChapter.smallChapterTitle}&nbsp;(${learn.smallChapter.videoTotalTime})
															</a>
														</span>
													</div>
													<div class="comment-footer">
														<span>时间:&nbsp;
															<fmt:formatDate value="${learn.learnTime }" pattern="yyyy-MM-dd HH:mm:ss" />
														</span>
														<a href="<%=request.getContextPath() %>/course/video?courseId=${learn.course.courseId}&smallChapterId=${learn.smallChapter.smallChapterId}" target="_blank">
														<span class="continue-btn">继续学习</span>
														</a>
													</div>
												</div>
											</div>	
										</c:forEach>
									</c:when>
									<c:otherwise>
										暂时还没有学习新课程哦！
										<!-- 当前用户  学习记录表没有数据 -->
									</c:otherwise>
								</c:choose>	
								<!-- 循环显示 最近学习课程列表 end -->	
								
							</form>
						</div>
					</div>
					<!-- 页面右边 end -->
				</div>
			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
		
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		//设置头部导航栏样式
		$(".nav .item:eq(4)").addClass('on');
		// 设置左边导航栏样式
		$('.user-menu-nav-block a:eq(1)').find('li').addClass('user-menu-nav-cur');
		
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