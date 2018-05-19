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
	<title>我的笔记</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
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
						<div><span class="f-16"><strong>我的笔记</strong></span></div>
						<div class="split-line" style="margin: 20px 0px;"></div>
						
						<form id="queryPageForm" action="" method="post">
									
							<!-- 我的笔记 start -->
							<div class="tab-pane fade in active" id="notes">
								<div id="course_note">
									<ul class="mod-post" id="comment-list">
						                 <!-- 循环显示--提问表中的数据 start -->
										<c:choose>
											<c:when test="${!empty noteList}">
												<c:forEach items="${noteList }" var="note" varStatus="loop">
													<li class="pl-list" id="529846">
											            <div class="pl-list-avator">
											                <a href="javascript:;" onclick="return startLearn()" target="_blank">
											                	<img src="/imgUrl/images/${note.user.userPhoto }" title="${note.user.userNickName }" width="40" height="40">
											                </a>
											            </div>
											            <div class="pl-list-main">
											                <div class="tit">
											                    <a href="javascript:;" onclick="return startLearn()" target="_blank">${note.user.userNickName }</a>
											                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">的笔记：</span>
											                </div>
											                <p class="pl-list-content">${note.noteContent }</p>
											                <div class="pl-list-btm clearfix">
											                	<!-- <label class="moco-label label l">
											                		<a href="javascript:;" onclick="return startLearn()" target="_blank">后端开发</a>
											                	</label> -->
					                    						<span title="创建时间" class="l timeago">时间:&nbsp;
					                    							<fmt:formatDate value="${note.noteTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					                    						</span>
						                                        <div class="actions r">
					                                                <a title="赞" href="javascript:;" onclick="return startLearn()" class="js-pl-praise list-praise post-action" data-id="529846">
										                            	<span class="glyphicon glyphicon-thumbs-up"></span>
										                            	<em>${note.noteThumbsNumber }</em>
										                        	</a>
											                    </div>
											                </div>
										            	</div>
										      		</li>
												</c:forEach>
											</c:when>
											<c:otherwise>
												还没有手记哦！快发一个吧^v^
											</c:otherwise>
										</c:choose>
										<!-- 循环显示--提问表中的数据 end -->
			        				</ul>
								</div>
							</div>
							<!-- 我的笔记 end -->
							
						</form>
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
		$('.user-menu-nav-block a:eq(5)').find('li').addClass('user-menu-nav-cur');
		
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