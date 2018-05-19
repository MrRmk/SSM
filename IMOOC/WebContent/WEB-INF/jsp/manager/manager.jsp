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
	<title>慕课网后台管理-主页</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/share.css">
	<!-- manager页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager-index.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	
	<script src="<%=request.getContextPath() %>/static/js/echarts.min.js"></script>
</head>

<body>
	<div class="index">
	
		<!-- 头部+左边导航栏 -->
		<jsp:include page="manager-header.jsp" flush="true"/>
		
		<!-- 主要内容 页面轮播效果 -->
		<div class="main clearfix">
			
			<jsp:include page="manager-left.jsp" flush="true"/>
			<!-- 右边内容 start -->
			<div id="content" class="content">
				<div class="container-fluid">
		            <div class="row-fluid">
		                <div class="row-fluid">
		                	<div class="alert alert-info">
		                		<button type="button" class="close" data-dismiss="alert">×</button>
		                      <strong>最新消息提示:</strong> 今日需要完成 在线网校 项目的上传!
		                  	</div>
		              	</div>
		
		                <div class="row-fluid">
		                    <div class="block span6">
								<div style="width: 100%; margin: 30px auto; margin-bottom: 50px;">
									<div id="echarts-content" style="height:500px; width: 100%;">
										<c:if test="${!empty userDateNumber }">
										</c:if>
									</div>
								</div>
								<script type="text/javascript">
										$(function () {
											// debugger;
											var dateTime = [];
											var data = [];
											var userDateNumberListStr = eval('${userDateNumberList}');
											if( userDateNumberListStr != null ){
												for( var i=0; i<userDateNumberListStr.length; i++ ){
													console.log("("+i+")--countNumber:"+userDateNumberListStr[i].countNumber);
													console.log("("+i+")--dateTime:"+userDateNumberListStr[i].dateTime);
													
													dateTime.push(userDateNumberListStr[i].dateTime);
													data.push(userDateNumberListStr[i].countNumber)
												}
											}
											
											// var categories =  ['03-19', '03-20', '03-21', '03-22', '03-23', '03-24','03-25', '03-26', '03-27', '03-28'];
											// var data = [100, 200, 300, 145, 182, 215, 252, 265, 280, 300];
											var myChart = echarts.init(document.getElementById("echarts-content"));//初始化画布
											var option = {
													color:[ '#0089D2' ],
												    title:{  
												        text:'用户注册人数(最近一周)',
												        left: 'center',
												        top:'1%'
												    },
												    tooltip : {/* 鼠标移动上去显示的内容 */
												        trigger: 'axis',
												        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
												            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
												        },
												        formatter:'{b}<br />注册人数：{c}人',
												    },
												    label:{/*柱形图上面的显示数字  */
												        show: true,
												        position: 'top',
												        distance: 5,
												        formatter:'{c}',
												        /* formatter:'{b}:{c}个', */
												    },
												    xAxis: {
												        type: 'category',
												        data: dateTime, 	//x轴显示时间
												        name: '时间'
												    },
												    yAxis: {
												        type: 'value',
												        name: '人数'
												    },
												    series: [{
												        name: '注册人数',
												        data: data, 	//数据 
												        type: 'line',	//折线图
												        //smooth: true	//变成曲线
												    }]
												};
			
											myChart.setOption(option);
										});
									</script>
		                    </div>
		                    
		                </div>
		
		           </div>
		    	</div>
			</div>
			<!-- 右边内容 end -->
		</div>

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		
	</div>
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		// 设置左边导航栏样式
		$("#dashboard-menu li:eq(0)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
</script>
</html>