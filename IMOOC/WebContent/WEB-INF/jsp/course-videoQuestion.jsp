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
	<title>慕课网-程序员的梦工厂</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
</head>
<body>
	
	<!-- 问答区 end -->
	
		<!-- 提问 start -->
		<div class="panel-comments">
			<form action="<%=request.getContextPath() %>/course/question/add" method="post">
				<input type="hidden" name="courseId" value=${courseId } />
				<input type="hidden" name="userId" value=${user.userId } />
				<!-- 提问标题 start -->
				<div class="coments-header">
					<div class="quesdetail clearfix">
	                  <span class="ques-label first-label">标题</span>
	                  <div class="question-area">
	                    <input type="text" id="ques-title" class="ipt autocomplete" maxlength="255" name="questionTitle" placeholder="请一句话说明你的问题，以问号结尾">
	                    <!-- <p class="errortip">标题不能少于5个汉字！</p> -->
	                    <p class="errortip"></p>
	                    <dl class="send-area-result" style="display: block;"></dl>
	                  </div>
	               </div>
				</div>
				<!-- 提问标题 end -->
				
				<!-- 提问内容 start -->
				<a href="" class="user-head l">
		            <c:choose>
						<c:when test="${!empty user.userPhoto}">
							<img src="/imgUrl/images/${user.userPhoto }" title="${user.userNickName }" alt="提问人的头像"/>
						</c:when>
						<c:otherwise>
							<img src="<%=request.getContextPath() %>/static/images/anonymous-photo.png" alt="提问人的头像"/>
						</c:otherwise>
					</c:choose>
		        </a>
				<div class="wgt-ipt-wrap pub-editor-wrap l" id="js-pl-input-fake">
		            <textarea id="js-pl-textarea" name="questionContent" class="" placeholder="说出你的疑问！"></textarea>
		            <span class="num-limit"><span id="js-pl-limit">0</span>/300</span>
		        </div>	
		        <div id="pub-btm" class="pub-btm clearfix">
		        	<!-- <button>提问</button> -->
		        	<div class="captcha-verify-box js-verify-box hide"></div>
			        <input type="submit" id="js-pl-submit" class="pub-btn comment-pub-btn r" data-cid="931" value="提问">
			        <span class="errortip r">内容不能少于5个字符！</span>
			    </div>
			    <!-- 提问内容 end -->
		    </form>
		</div>
		<!-- 提问 end -->

		<div id="course_note">
			<ul class="mod-post" id="comment-list">
				<!-- 循环获取--问题表数据 start -->
                <c:choose>
					<c:when test="${!empty questionList}">
						<c:forEach items="${questionList }" var="qList" varStatus="loop">
							<li class="pl-list" id="529846">
					            <div class="pl-list-avator">
					                <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">
					                	<img src="/imgUrl/images/${qList.user.userPhoto }" title="${qList.user.userNickName }" width="40" height="40">
					                </a>
					            </div>
					            <div class="pl-list-main">
					                <div class="tit">
					                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${qList.questionId}" onclick="return startLearn()" target="_blank">${qList.questionTitle }</a>
					                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${qList.questionId}" onclick="return startLearn()" class="tit-right" target="_blank">回答</a>
					                </div>
					                <p class="pl-list-content">${qList.questionContent }</p>
					                <div class="pl-list-btm clearfix">
					                	<span title="发布人" class="l timeago">发布人:&nbsp;${qList.user.userNickName }</span>
                   						<span title="创建时间" class="l timeago">时间:&nbsp;
                   							<fmt:formatDate value="${qList.questionTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                   						</span>
                                        <a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">源自:&nbsp;2-2 position-relative</a>
                                        <div class="actions r">
                                               <a title="" href="<%=request.getContextPath() %>/question/reply" onclick="return startLearn()" class="reply-action" data-id="529846">
				                            	<span class="static-item answer">1 回答</span>
			                                	<span class="static-item">${qList.questionScanNumber } 浏览</span>
				                        	</a>
					                    </div>
					                </div>
				            	</div>
				      		</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						还没有人提问题哦！
						<!-- 提问表暂无数据 -->
					</c:otherwise>
				</c:choose>
				<!-- 循环获取--问题表数据 end -->
     						</ul>
		</div>
	<!-- 问答区 end -->

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
			if( user != null && user != ""){
				$('.unLogin1').attr('style','display: none;');
				$('.unLogin2').css({display:'block'});
			}else{
				$('.unLogin2').attr('style','display: none;');
				$('.unLogin1').css({display:'block'});
			}
			
		});
	</script>
</html>