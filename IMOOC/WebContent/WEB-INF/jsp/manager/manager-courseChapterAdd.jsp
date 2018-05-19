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
	<title>慕课网后台管理-课程管理---章节添加</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- manager页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager-index.css">
	<!-- course页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/course-learn.css">
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
															<img src="<%=request.getContextPath() %>/static/images/course.png" style="width: 180px;height:100px;float: left;">
														</a>
													</p>
													<div class="ml-15 w-350" style="float:left;">
														<a href="javascript:void(0)">
															<p class="ellipsis" title="${courseDto.course.courseName }">
																<strong>${courseDto.course.courseName }</strong>
															</p>
														</a>
														<p class="ellipsis-multi h-40" title="简介：${courseDto.course.courseSummary }">
															简介：${courseDto.course.courseSummary }
														</p>
													</div> 
													<p></p>
												</td>
												<td>
													<p>
														<fmt:parseNumber integerOnly="true" value="${courseDto.course.courseTotalTime/60 }" />
														小时${courseDto.course.courseTotalTime%60 }分
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
													<!-- 设置课程id 隐藏域 -->
													<input type="hidden" id="courseId" value="${courseDto.course.courseId }" />
													<p><a href="<%=request.getContextPath() %>/manager/course/details?courseId=${courseDto.course.courseId }">返回</a></p> 
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
					
					<div class="row-fluid">
						<form action="<%=request.getContextPath() %>/manager/course/chapterUpload" method = "post" enctype="multipart/form-data">
							<ul id="myTab" class="nav nav-tabs">
								<li class="active">
									<a href="#section" data-toggle="tab">章节</a>
								</li>
								<li>
									<input style="margin-top:5px;" type="submit" onclick="return saveCourseSection();" class="search-btn" value="保存章节信息">
								</li>
								<li>
									<div id="sectionTipsAlert" style="display:none;float:left;margin-left:50px;margin-top:10px;height:30px;color:red;">
										<span id="sectionTipsAlert_msg" class="color-oc f-14"></span>
									</div>
								</li>
							</ul>
							
							
							<!-- 设置课程id 隐藏域 -->
							<input type="hidden" name="courseId" value="${courseDto.course.courseId }" />
							<div id="myTabContent" class="tab-content" style="padding: 10px;">
								<div id="demoCourseSectionDiv" sid="demoCourseSectionDiv" style="padding:20px;border:1px solid #CCC; margin-bottom:20px;display:block;">
									<div class="form-group clearfix"> 
										<label class="control-label">章名称</label> 
										<div class="col-sm-8">
											<input type="text" class="form-control" name="sectionName" placeholder="请输入名称">
										</div>
										<div class="col-sm-1" style="padding-left:25px;">
											<input type="button" onclick="addSection(this);" class="search-btn" value="+ 添加节">
										</div>
									</div>
									<div id="demoSectionDiv" sid="demoSectionDiv" class="form-group clearfix"> 
										<label class="control-label" style="margin-left:55px;">节信息</label> 
										<div class="col-sm-7">
											<input type="text" class="form-control" name="subSectionName" placeholder="请输入节名称" style="margin-bottom:5px;">
											<input type="file" accept="video/*" name="videoUrl" id="videoUrl" class="form-control btn-primary" style="margin-bottom: 5px;">
											<!-- <input type="text" class="form-control" name="time" id="videoTime" value="00:00" placeholder="请输入时长 00:00" style="margin-bottom:5px;"> -->
										</div>
										<div class="col-sm-1">
											<input type="button" onclick="deleteSection(this);" class="search-btn" value="- 删除节">
										</div>
									</div>
								</div>
								
							</div>
						</form>
					</div>
					
				</div>
			</div>
			<!-- 右边content内容 end -->
			
			<!-- 隐藏的视频 -->
			<!-- <video style="display:block; width:200px;height:100px;" controls="controls" id="aa" oncanplaythrough="myVideoFunction(this)">
		   	</video> -->
			
			<!-- 添加章节 demo div  start -->
			<div id="demoSection4Clone">
				<div id="demoCourseSectionDiv" sid="demoCourseSectionDiv" style="padding:20px;border:1px solid #CCC; margin-bottom:20px;display:none;">
					<div class="form-group clearfix"> 
						<label class="control-label">章名称</label> 
						<div class="col-sm-8">
							<input type="text" class="form-control" name="sectionName" placeholder="请输入名称">
						</div>
						<div class="col-sm-1" style="padding-left:25px;">
							<input type="button" onclick="addSection(this);" class="search-btn" value="+ 添加节">
						</div>
					</div>
					
					<div id="demoSectionDiv" sid="demoSectionDiv" class="form-group clearfix"> 
						<label class="control-label" style="margin-left:55px;">节信息</label> 
						<div class="col-sm-7">
							<input type="text" class="form-control" name="subSectionName" placeholder="请输入节名称" style="margin-bottom:5px;">
							<input type="file" name="videoUrl" id="videoUrl" class="form-control btn-primary" style="margin-bottom: 5px;">
							<!-- <input type="text" class="form-control" name="time" id="videoTime" value="00:00" placeholder="请输入时长 00:00" style="margin-bottom:5px;"> -->
						</div>
						<div class="col-sm-1">
							<input type="button" onclick="deleteSection(this);" class="search-btn" value="- 删除节">
						</div>
					</div>
					
				</div>
			</div>
			<!-- 添加章节 demo div  end -->
			
			<!-- 弹出层 alert 信息 start -->
			<div class="modal" id="_ocDialogModal" tabindex="-1" aria-hidden="true">
				<div class="modal_wapper small">
					<div class="modal-dialog w-4">
						<div class="modal-content">
							<div class="modal-header">
								<div class="modal-title f-16">提示信息</div>
							</div>
							<div class="modal-body">
								<div><span class="color-oc f-16 oc-content"></span></div>
							</div>
							<div class="modal-footer modal-center">
								<button type="button" class="btn btn-primary oc-ok">确 定</button>
								<button type="button" class="btn btn-default oc-cancel">取 消</button>
							</div>
							
						</div>
					</div>
				</div>
			</div>
			<!-- 弹出层 alert 信息 end -->
			
			<script type="text/javascript">
				//上传文件后，把视频文件显示在页面隐藏的地方----用来获取视频的时长
				/* function changeFile(e){
					debugger;
					var video = e.files[0];
					var url = null;
					if (window.createObjectURL != undefined) { 		// basic
						url = window.createObjectURL(video);
					} else if (window.webkitURL != undefined) { 	// webkit or chrome
						url = window.webkitURL.createObjectURL(video);
					} else if (window.URL != undefined) { 			// mozilla(firefox)
						url = window.URL.createObjectURL(video);
					} 
					
					var url1 = $('#videoUrl').val();
					console.log(url1);
					// var url = window.URL.createObjectURL(video);
					console.log(url);
					$('#aa').src = url;
				}
				//当视频可以正常播放且无需停顿时执行
				//oncanplaythrough 事件在视频/音频（audio/video）可以正常播放且无需停顿和缓冲时触发。
				function myVideoFunction(e){
					debugger;
					alert("1");
					var hour = parseInt((e.duration)/3600);
					var minute = parseInt((e.duration%3600)/60);
					var second = parseInt(e.duration%60);
					console.log(Math.floor(e.duration));
					console.log("这段视频的时长为："+hour+"小时，"+minute+"分，"+second+"秒");
					
					if( hour == 0 ){
						var time = Appendzero(minute)+":"+Appendzero(second);
						$('#videoTime').val(time);
					}else{
						var time = Appendzero(hour)+":"+Appendzero(minute)+":"+Appendzero(second);
						$('#videoTime').val(time);
					}
				}
				
				//时间不足两位补 0
				function Appendzero(obj)  
			    {  
			        if(obj<10) 
			        	return "0" +""+ obj;  
			        else 
			        	return obj;  
			    }  */
			
				//添加章
				function addCourseSection(){
					var tmpDiv = $('#demoSection4Clone').clone().html();
					tmpDiv = tmpDiv.replace('display:none','display:block');
					$('#myTabContent').append(tmpDiv);
				}
				
				//删除章
				function deleteCourseSection(el){
					$(el).parent().parent().parent().remove();
				}
				
				//添加节
				function addSection(el){
					var sectionDiv = $('#demoSectionDiv').clone();
					$(el).parent().parent().parent().append(sectionDiv);
				}
				
				//删除节
				function deleteSection(el){
					$(el).parent().parent().remove();
				}
				
				//保存章节信息
				function saveCourseSection(){
					debugger;
					var flag = true;
					var courseId = $('#courseId').val();
					if(courseId == ''){
						$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
						$("#sectionTipsAlert_msg").html('请先保存课程基本信息');
						flag = false;
						return;
					}
					
					var sectionDivs = $('#myTabContent').find("div[sid='demoCourseSectionDiv']");// 章div 数组对象
					var batchSections = [];
					//章
					$.each(sectionDivs,function(i,item){
						var sectionName = $(item).find("input[name='sectionName']").val();	// 章 名称
						if(sectionName && $.trim(sectionName) != ''){
							var obj = {};
							obj.name = $.trim(sectionName);
							obj.courseId = courseId;
							obj.sections = [];
							//节
							var subSectionDivs = $(item).find("div[sid='demoSectionDiv']");
							$.each(subSectionDivs,function(j,subItem){
								var subSectionName = $(subItem).find("input[name='subSectionName']").val();	// 节名称
								var videoUrl = $(subItem).find("input[name='videoUrl']").val();				// 视频文件
								/* var time = $(subItem).find("input[name='time']").val();						// 视频时间
								//正则表达式验证time
								var regTime = RegExp(/^([0-5][0-9]):([0-5][0-9])$/);
								if (!regTime.test(time)) {//如果验证不通过 	//test() 方法用于检测一个字符串是否匹配某个模式.
									time = "00:00";
								} */
								if(subSectionName && $.trim(subSectionName) != ''){
									var subObj = {};
									subObj.name = $.trim(subSectionName);
									subObj.videoUrl = $.trim(videoUrl);
									// subObj.time = $.trim(time);
									obj.sections.push(subObj);
								}else{
									$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
									$("#sectionTipsAlert_msg").html('节名称不能为空！！请填写！！');
									flag = false;
									return;
								}
								if( videoUrl.length == 0 ){	
									$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
									$("#sectionTipsAlert_msg").html('视频文件不能为空！！请上传！！');
									flag = false;
									return;
								}
								/* if( time == "00:00" || $.trim(time) == "00:00" ){
									$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
									$("#sectionTipsAlert_msg").html('时间不能为空！！请填写！！！');
									flag = false;
									return;
								}
								if( $.trim(time) == '' || time == null ){
									$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
									$("#sectionTipsAlert_msg").html('时间不能为空！！请填写！！');
									flag = false;
									return;
								} */
							});
							batchSections.push(obj);
						}else{
							$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
							$("#sectionTipsAlert_msg").html('章名称不能为空！！请填写！！');
							flag = false;
							return;
						}
					});
					if(batchSections.length == 0){
						$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
						$("#sectionTipsAlert_msg").html('请填写章节信息');
						flag = false;
						return false;
					}
					// 判断是否返回
					if( flag ){
						return true;
					}else{
						return false;
					}
					
				}
				
				//导入章节
				function importCourseSection(){
					var courseId = $('#courseId').val();
					if(courseId == ''){
						$("#sectionTipsAlert").show().fadeOut(3000);//显示模态框
						$("#sectionTipsAlert_msg").html('请先保存课程基本信息');
						return;
					}
					Modal.show('courseSectionModal');
				}
				
				//文件验证
				function fileChange(){
					var excelFile = $('#courseSectionExcel').val();
					if(oc.excelValid(excelFile)){
						return true;
					}else{
						$('#_ocAlertTip').show();
						return false;
					}
				}
				
				//导入文件
				function doImport(){
					if(fileChange()){//验证文件类型 
						var courseId = $('#courseId').val();
						$('#importCourseSectionForm').ajaxSubmit({
							datatype : 'json',
							data:{"courseId":courseId},
							success : function(resp) {
								var resp = $.parseJSON(resp);
								if (resp.errcode == 0) {
									//保存成功，跳转到详情页
						    		window.location.href='/course/read.html?id=' + courseId;
								} else {
									alert('保存失败');
								}
							},
							error : function(xhr) {
							}
						});
					}
				}
				
			</script>
	
	
		</div>
		<!-- 底部 页面 start -->
		<jsp:include   page="../footer.jsp" flush="true"/>
		<!-- 底部 页面 end -->
</div>		
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="${pageContext.request.contextPath }/static/js/jquery-3.1.1.js"></script>
	<script src="${pageContext.request.contextPath }/static/BootStrap/js/bootstrap.min.js"></script>
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
	});
</script>
</html>
	