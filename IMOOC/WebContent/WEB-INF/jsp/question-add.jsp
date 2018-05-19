<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

					<div class="wd-top-slogan wd-top-add">
		                <span>程序员自己的问答社区——提问模块</span>
		                <a class="js-quiz" href="<%=request.getContextPath() %>/question">返回猿问</a>
		            </div>
					<!-- 页面左边 start -->
					<div class="main-course-left">
			            <!-- 问答区 end -->
			            <div class="tab-pane fade in active" id="QA">
			            
							<!-- 提问 start -->
							<div class="panel-comments">
								<form action="<%=request.getContextPath() %>/question/add/success" method="post">
									<input type="hidden" name="userId" value=${user.userId } />
									<!-- 提问标题 start -->
									<div class="coments-header">
										<div class="quesdetail clearfix">
						                  <span class="ques-label first-label">标题</span>
						                  <div class="question-area">
						                    <input type="text" id="ques-title" name="questionTitle" class="ipt autocomplete" maxlength="255" placeholder="请一句话说明你的问题，以问号结尾">
						                    <!-- <p class="errortip">标题不能少于5个汉字！</p> -->
						                    <p class="errortip"></p>
						                    <dl class="send-area-result" style="display: block;"></dl>
						                  </div>
						               </div>
									</div>
									<!-- 提问标题 end -->
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
								        <input type="submit" onclick="return notNull()" id="js-pl-submit" class="pub-btn comment-pub-btn r" data-cid="931" value="提问">
								        <span class="errortip r">内容不能少于5个字符！</span>
								    </div>
							    </form>
							</div>
							<!-- 提问 end -->
						</div>
						<!-- 问答区 end -->
					</div>
					<!-- 页面左边 end -->

					<!-- 页面右边 start -->
					<div class="main-course-right">
						<div class="panel-body">
				          <h1><img src="<%=request.getContextPath() %>/static/images/hint.png" alt="小灯泡图片" />提问注意事项</h1>
				          <dl>
				            <dd>1、大家每天可以免费提出两个问题，从第三个问题起，每个问题扣除2点积分，请知晓哦；</dd>
				            <dd>2、您是来解决问题？请先搜索是否已经有同类问题吧。这样您就省心少打字。</dd>
				            <dd>3、没找到是么？就在发问题时精确描述你的问题，不要写与问题无关的内容哟；</dd>
				            <dd>4、慕课讨论更热衷于解达您想要的答案。能引起思考和讨论的知识性问题；</dd>
				            <dt>问答禁止这些提问</dt>
				            <dd>1、禁止发布求职、交易、推广、广告类与问答无关信息将一律清理。</dd>
				            <dd>2、尽可能详细描述您的问题，如标题与内容不符，或与问答无关的信息将被删除扣分。</dd>
				            <dd>3、问答刷屏用户一律冻结帐号</dd>
				          </dl>
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
		
		// a标签链接跳转之前--通过添加问题框中是否有内容---来判断是否提交跳转
		function notNull(){
			var questionTitle = $('#ques-title').val();
			var questionContent = $('#js-pl-textarea').val();
			if( questionTitle != null && questionTitle != "" && questionContent != null && questionContent != ""){	// 用户已输入问题内容
				return true; 	//页面跳转
			}else{	// 用户未输入问题内容
				alert("问题标题和内容不能为空");
				return false;	//页面不跳转
			}
		}
	</script>
</html>