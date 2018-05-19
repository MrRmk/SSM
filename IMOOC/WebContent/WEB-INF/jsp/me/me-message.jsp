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
	<!-- me页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
</head>

<body style="padding-right:0px;">
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
					<div class="setting-right">
						<div style="padding-top: 10px;">
							<span class="f-16"><strong>个人信息</strong>
								<!-- 按钮触发模态框 -->
								<a href="javascript: void(0);" class="pull-right js-edit-info" data-toggle="modal" data-target="#myModal" >
									<span class="glyphicon glyphicon-pencil" style="font-size: 11px;margin-right: 0px;color: #337ab7;"></span>
									<span class="message-edit">编辑</span>
								</a>
							</span>
						</div>
						<div class="split-line" style="margin: 20px 0px;"></div>
						
						<div class="oc-form" >
								<%-- <div>
									<input type="file" id="pictureImg" name="userPhoto" style="display: none;" onchange="photoImgChange();">
									<img id="user_header" src="/imgUrl/images/${user.userPhoto }" title="${question.user.userNickName }" style="height:96px;">
									<div style="margin:15px 0px;" class="clearfix">
										<a href="javascript:void(0);" onclick="doUpload();" style="float:left;" class="btn">更换头像</a>
										<span id="imgErrSpan" style="color:red;font-weight:normal;float:left;margin-left:10px;margin-top:5px;"></span>
									</div>
								</div> --%>
							<ul>
								<li><label>账号</label> 
									<input name="userId" value="${user.userId }" type="text" readonly="readonly" class="input-text2" />
								</li>
								<li><label>密码</label> 
									<input name="userPassword" value="${user.userPassword }" type="password" readonly="readonly" class="input-text2">
								</li>
								<li><label>昵称</label> 
									<input name="userNickName" value="${user.userNickName }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>姓名</label> 
									<input name="userRealName" value="${user.userRealName }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>性别</label> 
									<input name="userSex" value="${user.userSex }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>职位</label>
									<input name="userPosition" value="${user.userPosition }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>学校</label> 
									<input name="userSchool" value="${user.userSchool }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>资格证书</label> 
									<input name="userQualification" value="${user.userQualification }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>学历</label> 
									<input name="userEducation" value="${user.userEducation }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>qq</label>
									<input name="userQQ" value="${user.userQQ }" type="text" readonly="readonly" class="input-text2">
								</li>
								<li><label>个性签名</label>
									<input name="userSummary" value="${user.userSummary }" type="text" readonly="readonly" class="input-text2">
								</li>
								<!-- <li class="clearfix" style="margin-top: 50px;padding-left: 170px;">
									<div class="btn" onclick="infoSubmit();">保存</div>
								</li> -->
							</ul>	
								<!-- <li>
									<div id="myAlert" class="alert alert-success" style="display: none;">
										<span id="myAlert_msg" class="color-oc f-16">保存成功！</span>
									</div>
								</li> -->
								
							
								<!-- 模态框（Modal） -->
								<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<!-- 表单 -->
										<form class="oc-form" id="infoForm" method="post" action="<%=request.getContextPath() %>/me/message/update">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
													&times;
												</button>
												<h4 class="modal-title" id="myModalLabel">
													编辑个人信息
												</h4>
											</div>
											<div class="modal-body">
											<ul>
												<li><label>账号</label> 
													<input name="userId" value="${user.userId }" type="text" readonly="readonly" class="input-text2" style="background-color: #d9dde1;" />
												</li>
												<li><label>密码</label> 
													<input name="userPassword" value="${user.userPassword }" type="password" class="input-text2">
												</li>
												<li><label>昵称</label> 
													<input name="userNickName" value="${user.userNickName }" type="text" class="input-text2">
												</li>
												<li><label>姓名</label> 
													<input name="userRealName" value="${user.userRealName }" type="text" class="input-text2">
												</li>
												<li><label>性别</label> 
													<select class="input-select" name="userSex">
														<option value="男" <c:if test='${user.userSex == "男"}'>selected='selected'</c:if> >男</option>
														<option value="女" <c:if test='${user.userSex == "女"}'>selected='selected'</c:if> >女</option>
													</select>
												</li>
												<li><label>职位</label>
													<select class="input-select" name="userPosition">
														<option value="学生" <c:if test='${user.userPosition == "学生"}'>selected='selected'</c:if> >学生</option>
														<option value="讲师" <c:if test='${user.userPosition == "讲师"}'>selected='selected'</c:if> >讲师</option>
														<option value="前端开发工程师" <c:if test='${user.userPosition == "前端开发工程师"}'>selected='selected'</c:if> >前端开发工程师</option>
														<option value="后端开发工程师" <c:if test='${user.userPosition == "后端开发工程师"}'>selected='selected'</c:if> >后端开发工程师</option>
														<option value="UI设计师" <c:if test='${user.userPosition == "UI设计师"}'>selected='selected'</c:if> >UI设计师</option>
														<option value="测试工程师" <c:if test='${user.userPosition == "测试工程师"}'>selected='selected'</c:if> >测试工程师</option>
														<option value="其他" <c:if test='${user.userPosition == "其他"}'>selected='selected'</c:if> >其他</option>
													</select>
												</li>
												<li><label>学校</label> 
													<input name="userSchool" value="${user.userSchool }" type="text" class="input-text2">
												</li>
												<li><label>资格证书</label> 
													<input name="userQualification" value="${user.userQualification }" type="text" class="input-text2">
												</li>
												<li><label>学历</label> 
													<select class="input-select" name="userEducation">
														<option value="本科" <c:if test='${user.userEducation == "本科"}'>selected='selected'</c:if> >本科</option>
														<option value="硕士" <c:if test='${user.userEducation == "硕士"}'>selected='selected'</c:if> >硕士</option>
														<option value="博士" <c:if test='${user.userEducation == "博士"}'>selected='selected'</c:if> >博士</option>
														<option value="博士后" <c:if test='${user.userEducation == "博士后"}'>selected='selected'</c:if> >博士后</option>
														<option value="大专" <c:if test='${user.userEducation == "大专"}'>selected='selected'</c:if> >大专</option>
														<option value="其他" <c:if test='${user.userEducation == "其他"}'>selected='selected'</c:if> >其他</option>
													</select>
												</li>
												<li><label>qq</label>
													<input name="userQQ" value="${user.userQQ }" type="text" class="input-text2">
												</li>
												<li><label>个性签名</label>
													<input name="userSummary" value="${user.userSummary }" type="text" class="input-text2">
												</li>
											</ul>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
												<button type="submit" class="btn btn-primary">确定</button>
											</div>
										</div><!-- /.modal-content -->
										</form>
									</div><!-- /.modal -->
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
	<!-- JavaScript 放置在文档最后面可以使页面加载速度更快 -->
	<script src="<%=request.getContextPath() %>/static/js/jquery-3.1.1.js"></script>
	<script src="<%=request.getContextPath() %>/static/BootStrap/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		//设置头部导航栏样式
		$(".nav .item:eq(4)").addClass('on');
		// 设置左边导航栏样式
		$('.user-menu-nav-block a:eq(3)').find('li').addClass('user-menu-nav-cur');
		
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
</script>
<script type="text/javascript">
		
	function doUpload(){
		$('#pictureImg').click();
	}
	function photoImgChange(){
		var img = $('#pictureImg').val();
		if(oc.photoValid(img)){
			oc.previewUploadImg('pictureImg','user_header');
			$('#user_header').show();
			$('#imgErrSpan').html('');
			return;
		}else{
			$('#imgErrSpan').html('&nbsp;请选择png,jpeg,jpg格式图片');
			$('#pictureImg').val('');
		}
	}

	function infoSubmit(){
		$('#infoForm').ajaxSubmit({
			datatype : 'json',
			success : function(resp) {
				var resp = $.parseJSON(resp);
				if (resp.errcode == 0) {
					$("#myAlert").show().fadeOut(2500);//显示模态框
				} else {
					$("#myAlert").show().fadeOut(2500);//显示模态框
				}
			},
			error : function(xhr) {
			}
		});
	}
</script>
</html>