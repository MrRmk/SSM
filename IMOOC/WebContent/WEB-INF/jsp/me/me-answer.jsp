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
						<form id="queryPageForm" action="" method="post">
							<!-- 菜单块 分面板 start -->
							<div class="course-menu">
								<ul id="myTab" class="nav nav-tabs">
									<li><a href="#question" data-toggle="tab">我的提问</a></li>
									<li><a href="#note" data-toggle="tab">我的回答</a></li>
								</ul>
							</div>
							<!-- 菜单块 分面板 end -->
							
							<!-- 面板 start -->
							<div id="commentQA">
								<div id="myTabContent" class="tab-content">
									
									<!-- 我的提问  start -->
									<div class="tab-pane fade in active" id="question">
										<div id="course_note">
											<ul class="mod-post" id="comment-list">
												<!-- 循环显示--提问表中的数据 start -->
												<c:choose>
													<c:when test="${!empty questionList}">
														<c:forEach items="${questionList }" var="question" varStatus="loop">
															<li class="pl-list" id="529846">
													            <div class="pl-list-avator">
													                <a href="javascript:;" onclick="return startLearn()" target="_parent">
													                	<img src="/imgUrl/images/${question.user.userPhoto }" title="${question.user.userNickName }" width="40" height="40">
													                </a>
													            </div>
													            <div class="pl-list-main">
													                <div class="tit">
													                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" title="标题：${question.questionTitle }" target="_parent" onclick="return startLearn()">
													                    	标题：${question.questionTitle}</a>
													                </div>
													                <p class="pl-list-content" title="内容：${question.questionContent }">内容：${question.questionContent}</p>
													                <div class="pl-list-btm clearfix">
													                	<span title="发布人" class="l timeago">发布人:&nbsp;${question.user.userNickName }</span>
							                    						<span title="创建时间" class="l timeago">时间:&nbsp;
							                    							<fmt:formatDate value="${question.questionTime}" pattern="yyyy-MM-dd HH:mm:ss" />	
							                    						</span>
							                    							
								                                        	<!-- <a href="course/video" onclick="return startLearn()" class="from">源自:&nbsp;2-2 position-relative</a> -->
								                                        <div class="actions r">
							                                                <a title="" href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" target="_parent" onclick="return startLearn()" class="reply-action" data-id="529846">
												                            	<span class="static-item answer">${question.questionReplyNumber } 回答</span>
											                                	<span class="static-item">${question.questionScanNumber } 浏览</span>
												                        	</a>
													                    </div>
													                </div>
												            	</div>
												      		</li>
														</c:forEach>
													</c:when>
													<c:otherwise>
														还没有人提问题哦！快发一个吧^v^
													</c:otherwise>
												</c:choose>
												<!-- 循环显示--提问表中的数据 end -->
			          						</ul>
										</div>
									</div>
									<!-- 我的提问 end -->
									
									<!-- 我的回答 start -->
									<div class="tab-pane fade" id="note">
										<div id="course_note">
											<ul class="mod-post" id="comment-list">
								                <!-- 循环显示已回答的 此问题的 回答记录 -->
												<c:choose>
													<c:when test="${!empty replyList }">
														<c:forEach items="${replyList }" var="reply" varStatus="loop">
															<li class="pl-list" id="529846">
													            <div class="pl-list-avator">
													                <a href="javascript:;" target="_blank">
													                	<img src="/imgUrl/images/${reply.user.userPhoto }" title="${reply.user.userNickName }" width="40" height="40">
													                </a>
													            </div>
													            <div class="pl-list-main">
													                <div class="tit">
													                    <a href="javascript:;" target="_blank">${reply.user.userNickName }</a>
													                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">的回答：</span>
													                </div>
													                <p class="pl-list-content">${reply.replyContent }</p>
													                <div class="pl-list-btm clearfix">
								                                        <div class="actions l">
											                            	<span class="static-item answer">${reply.replyAgreeNumber }&nbsp;赞成</span>
											                                <span class="static-item">${reply.replyAgainstNumber }&nbsp;反对</span>
													                    </div>
													                    <div class="actions r">
													                    <span title="回复时间" class="l timeago">时间:&nbsp;
													                    	<fmt:formatDate value="${reply.replyTime }" pattern="yyyy-MM-dd HH:mm:ss" />	
													                    </span>
													                    </div>
													                </div>
												            	</div>
												      		</li>
														</c:forEach>
													</c:when>
													<c:otherwise>
														暂时没有回答记录，快去回复一个吧^v^
													</c:otherwise>
												</c:choose>
			          						</ul>
										</div>
									</div>
									<!-- 我的回答 end -->
										
								</div>
							</div>	
									
							
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
		$('.user-menu-nav-block a:eq(4)').find('li').addClass('user-menu-nav-cur');
		
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