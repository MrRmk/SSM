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
	<title>IT技术文章-慕课网手记</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/font-awesome-4.7.0/css/font-awesome.min.css">
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
		                <span>让世界感知你的存在</span>
		            </div>

		            <!-- 问答区 end -->
		            <div class="tab-pane fade in active" id="QA">
						<!-- 提问 start -->
						<div class="panel-comments">
							<form action="<%=request.getContextPath() %>/note/add" method="post">
								<input type="hidden" name="userId" value=${user.userId } />
								<a href="#" onclick="return startLearn()" class="user-head l">
						            <c:choose>
										<c:when test="${!empty user.userPhoto}">
											<img src="/imgUrl/images/${user.userPhoto }" alt="发笔记人的头像"/>
										</c:when>
										<c:otherwise>
											<img src="<%=request.getContextPath() %>/static/images/anonymous-photo.png" alt="发笔记人的头像"/>
										</c:otherwise>
									</c:choose>
						        </a>
								<div class="wgt-ipt-wrap pub-editor-wrap l" id="js-pl-input-fake">
						            <textarea id="js-pl-textarea" name="noteContent" onclick="return startLearn()" class="" placeholder="记录下你的笔记"></textarea>
						            <span class="num-limit"><span id="js-pl-limit">0</span>/300</span>
						        </div>	
						        <div id="pub-btm" class="pub-btm clearfix">
						        	<!-- <button>提问</button> -->
						        	<div class="captcha-verify-box js-verify-box hide"></div>
							        <input type="submit" onclick="return notNull()" id="js-pl-submit" class="pub-btn comment-pub-btn r" data-cid="931" onclick="return startLearn()" value="发表">
							        <span class="errortip r">内容不能少于5个字符！</span>
							    </div>
							 </form>
						</div>
						<!-- 提问 end -->

						<div id="course_note">
							<ul class="mod-post" id="comment-list">
				                <!-- 循环显示--提问表中的数据 start -->
								<c:choose>
									<c:when test="${!empty pageModel.noteList}">
										<c:forEach items="${pageModel.noteList }" var="note" varStatus="loop">
											<li class="pl-list" id="529846">
									            <div class="pl-list-avator">
									                <a href="####" onclick="return startLearn()" target="_blank">
									                	<img src="/imgUrl/images/${note.user.userPhoto }" title="${note.user.userNickName }" width="40" height="40">
									                </a>
									            </div>
									            <div class="pl-list-main">
									                <div class="tit">
									                    <a href="####" onclick="return startLearn()" target="_blank">${note.user.userNickName }</a>
									                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">的笔记：</span>
									                </div>
									                <p class="pl-list-content">${note.noteContent }</p>
									                <div class="pl-list-btm clearfix">
									                	<!-- <label class="moco-label label l">
									                		<a href="#" onclick="return startLearn()" target="_blank">后端开发</a>
									                	</label> -->
			                    						<span title="创建时间" class="l timeago">时间:&nbsp;
			                    							<fmt:formatDate value="${note.noteTime}" pattern="yyyy-MM-dd HH:mm:ss" />
			                    						</span>
				                                        <%-- <a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">源自：2-2 position-relative</a> --%>
				                                        <div class="actions r">
			                                                <a title="赞" href="javascript:;" onclick="thumbsUp('${note.noteId}')" class="js-pl-praise list-praise post-action" data-id="529846">
								                            	<span class="glyphicon glyphicon-thumbs-up"></span>
								                            	<!-- <i class="fa fa-thumbs-up" style="font-size: 20px;"></i> -->
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
					<!-- 问答区 end -->

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
					
					<!-- <div class="page-box clearfix">
						<div class="page clearfix">
							<ul class="pagination">
								<li><a href="#">首页</a></li>
								<li><a href="#">&laquo;</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">&raquo;</a></li>
								<li><a href="#">末页</a></li>
							</ul>
						</div>
					</div> -->

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
		// 设置头部导航栏样式
		$(".nav .item:eq(3)").addClass('on');
		
		/* 分页 */
		var page=${pageModel.page};
		var totalPage=${pageModel.totalPage};
		$(function(){
		    $("#frist1").click(function(){
		    	if(page!=1){
		    		page=1;
		        	window.location.href='<%=request.getContextPath()%>/note?page='+page;
		    	}else{
		    		alert("本页就是第一页！");
		    	}
		    	
			});
			$("#forw1").click(function(){
				if(page>1){
					page--;
					window.location.href='<%=request.getContextPath()%>/note?page='+page;
				}else{
					alert("已经是第一页了！");
				}
			});
		 	$("#next1").click(function(){
		 		if(page<totalPage){
					page++;
					window.location.href='<%=request.getContextPath()%>/note?page='+page;
				}else{
					alert("已经是最后一页了！");
				}
			});
		 	$("#end1").click(function(){
		 		if(page!=totalPage){
		 			page=totalPage;
					window.location.href='<%=request.getContextPath()%>/note?page='+page;
		 		}else{
		 			alert("本页就是最后一页！");
		 		}
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			
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
		
		// 点赞功能
		/* function thumbsUp(noteId){
			console.log(noteId);
			
			// 请求后台，进行数据库切换，是收藏还是不收藏
		    $.ajax({
		        type : "POST",
		        url : '${pageContext.request.contextPath}/user/note/thumbsUp',
		        data: {"noteId": noteId},	// 传入参数:笔记id
		        dataType:"json",			// 返回来的数据格式为json。如果不 添加该条属性，则返回来的为字符串。字符串对象可以通过eval("("+data+")")方法转成json对象。区分data为JSON对象还是字符串，可以通过alert语句进行打印，如果是Object object就是JSON对象，如果将内容显示出来则为字符串
		        async: false,       		//false即修改此方法为同步  ,true此方法为异步
		        success : function(res) {	//返回数据根据结果进行相应的处理
		            if( res.result == "1" ){
		            	alert("点赞成功");
		            }else if( res.result == "2" ){
		            	alert("取消点赞");
		            }
		        },
		        error:function(){
		            alert("请求失败");
		        }
		    });
		} */
		
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
		
		// a标签链接跳转之前--通过笔记框中是否有内容---来判断是否提交跳转
		function notNull(){
			var user = '${sessionScope.user}';
			if( user != null && user != ""){	// 用户已登录
				
				// 判断手记内容不为空
				var noteContent = $('#js-pl-textarea').val();
				if( noteContent != null && noteContent != ""){	// 用户已输入手记内容
					return true; 	//页面跳转
				}else{	// 用户未输入手记内容
					alert("手记内容不能为空");
					return false;	//页面不跳转
				}
				
				return true; 	//页面跳转
			}else{	// 用户未登录
				alert("你还未登陆，请先登陆！");
				return false;	//页面不跳转
			}
			
		}
	</script>
</html>