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
	<title>慕课网后台管理-课程管理</title>

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
			    <div class="container-fluid">
					
					<form id="queryPageForm" class="mt-15" action="<%=request.getContextPath()%>/manager/course" method="get">
						<!-- 头部搜索条件 start -->
						<div class="row-fluid">
							<div class="block span6">
								<a class="block-heading f-14" data-toggle="collapse">课程管理</a>
								<div class="block-body collapse in" style="margin-bottom: 10px;">
								<p>
									<select name="oneCode" class="search-select form-control" style="margin-top:1px;" type="select">
										<option value="-1">总分类</option>
										<c:choose >
											<c:when test="${ !empty sortsOneList }">
												<c:forEach items="${sortsOneList }" var="sortsOne" varStatus="loop">
													<option value="${sortsOne.oneCode }" <c:if test='${oneCode == sortsOne.oneCode}'>selected='selected'</c:if> >${sortsOne.oneName }</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</select>
								</p>
				                <p>	
				                	<input type="text" class="search-text form-control" name="courseName" value="${courseName}" style="margin-top:1px;" placeholder="请输入课程名称">
				                </p>
				                	<input type="submit" onclick="return submitBefore()" class="btn btn-primary form-control" style="width:80px;margin-left: 15px;" value="搜索">
				                	<input type="button" class="btn btn-primary form-control" style="width:100px;margin-left: 15px;" onclick="window.location.href='<%=request.getContextPath() %>/manager/course/addPage'" value=" + 添加课程 ">
			                	</div>
			                </div>
						</div>
						<!-- 头部搜索条件 end -->
						
						<!-- table表显示课程信息  start  -->
						<div class="row-fluid">
							<div class="block span6">
								<div id="widget2container" class="block-body">
									<table class="table list">
										<tbody>
											<c:choose >
												<c:when test="${ !empty pageModel.courseDtoList }">
													<c:forEach items="${pageModel.courseDtoList }" var="courseDto" varStatus="loop">
														<tr id="tr-${courseDto.course.courseId }">
															<td style="width:600px;">
																<p>
																	<a href="<%=request.getContextPath() %>/manager/course/details?courseId=${courseDto.course.courseId }">
																		<img src="<%=request.getContextPath() %>/static/images/course.png" title="${courseDto.course.courseName }" style="width: 180px;height:100px;float: left;">
																	</a>
																</p>
																<div class="ml-15 w-350" style="float:left;">
																	<a href="<%=request.getContextPath() %>/manager/course/details?courseId=${courseDto.course.courseId }">
																		<p class="ellipsis" title="${courseDto.course.courseName }"><strong>${courseDto.course.courseName }</strong></p>
																	</a>
																	<p class="ellipsis-multi h-40" title="简介：${courseDto.course.courseSummary }">
																		简介：${courseDto.course.courseSummary }
																	</p>
																</div> 
																<p></p>
															</td>
															<td>
																<p>
																	<fmt:parseNumber integerOnly="true" value="${courseDto.course.courseTotalTime/3600 }" />小时
																	<fmt:parseNumber integerOnly="true" value="${(courseDto.course.courseTotalTime%3600)/60 }" />分
																</p>
																<c:choose>
																	<c:when test="${courseDto.course.courseIsProject == 0 }">
																		<p style="color: red;">免费</p>
																	</c:when>
																	<c:otherwise>
																		<p style="color: red;">￥${courseDto.course.coursePrice}</p>
																	</c:otherwise>
																</c:choose>
																<p>${courseDto.course.courseGrade }</p>
															</td>
															<td>
																<p>${courseDto.oneName } <span style="color: red;">/</span> ${courseDto.sortsTwoName }</p> 
																<p>${courseDto.number }人在学</p>
																<p>讲师：${courseDto.teacher}</p>
															</td>
															<td style="width:130px;">
																<c:choose>
																	<c:when test="${courseDto.course.courseStatus == 0 }">
																		<p id="currentCourseStatus-${courseDto.course.courseId }">当前状态：<span style="color: red;">未在架</span></p>
																		<p id="optionalCourseStatus-${courseDto.course.courseId }"><a href="javascript:void(0)" onclick="doSale(${courseDto.course.courseId },${courseDto.course.courseStatus});">发布上架</a></p>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${courseDto.course.courseStatus == 1 }">
																			<p id="currentCourseStatus-${courseDto.course.courseId }">当前状态：在架</p>
																			<p id="optionalCourseStatus-${courseDto.course.courseId }"><a href="javascript:void(0)" onclick="doSale(${courseDto.course.courseId },${courseDto.course.courseStatus});">课程下架</a></p>
																		</c:if>
																	</c:otherwise>
																</c:choose>
																<p><a href="javascript:void(0)" onclick="showDeleteCourseAlert('${courseDto.course.courseId }');">删除</a></p> 
															</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<h3>课程列表暂时没有数据</h3>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									
									<!-- 分页 start -->
									<div class="page-box clearfix">
										<div class="page clearfix">
											<ul class="pagination">
												<li><input type="hidden" name="page" id="pageNumber" value="${pageModel.page }" /></li>
												<li><a href="#" id="frist1">首页</a></li>
												<li><a href="#" id="forw1">上一页</a></li>
												<li><a href="javascript:void(0);" style="color: #14191e;">第${pageModel.page}/${pageModel.totalPage}页</a></li>
												<li><a href="#" id="next1">下一页</a></li>
												<li><a href="#" id="end1">尾页</a></li>
											</ul>
											<div class="page-total">
												总记录数：${pageModel.totalSize }条
											</div>
										</div>
									</div>
									<!-- 分页 end -->
									
								</div>
							</div>
						</div>
						<!-- table表显示课程信息  end  -->
					</form>
					
				</div>
				
				<!-- 课程 删除弹出层 alert 信息 start -->
				<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
					<div class="modal_wapper">
						<div class="modal-dialog w-4">
							<div class="modal-content">
								<!-- 表单 -->
								<%-- <form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/course/delete" method="post"> --%>
									<div class="modal-header">
										<div class="modal-title f-16">提示信息</div>
									</div>
									<div class="modal-body">
										<div><span class="color-oc f-16 oc-content">确定删除？</span></div>
									</div>
									<div class="modal-footer modal-center">
										<button type="submit" class="btn btn-primary oc-ok" id="courseId" value="" onclick="doDeleteCourse(this)">确 定</button>
										<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
									</div>
								<!-- </form> -->
							</div>
						</div>
					</div>
				</div>
				<!-- 课程弹出层 alert 信息  end -->
				
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
	/* 分页 */
	var page=${pageModel.page};
	var totalPage=${pageModel.totalPage};
	$(function(){
	    $("#frist1").click(function(){
	    	if(page!=1){
	    		page=1;
	    		$('#pageNumber').val(page);
	    		$('#queryPageForm').submit();
	    	}else{
	    		alert("本页就是第一页！");
	    	}
	    	
		});
		$("#forw1").click(function(){
			if(page>1){
				page--;
				$('#pageNumber').val(page);
				$('#queryPageForm').submit();
			}else{
				alert("已经是第一页了！");
			}
		});
	 	$("#next1").click(function(){
	 		if(page<totalPage){
				page++;
				$('#pageNumber').val(page);
				$('#queryPageForm').submit();
			}else{
				alert("已经是最后一页了！");
			}
		});
	 	$("#end1").click(function(){
	 		if(page!=totalPage){
	 			page=totalPage;
	 			$('#pageNumber').val(page);
	 			$('#queryPageForm').submit();
	 		}else{
	 			alert("本页就是最后一页！");
	 		}
		});
	});
	
	function submitBefore(){
		$('#pageNumber').val(1);
		return true;
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		// 设置左边导航栏样式
		$("#dashboard-menu li:eq(1)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
	
	//课程上下架
	function doSale(courseId,status){
		// courseId：课程id；status：状态
		// alert("courseId:"+courseId+", status:"+status);
		if(status == 0){//status == 0 表示未在架
			status = 1;	//设置为：在架
		}else{
			status = 0;	//设置为：未在架
		}
		$.ajax({
			url:'${pageContext.request.contextPath}/manager/course/doSale',
		    type:'POST',
		    dataType:'json',
		    data:{"courseId":courseId,"status":status},
		    success:function(resp){
		    	var res = resp.res;
		    	if( res == 1 ){// 更新成功
		    		// 判断状态更新页面显示数据
		    		if( status == 1 ){
		    			$('#currentCourseStatus-'+courseId).html('当前状态：在架');
		    			$('#optionalCourseStatus-'+courseId).html('<a href="javascript:void(0)" onclick="doSale('+courseId+','+status+');">课程下架</a>');
		    		}else{
		    			$('#currentCourseStatus-'+courseId).html('当前状态：<span style="color: red;">未在架</span>');
		    			$('#optionalCourseStatus-'+courseId).html('<a href="javascript:void(0)" onclick="doSale('+courseId+','+status+');">发布上架</a>');
		    		}
		    	}
		    },
		    error: function(){
		    	alert("请求失败");
		    }
		});
	}
	
	
	/* function doDelete(courseId){
		alert("课程id---courseId："+courseId);
		$('#deleteModal').modal('show');
		$('#deleteCourseId').val(courseId);
	} */
	//删除课程--显示提示弹出框
	function showDeleteCourseAlert(courseId){
		$('#deleteModal').modal('show');
		$('#courseId').val(courseId);
	}
	// 异步删除课程
	function doDeleteCourse(e){
		var courseId = e.value;
		$.ajax({
			url:'${pageContext.request.contextPath}/manager/course/delete',
		    type:'POST',
		    dataType:'json',
		    data:{"courseId":courseId},
		    success:function(data){
		    	var res = data.res;
		    	if(res == 1){
		    		$('#deleteModal').modal('hide');
		    		$('#tr-'+courseId).remove();
		    	}
		    },
		    error: function(){
		    	alert("请求失败");
		    }
		});
	}
</script>
</html>
	