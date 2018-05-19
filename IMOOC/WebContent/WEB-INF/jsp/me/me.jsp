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
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- me页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/js/echarts.min.js"></script>	
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
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
					<div class="setting-right" style="height: 100%;">
						<div class="setting-all">
							<div><span class="f-16"><strong>我的主页</strong></span></div>
							<!-- 分割线 -->
							<div class="split-line" style="margin: 20px 0px;"></div>
							
							<div class="course-meta">
								<div class="static-item">
									<div class="meta">学习时长</div>
									<div class="meta-value" title="">
										<fmt:parseNumber integerOnly="true" value="${ messageDto.learnTime/3600 }" />小时
										<fmt:parseNumber integerOnly="true" value="${(messageDto.learnTime%3600)/60 }" />分
									</div>
								</div>
								<div class="static-item">
									<%-- <div class="meta"><a href="<%=request.getContextPath() %>/me/course" target="_blank">学习课程</a></div> --%>
									<div class="meta">学习课程</div>
									<div class="meta-value">${messageDto.courseNumber }个</div>
									<input id="courseNumber" type="hidden" value="${messageDto.courseNumber }" />
								</div>
								<div class="static-item">
									<div class="meta">收藏课程</div>
									<div class="meta-value">${messageDto.collectNumber }个</div>
									<input id="collectNumber" type="hidden" value="${messageDto.collectNumber }" />
								</div>
								<div class="static-item">
									<div class="meta">提问</div>
									<div class="meta-value">${messageDto.questionNumber }个</div>
									<input id="questionNumber" type="hidden" value="${messageDto.questionNumber }" />
								</div>
								<div class="static-item">
									<div class="meta">回答</div>
									<div class="meta-value">${messageDto.replyNumber }个</div>
									<input id="replyNumber" type="hidden" value="${messageDto.replyNumber }" />
								</div>
								<div class="static-item">
									<div class="meta">笔记</div>
									<div class="meta-value">${messageDto.noteNumber }个</div>
									<input id="noteNumber" type="hidden" value="${messageDto.noteNumber }" />
								</div>
								<div class="static-item">
									<div class="meta">关注</div>
									<div class="meta-value">${messageDto.followsNumber }个</div>
									<input id="followsNumber" type="hidden" value="${messageDto.followsNumber }" />
								</div>
								<div class="static-item" style="border:none;">
									<div class="meta">粉丝</div>
									<div class="meta-value" title="">${messageDto.fansNumber }个</div>
									<input id="fansNumber" type="hidden" value="${messageDto.fansNumber }" />
								</div>
							</div>
							
							<div id="echarts-content" style="height:500px;width:930px;margin-top: 50px;">
							
							</div>
								
						</div>
					</div>
					<!-- 页面右边 end -->
				</div>
			</div>
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		// 设置头部导航栏样式
		$('.nav .item:eq(4)').addClass('on');
		// 设置左边导航栏样式
		$('.user-menu-nav-block a:eq(0)').find('li').addClass('user-menu-nav-cur');
	
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


		var courseNumber = $("#courseNumber").val();
		var collectNumber = $("#collectNumber").val();
		var questionNumber = $("#questionNumber").val();
		var replyNumber = $("#replyNumber").val();
		var noteNumber = $("#noteNumber").val();
		var followsNumber = $("#followsNumber").val();
		var fansNumber = $("#fansNumber").val();
		var data = new Array(courseNumber,collectNumber,questionNumber,replyNumber,noteNumber,followsNumber,fansNumber);

		var myChart = echarts.init(document.getElementById("echarts-content"));//初始化画布
		var option = {
			    title:{  
			        text:'数据统计',
			        left: 'center',
			        top:'1%'
			    },
			    color:[ '#0089D2' ],
			    tooltip : {	/* 鼠标移动上去显示的内容 */
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        },
			        formatter:'{b}: {c}个',
			    },
			    label:{	/*柱形图上面的显示数字  */
			        show: true,
			        position: 'top',
			        distance: 5,
			        formatter:'{c}',
			        /* formatter:'{b}:{c}个', */
			    },
			    grid: {
			        left: '5%',
			        right: '5%',
			        bottom: '5%',
			        containLabel: true,
			        
			    },
			    xAxis: {
			        type: 'category',	//类型为类目
			        data: ['学习课程', '收藏课程', '我的提问', '我的回答', '我的笔记', '关注', '粉丝'],
			        name: '类型',
			    },
			    yAxis: {
			        type: 'value',
			        name: '数量',
			    },
			    series: [{
			        data: data,
			        type: 'bar',	//条形图
			        barWidth: '50px'
			    }]
			};
		myChart.setOption(option);
	});
</script>
</html>