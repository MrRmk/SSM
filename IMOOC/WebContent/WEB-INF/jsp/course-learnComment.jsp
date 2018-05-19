<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "com.imooc.entity.*" %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网-程序员的梦工厂</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
</head>

<body>
	
				
	<!-- 评论区 start -->

		<!-- 发表评论 start -->
		<div class="panel-comments">
			<form action="<%=request.getContextPath() %>/comments/add" method="post">
				<a href="<%=request.getContextPath() %>/me" target="_blank" class="user-head l">
		            <c:choose>
						<c:when test="${!empty user.userPhoto}">
							<img src="/imgUrl/images/${user.userPhoto }" title="${user.userNickName }" alt="发表评论人的头像"/>
						</c:when>
						<c:otherwise>
							<img src="<%=request.getContextPath() %>/static/images/anonymous-photo.png" alt="发表评论人的头像"/>
						</c:otherwise>
					</c:choose>
		        </a>
		        <input type="hidden" name="courseId" value=${courseId } />
				<div class="wgt-ipt-wrap pub-editor-wrap l" id="js-pl-input-fake">
		            <textarea id="js-pl-textarea" name="commentsContent" class="" placeholder="扯淡、吐槽、表扬、鼓励……想说啥就说啥！"></textarea>
		            <span class="num-limit"><span id="js-pl-limit">0</span>/300</span>
		        </div>	
		        <div id="pub-btm" class="pub-btm clearfix">
		        	<!-- <button>发表评论</button> -->
		        	<div class="captcha-verify-box js-verify-box hide"></div>
			        <input type="submit" id="js-pl-submit" class="pub-btn comment-pub-btn r" data-cid="931" value="发表评论" />
			        <span class="errortip r">内容不能少于5个字符！</span>
			    </div>
		    </form>
		</div>
		<!-- 发表评论 end -->

		<!-- 他人评论 start -->
		<div id="course_note">
			<ul class="mod-post" id="comment-list">
				<!-- 循环获取--评论表数据 start -->
				<c:choose>
					<c:when test="${!empty commentsList}">
						<c:forEach items="${commentsList }" var="comments" varStatus="loop">
							 <li class="pl-list" id="529846">
					            <div class="pl-list-avator">
					                <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">
					                	<%-- <img src="<%=request.getContextPath() %>/static/images/header2.png" width="40" height="40"> --%>
					                	<img src="/imgUrl/images/${comments.user.userPhoto }" title="${comments.user.userNickName }" alt="用户头像" width="40" height="40">
					                </a>
					            </div>
					            <div class="pl-list-main">
					                <div class="tit">
					                    <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">${comments.user.userNickName }</a>
					                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">评论道：</span>
					                </div>
					                <p class="pl-list-content">${comments.commentsContent }</p>
					                <div class="pl-list-btm clearfix">
                   						<span title="创建时间" class="l timeago">时间:&nbsp;
                   							<fmt:formatDate value="${comments.commentsTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                   						</span>
                   						<c:if test="${not empty comments.chapter.chapterOrder && not empty comments.smallChapter.smallChapterOrder && not empty comments.smallChapter.smallChapterTitle }  ">
                   							<a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">
	                                        	源自:&nbsp;${comments.chapter.chapterOrder }-${comments.smallChapter.smallChapterOrder }&nbsp;${comments.smallChapter.smallChapterTitle }
	                                        </a>
                   						</c:if>
                                        <div class="actions r">
                                               <a title="赞" href="javascript:;" onclick="return startLearn()" class="js-pl-praise list-praise post-action" data-id="529846">
				                            	<span class="glyphicon glyphicon-thumbs-up"></span>
				                            	<em>${comments.commentsThumbsNumber }</em>
				                        	</a>
					                    </div>
					                </div>
				            	</div>
				      		</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						还没有人评论哦！快发一个吧^v^
						<!-- 评论表暂无数据 -->
					</c:otherwise>
				</c:choose>
				<!-- 循环获取--评论表数据 end -->
     						</ul>
		</div>
		<!-- 他人评论 end -->
	<!-- 评论区 end -->								
						
							
	
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript">
		$(document).ready(function(){
			// 设置头部导航栏样式
			$(".nav .item:eq(1)").addClass('on');
			
			// 判断用户是否登录
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				$('.unLogin1').attr('style','display: none;');
				$('.unLogin2').css({display:'block'});			// 显示头像
				$('.panel-comments').css({display:'block'});	// 显示发布评论面板
			}else{	// 用户未登录
				$('.unLogin1').css({display:'block'});	
				$('.unLogin2').attr('style','display: none;');	// 不显示头像
				$('.panel-comments').css({display:'none'});		// 不显示发布评论面板
			}
			
		});
		
		// a标签链接跳转之前--通过用户是否登录---来判断是否跳转
		function startLearn(){
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				return true; 	//页面跳转
			}else{	// 用户未登录
				alert("你还未登陆，请先登陆！");
				return false;	//页面不跳转
			}
		}
	</script>
</html>