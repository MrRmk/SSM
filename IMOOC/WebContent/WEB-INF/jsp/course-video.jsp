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
						<div class="course-title video-title">${course.courseName }&nbsp;
							<span>${learnFirst.chapter.chapterOrder}-${learnFirst.smallChapter.smallChapterOrder}&nbsp;${learnFirst.smallChapter.smallChapterTitle}</span>
						</div>
						<div>
							<div class="video1" style="width:820px; height:500px;">
								<c:choose>
									<c:when test="${!empty smallChapter.videoPath }">
										<video id="myVideo" src="/videoUrl/video/${smallChapter.videoPath }"  width="820px" height="500px" controls="controls" autoplay preload="auto">
											<%-- <source src="<%=request.getContextPath() %>/static/video/JFRS.mp4" type="video/mp4"> --%>
											Your browser does not support the video tag.	
										</video>
										
										<span id="time"></span>
									</c:when>
									<c:otherwise>
										<h3>当前课程视频资源暂未找到!!</h3>
									</c:otherwise> 
								</c:choose>
							</div>
							<div class="video-mask" style="display: none;">
								<c:choose>
									<c:when test="${!empty nextSmallChapter }">
										<h2>下一节课程： ${nextSmallChapter.smallChapterTitle}
			                                <span class="course-duration"> (${nextSmallChapter.videoTotalTime})</span>
			                            </h2>
			                            <a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${nextSmallChapter.smallChapterId}" class="J-next-btn next-auto btn btn-green">下一节</a>
									</c:when>
									<c:otherwise>
										<a href="<%=request.getContextPath() %>/course/learn?courseId=${course.courseId}" style="display: block;margin-bottom:30px;">返回课程</a>
									</c:otherwise>
								</c:choose>
								<a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${smallChapter.smallChapterId}" class="review-course">
	                            	<span class="glyphicon glyphicon-repeat"></span>重新观看
	                            </a>
							</div>
						</div>
						
						<div class="course-menu">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active"><a href="#comments" data-toggle="tab">评论</a></li>
								<li><a href="#question" data-toggle="tab">问答</a></li>
								<li><a href="#notes" data-toggle="tab">笔记</a></li>
							</ul>
						</div>
					</div>
					<!-- 基础信息 - end -->	
					<!-- tab面板 start -->
					<div id="commentQA">
						<div id="myTabContent" class="tab-content">
							
							<!-- 评论区 start -->
							<div class="tab-pane fade in active" id="comments" style="height: 100%;">
								<!--iframe框架内容--><!-- seamless="seamless" 无边框或滚动条 -->
							    <iframe src="<%=request.getContextPath() %>/course/learn/comment?courseId=${course.courseId }" width="100%"  frameborder="0" scrolling="no" id="comment1" onload="this.height=100">
							    	您的浏览器不支持iframe，请升级
							    </iframe>
							</div>
							<!-- 评论区 end -->
							
							<!-- 问答区 start -->
							<div class="tab-pane fade" id="question" style="height: 100%;">
								<!--iframe框架内容-->
							    <iframe src="<%=request.getContextPath() %>/course/video/question?courseId=${course.courseId }" width="100%"  frameborder="0" scrolling="no" id="question1" onload="this.height=100">
							    	您的浏览器不支持iframe，请升级
							    </iframe>
							</div>
							<!-- 问答区 end -->

							<!-- 笔记 start -->
							<div class="tab-pane fade" id="notes" style="height: 100%;">
								<!--iframe框架内容-->
							    <iframe src="<%=request.getContextPath() %>/course/video/note?courseId=${course.courseId }" width="100%"  frameborder="0" scrolling="no" id="note1" onload="this.height=100">
							    	您的浏览器不支持iframe，请升级
							    </iframe>
							</div>
							<!-- 笔记 end -->

						</div>
					</div>
					<!-- tab面板 end -->
				
				</div>
				<!-- 页面左边 end -->

				<!-- 页面右边 start -->
				<div class="main-course-right">

					<div class="tab-pane fade in active" id="chapter">
						<p>所有章节</p>
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
								                                            						<em class="laststudy" style="color: #00b43c;">正在学习</em>
								                                            						<input type="hidden" name="learnSmallChapterId" value="${small.smallChapterId }" />
								                                            						<a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${small.smallChapterId}" target="_black" class="J-media-item">
													                                                	<span class="glyphicon glyphicon-time done circle-on"></span><!-- 正在学习图标 -->
													                                    				<span class="glyphicon glyphicon-play"></span>
																										<!-- 形如： 1-1 课程简介(00:53) -->
																										${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
													                                                </a>
								                                            					</c:when>
								                                            					<c:otherwise>
								                                            						<c:choose>
								                                            							<c:when test="${learn.learnStatus == 1 }">
								                                            								<!-- 已经完成学习 -->
								                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${small.smallChapterId}" target="_black" class="J-media-item">
															                                                	<!-- <span class="glyphicon glyphicon-ok-circle done circle-on"></span> --><!-- (旧版)已完成学习图标 -->
															                                                	<span class="glyphicon glyphicon-ok-sign done circle-on"></span><!-- (新版)已完成学习图标 -->
															                                    				<span class="glyphicon glyphicon-play"></span>
																												<!-- 形如： 1-1 课程简介(00:53) -->
																												${loop.count}-${loop1.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
															                                                </a>
								                                            							</c:when>
								                                            							<c:otherwise>
								                                            								<a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${small.smallChapterId}" target="_black" class="J-media-item">
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
							                                            		<a href="<%=request.getContextPath() %>/course/video?courseId=${course.courseId}&smallChapterId=${small.smallChapterId}" target="_black" class="J-media-item">
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
						                                            	<%-- <c:if test="${empty sessionScope.user }">
					                                            			<em class="laststudy" style="display: none;">开始学习</em>
					                                            			<a href="<%=request.getContextPath() %>/course/video?courseId=${courseDto.course.courseId}&smallChapterId=${small.smallChapterId}" onclick="return startLearn()" target="_black" class="J-media-item">
							                                                	<span class="glyphicon glyphicon-ok-circle done" style="display: none;"></span>
							                                    				<span class="glyphicon glyphicon-play"></span>
																				<!-- 形如： 1-1 课程简介(00:53) -->
																				${c.chapterOrder}-${small.smallChapterOrder}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})
							                                                </a>
							                                             </c:if> --%>
						                                                
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
				// 设置视频的属性
				setVideo();
				
			}else{	// 用户未登录
				$('.unLogin2').attr('style','display: none;');
				$('.unLogin1').css({display:'block'});			// 不显示头像
				$('.panel-comments').css({display:'none'});		// 不显示发布评论面板
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
		// 设置视频的属性
		function setVideo(){  
			// 设置视频的属性
			var myVideo = document.getElementById("myVideo");
			// 设置浏览器应当显示标准的音视频控件,包括播放，暂停，进度条，音量，全屏切换（供视频），字幕（当可用时），轨道（当可用时）
			myVideo.controls=true;
			// 页面一旦加载，就开始加载视频
			myVideo.preload="auto";
			// 启用自动播放，并重载视频
			myVideo.autoplay=true;
			/* myVideo.load(); */
			// 设置视频的默认播放速度
			myVideo.defaultPlaybackRate=1.0;
			// 设置视频的当前播放速度
			myVideo.playbackRate=1.0;
			
			// 获取当前视频  上次播放记录中的时间
			var lastTime = '${learnFirst.learnUseTime}';
			// alert("获取当前视频  上次播放记录中的时间:  " + lastTime);
			// 设置或返回音频/视频中的当前播放位置（以秒计）
			myVideo.currentTime = lastTime;
			// ended 属性返回音频/视频是否已结束。如果播放已结束，则返回 true。否则返回 false
			// alert("该视频播放是否已结束？ " + myVideo.ended);
			// duration 属性返回当前音频/视频的长度（以秒计）
			// alert("当前视频的长度：" + myVideo.duration + "秒");
			// loop 属性设置或返回音频/视频是否应该在结束时再次播放。 设置true为重复播放
			myVideo.loop = false;
			// 获得视频的当前网络状态
			// alert("当前视频的当前网络状态：" + myVideo.networkState);
			// 设置或返回音频/视频元素的当前来源
			// myVideo.src="movie.ogg";
			// 设置或返回音频/视频的音量。规定音频/视频的当前音量。必须是介于 0.0 与 1.0 之间的数字。
			myVideo.volume = 0.2;
			
			// 点击视频屏幕时，播放与暂停
			myVideo.onclick = function(){
			    if(myVideo.paused){
			    	myVideo.play();
			    }else{
			    	myVideo.pause();
			    	// 更新当前视频观看的进度
			    	updateLearnUseTime(myVideo.currentTime);
			    }
			}
			
			// alert("当目前的播放列表已结束时:" + myVideo.ended);
			
			// 使用事件监听方式捕捉事件---(timeupdate:当目前的播放位置已更改时)
			myVideo.addEventListener("timeupdate",function(){
				var timeDisplay = document.getElementById("time");
				//用秒数来显示当前播放进度
				timeDisplay.innerHTML = Math.floor(myVideo.currentTime) + "/" + Math.floor(myVideo.duration) + " 秒";
			},false);
			
			// 监听视频是否播放完, 放完之后显示遮罩div, 然后ajax异步更新学习记录表中的状态为1(表示已看完)
			myVideo.addEventListener("ended",function(){
		         // alert("视频结束");
		         var videoHeight = $(".video1").height();
		         // alert(videoHeight);
		         // 设置遮罩属性
		         $(".video-mask").css({display:'block'});
		         $(".video-mask").css("height", videoHeight+'px');
		         
		         var learnId = '${requestScope.learnFirst.learnId }';
		         var data = {
		        	"learnId" : learnId,	 
		         };
		         $.ajax({
		        	 type: "POST",
		        	 url: "${pageContext.request.contextPath}/course/video/updateLearnStatus",
		        	 data: data,
		        	 dataType: "json",	// 1预期服务器返回的数据类型，可以不指定
		        	 async: true,	//false即修改此方法为同步  ,true此方法为异步;异步是先执行后续动作，再执行success里代码；同步则相反
		        	 success: function(res){
		        		 if( res.result == 1 ){
		        			 conlose.log("当前视频状态更新成功！！");
		        		 }else{
		        			 conlose.log("当前视频状态更新失败。。");
		        		 }
		        	 },
		        	 error: function(){
		        		 conlose.log("更新当前视频状态---请求失败");
		        	 }
		         });
	      		 /* // 更新当前视频观看的进度
		    	 updateLearnUseTime(myVideo.currentTime); */
		    })
		}
		
		// 通过ajax请求异步的更新--视频观看的进度
		function updateLearnUseTime( learnUseTime ){
			// 设置视频的属性
			var myVideo = document.getElementById("myVideo");
			// 当 当前视频观看的进度已经播放完时，将当前观看进度设置为零，以便下次打开时从0开始播放
			// alert("已经用时：" + learnUseTime +",  当前视频的长度：" + myVideo.duration + "秒");
			if( learnUseTime >= myVideo.duration ){
				learnUseTime = 0;
			}
			
			var learnId = '${requestScope.learnFirst.learnId }';
			// alert("learnId-----: "+ learnId + ", learnUseTime：" + learnUseTime);
	        /* var data = {
	        	"learnId" : learnId,
	        	"learnUseTime" : learnUseTime,
	         }; */
	        var learnUseTime = Math.floor(learnUseTime); // 取整数(获取的时间为小数)
	        var data = "learnId="+learnId+"&learnUseTime="+learnUseTime;	// 拼接url
			$.ajax({
				type: "GET",
				url: "${pageContext.request.contextPath}/course/video/updateLearnUseTime",
				data: data,
				dataType: "json",
				async: true,	//false即修改此方法为同步  ,true此方法为异步;异步是先执行后续动作，再执行success里代码；同步则相反
				success: function(res){
					if( res.result == 1 ){
						conlose.log("已保存当前视频进度成功！！！");
					}else{
						conlose.log("保存当前视频进度失败。。");
					}
				},
				error: function(){
					conlose.log("更新--视频观看的进度--请求失败");
				}
			});
			
		}
		
		// 点击 其他视频链接播放之前--更新当前视频观看的进度
		function beforeJump(){
			var myVideo = document.getElementById("myVideo");
			// 更新当前视频观看的进度
	    	updateLearnUseTime(myVideo.currentTime);
		}
		
		// 页面关闭之前执行的函数----更新当前视频观看的进度
		window.onbeforeunload = beforeJump; 
		
		
		// 评论面板--设置iframe的高度与父页面自适应高度
		function reinitIframe(){  
	        var iframe = document.getElementById("comment1");  
	        try{  
	            var bHeight = iframe.contentWindow.document.body.scrollHeight;  
	            var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;  
	            var height = Math.max(bHeight, dHeight);  
	            iframe.height =  height;  
	            console.log(height);
	        }catch (ex){}  
	    }  
		// 问答面板--设置iframe的高度与父页面自适应高度
		function reinitIframeQuestion(){  
	        var iframe = document.getElementById("question1");  
	        try{  
	            var bHeight = iframe.contentWindow.document.body.scrollHeight;  
	            var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;  
	            var height = Math.max(bHeight, dHeight);  
	            iframe.height =  height;  
	            console.log(height);
	        }catch (ex){}  
	    } 
		// 笔记面板--设置iframe的高度与父页面自适应高度
		function reinitIframeNote(){  
	        var iframe = document.getElementById("note1");  
	        try{  
	            var bHeight = iframe.contentWindow.document.body.scrollHeight;  
	            var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;  
	            var height = Math.max(bHeight, dHeight);  
	            iframe.height =  height;  
	            console.log(height);
	        }catch (ex){}  
	    } 
	    window.setInterval("reinitIframe()", 200);  
	    window.setInterval("reinitIframeQuestion()", 300);  
	    window.setInterval("reinitIframeNote()", 300);  
	</script>
</html>