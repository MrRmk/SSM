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
	<title>慕课网后台管理-课程管理--课程详情</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- manager页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager-index.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	
	<script src="${pageContext.request.contextPath }/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/js/echarts.min.js"></script>
	<script src="${pageContext.request.contextPath }/static/BootStrap/js/bootstrap.min.js"></script>
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
			
					<div class="block span6">
						<div class="block-body collapse in">
							<!-- 课程基本信息 -->
							<table class="table list">
								<tbody>
									<c:choose >
										<c:when test="${ !empty courseDto }">
											<tr id="tr-1">
												<td style="width:600px;">
													<!-- 设置一级分类，二级分类的隐藏域，用于js获取，来设置弹出修改课程信息时选中的一级二级分类 -->
													<input type="hidden" id="oneClassifyCode" name="oneClassifyCode" value="${courseDto.sortsOne.oneCode}">
													<input type="hidden" id="twoClassifyCode" name="twoClassifyCode" value="${courseDto.sortsTwo.twoCode}">
													<p>
														<a href="javascript:void(0)">
															<img src="<%=request.getContextPath() %>/static/images/course.png" title="${courseDto.course.courseName }" style="width: 180px;height:100px;float: left;">
														</a>
													</p>
													<div class="ml-15 w-350" style="float:left;">
														<!-- <a href="javascript:void(0)"> -->
															<p class="ellipsis" title="${courseDto.course.courseName }">
																<strong>${courseDto.course.courseName }</strong>
															</p>
														<!-- </a> -->
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
													<c:if test="${!empty courseDto.teacher }">
														<p>讲师：${courseDto.teacher}</p>
													</c:if>
												</td>
												<td style="width:130px;">
													<p><a href="<%=request.getContextPath() %>/manager/course">返回主页</a></p>
													<p><a href="javascript:void(0)" data-toggle="modal" data-target="#courseMessageModal">修改信息</a></p>
													<p><a href="<%=request.getContextPath() %>/manager/course/chapterAddPage?courseId=${courseDto.course.courseId }">添加章节</a></p> 
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<h3>课程列表暂时没有数据</h3>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					
					<!-- 更新  课程信息弹出层 -start -->
					<div class="modal" id="courseMessageModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
						<div class="modal_wapper">
							<div class="modal-dialog w-8">
								<div class="modal-content">
									<form role="form" id="courseForm" method="post" action="<%=request.getContextPath() %>/manager/course/update">
										<input type="hidden" name="courseStatus" value="${courseDto.course.courseStatus }" />
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">×</span>
											</button>
											<h4 class="modal-title">课程基本信息</h4>
										</div>
										<div class="modal-body">
											<input type="hidden" name="courseId" value="${courseDto.course.courseId}"/>
											<div class="form-group clearfix"> 
												<label class="control-label">名称</label> 
												<div class="col-sm-10">
												<input type="text" class="form-control" value="${courseDto.course.courseName }" name="courseName" id="name" required placeholder="请输入名称">
												</div>
											</div>
											<div class="form-group clearfix"> 
													<label class="control-label">分类</label>
				                                    <div class="col-sm-4">
				                                        <select id="classify" name="" class="form-control" required type="select">
															<c:choose >
																<c:when test="${ !empty sortsOneList }">
																	<c:forEach items="${sortsOneList }" var="sortsOne" varStatus="loop">
																		<option value="${sortsOne.oneCode }">${sortsOne.oneName }</option>
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<h3>一级分类列表暂时没有数据</h3>
																</c:otherwise>
															</c:choose>
														</select>
				                                    </div>
				                                    <label class="control-label">二级分类</label>
				                                    <div class="col-sm-4">
				                                        <select id="subClassify" name="twoCode" class="form-control" required  type="select">
				                                        	<c:choose >
																<c:when test="${ !empty sortsTwoList }">
																	<c:forEach items="${sortsTwoList }" var="sortsTwo" varStatus="loop">
																		<option parentcode="${sortsTwo.sortsOne.oneCode }" value="${sortsTwo.twoCode }">${sortsTwo.twoName }</option>
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<h3>二级分类列表暂时没有数据</h3>
																</c:otherwise>
															</c:choose>
														</select>
				                                    </div>
											</div>
											<div class="form-group clearfix"> 
													<label class="control-label">级别</label>
				                                    <div class="col-sm-4">
				                                       <select name="courseGrade" class="form-control" required type="select">
															<option value="入门" <c:if test='${courseDto.course.courseGrade == "入门" }'>selected='selected'</c:if> >入门</option>
															<option value="初级" <c:if test='${courseDto.course.courseGrade == "初级" }'>selected='selected'</c:if> >初级</option>
															<option value="中级" <c:if test='${courseDto.course.courseGrade == "中级" }'>selected='selected'</c:if> >中级</option>
															<option value="高级" <c:if test='${courseDto.course.courseGrade == "高级" }'>selected='selected'</c:if> >高级</option>
														</select>
				                                    </div>
				                                    <label class="control-label">讲师登录名</label>
				                                    <div class="col-sm-4">
				                                       <input type="text" class="form-control" value="${courseDto.course.userId}" id="userId" name="userId" required placeholder="请输入讲师登录名">
				                                    </div>
				                                    <%-- <label class="control-label">时长</label>
				                                    <div class="col-sm-4">
				                                    	<input type="hidden" name="courseTotalTime" value="${courseDto.course.courseTotalTime}"/>
				                                        <input class="form-control" type="text" 
				                                        	<c:choose>
				                                        		<c:when test='${courseDto.course.courseTotalTime/60 == 0 }'>
				                                        			value='${courseDto.course.courseTotalTime%60 }分'
				                                        		</c:when>
				                                        		<c:otherwise>
				                                        			value='<fmt:parseNumber integerOnly="true" value='${courseDto.course.courseTotalTime/60 }'/>小时${courseDto.course.courseTotalTime%60 }分'
				                                        		</c:otherwise>
				                                        	</c:choose>
				                                          readonly="readonly">
				                                    </div> --%>
											</div>
											<div class="form-group clearfix"> 
													<label class="control-label">是否免费</label>
				                                    <div class="col-sm-4">
				                                       <select name="courseIsProject" class="form-control" required type="select">
															<option value="0" <c:if test='${courseDto.course.courseIsProject == 0}'>selected='selected'</c:if> >是</option>
															<option value="1" <c:if test='${courseDto.course.courseIsProject == 1}'>selected='selected'</c:if> >否</option>
														</select>
				                                    </div>
				                                    <label class="control-label">价格</label>
				                                    <div class="col-sm-4">
				                                        <input type="text" name="coursePrice" value="${courseDto.course.coursePrice}" required class="form-control">
				                                    </div>
											</div>
											<%-- <div class="form-group clearfix"> 
													<label class="control-label">讲师</label>
				                                    <div class="col-sm-4">
				                                       <input type="text" class="form-control" value="${courseDto.course.userId}" name="userId" required placeholder="请输入讲师登录名">
				                                    </div>
											</div> --%>
											<div class="form-group clearfix"> 
												<label class="control-label">概述</label> 
												<div class="col-sm-10">
												<textarea name="courseSummary" class="form-control" rows="5" cols="80" required>${courseDto.course.courseSummary}</textarea>
												</div>
											</div>
											<!-- tip提示-start -->
											<div id="_ocAlertTip" class="alert alert-success f-16" style="display: none;"></div>
											<!-- tip提示-end -->
										</div>
									
										<div class="modal-footer">
											<!-- <button type="button" class="btn btn-primary" onclick="doSave();">保存</button> -->
											<button type="submit" class="btn btn-primary" onclick="return submitBefore()">保存</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- 更新  课程信息弹出层 -end -->
					
					<div class="row-fluid">
						<ul id="myTab" class="nav nav-tabs">
							<li class="active"><a href="#section" data-toggle="tab">章节</a></li>
							<li onclick="activeComment(21,0);"><a href="#comment" data-toggle="tab">评论</a></li>
							<li><a href="#qa" data-toggle="tab">问答</a></li>
							<li><a href="#note" data-toggle="tab">笔记</a></li>
							<li><a href="#studentCount" data-toggle="tab">统计</a></li>
						</ul>
						
						<div id="myTabContent" class="tab-content" style="padding: 10px;margin-bottom: 100px;">
							<!-- 课程章节-start -->
							<div class="tab-pane fade active in" id="section">
								<!-- 循环获取--章节表数据 start -->
								<c:choose>
									<c:when test="${!empty chapterList}">
										<c:forEach items="${chapterList }" var="c" varStatus="loop">
											<div class="chapter" id="chapter-${c.chapterId }">
												<h3>
													<strong id="sectionTitle_${c.chapterId }">第${loop.count}章&nbsp;${c.chapterTitle}</strong>
													<a href="javascript:void(0);" class="chapter-edit" style="margin-right:20px;" onclick="doDeleteSection(${c.chapterId },0)">删除</a> 
													<a href="javascript:void(0);" class="chapter-edit" onclick="toEditSection(${c.chapterId },0)">修改</a> 
													<%-- <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${c.chapterId },0)">↑</a> 
													<a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${c.chapterId },1)">↓</a>  --%>
													<a href="javascript:void(0);" class="chapter-edit" onclick="addSmallChapter(${c.chapterId });">添加节</a> 
												</h3>
												<ul class="chapter-sub">
													<!-- 循环显示小节视频 start -->
													<c:if test="${!empty chapterAndSmallChapterList}">
														<c:forEach items="${chapterAndSmallChapterList }" var="cs" varStatus="loop1">
															<c:choose>
																<c:when test="${!empty cs.smallChapterList}">
																	<c:forEach items="${cs.smallChapterList }" var="small" varStatus="loop2">
																		<c:if test="${c.chapterId == small.chapterId }">
																			<li id="chapter-sub-li-${small.smallChapterId }" class="chapter-sub-li">
																				<span id="sectionSubTitle_101">${loop.count}-${loop2.count}&nbsp;${small.smallChapterTitle}&nbsp;(${small.videoTotalTime})</span>
																				<a href="javascript:void(0);" class="chapter-edit" onclick="doDeleteSection(${small.smallChapterId },1)">删除</a> 
																				<a href="javascript:void(0);" class="chapter-edit" onclick="toEditSection(${small.smallChapterId },1)">修改</a> 
																				<%-- <a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${small.smallChapterId },0)">↑</a> 
																				<a href="javascript:void(0);" class="chapter-edit" onclick="toSortSection(${small.smallChapterId },1)">↓</a>  --%>
																			</li>
																		</c:if>
																	</c:forEach>
																</c:when>
															</c:choose>
														</c:forEach>
													</c:if>
													
												</ul>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<h4>此课程暂时还没有添加章节哦！</h4>
									</c:otherwise>
								</c:choose>
								
							</div>
							
							<!-- 添加节弹出层 -start -->
							<div class="modal" id="addSmallChapterModal" tabindex="-1" role="dialog" aria-hidden="true">
								<div class="modal_wapper">
									<div class="modal-dialog w-8">
										<div class="modal-content">
											<form role="form" id="sectionForm" method="post" action="<%=request.getContextPath() %>/manager/course/addSmallChapter" enctype="multipart/form-data">
												<input type="hidden" id="chapterId" name="chapterId" value="">
												<input type="hidden" name="courseId" value="${courseDto.course.courseId}"/>
												
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-label="Close">
														<span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title">课程章节信息</h4>
												</div>
												<div class="modal-body">
													<div class="form-group">
														<label>名称</label> 
														<input type="text" class="form-control" name="smallChapterTitle" id="smallChapterTitle" placeholder="请输入名称" required>
													</div>
													<div class="form-group" id="videoUrl-group">
														<label>视频信息</label> 
														<input type="file" name="file" accept="video/*" class="form-control btn-primary" required style="margin-bottom: 5px;">
													</div>
													<!-- <div class="form-group" id="time-group">
														<label>时长</label> 
														<input type="text" class="form-control" name="smallChapterTime" id="smallChapterTime" value="00:00" placeholder="请输入分钟数" required>
													</div> -->
													<div class="form-group" id="tip-group">
														<!-- tip提示-start -->
														<div id="addSmallChapterAlertTip" class="alert alert-error" style="display: none;height:30px;color:red;">
															<span id="addSmallChapterAlertTip_msg" class="color-oc f-14"></span>
														</div>
														<!-- tip提示-end -->
													</div>
												</div>
												<div class="modal-footer">
													<button type="submit" class="btn btn-primary" onclick="return addSmallChapterValidate()">保存</button>
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<!-- 添加节弹出层 -end -->
							
							<!-- 修改章节弹出层 -start -->
							<div class="modal" id="sectionModal" tabindex="-1" role="dialog" aria-hidden="true">
								<div class="modal_wapper">
									<div class="modal-dialog w-8">
										<div class="modal-content">
											<form role="form" id="sectionForm" method="post" action="<%=request.getContextPath() %>/manager/course/updateChapter" enctype="multipart/form-data">
												<input type="hidden" id="sectionHiddenId" name="smallChapterId" value="">
												<input type="hidden" id="sectionHiddenParentId" name="chapterId" value="">
												<input type="hidden" name="courseId" value="${courseDto.course.courseId}"/>
												
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-label="Close">
														<span aria-hidden="true">×</span>
													</button>
													<h4 class="modal-title">课程章节信息</h4>
												</div>
												<div class="modal-body">
													<div class="form-group">
														<label>名称</label> 
														<input type="text" class="form-control" name="name" id="sectionName" placeholder="请输入名称" required>
													</div>
													<div class="form-group" id="videoUrl-group-update">
														<label>视频信息</label> 
														<input type="text" class="form-control" name="" id="videoUrl0" placeholder="请输入url">
														<input type="file" id="fileId" name="videoUrl" accept="video/*" class="form-control btn-primary" onchange="getfilename();" style="margin-bottom: 5px;">
													</div>
													<!-- <div class="form-group" id="time-group-update">
														<label>时长</label> 
														<input type="text" class="form-control" name="time" id="sectionTime" placeholder="请输入分钟数" required>
													</div> -->
													
													<!-- tip提示-start -->
													<div id="_ocAlertTip" class="alert alert-success f-16" style="display: none;"></div>
													<!-- tip提示-end -->
												</div>
												<div class="modal-footer">
													<!-- <button type="button" class="btn btn-primary" onclick="doSaveSection();">保存</button> -->
													<button type="submit" class="btn btn-primary">保存</button>
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<!-- 修改章节弹出层 -end -->
								
							<script type="text/javascript">
								// 更新文件名--显示到input框中
								function getfilename(){
								   	var file = $("#fileId").val();
								   	var pos = file.lastIndexOf("\\");
								   	var fileName = file.substring(pos+1); 
									// alert(fileName);
								   	$('#videoUrl0').val(fileName);
								}
							
								//编辑章节 
								function toEditSection(id,type){
									debugger;
									// type=0:代表章； type=1:代表节；id：代表章节id
									// alert("id:"+id+", type:"+type);
									if(type == 1){//节
										$('#videoUrl-group-update').show();
										$('#time-group-update').show();
									}else{
										$('#videoUrl-group-update').hide();
										$('#time-group-update').hide();
									}
									$.ajax({
										url:'${pageContext.request.contextPath}/manager/course/getChapterById',
									    type:'POST',
									    dataType:'json',
									    data:{"id":id,"type":type},
									    success:function(resp){
									    	if( resp.smallChapterTitle != null && resp.smallChapterTitle != "" ){// 小节信息
									    		$('#sectionName').val(resp.smallChapterTitle);	//设置模态框  小节名称
									    		$('#videoUrl0').val(resp.videoPath);			//设置模态框  小节视频时间
									    		$('#sectionTime').val(resp.videoTotalTime);		//设置模态框  小节视频时间
									    		$('#sectionHiddenId').val(resp.smallChapterId);	//设置模态框  隐藏小节id
									    	}else if( resp.chapterTitle != null && resp.chapterTitle != "" ){	// 章信息
									    		$('#sectionName').val(resp.chapterTitle);		//设置模态框  章名称
									    		$('#sectionHiddenParentId').val(resp.chapterId);//设置模态框  隐藏章id
									    		$('#sectionTime').removeAttr("required");
									    	}
									    	$('#sectionModal').modal('show');
									    },
									    error: function(){
									    	alert("请求失败！");	
									    }
									});
								}
								
								// 添加节
								function addSmallChapter(chapterId){
									console.log("chapterId:"+chapterId);
									$('#addSmallChapterModal').modal('show');
									$('#chapterId').val(chapterId);
								}
								// 添加节提交之前验证
								function addSmallChapterValidate(){
									var smallChapterTitle = $('#smallChapterTitle').val();
									var smallChapterTime = $('#smallChapterTime').val();
									var flag = true;
									if( smallChapterTitle == null || smallChapterTitle == "" ){
										$('#addSmallChapterAlertTip').show().fadeOut(3000);//显示模态框
										$('#addSmallChapterAlertTip_msg').html('小节名称不能为空！！');
										flag = false;
									}
									/* if( smallChapterTime == "00:00" || smallChapterTime == "" ){
										$('#addSmallChapterAlertTip').show().fadeOut(3000);//显示模态框
										$('#addSmallChapterAlertTip_msg').html('时长不能为空或零！！');
										flag = false;
									} */
									return flag;
								}
								
								//保存章节 
								/* function doSaveSection(){
									var id = $('#sectionHiddenId').val();
									var parentId = $('#sectionHiddenParentId').val();
									$('#sectionForm').ajaxSubmit({
										datatype : 'json',
										success : function(resp) {
											var resp = $.parseJSON(resp);
											if (resp.errcode == 0) {
												if(parentId == 0){//一级标题 
													$('#sectionTitle_' + id).html($('#sectionName').val());
												}else{//二级标题 
													$('#sectionSubTitle_' + id).html($('#sectionName').val() + "(" + $('#sectionTime').val() + ")");
												}
												Modal.hide('sectionModal');
											} else {
												alert('保存失败');
											}
										},
										error : function(xhr) {
										}
									});
								} */
								
								//删除章节 0-章，1-节 
								function doDeleteSection(id,type){
									// type=0:代表章； type=1:代表节；id：代表章节id
									// alert("id:"+id+", type:"+type);
									debugger;
									if( type == 0 ){
										var r = confirm("确定删除吗？将删除该章和该章下包括的所有小节和视频！");
									}else if( type == 1 ){
										var r = confirm("确定删除该小节吗？");
									}else{
										var r = confirm("确定删除吗？");
									}
									if( r == true ){// 确定删除
										$.ajax({
											url:'${pageContext.request.contextPath}/manager/course/deleteChapterById',
										    type:'POST',
										    dataType:'json',
										    data:{"id":id,"type":type},
										    success:function(resp){
										    	var success = resp.res;
										    	// alert("success:"+success);
										    	if( success == 1 ){//删除成功
										    		if(type == 0){
										    			$('#chapter-'+id).remove();
										    		}else if( type == 1 ){
										    			$('#chapter-sub-li-'+id).remove();
										    		}
										    	}else if( success == 2 ){ // 删除的小节为该章的最后一节时，将该章全部删除
										    		var chapterId = resp.chapterId;
										    		alert("chapterId:"+chapterId);
										    		$('#chapter-'+chapterId).remove();
										    	}else{
										    		alert("删除失败");
										    	}
										    },
										    error: function(){
										    	alert("删除请求失败！");
										    }
										});
									}else{// 取消删除
										console.log("取消删除");
									}
									
								}
								//排序
								function toSortSection(id,sortType){
									$.ajax({
										url:'/courseSection/sortSection.html',
									    type:'POST',
									    dataType:'json',
									    data:{"id":id,"sortType":sortType},
									    success:function(resp){
									    	var errcode = resp.errcode;
									    	if(errcode == 0){
									    		window.location.reload();
									    	}
									    }
									});
								}
							</script>
							<!-- 课程章节-end -->
												
							<!-- 评论 -start -->
							<div class="tab-pane fade" id="comment">
								<form id="queryPageForm" querypage="1">
									<input type="hidden" id="courseId" value="${courseDto.course.courseId }">
									<div id="course_note">
										<ul class="mod-post" id="comment-list">
											<!-- 循环获取--评论表数据 start -->
											<c:choose>
												<c:when test="${!empty commentsList}">
													<c:forEach items="${commentsList }" var="comments" varStatus="loop">
														 <li class="pl-list" id="comments-div-${comments.commentsId }">
												            <div class="pl-list-avator">
												                <a href="javascript:void(0)" target="_blank">
												                	<img src="/imgUrl/images/${comments.user.userPhoto }" title="${comments.user.userNickName }" alt="用户头像" width="40" height="40">
												                </a>
												            </div>
												            <div class="pl-list-main">
												                <div class="tit">
												                    <a href="javascript:void(0)" target="_blank">${comments.user.userNickName }</a>
												                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">评论道：</span>
												                </div>
												                <p class="pl-list-content">${comments.commentsContent }</p>
												                <div class="pl-list-btm clearfix">
							                   						<span title="创建时间" class="l timeago">时间:&nbsp;
							                   							<fmt:formatDate value="${comments.commentsTime}" pattern="yyyy-MM-dd HH:mm:ss" />
							                   						</span>
							                   						<c:if test="${not empty comments.chapter.chapterOrder && not empty comments.smallChapter.smallChapterOrder && not empty comments.smallChapter.smallChapterTitle }  ">
							                   							<a href="<%=request.getContextPath() %>/course/video" onclick="return startLearn()" class="from">
								                                        	源自:&nbsp;${comments.chapter.chapterOrder }-${comments.smallChapter.smallChapterOrder }&nbsp;${comments.smallChapter.smallChapterTitle }
								                                        </a>
							                   						</c:if>
												                </div>
												                <div class="comment-footer" style="margin-top: 10px;">
																	<span class="label-title" style="color: #4d555d;font-weight: 700;">操作：</span>
																	<span><a onclick="showCommentAlert(${comments.commentsId })" href="javascript:void(0);">删除</a></span>
																</div>
											            	</div>
											      		</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
													还没有人评论哦！快发一个吧^v^
													<!-- 评论表暂无数据 -->
												</c:otherwise>
											</c:choose>
											<!-- 循环获取--评论表数据 end -->
							     		</ul>
									</div>
								</form>
							
								<script type="text/javascript">
									function showCommentAlert(commentsId){
										$('#deleteCommentsAlertModal').modal('show');
										$('#commentsId').val(commentsId);
									}
									function doDeleteComments(e){
										var commentsId = e.value;
										$.ajax({
											url:'${pageContext.request.contextPath}/manager/course/commentsDelete',
										    type:'POST',
										    dataType:'json',
										    data:{"commentsId":commentsId},
										    success:function(data){
										    	var res = data.res;
										    	if(res == 1){
										    		$('#deleteCommentsAlertModal').modal('hide');
										    		$('#comments-div-'+commentsId).remove();
										    	}
										    },
										    error: function(){
										    	alert("请求失败");
										    }
										});
									}
								</script>
							</div>
							<!-- 评论 -end -->
							
							<!-- 问答 -start -->
							<div class="tab-pane fade" id="qa">
								<form id="queryPageForm" querypage="1">
									<input type="hidden" id="courseId" value="${courseDto.course.courseId }">
									<div id="course_note">
										<ul class="mod-post" id="comment-list">
											<!-- 循环获取--问题表数据 start -->
											<c:choose>
												<c:when test="${!empty questionList}">
													<c:forEach items="${questionList }" var="question" varStatus="loop">
														<li class="pl-list" id="question-div-${question.questionId }">
												            <div class="pl-list-avator">
												                <a href="${pageContext.request.contextPath }/me" onclick="return startLearn()" target="_blank">
												                	<img src="/imgUrl/images/${question.user.userPhoto }" title="${question.user.userNickName }" width="40" height="40">
												                </a>
												            </div>
												            <div class="pl-list-main">
												                <div class="tit">
												                    <a href="${pageContext.request.contextPath }/question/reply?questionId=${question.questionId}" title="标题：${question.questionTitle }" onclick="return startLearn()" target="_blank">
												                    	标题：${question.questionTitle }</a>
												                </div>
												                <p class="pl-list-content" title="内容：${question.questionContent }">内容：${question.questionContent }</p>
												                <div class="pl-list-btm clearfix">
												                	<span title="发布人" class="l timeago">发布人:&nbsp;${question.user.userNickName }</span>
						                    						<span title="创建时间" class="l timeago">时间:&nbsp;
						                    							<fmt:formatDate value="${question.questionTime}" pattern="yyyy-MM-dd HH:mm:ss" />
						                    						</span>
						                    						<c:if test="${not empty question.chapter.chapterOrder && not empty question.smallChapter.smallChapterOrder && not empty question.smallChapter.smallChapterTitle }  ">
								                                        <a href="${pageContext.request.contextPath }/course/video" onclick="return startLearn()" class="from">
								                                        	源自:&nbsp;${question.chapter.chapterOrder }-${question.smallChapter.smallChapterOrder }&nbsp;${question.smallChapter.smallChapterTitle }
								                                        </a>
							                                        </c:if>
												                </div>
												                <div class="comment-footer" style="margin-top: 10px;">
																	<span class="label-title" style="color: #4d555d;font-weight: 700;">操作：</span>
																	<span><a onclick="showQuestionAlert(${question.questionId })" href="javascript:void(0);">删除</a></span>
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
								</form>
							
								<script type="text/javascript">
									function showQuestionAlert(questionId){
										$('#deleteQuestionAlertModal').modal('show');
										$('#questionId').val(questionId);
									}
									function doDeleteQuestion(e){
										var questionId = e.value;
										$.ajax({
											url:'${pageContext.request.contextPath}/manager/course/questionDelete',
										    type:'POST',
										    dataType:'json',
										    data:{"questionId":questionId},
										    success:function(data){
										    	var res = data.res;
										    	if(res == 1){
										    		$('#deleteQuestionAlertModal').modal('hide');
										    		$('#question-div-'+questionId).remove();
										    	}
										    },
										    error: function(){
										    	alert("请求失败");
										    }
										});
									}
								</script>
							</div>
							<!-- 问答 -end -->
							
							<!-- 笔记 start -->
							<div class="tab-pane fade" id="note">
								<form id="queryPageForm" querypage="1">
									<input type="hidden" id="courseId" value="${courseDto.course.courseId }">
									<div id="course_note">
										<ul class="mod-post" id="comment-list">
											<!-- 循环获取--笔记表数据 start -->
							                <c:choose>
												<c:when test="${!empty noteList}">
													<c:forEach items="${noteList }" var="note" varStatus="loop">
														<li class="pl-list" id="note-div-${note.noteId }">
												            <div class="pl-list-avator">
												                <a href="${pageContext.request.contextPath }/me" onclick="return startLearn()" target="_blank">
												                	<img src="/imgUrl/images/${note.user.userPhoto }" title="${note.user.userNickName }" width="40" height="40">
												                </a>
												            </div>
												            <div class="pl-list-main">
												                <div class="tit">
												                    <a href="${pageContext.request.contextPath }/me" onclick="return startLearn()" target="_blank">${note.user.userNickName }</a>
												                    <span style="margin-left:5px; font-size: 12px; color: #b5b9bc;">的笔记：</span>
												                </div>
												                <p class="pl-list-content">${note.noteContent }</p>
												                <div class="pl-list-btm clearfix">
						                    						<span title="创建时间" class="l timeago">时间:&nbsp;
						                    							<fmt:formatDate value="${note.noteTime}" pattern="yyyy-MM-dd HH:mm:ss" />
						                    						</span>
						                    						<c:if test="${not empty note.chapter.chapterOrder && not empty note.smallChapter.smallChapterOrder && not empty note.smallChapter.smallChapterTitle }  ">
								                                        <a href="${pageContext.request.contextPath }/course/video" onclick="return startLearn()" class="from">
								                                        	源自:&nbsp;${note.chapter.chapterOrder }-${note.smallChapter.smallChapterOrder }&nbsp;${note.smallChapter.smallChapterTitle }
								                                        </a>
								                                    </c:if>
												                </div>
												                <div class="comment-footer" style="margin-top: 10px;">
																	<span class="label-title" style="color: #4d555d;font-weight: 700;">操作：</span>
																	<span><a onclick="showNoteAlert(${note.noteId })" href="javascript:void(0);">删除</a></span>
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
								</form>
								<script type="text/javascript">
									function showNoteAlert(noteId){
										$('#deleteNoteAlertModal').modal('show');
										$('#noteId').val(noteId);
									}
									function doDeleteNote(e){
										var noteId = e.value;
										$.ajax({
											url:'${pageContext.request.contextPath}/manager/course/noteDelete',
										    type:'POST',
										    dataType:'json',
										    data:{"noteId":noteId},
										    success:function(data){
										    	var res = data.res;
										    	if(res == 1){
										    		$('#deleteNoteAlertModal').modal('hide');
										    		$('#note-div-'+noteId).remove();
										    	}
										    },
										    error: function(){
										    	alert("请求失败");
										    }
										});
									}
								</script>
							</div>
							<!-- 笔记 end -->
							
							
							<!-- 报表 - start -->
							<div class="tab-pane fade" id="studentCount" style="height:400px; width: 80%; margin: 50px auto;">
								<input id="commentsNumber" type="hidden" value="${courseMessageDto.commentsNumber }" />
								<input id="questionNumber" type="hidden" value="${courseMessageDto.questionNumber }" />
								<input id="replyNumber" type="hidden" value="${courseMessageDto.replyNumber }" />
								<input id="noteNumber" type="hidden" value="${courseMessageDto.noteNumber }" />
								<div id="echarts-content" style="height:400px; width: 900px;" >
									
								</div>
								<script type="text/javascript">
									var commentsNumber = $("#commentsNumber").val();
									var questionNumber = $("#questionNumber").val();
									var replyNumber = $("#replyNumber").val();
									var noteNumber = $("#noteNumber").val();
									var data = new Array(commentsNumber,questionNumber,replyNumber,noteNumber);
									var myChart = echarts.init(document.getElementById("echarts-content"));//初始化画布
									var option = {
										    title:{  
										        text:'该课程的数据统计图',
										        left: 'center',
										        top:'1%'
										    },
										    color:[ '#0089D2' ],
										    tooltip : {/* 鼠标移动上去显示的内容 */
										        trigger: 'axis',
										        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
										            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
										        },
										        formatter:'{b}:{c}个',
										    },
										    label:{/*柱形图上面的显示数字  */
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
										        data: ['评论', '问题', '回答', '笔记'],
										        name: '类型',
										    },
										    yAxis: {
										        type: 'value',
										        name: '数值',
										    },
										    series: [{
										        data: data,
										        type: 'bar',	//条形图
										        barWidth: '50px'
										    }]
										};
	
									myChart.setOption(option);
								</script>
							</div>
							<!-- 报表 - end -->
						
						<!-- 删除评论弹出层 alert 信息 start -->
						<div class="modal fade" id="deleteCommentsAlertModal" tabindex="-1" aria-hidden="true" style="display: none;">
							<div class="modal_wapper">
								<div class="modal-dialog w-4">
									<div class="modal-content">
										<div class="modal-header">
											<div class="modal-title f-16">提示信息</div>
										</div>
										<div class="modal-body">
											<div><span class="color-oc f-16 oc-content">确定删除?</span></div>
										</div>
										<div class="modal-footer modal-center">
											<button type="button" class="btn btn-primary oc-ok" id="commentsId" value="" onclick="doDeleteComments(this)">确 定</button>
											<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 删除评论弹出层 alert 信息 end -->
						
						<!-- 删除问答弹出层 alert 信息 start -->
						<div class="modal fade" id="deleteQuestionAlertModal" tabindex="-1" aria-hidden="true" style="display: none;">
							<div class="modal_wapper">
								<div class="modal-dialog w-4">
									<div class="modal-content">
										<div class="modal-header">
											<div class="modal-title f-16">提示信息</div>
										</div>
										<div class="modal-body">
											<div><span class="color-oc f-16 oc-content">确定删除?</span></div>
										</div>
										<div class="modal-footer modal-center">
											<button type="button" class="btn btn-primary oc-ok" id="questionId" value="" onclick="doDeleteQuestion(this)">确 定</button>
											<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 删除问答弹出层 alert 信息 end -->
						
						<!-- 删除笔记弹出层 alert 信息 start -->
						<div class="modal fade" id="deleteNoteAlertModal" tabindex="-1" aria-hidden="true" style="display: none;">
							<div class="modal_wapper">
								<div class="modal-dialog w-4">
									<div class="modal-content">
										<div class="modal-header">
											<div class="modal-title f-16">提示信息</div>
										</div>
										<div class="modal-body">
											<div><span class="color-oc f-16 oc-content">确定删除?</span></div>
										</div>
										<div class="modal-footer modal-center">
											<button type="button" class="btn btn-primary oc-ok" id="noteId" value="" onclick="doDeleteNote(this)">确 定</button>
											<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 删除笔记弹出层 alert 信息 end -->
						
					</div>
					
				</div>
			</div>
			<!-- 右边内容 end -->
		</div>
		

		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
</div>		
</body>
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
		
		//过滤二级分类 
		filterSubClassify($('#classify').val());//第一次加载的时候过滤
		$('#classify').change(function(){
			filterSubClassify($('#classify').val());
		});
		
		// 设置选中一级分类二级分类的下拉框
		var oneClassify = $('#oneClassifyCode').val();
		var twoClassify = $('#twoClassifyCode').val();
		$('#subClassify').find("option").each(function(i,item){
			if($(item).val() == twoClassify){
				$('#subClassify').val($(item).val());//设置当前课程 二级分类下拉框的选中值
			}
		});
		$('#classify').find("option").each(function(i,item){// i是选择器的 index 位置，item是当前的元素
			if($(item).val() == oneClassify){
				$('#classify').val($(item).val());//设置当前课程 一级分类下拉框的选中值
			}
		});
		
	});
	
	// 更新课程信息之前校验讲师登录名是否存在
	function submitBefore(){
		// 获取到教师登录名id,判断教师登录名id是否存在
		var userId = $('#userId').val();
		// alert(userId);
		var flag = true;
		$.ajax({
			url: '${pageContext.request.contextPath}/manager/course/addValidate',
			type:'POST',
		    dataType:'json',
		    async: false,	//同步
		    data:{"userId":userId},
		    success:function(result){
		    	if( result.res == 0 ){
		    		alert('保存失败，请输入正确的 讲师登录名 (如 zhangsan )');
		    		flag = false;
		    		$('#userId').focus();
		    	}
		    },
		    error: function(){
		    	
		    }
		});
		return flag;
	}
	
	//过滤二级分类 
	function filterSubClassify(classify){
		var flag = false;
		$('#subClassify').find("option").each(function(i,item){
			if($(item).attr('parentCode') == classify){
				if(flag == false){
					$('#subClassify').val($(item).attr('value'));//默认选中第一个
					flag = true;
				}
				$(item).show();
			}else{
				$(item).hide();
			}
		});
	}
</script>
</html>
	