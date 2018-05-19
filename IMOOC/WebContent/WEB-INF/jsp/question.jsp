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
	<title>IT技术问答平台-慕课网猿问</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- questions页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/questions.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>
<body>
	<div class="index">
		<!-- 头部导航栏 -->
		<jsp:include   page="header.jsp" flush="true"/>

		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			<div class="content">
				<div class="content-wrap">

					<div class="wd-top-slogan">
		                <span>程序员自己的问答社区</span>
		                <a class="js-quiz" href="<%=request.getContextPath() %>/question/add" onclick="return startLearn()">我要提问</a>
		            </div>

		            <!-- 问答区 end -->
		            <div class="tab-pane fade in active" id="QA">
						<div id="course_note">
							<ul class="mod-post" id="comment-list">
								<!-- 循环显示--提问表中的数据 start -->
								<c:choose>
									<c:when test="${!empty pageModel.questionList}">
										<c:forEach items="${pageModel.questionList }" var="question" varStatus="loop">
											<li class="pl-list" id="529846">
									            <div class="pl-list-avator">
									                <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">
									                	<img src="/imgUrl/images/${question.user.userPhoto }" title="${question.user.userNickName }" width="40" height="40">
									                </a>
									            </div>
									            <div class="pl-list-main">
									                <div class="tit">
									                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" onclick="return startLearn()">标题：${question.questionTitle}</a>
									                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" onclick="return startLearn()" class="tit-right">回答</a>
									                </div>
									                <p class="pl-list-content">内容：${question.questionContent}</p>
									                <div class="pl-list-btm clearfix">
									                	<span title="发布人" class="l timeago">发布人:&nbsp;${question.user.userNickName }</span>
			                    						<span title="创建时间" class="l timeago">时间:&nbsp;
			                    							<fmt:formatDate value="${question.questionTime}" pattern="yyyy-MM-dd HH:mm:ss" />	
			                    						</span>
			                    							
				                                        	<!-- <a href="course/video" onclick="return startLearn()" class="from">源自:&nbsp;2-2 position-relative</a> -->
				                                        <div class="actions r">
			                                                <a title="" href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" onclick="return startLearn()" class="reply-action" data-id="529846">
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
						<!-- 分页 start -->
						<div class="page-box clearfix">
							<div class="page clearfix">
								<ul class="pagination">
									<li><a href="#" id="frist1">首页</a></li>
									<li><a href="#" id="forw1">上一页</a></li>
									<li><a href="javascript:;" style="color: #14191e;">第${pageModel.page}/${pageModel.totalPage}页</a></li>
									<li><a href="#" id="next1">下一页</a></li>
									<li><a href="#" id="end1">尾页</a></li>
								</ul>
							</div>
						</div>
						<!-- 分页 end -->
					</div>
					<!-- 问答区 end -->
		
				</div>
			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
		
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<!-- 可选: 包含 jQuery 库 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<!-- 可选: 合并了 Bootstrap JavaScript 插件 -->	
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript">
		/* 分页 */
		var page=${pageModel.page};
		var totalPage=${pageModel.totalPage};
		$(function(){
		    $("#frist1").click(function(){
		    	if(page!=1){
		    		page=1;
		        	window.location.href='<%=request.getContextPath()%>/question?page='+page;
		    	}else{
		    		alert("本页就是第一页！");
		    	}
		    	
			});
			$("#forw1").click(function(){
				if(page>1){
					page--;
					window.location.href='<%=request.getContextPath()%>/question?page='+page;
				}else{
					alert("已经是第一页了！");
				}
			});
		 	$("#next1").click(function(){
		 		if(page<totalPage){
					page++;
					window.location.href='<%=request.getContextPath()%>/question?page='+page;
				}else{
					alert("已经是最后一页了！");
				}
			});
		 	$("#end1").click(function(){
		 		if(page!=totalPage){
		 			page=totalPage;
					window.location.href='<%=request.getContextPath()%>/question?page='+page;
		 		}else{
		 			alert("本页就是最后一页！");
		 		}
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			// 设置头部导航栏样式
			$(".nav .item:eq(2)").addClass('on');
			
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
			
			// 浏览 回答 显示样式控制
			$(".reply-action").on({  
		        mouseover : function(){  
		        	$(this).find('span').addClass('span-black');
		        },  
		        mouseout : function(){  
		        	$(this).find('span').removeClass('span-black');
		        }   
		   	});
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