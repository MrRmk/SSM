<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网后台管理-轮播管理</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- manager页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager-index.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
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
				<input type="button" class="search-btn mt-10" style="margin-left: 15px;" onclick="window.location.href='/carousel/toMerge.html'" value=" 添加轮播配置">
			    <div class="container-fluid">
            
		            <div class="row-fluid">
		            	<form id="queryPageForm" class="mt-15">
						<div class="block span6">
							<div id="widget2container" class="block-body">
								<table class="table list">
									<tbody>
										<tr id="tr-1">
											<td style="width:600px;">
												<p>
													<img src="<%=request.getContextPath() %>/static/images/course.png" style="width: 250px;height:150px;float: left;">
													</p><div class="ml-15" style="float:left;">
														<p class="ellipsis" title="成为高级的android工程师">成为高级的android工程师</p>
														<p class="ellipsis-multi h-40" title="">链接：
														<a href="http://www.ioswift.org/course/learn/1.html" target="_blank">http://www.ioswift.org/course/learn/1.html</a>
														</p>
													</div> 
												<p></p>
											</td>
											<td style="width:120px;">
												<p>推荐权重：1</p> 
												<p><a href="/carousel/toMerge.html?id=1">修改</a></p> 
												<p><a href="javascript:void(0);" onclick="doDelete(1);">删除</a></p> 
											</td>
										</tr>
										<tr id="tr-2">
											<td style="width:600px;">
												<p>
													<img src="http://onw21pjl5.bkt.clouddn.com/@/default/all/0/28bed8dc4b5e48078a1a364a4b624a0d.jpeg?e=1524467389&amp;token=kEUR-PJ-onSZZfmXGQcwQ2brvIdXM9y_vjyr18qH:GwU0ChJkNRGDdIe_3XEr70H_bb4=" style="width: 250px;height:150px;float: left;">
													</p><div class="ml-15" style="float:left;">
														<p class="ellipsis" title="开发跨平台的教育系统">开发跨平台的教育系统</p>
														<p class="ellipsis-multi h-40" title="">链接：
														<a href="http://www.ioswift.org/course/learn/1.html" target="_blank">http://www.ioswift.org/course/learn/1.html</a>
														</p>
													</div> 
												<p></p>
											</td>
											<td style="width:120px;">
												<p>推荐权重：1</p> 
												<p><a href="/carousel/toMerge.html?id=2">修改</a></p> 
												<p><a href="javascript:void(0);" onclick="doDelete(2);">删除</a></p> 
											</td>
										</tr>
										<tr id="tr-3">
											<td style="width:600px;">
												<p>
													<img src="http://onw21pjl5.bkt.clouddn.com/@/default/all/0/fab11ebb70ca48aca51af0bb42a05530.jpeg?e=1524467389&amp;token=kEUR-PJ-onSZZfmXGQcwQ2brvIdXM9y_vjyr18qH:e_8wuDP-zLg0oK3JV2a7g9DyBsM=" style="width: 250px;height:150px;float: left;">
													</p><div class="ml-15" style="float:left;">
														<p class="ellipsis" title="ReactJS实战">ReactJS实战</p>
														<p class="ellipsis-multi h-40" title="">链接：
														<a href="http://www.ioswift.org/course/learn/1.html" target="_blank">http://www.ioswift.org/course/learn/1.html</a>
														</p>
													</div> 
												<p></p>
											</td>
											<td style="width:120px;">
												<p>推荐权重：1</p> 
												<p><a href="/carousel/toMerge.html?id=3">修改</a></p> 
												<p><a href="javascript:void(0);" onclick="doDelete(3);">删除</a></p> 
											</td>
										</tr>
										<tr id="tr-4">
											<td style="width:600px;">
												<p>
													<img src="http://onw21pjl5.bkt.clouddn.com/@/default/all/0/4db0cf1dd51349219c252983c9cba09b.jpeg?e=1524467389&amp;token=kEUR-PJ-onSZZfmXGQcwQ2brvIdXM9y_vjyr18qH:AumCsrjZ_m48tXRj8oA1Z6aBzHg=" style="width: 250px;height:150px;float: left;">
													</p><div class="ml-15" style="float:left;">
														<p class="ellipsis" title="AngularJS模仿拉钩网">AngularJS模仿拉钩网</p>
														<p class="ellipsis-multi h-40" title="">链接：
														<a href="http://www.ioswift.org/course/learn/1.html" target="_blank">http://www.ioswift.org/course/learn/1.html</a>
														</p>
													</div> 
												<p></p>
											</td>
											<td style="width:120px;">
												<p>推荐权重：1</p> 
												<p><a href="/carousel/toMerge.html?id=4">修改</a></p> 
												<p><a href="javascript:void(0);" onclick="doDelete(4);">删除</a></p> 
											</td>
										</tr>
									</tbody>
								</table>
								<p>
									<script type="text/javascript">
										function _queryPage(page){
											if(page != undefined){
												$('#_id_pageNum').val(page);
											}
											var query = $('#queryPageForm').attr('queryPage');
											if(query && Number(query) == 1){
												queryPage(page);
											}else{
												$('#queryPageForm').submit();
											}
										}
									</script>
								</p>
							</div>
						</div>
						</form>
					</div>
            
    			</div>
			</div>
			<!-- 右边内容 end -->
		</div>
	

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
</div>		
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		// 设置左边导航栏样式
		$("#dashboard-menu li:eq(2)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
</script>
</html>
	