<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网后台管理-管理员个人信息管理</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
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
			
					<form id="queryPageForm" class="mt-15" action="<%=request.getContextPath()%>/manager/user" method="get">
						<div class="block span6">
							<a class="block-heading f-14" data-toggle="collapse">用户管理</a>
							<div class="block-body collapse in">
								<p>
									<select name="userStatus" class="search-select form-control" >
										<option value="-1" <c:if test='${userStatus == -1}'>selected='selected'</c:if> >全部</option>
										<option value="1" <c:if test='${userStatus == 1}'>selected='selected'</c:if> >可用</option>
										<option value="0" <c:if test='${userStatus == 0}'>selected='selected'</c:if> >禁用</option>
									</select>
								</p>
								<p>
									<input name="userId" type="text" value="${userId }" class="search-text form-control" placeholder="请输入登录名/职位/学校">
								</p>
								<p>
									<input type="submit" onclick="return submitBefore()" class="btn btn-primary btn-search" style="margin-left: 10px;" value="搜索">
								</p>
							</div>
						</div>
		
						<div class="row-fluid">
							<div class="block span6">
								<div id="tablewidget" class="block-body collapse in">
									<table class="table table-striped">
										<thead>
											<tr>
												<th>ID</th>
												<th>姓名</th>
												<th>登录名</th>
												<th>密码</th>
												<th>性别</th>
												<th>学历</th>
												<th>学校</th>
												<th>职位</th>
												<th>状态</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:choose >
												<c:when test="${ !empty pageModel.userList }">
													<c:forEach items="${pageModel.userList }" var="user" varStatus="loop">
														<tr>
															<td>${loop.count }</td>
															<td>${user.userRealName }</td>
															<td>${user.userId }</td>
															<td>${user.userPassword }</td>
															<td>${user.userSex }</td>
															<td>${user.userEducation }</td>
															<td>${user.userSchool }</td>
															<td>${user.userPosition }</td>
															<td>
																<c:if test="${user.userStatus == 1 }">可用</c:if>
																<c:if test="${user.userStatus == 0 }">禁用</c:if>
															</td>
															<td>
																<a href="javascript:void(0)" onclick="toEdit('${user.userId }');">修改</a>
															</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<h3>暂时没有用户信息！！</h3>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									<p></p>
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
					</form>
					
					<!-- 模态框（Modal） -->
					<div class="modal fade infoForm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<!-- 表单 -->
							<form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/user/update" method="post">
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
									<li><label>状态</label> 
										<select class="input-select form-control userStatus" name="userStatus">
											<option value="1" <c:if test='${user.userStatus == 1}'>selected='selected'</c:if> >可用</option>
											<option value="0" <c:if test='${user.userStatus == 0}'>selected='selected'</c:if> >禁用</option>
										</select>
									</li>
									<li><label>登录名</label> 
										<input name="userId" value="${user.userId }" type="text" readonly="readonly" class="input-text2 form-control userId" style="background-color: #d9dde1;" />
									</li>
									<li><label>姓名</label> 
										<input name="userRealName" value="${user.userRealName }" type="text" class="input-text2 form-control userRealName">
									</li>
									<li><label>密码</label> 
										<input name="userPassword" value="${user.userPassword }" type="password" class="input-text2 form-control userPassword">
									</li>
									<li><label>性别</label> 
										<select class="input-select form-control userSex" name="userSex">
											<option value="男" <c:if test='${user.userSex == "男"}'>selected='selected'</c:if> >男</option>
											<option value="女" <c:if test='${user.userSex == "女"}'>selected='selected'</c:if> >女</option>
										</select>
									</li>
									<li><label>学校</label> 
										<input name="userSchool" value="${user.userSchool }" type="text" class="input-text2 form-control userSchool">
									</li>
									<li><label>学历</label> 
										<select class="input-select form-control userEducation" name="userEducation">
											<option value="本科" <c:if test='${user.userEducation == "本科"}'>selected='selected'</c:if> >本科</option>
											<option value="硕士" <c:if test='${user.userEducation == "硕士"}'>selected='selected'</c:if> >硕士</option>
											<option value="博士" <c:if test='${user.userEducation == "博士"}'>selected='selected'</c:if> >博士</option>
											<option value="博士后" <c:if test='${user.userEducation == "博士后"}'>selected='selected'</c:if> >博士后</option>
											<option value="大专" <c:if test='${user.userEducation == "大专"}'>selected='selected'</c:if> >大专</option>
											<option value="其他" <c:if test='${user.userEducation == "其他"}'>selected='selected'</c:if> >其他</option>
										</select>
									</li>
									<li><label>职位</label>
										<select class="input-select form-control userPosition" name="userPosition">
											<option value="学生" <c:if test='${user.userPosition == "学生"}'>selected='selected'</c:if> >学生</option>
											<option value="讲师" <c:if test='${user.userPosition == "讲师"}'>selected='selected'</c:if> >讲师</option>
											<option value="前端开发工程师" <c:if test='${user.userPosition == "前端开发工程师"}'>selected='selected'</c:if> >前端开发工程师</option>
											<option value="Java开发工程师" <c:if test='${user.userPosition == "Java开发工程师"}'>selected='selected'</c:if> >Java开发工程师</option>
											<option value="后端开发工程师" <c:if test='${user.userPosition == "后端开发工程师"}'>selected='selected'</c:if> >后端开发工程师</option>
											<option value="UI设计师" <c:if test='${user.userPosition == "UI设计师"}'>selected='selected'</c:if> >UI设计师</option>
											<option value="测试工程师" <c:if test='${user.userPosition == "测试工程师"}'>selected='selected'</c:if> >测试工程师</option>
											<option value="其他" <c:if test='${user.userPosition == "其他"}'>selected='selected'</c:if> >其他</option>
										</select>
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
			$("#dashboard-menu li:eq(3)").addClass('active');
			
			// 左边导航栏控制
			$('.sidebar-nav ul li').click(function(){
				$(this).addClass('active');
				$(this).siblings().removeClass('active');
				$(this).parent('ul').siblings().find('li').removeClass('active');
			});
		});
	</script>
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
		        	<%-- window.location.href='<%=request.getContextPath()%>/manager/user?page='+page; --%>
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
	</script>
	<script type="text/javascript">
		// 编辑   通过用户id获取此用户的信息
		function toEdit(id){
			$.ajax({
				url:'${pageContext.request.contextPath}/manager/user/getUserById',
			    type:'POST',
			    dataType:'json',
			    data:{"userId":id},
			    success:function(data){
			    	/* alert("success");
			    	alert("data:" + data.userRealName); */
			    	/* var jsondata = JSON.parse(data); // 将json字符串转换成json对象
			    	alert("jsondata2:"+jsondata); */
			    	
			    	$('#myModal').modal('show');
	                // 页面显示数据
	                $('.userStatus').val(data.userStatus);
	                $('.userId').val(data.userId);
	                $('.userRealName').val(data.userRealName);
	                $('.userPassword').val(data.userPassword);
	                $('.userSex').val(data.userSex);
	                $('.userSchool').val(data.userSchool);
	                $('.userEducation').val(data.userEducation);
	                $('.userPosition').val(data.userPosition);
			    },
			    error: function(){
			    	alert("请求失败");
			    }
			});
		}
		
		// 搜索提交之前，设置page=1
		function submitBefore(){
			$('#pageNumber').val(1);
			return true;
		}
	</script>
</html>
	
	