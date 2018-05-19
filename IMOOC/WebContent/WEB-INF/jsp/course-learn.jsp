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
	<!-- header头部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/header.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>

<body>
	<!-- flag用来标记判断，来取得已经学习过的小节视频的学习状态 -->
	<% boolean flag = false; %>
	<div class="index">
		<!-- 头部导航栏 -->
		<jsp:include   page="header.jsp" flush="true"/>

		<!-- course页面主要内容 -->
		<div class="main clearfix">
			<!-- 主内容面板 -->
			<div class="content-wrap">
			
				<!-- 页面左边 start -->
				<div class="main-course-left">
					<!-- 基础信息 - start -->
					<div class="course-info">
						<div class="course-title">${courseDto.course.courseName }</div>
						
						<div class="course-meta">
							<c:choose>
								<c:when test="${!empty learnList }">
									<!-- 如果学习记录表不为空，则页面应显示  继续学习， 进入上次学习记录表中最后学习的一小节   -->
									<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${learnFirst.smallChapterId}" onclick="return startLearn()" class="learn-btn" target="_black">继续学习</a>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${!empty chapterList }">
											<!-- 如果学习记录表不为空，同时章节表不为空，则页面应显示  开始学习，并且进入第一章第一小节   -->
											<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${smallChapterFirst.smallChapterId}" onclick="return startLearn()" class="learn-btn" target="_black">开始学习</a>
										</c:when>
										<c:otherwise>
											<!-- 如果学习记录表为空，同时章节表为空(即该课程还没有章节)，则不跳转   -->
											<a href="javascript:void(0);" onclick="return startLearnNoChapter()" class="learn-btn" target="_black">开始学习</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							
							<div class="static-item">
								<div class="meta">上次学到</div>
								<div class="meta-value" title=""></div>
							</div>
							<div class="static-item">
								<div class="meta">学习人数</div>
								<div class="meta-value">${courseDto.number }</div>
							</div>
							<div class="static-item">
								<div class="meta">难度级别</div>
								<div class="meta-value">${courseDto.course.courseGrade }</div>
							</div>
							<div class="static-item" style="border:none;">
								<div class="meta">课程时长</div>
								<div class="meta-value" title="">
									<fmt:parseNumber integerOnly="true" value="${courseDto.course.courseTotalTime/3600 }" />小时
									<fmt:parseNumber integerOnly="true" value="${(courseDto.course.courseTotalTime%3600)/60 }" />分
								</div>
							</div>
							<c:choose>
								<c:when test="${!empty collect }">
									<!-- 当collect不为空时，说明用户已收藏了此课程 -->
									<a id="collectionSpan" onclick="doCollect('${courseDto.course.courseId}','${courseDto.course.twoId}','<%=request.getContextPath() %>/isOrNotCollect')" href="#" class="following">
										<img id="collectionImg" alt="" title="" src="<%=request.getContextPath() %>/static/images/followed.png" />
									</a>
								</c:when>
								<c:otherwise>
									<!-- 当collect为空时，说明用户还没有收藏了此课程 -->
									<a id="collectionSpan" onclick="doCollect('${courseDto.course.courseId}','${courseDto.course.twoId}','<%=request.getContextPath() %>/isOrNotCollect')" href="#" class="following">
										<img id="collectionImg" alt="" title="" src="<%=request.getContextPath() %>/static/images/following.png" />
									</a>
								</c:otherwise>
							</c:choose>
							
						</div>
						<div class="course-brief">
							简介: ${courseDto.course.courseSummary }
						</div>
						
						<div class="course-menu">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active"><a href="#chapter" data-toggle="tab">章节</a></li>
								<li><a href="#comments" data-toggle="tab">评论</a></li>
								<li><a href="#QA" data-toggle="tab">问答</a></li>
								<li><a href="#notes" data-toggle="tab">笔记</a></li>
							</ul>
						</div>
					</div>
					<!-- 基础信息 - end -->	
					<!-- tab面板 start -->
					<div id="commentQA">
						<div id="myTabContent" class="tab-content">
							
							<div class="tab-pane fade in active" id="chapter">
								<!-- 章节信息****折叠面板 start -->
								<div class="panel-group" id="accordion">
									<!-- 循环获取--章节表数据 start -->
									<c:choose>
										<c:when test="${!empty chapterList}">
											<c:forEach items="${chapterList }" var="c" varStatus="loop">
												<div class="panel panel-default">
													<div class="panel-heading">
														<h4 class="panel-title">
															<span class="glyphicon glyphicon-align-justify"></span>
															<a data-toggle="collapse" data-parent="#accordion${loop.count}" 
															   href="#collapse${loop.count}">
															   <!-- 形如： 第1章 课程介绍 -->
																<strong>第${loop.count}章&nbsp;${c.chapterTitle}</strong>
																<span class="glyphicon glyphicon-play play-bottom"></span>
															</a>
														</h4>
													</div>
													<div id="collapse${loop.count}" class="panel-collapse collapse in">
														<div class="panel-body">
															<ul class="video">
																<!-- 循环显示小节视频 start -->
																<c:choose>
																	<c:when test="${!empty c.smallChapterList}">
																		<c:forEach items="${c.smallChapterList }" var="small" varStatus="loop1">
								                                            <li data-media-id="16321">
								                                            	<!-- <em class="laststudy">最近学习</em> -->
								                                            	
								                                            	<!-- 通过session中是否有user对象***来判断***用户已登录 -->
								                                            	<c:if test="${!empty sessionScope.user }">
								                                            		<c:choose>
									                                            		<c:when test="${!empty learnList }">
									                                            			<c:forEach items="${learnList }" var="learn" varStatus="index">
									                                            				<c:if test="${learn.smallChapterId eq small.smallChapterId and learn.chapter.chapterId eq c.chapterId}">
									                                            					<c:choose>
										                                            					<c:when test="${index.count == 1 }">
										                                            						<em class="laststudy" style="color: #00b43c;">最近学习</em>
										                                            						<c:choose>
										                                            							<c:when test="${learn.learnStatus == 1 }">
										                                            								<!-- 已经完成学习 -->
										                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
																	                                                	<span class="glyphicon glyphicon-ok-sign done circle-on"></span><!-- (新版)已完成学习图标 -->
																	                                    				<span class="glyphicon glyphicon-play"></span>
																														<!-- 形如： 1-1 课程简介(00:53) -->
																														${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
																	                                                </a>
										                                            							</c:when>
										                                            							<c:otherwise>
										                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
																	                                                	<span class="glyphicon glyphicon-adjust done circle-on" style="transform: rotate(90deg);"></span><!-- 学习过，但是没有学习完视频的图标 -->
																	                                    				<span class="glyphicon glyphicon-play"></span>
																														<!-- 形如： 1-1 课程简介(00:53) -->
																														${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
																	                                                </a>
										                                            							</c:otherwise>
										                                            						</c:choose>
										                                            					</c:when>
										                                            					<c:otherwise>
										                                            						<c:choose>
										                                            							<c:when test="${learn.learnStatus == 1 }">
										                                            								<!-- 已经完成学习 -->
										                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
																	                                                	<!-- <span class="glyphicon glyphicon-ok-circle done circle-on"></span> --><!-- (旧版)已完成学习图标 -->
																	                                                	<span class="glyphicon glyphicon-ok-sign done circle-on"></span><!-- (新版)已完成学习图标 -->
																	                                    				<span class="glyphicon glyphicon-play"></span>
																														<!-- 形如： 1-1 课程简介(00:53) -->
																														${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
																	                                                </a>
										                                            							</c:when>
										                                            							<c:otherwise>
										                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
																	                                                	<span class="glyphicon glyphicon-adjust done circle-on" style="transform: rotate(90deg);"></span><!-- 学习过，但是没有学习完视频的图标 -->
																	                                    				<span class="glyphicon glyphicon-play"></span>
																														<!-- 形如： 1-1 课程简介(00:53) -->
																														${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
																	                                                </a>
										                                            							</c:otherwise>
										                                            						</c:choose>
										                                            					</c:otherwise>
										                                            				</c:choose>
													                                                <% flag = true; %>
									                                            				</c:if>
									                                            			</c:forEach>
									                                            		</c:when>
									                                            	</c:choose>
									                                            	<%
									                                            		if( !flag ){
									                                            	%>
									                                            		<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
										                                                	<span class="glyphicon glyphicon-play-circle done"></span><!-- 未学习图标 -->
										                                    				<span class="glyphicon glyphicon-play"></span>
																							<!-- 形如： 1-1 课程简介(00:53) -->
																							${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
										                                                </a>
									                                            	<%		
									                                            		}
									                                            		flag = false;
									                                            	%>
								                                            		
								                                            	</c:if>
								                                            	
						                                            			<!-- 用户未登录 -->
								                                            	<c:if test="${empty sessionScope.user }">
							                                            			<em class="laststudy" style="display: none;">开始学习</em>
							                                            			<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
									                                                	<span class="glyphicon glyphicon-ok-circle done" style="display: none;"></span>
									                                    				<span class="glyphicon glyphicon-play"></span>
																						<!-- 形如： 1-1 课程简介(00:53) -->
																						${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
									                                                </a>
									                                             </c:if>
								                                                
								                        					</li>
						                        						</c:forEach>
																	</c:when>
																	<c:otherwise>
																		<!-- 小节列表暂无数据 -->
																	</c:otherwise>
																</c:choose>
																<!-- 循环显示小节视频 end -->
					                                        </ul>
														</div>
													</div>
												</div>
											</c:forEach>
										</c:when>
										<c:otherwise>
											此课程暂时还没有添加章节哦！
											<!-- 章节表没有数据 -->
										</c:otherwise>
									</c:choose>
									<!-- 循环获取--章节表数据 end -->
									
									
								</div>
								<!-- 章节信息****折叠面板 end -->
								
							</div>
							
							<!-- 评论区 start -->
							<div class="tab-pane fade" id="comments" style="height: 100%;">
								<!--iframe框架内容--><!-- seamless="seamless" 无边框或滚动条 -->
							    <iframe src="<%=request.getContextPath() %>/course/learn/comment?courseId=${courseDto.course.courseId }" width="100%"  frameborder="0" scrolling="no" id="test" onload="this.height=100">
							    	您的浏览器不支持iframe，请升级
							    </iframe>
							</div>
							<!-- 评论区 end -->
							
							<div class="tab-pane fade" id="QA">
								<!-- 问答区 end -->
								<div id="course_note">
									<ul class="mod-post" id="comment-list">
										<!-- 循环获取--问题表数据 start -->
										<c:choose>
											<c:when test="${!empty questionList}">
												<c:forEach items="${questionList }" var="question" varStatus="loop">
													<li class="pl-list" id="529846">
											            <div class="pl-list-avator">
											                <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">
											                	<img src="/imgUrl/images/${question.user.userPhoto }" title="${question.user.userNickName }" width="40" height="40">
											                </a>
											            </div>
											            <div class="pl-list-main">
											                <div class="tit">
											                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" onclick="return startLearn()" target="_blank">${question.questionTitle }</a>
											                    <a href="<%=request.getContextPath() %>/question/reply?questionId=${question.questionId}" onclick="return startLearn()" class="tit-right" target="_blank">回答</a>
											                </div>
											                <p class="pl-list-content">${question.questionContent }</p>
											                <div class="pl-list-btm clearfix">
											                	<span title="发布人" class="l timeago">发布人:&nbsp;${question.user.userNickName }</span>
					                    						<span title="创建时间" class="l timeago">时间:&nbsp;
					                    							<fmt:formatDate value="${question.questionTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					                    						</span>
					                    						<c:if test="${not empty question.chapter.chapterOrder && not empty question.smallChapter.smallChapterOrder && not empty question.smallChapter.smallChapterTitle }  ">
							                                        <a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">
							                                        	源自:&nbsp;${question.chapter.chapterOrder }-${question.smallChapter.smallChapterOrder }&nbsp;${question.smallChapter.smallChapterTitle }
							                                        </a>
						                                        </c:if>
						                                        <div class="actions r">
					                                                <a title="" href="<%=request.getContextPath() %>/question/reply" onclick="return startLearn()" class="reply-action" data-id="529846">
										                            	<span class="static-item answer">1 回答</span>
									                                	<span class="static-item">${question.questionScanNumber } 浏览</span>
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
							</div>
							<div class="tab-pane fade" id="notes">
								<!-- 笔记 end -->
								<div id="course_note">
									<ul class="mod-post" id="comment-list">
										<!-- 循环获取--笔记表数据 start -->
						                <c:choose>
											<c:when test="${!empty noteList}">
												<c:forEach items="${noteList }" var="note" varStatus="loop">
													<li class="pl-list" id="529846">
											            <div class="pl-list-avator">
											                <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">
											                	<img src="/imgUrl/images/${note.user.userPhoto }" title="${note.user.userNickName }" width="40" height="40">
											                </a>
											            </div>
											            <div class="pl-list-main">
											                <div class="tit">
											                    <a href="<%=request.getContextPath() %>/me" onclick="return startLearn()" target="_blank">${note.user.userNickName }</a>
											                </div>
											                <p class="pl-list-content">${note.noteContent }</p>
											                <div class="pl-list-btm clearfix">
					                    						<span title="创建时间" class="l timeago">时间:&nbsp;
					                    							<fmt:formatDate value="${note.noteTime}" pattern="yyyy-MM-dd HH:mm:ss" />
					                    						</span>
					                    						<c:if test="${not empty note.chapter.chapterOrder && not empty note.smallChapter.smallChapterOrder && not empty note.smallChapter.smallChapterTitle }  ">
							                                        <a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">
							                                        	源自:&nbsp;${note.chapter.chapterOrder }-${note.smallChapter.smallChapterOrder }&nbsp;${note.smallChapter.smallChapterTitle }
							                                        </a>
							                                    </c:if>
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
												还没有人发笔记哦！
												<!-- 笔记表暂无数据 -->
											</c:otherwise>
										</c:choose>
						                <!-- 循环获取--笔记表数据 end -->
	          						</ul>
								</div>
								<!-- 笔记 end -->
							</div>
						</div>
					</div>
					<!-- tab面板 end -->
				
				</div>
				<!-- 页面左边 end -->

				<!-- 页面右边 start -->
				<div class="main-course-right">
					<div class="lecturer-item" style="width: 98%;">
						<img class="lecturer-uimg" src="${pageContext.request.contextPath}/static/images/header1.png"> 
						<span class="lecturer-name">王阳明</span>
						<span class="lecturer-title">华南大学 · 博士后</span>
						<span class="lecturer-p">高级讲师，擅长人工智能算法11</span>
						<a href="javascript:void(0)" onclick="doFollow('1');">
							<span id="followSpan" class="follow-btn">+关注</span>
						</a>
					</div>
				
					<h4 class="mt-50">推荐课程</h4>
					<a href="${pageContext.request.contextPath}/course/learn" onclick="return startLearn()" target="_black" class="mb-5" title="基于SSH实现员工管理系统之框架整合篇">
						<li class="ellipsis oc-color-hover">基于SSH实现员工管理系统之框架整合篇</li>
					</a>
					<a href="${pageContext.request.contextPath}/course/learn" onclick="return startLearn()" target="_black" class="mb-5" title="Java实现邮箱验证">
						<li class="ellipsis oc-color-hover">Java实现邮箱验证</li>
					</a>
					<a href="${pageContext.request.contextPath}/course/learn" onclick="return startLearn()" target="_black" class="mb-5" title="Java眼中的XML  文件写入">
						<li class="ellipsis oc-color-hover">Java眼中的XML  文件写入</li>
					</a>
					<a href="<%=request.getContextPath() %>/course/learn" onclick="return startLearn()" target="_black" class="mb-5" title="JAVA生成二维码">
						<li class="ellipsis oc-color-hover">JAVA生成二维码</li>
					</a>
					<a href="<%=request.getContextPath() %>/course/learn" onclick="return startLearn()" target="_black" class="mb-5" title="高性能高可用Yii2.0电商平台 高级组件 MySQL LVS">
						<li class="ellipsis oc-color-hover">高性能高可用Yii2.0电商平台 高级组件 MySQL LVS</li>
					</a>
				</div>
				<!-- 页面右边 end -->


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
			$(".nav .item:eq(1)").addClass('on');
			
			// 判断用户是否登录
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				$('.unLogin1').attr('style','display: none;');
				$('.unLogin2').css({display:'block'});			// 显示头像
				$('.panel-comments').css({display:'block'});	// 显示发布评论面板
				$('.panel-group .video li .laststudy').css({display:'block'});	//学习状态显示
				$('.panel-group .video li a .glyphicon-ok-circle').css({display:'block'});	
			}else{	// 用户未登录
				$('.unLogin1').css({display:'block'});	
				$('.unLogin2').attr('style','display: none;');	// 不显示头像
				$('.panel-comments').css({display:'none'});		// 不显示发布评论面板
				$('.panel-group .video li').on({				// 小节列表中的样式设置
					mouseover: function(){
						$(this).find('em').css({display:'block',color:'#00b43c'});	//显示 开始学习
					},
					mouseout: function(){
						$(this).find('em').css({display:'none'});	
					}
				});
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
		
		// 点击开始学习时---没有章节---来判断是否跳转
		function startLearnNoChapter(){
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				alert("此课程还没有添加章节！！暂时无法观看！！");
				return true; 	//页面跳转
			}else{	// 用户未登录
				alert("你还未登陆，请先登陆！");
				return false;	//页面不跳转
			}
		}
		
		
		// 点击切换 收藏图片
		function doCollect(courseId, twoId, url){
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				// alert("courseId:"+courseId + ", 二级分类id" + twoId);
				var userId = '${sessionScope.user.userId}';	// 用户id
				var data1 = {
					"userId" : userId,		/* 用户id */
					"courseId" : courseId,	/* 课程id */
					"classId" : twoId		/* 二级分类id */
				};
				// 请求后台，进行数据库切换，是收藏还是不收藏
			    $.ajax({
			        type : "POST",
			        url : url,
			        data: data1,			// 传入参数
			        dataType:"json",	// 返回来的数据格式为json。如果不 添加该条属性，则返回来的为字符串。字符串对象可以通过eval("("+data+")")方法转成json对象。区分data为JSON对象还是字符串，可以通过alert语句进行打印，如果是Object object就是JSON对象，如果将内容显示出来则为字符串
			        async: false,       		//false即修改此方法为同步  ,true此方法为异步
			        success : function(res) {	//返回数据根据结果进行相应的处理
			            if( res.result == "1" ){
			            	var imgObj = document.getElementById("collectionImg");
							imgObj.src = "<%=request.getContextPath() %>/static/images/following.png";
			            	alert("取消收藏");
			            }else if( res.result == "2" ){
			            	alert("取消收藏失败。。。");
			            }else if( res.result == "3" ){
			            	var imgObj = document.getElementById("collectionImg");
							imgObj.src = "<%=request.getContextPath() %>/static/images/followed.png";
			            	alert("收藏成功");
			            }else if( res.result == "4" ){
			            	alert("收藏失败。。。");
			            }else{
			            	alert("请求错误");
			            }
			        },
			        error:function(){
			            alert("请求失败");
			        }
			    });
				
				// 更改收藏的背景图片
				<%-- var imgObj = document.getElementById("collectionImg");
				var Flag=(imgObj.getAttribute("src",2)=="<%=request.getContextPath() %>/static/images/following.png");
				imgObj.src=Flag?"<%=request.getContextPath() %>/static/images/followed.png":"<%=request.getContextPath() %>/static/images/following.png"; --%>
				
				
				return true; 	//页面跳转
			}else{	// 用户未登录
				alert("你还未登陆，请先登陆！");
				return false;	//页面不跳转
			}
			
		}
		
		// 设置iframe的高度与父页面自适应高度
		function reinitIframe(){  
	        var iframe = document.getElementById("test");  
	        try{  
	            var bHeight = iframe.contentWindow.document.body.scrollHeight;  
	            var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;  
	            var height = Math.max(bHeight, dHeight);  
	            iframe.height =  height;  
	            console.log(height);
	        }catch (ex){}  
	    }  
	    window.setInterval("reinitIframe()", 200);  
	</script>
</html>