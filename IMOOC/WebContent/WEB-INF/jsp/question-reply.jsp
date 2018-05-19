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
	<title>IT技术问答平台_回答-慕课网猿问</title>

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

					<div class="wd-top-slogan wd-top-add">
		                <span>程序员自己的问答社区——回答模块</span>
		                <a class="js-quiz" href="<%=request.getContextPath() %>/question">返回猿问</a>
		            </div>
					<!-- 页面左边 start -->
					<div class="main-course-left">
			            <!-- 问答区 end -->
			            <div class="tab-pane fade in active" id="QA">
							<!-- 问题 start -->
			            	<div id="course_note">
								<ul class="mod-post" id="comment-list">
					                <li class="pl-list" id="529846">
							            <div class="pl-list-avator">
							                <a href="####" target="_blank">
							                	<img src="/imgUrl/images/${question.user.userPhoto }" title="${question.user.userNickName }" width="40" height="40">
							                </a>
							            </div>
							            <div class="pl-list-main">
							                <div class="tit">
							                    <a href="####" target="_blank">${question.questionTitle }</a>
							                </div>
							                <p class="pl-list-content">${question.questionContent }</p>
							                <div class="pl-list-btm clearfix">
							                	<span title="发布人" class="l timeago">发布人:&nbsp;${question.user.userNickName }</span>
	                    						<span title="创建时间" class="l timeago">时间:&nbsp;
	                    							<fmt:formatDate value="${question.questionTime }" pattern="yyyy-MM-dd HH:mm:ss" />	
	                    						</span>
		                                        <a href="/video/16323" class="from">源自:&nbsp;2-2 position-relative</a>
		                                        <div class="actions r">
					                            	<span class="static-item answer">${question.questionReplyNumber }&nbsp;回答</span>
					                                <span class="static-item">${question.questionScanNumber }&nbsp;浏览</span>
							                    </div>
							                </div>
						            	</div>
						      		</li>
	      						</ul>
							</div>
							<!-- 问题 end -->

							<!-- 添加回答 start -->
							<div class="panel-comments">
								<form action="<%=request.getContextPath() %>/question/reply/add" method="post">
									<input type="hidden" name="userId" value=${user.userId } />
									<input type="hidden" name="questionId" value=${question.questionId } />
									<div class="panel-top"><span>添加回答</span></div>
									<a href="<%=request.getContextPath() %>/me" class="user-head l">
							            <img src="/imgUrl/images/${user.userPhoto }" title="${user.userNickName }" alt="回答人的头像" />
							        </a>
									<div class="wgt-ipt-wrap pub-editor-wrap l" id="js-pl-input-fake">
							            <textarea id="js-pl-textarea" class="" name="replyContent" placeholder="认真回答帮助ta"></textarea>
							            <span class="num-limit"><span id="js-pl-limit">0</span>/300</span>
							        </div>	
							        <div id="pub-btm" class="pub-btm clearfix">
							        	<!-- <button>提问</button> -->
							        	<div class="captcha-verify-box js-verify-box hide"></div>
								        <input type="submit" onclick="return notNull()" id="js-pl-submit" class="pub-btn comment-pub-btn r" data-cid="931" value="回答">
								        <span class="errortip r">内容不能少于5个字符！</span>
								    </div>
							    </form>
							</div>
							<!-- 添加回答 end -->

							<!-- 已回答 start -->
							<c:if test="${replyNumber == 0 }">
								<div class="ans_num">暂无回答</div>
							</c:if>
							
							<c:if test="${replyNumber > 0 }">
								<div class="ans_num">${replyNumber }&nbsp;回答</div>
								<div id="course_note">
									<ul class="mod-post" id="comment-list">
										<!-- 循环显示已回答的 此问题的 回答记录 -->
										<c:choose>
											<c:when test="${!empty replyList }">
												<c:forEach items="${replyList }" var="reply" varStatus="loop">
													<li class="pl-list" id="529846">
											            <div class="pl-list-avator">
											                <a href="####" target="_blank">
											                	<img src="/imgUrl/images/${reply.user.userPhoto }" title="${reply.user.userNickName }" width="40" height="40">
											                </a>
											            </div>
											            <div class="pl-list-main">
											                <div class="tit">
											                    <a href="##" target="_blank">${reply.user.userNickName }</a>
											                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">回答：</span>
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
							</c:if>
							<!-- 已回答 end -->

						</div>
						<!-- 问答区 end -->
					</div>
					<!-- 页面左边 end -->

					<!-- 页面右边 start -->
					<div class="main-course-right">
						<div class="panel-body panel-content">
							<a class="loginlink" href="javascript:void(0)">
								<img src="<%=request.getContextPath() %>/static/images/qusetions-reply.png" alt="图片" />
							</a>
							<!-- 相关问题 start -->
							<div class="panel-header">
			                  <h2 class="panel-title">相关问题</h2>
			                </div>
			                <div class="panel-inner-body clearfix">
                                <div class="mkhotlist padtop">
		                            <a class="relwenda" href="/wenda/detail/388362" target="_blank">那种对求职者收费的猎头靠谱吗</a>
		                            <i class="answer-num">2 回答</i>
		                        </div>
                                <div class="mkhotlist ">
		                            <a class="relwenda" href="/wenda/detail/388346" target="_blank">页面是格式如何随着网页缩小变大自行调整盒子的大小？</a>
		                            <i class="answer-num">3 回答</i>
		                        </div>
                                <div class="mkhotlist ">
		                            <a class="relwenda" href="/wenda/detail/388344" target="_blank">为啥非要加上this才有用啊？</a>
		                            <i class="answer-num">5 回答</i>
		                        </div>
                                <div class="mkhotlist ">
		                            <a class="relwenda" href="/wenda/detail/388334" target="_blank">第三方页面跳转一定要后台跳转吗？前端可以跳转吗？</a>
		                            <i class="answer-num">2 回答</i>
		                        </div>
                                <div class="mkhotlist bordbottom">
		                            <a class="relwenda" href="/wenda/detail/388311" target="_blank">我也是醉了。我复制到TXT文本然后另存为.html</a>
		                            <i class="answer-num">3 回答</i>
		                        </div>
                            </div>
                            <!-- 相关问题 start -->
							<div class="advertisement">
								<a class="loginlink" href="javascript:void(0)">
									<img src="<%=request.getContextPath() %>/static/images/qusetions-reply.png" alt="图片" />
								</a>
							</div>

                            <!-- 相关分类 start -->
                            <div class="recommend-class">
                            	<!--title start-->
			                    <div class="title clearfix">
			                        <h3>相关分类</h3>
			                    </div>
			                    <!--title end-->
			                    <ul class="cls-list">
                                    <li>
			                            <div class="class-info">
			                            	<!--.class-icon start-->
			                                <div class="class-icon">
			                                    <a href="####" target="_blank">
			                                        <img src="<%=request.getContextPath() %>/static/images/js.png" alt="JavaScript">
			                                    </a>
			                                </div><!--.class-icon end-->
			                                <h4>
			                                    <a href="/wenda/17" target="_blank">JavaScript</a>
			                                </h4>
			                                <p class="follow-person">57690人关注</p>
			                                <a href="javascript:void(0)" data-tag-id="17" class="follow active">取消关注</a>
			                            </div>
			                            <!--.class-info end-->
		                            	<div class="desc">
			                                <a class="desc-link" href="/wenda/detail/352349" taget="_blank">Chrome59到底支不支持forEach函数？</a>
			                                <i class="answer-num">9 回答</i>
			                            </div>
		                                <div class="desc">
			                                <a class="desc-link" href="/wenda/detail/352311" taget="_blank">慕课网适合非计算机专业的人学习吗</a>
			                                <i class="answer-num">23 回答</i>
			                            </div>
                                    </li><!--li end-->
                                </ul><!--.cls-list end-->
                			</div>
                			<!-- 相关分类 end -->
						</div>
					</div>
					<!-- 页面右边 end -->
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
			
		});
		
		// a标签链接跳转之前--通过回复框中是否有内容---来判断是否提交跳转
		function notNull(){
			var replyContent = $('#js-pl-textarea').val();
			if( replyContent != null && replyContent != ""){	// 用户已输入回复内容
				return true; 	//页面跳转
			}else{	// 用户未输入回复内容
				alert("回复内容不能为空");
				return false;	//页面不跳转
			}
		}
	</script>
</html>