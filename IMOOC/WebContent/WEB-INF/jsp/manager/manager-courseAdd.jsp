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
	<title>慕课网后台管理-课程管理--添加课程</title>

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
					<div class="block span6">
						<div class="block-body collapse in" >
							<div>
								<h3 style="margin-bottom: 30px;">添加课程信息：
									<a href="<%=request.getContextPath() %>/manager/course" style="float: right;font-size: 18px;margin-right: 20px;">返回主页</a>
								</h3>
							</div>
							<!-- <form role="form" id="courseForm" method="post" action="/manager/course/add" enctype="multipart/form-data"> -->
							<form role="form" id="courseForm" method="post" action="<%=request.getContextPath() %>/manager/course/add">
									
									<div class="form-group clearfix"> 
										<label class="control-label">名称</label> 
										<div class="col-sm-10">
										<input type="text" class="form-control" name="courseName" id="name" placeholder="请输入名称" required>
										</div>
									</div>
									<div class="form-group clearfix"> 
											<label class="control-label">分类</label>
		                                    <div class="col-sm-4">
		                                        <select id="classify" name="oneCode" class="form-control" type="select">
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
		                                        <select id="subClassify" name="twoCode" class="form-control" type="select">
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
											<label class="control-label">是否免费</label>
		                                    <div class="col-sm-4">
		                                       <select name="courseIsProject" class="form-control" type="select">
													<option value="0">是</option>
													<option value="1">否</option>
												</select>
		                                    </div>
		                                    <label class="control-label">价格</label>
		                                    <div class="col-sm-4">
		                                        <input type="text" value="0" name="coursePrice" class="form-control" required>
		                                    </div>
									</div>
									<div class="form-group clearfix"> 
											<label class="control-label">级别</label>
		                                    <div class="col-sm-4">
		                                       <select name="courseGrade" class="form-control" type="select">
		                                       		<option value="入门">入门</option>
													<option value="初级">初级</option>
													<option value="中级">中级</option>
													<option value="高级">高级</option>
												</select>
		                                    </div>
									</div>
									<div class="form-group clearfix"> 
											<label class="control-label">讲师<span style="color:red;">*</span></label>
		                                    <div class="col-sm-4">
		                                       <input type="text" class="form-control" id="userId" name="userId" placeholder="请输入讲师登录名" required>
		                                    </div>
									</div>
									<div class="form-group clearfix"> 
										<label class="control-label">概述</label> 
										<div class="col-sm-10">
										<textarea name="courseSummary" class="form-control" rows="6" cols="60" required></textarea>
										</div>
									</div>
									<div class="form-group clearfix" style="height:50px;"> 
										<label class="control-label"></label>
		                                <div class="col-sm-4">
		                                   <!-- <input type="button" class="search-btn" onclick="doSave();" value=" 保存基本信息" style="float:left;height:40px;"> -->
		                                   <input type="submit" class="search-btn" onclick="return submitBefore()" value=" 保存基本信息" style="float:left;height:40px;">
		                                   <div id="successAlert" class="alert alert-success" style="display:none;float:left;margin-left:50px;margin-top:0px;">
												<span id="successAlert_msg" class="color-oc f-16">保存成功！</span>
											</div>
		                                </div>
									</div>
									<div style="margin-bottom:5px;"><span id="failureMsg" style="color:red;"></span></div>
								</form>
						</div>
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
		$("#dashboard-menu li:eq(1)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
</script>
<script type="text/javascript">
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
		$(function(){
			filterSubClassify($('#classify').val());//第一次加载的时候过滤
			$('#classify').change(function(){
				filterSubClassify($('#classify').val());
			});
		});
	
		// 添加课程信息之前校验讲师登录名是否存在
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
		
/*---------------------暂未使用------------------------------------------------------*/
		function activeComment(courseId,type){
			var elId = 'comment';
			if(type == 1){
				elId = 'qa';
			}
			var url = '/courseComment/pagelist.html';
			$("#" + elId).load(
				url,
				{'courseId':courseId,'type':type,'pageNum':1},
				function(){ }
			);
		}
		
		//修改课程基本信息
		function toEdit(id){
			$.ajax({
				url:'/course/getById.html',
			    type:'POST',
			    dataType:'json',
			    data:{"id":id},
			    success:function(resp){
			    	var errcode = resp.errcode;
			    	if(errcode == 0){
			    		Modal.show('myModal');
			    		$("#courseForm").fill(resp.data);
			    		$('#coursePicture').attr('src',resp.data.picture)
			    	}
			    }
			});
		}
		
		//选择图片 
		function doUpload(){
			$('#pictureImg').click();
		}
		//选择图片
		function photoImgChange(){
			var img = $('#pictureImg').val();
			if(oc.photoValid(img)){
				oc.previewUploadImg('pictureImg','coursePicture');
				$('#coursePicture').show();
				$('#imgErrSpan').html('');
				return;
			}else{
				$('#imgErrSpan').html('&nbsp;请选择png,jpeg,jpg格式图片');
				$('#coursePicture').val('');
			}
		}
		
		//保存
		function doSave(){
			$('#courseForm').ajaxSubmit({
				datatype : 'json',
				success : function(resp) {
					var resp = $.parseJSON(resp);
					if (resp.errcode == 0) {
						window.location.reload();
					} else {
						alert('保存失败，请输入正确的 教师登录名 (如 wangyangming )');
					}
				},
				error : function(xhr) {
				}
			});
		}
		
	</script>
</html>
	