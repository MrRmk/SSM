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
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>

<body>
	
	<div class="index">
		<!-- 头部导航栏 -->
		<jsp:include   page="header.jsp" flush="true"/>

		<!-- course页面主要内容 -->
		<div class="main clearfix">
			<div class="content">
				<div class="content-wrap">
					<!-- 方向 start -->
					<div class="course-nav-row clearfix">
						<span class="hd">方向：</span>
						<ul class="course-nav">
							<li class="course-nav-item cur-course-nav" data-ct="-1">
								<%-- <a href="<%=request.getContextPath() %>/course/total?c=-1" >全部</a> --%>
								<a href="#" onclick="queryPage(1,-1);">全部</a>
							</li>
							<!-- 类似if-else语句 -->
							<c:choose>
								<c:when test="${!empty sortsOneList}">
									<c:forEach items="${sortsOneList }" var="s1" varStatus="loop">
										<li class="course-nav-item " data-ct="${s1.oneCode}">
											<%-- <a href="<%=request.getContextPath() %>/course/total?c=${s1.oneCode}" >${s1.oneName }</a> --%>
											<a href="#" onclick="queryPage(1,'${s1.oneCode}');" >${s1.oneName }</a>
										</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 一级分类数据表没有数据 -->
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<!-- 方向 end -->

					<!-- 分类 start -->
					<div class="course-nav-row clearfix">
						<span class="hd">分类：</span>
						<ul class="course-nav">
							<li class="course-nav-item cur-course-nav">
								<%-- <a href="<%=request.getContextPath() %>/course/total?c=${sessionScope.direction}">全部</a> --%>
								<a href="#" onclick="queryPage(1,'${sessionScope.direction}')">全部</a>
							</li>
							<c:choose>
								<c:when test="${!empty sortsTwoList}">
									<c:forEach items="${sortsTwoList }" var="s2" varStatus="loop">
										<li class="course-nav-item " data-ct="${s2.twoCode}">
											<%-- <a href="<%=request.getContextPath() %>/course/total?c=${s2.twoCode}">${s2.twoName }</a> --%>
											<a href="#" onclick="queryPage(1,'${s2.twoCode}')">${s2.twoName }</a>
										</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<!-- 二级分类数据表没有数据 -->
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<!-- 分类 end -->
				</div>
				
				<!-- 课程列表 start -->
				<div class="types-block clearfix">
					<h3 style="margin-bottom: 20px;">	
						<span class="types-title" style="margin-right:40px;">课程列表</span>
						<!-- <a href="javascript:void(0)" style="display: inline-block;margin-right:20px;" onclick="queryPage(1,undefined,'last')">
						<span class="color-oc">最新</span>
						</a>
						<a href="javascript:void(0)" style="display: inline-block;" onclick="queryPage(1,undefined,'pop')">
						<span>最热</span>
						</a> -->
					</h3>
					<div class="types-content clearfix" style="margin-bottom: 20px;">
						
						<div>
							<c:choose>
								<c:when test="${!empty pageModel.courseDtoList}">
									<c:forEach items="${pageModel.courseDtoList }" var="cDto" varStatus="loop">
										<a href="<%=request.getContextPath() %>/course/learn?courseId=${cDto.course.courseId}" target="_black">
											<c:choose>
												<c:when test="${loop.count%5 == 0 }">
													<!-- 如果div有第五个，要设置样式 为card-right -->
													<div class="course-card-container card-right">
														<div class="course-card-top green-bg">
												</c:when>
												<c:otherwise>
													<c:if test="${loop.count%5 == 1 }">
														<div class="course-card-container">
															<div class="course-card-top brown-bg">
													</c:if>
													<c:if test="${loop.count%5 == 2 }">
														<div class="course-card-container">
															<div class="course-card-top gray-bg">
													</c:if>
													<c:if test="${loop.count%5 == 3 }">
														<div class="course-card-container">
															<div class="course-card-top purple-bg">
													</c:if>
													<c:if test="${loop.count%5 == 4 }">
														<div class="course-card-container">
															<div class="course-card-top pink-bg">
													</c:if>
												</c:otherwise>
											</c:choose>
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
						
						<!-- 分页 start -->
						<div class="page-box clearfix">
							<div class="page clearfix">
								<ul class="pagination">
									<li><input type="hidden" name="page" id="pageNumber" value="${pageModel.page }" /></li>
									<li><a href="#" id="frist1" onclick="queryPage(1)">首页</a></li>
									<li><a href="#" id="forw1" >上一页</a></li>
									<li><a href="javascript:void(0);" style="color: #14191e;">第${pageModel.page}/${pageModel.totalPage}页</a></li>
									<li><a href="#" id="next1" >下一页</a></li>
									<li><a href="#" id="end1" onclick="queryPage('${pageModel.totalPage}')">尾页</a></li>
								</ul>
								<div class="page-total">
									总记录数：${pageModel.totalSize }条
								</div>
							</div>
						</div>
						<!-- 分页 end -->
						
					</div>
				</div>
				<!-- 课程列表 end -->

			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	//通过session参数direction+classify来判断 (页面返回来时的)一级分类(方向)和二级分类的样式
	var direction = '${sessionScope.direction}';
	var classify = '${sessionScope.classify}';

	function queryPage(pageNum,code){
		debugger;
		var params = '?pageNum='+pageNum;
		//分类，参数没有就用页面缓存 
		if(code == undefined){//来自于分页按钮
			code = direction;	//设置一级分类编码
			if( classify != '-2' ){	// 如果二级分类编码不为"全部"，则设置二级分类编码
				code = classify;
			}
		}
		params += '&c='+code;
		console.log(params);
		window.location.href='${pageContext.request.contextPath}/course/total'+params;
	}	
	
	//分页
	var page = '${pageModel.page}';
	var totalPage = '${pageModel.totalPage}';
	$(function(){
	    $("#frist1").click(function(){
	    	if(page!=1){
	    		page=1;
	    		queryPage(page);
	    	}else{
	    		alert("本页就是第一页！");
	    	}
	    	
		});
		$("#forw1").click(function(){
			if(page>1){
				page--;
				queryPage(page);
			}else{
				alert("已经是第一页了！");
			}
		});
	 	$("#next1").click(function(){
	 		if(page<totalPage){
				page++;
				queryPage(page);
			}else{
				alert("已经是最后一页了！");
			}
		});
	 	$("#end1").click(function(){
	 		if(page!=totalPage){
	 			page=totalPage;
	 			queryPage(page);
	 		}else{
	 			alert("本页就是最后一页！");
	 		}
		});
	});  
</script>
<script type="text/javascript">
	$(function(){
		// 设置头部导航栏样式
		$(".nav .item:eq(1)").addClass('on');
		
		// 通过session参数direction+classify来判断 (页面返回来时的)一级分类(方向)和二级分类的样式
		var direction = '${sessionScope.direction}';
		var classify = '${sessionScope.classify}';
		$(".course-nav li").each(function(){
			var ct = $(this).data('ct');
			if( ct == direction ){
				$(this).siblings().removeClass('cur-course-nav');
				$(this).addClass('cur-course-nav');
			}
			if( ct == classify ){
				$(this).siblings().removeClass('cur-course-nav');
				$(this).addClass('cur-course-nav');
			}
		});
		
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
		
		/* var _code = -1;
		//var page = ${pageModel.page};
		//var totalPage=${pageModel.totalPage};
		$("#forw1").click(function(){
			if(page>1){
				page--;
				queryPage(page);
			}else{
				alert("已经是第一页了！");
			}
		});
	 	$("#next1").click(function(){
	 		if(page<totalPage){
				page++;
				queryPage(page);
			}else{
				alert("已经是最后一页了！");
			}
		}); */
		
	});
	
	
	
</script>
</html>