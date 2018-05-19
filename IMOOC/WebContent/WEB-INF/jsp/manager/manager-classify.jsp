<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>慕课网后台管理-课程分类管理</title>

	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<!-- manager页面样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/manager-index.css">
	<!-- footer底部样式表 -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/footer.css">
	<style>
		.modal-open {
			overflow: inherit ;
		    padding-right: 0px !important;
		}
		body{
			padding-right: 0px !important;
		}
	</style>
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
		        <input type="button" class="search-btn mt-10" data-toggle="modal" data-target="#addModal" style="margin-left: 15px;" value=" 添加分类">
		        
		        <div class="container-fluid pt-10">
						
					<div class="panel panel-5">
						<a class="block-heading f-14" data-toggle="collapse">一级分类</a>
						<div class="block-body collapse in">
							<table class="table">
								<thead>
									<tr>
										<th>名称</th>
										<th>编码</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:choose >
										<c:when test="${ !empty sortsOneList }">
											<c:forEach items="${sortsOneList }" var="sortsOne" varStatus="loop">
												<tr class="tr-bg-gray" code="${sortsOne.oneCode }">
													<td>${sortsOne.oneName }</td>
													<td>${sortsOne.oneCode }</td>
													<td>
														<a class="link-a" href="javascript:void(0)" onclick="toEditOne('${sortsOne.oneCode }');">修改</a>
														<a class="link-a" href="javascript:void(0)" onclick="doDeleteOne('${sortsOne.oneId }')">删除</a>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<h3>一级分类列表暂时没有数据</h3>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="panel panel-5">
							<a class="block-heading f-14" data-toggle="collapse">二级分类</a>
							<div class="block-body collapse in">
								<table id="subClassifysTable" class="table">
									<thead>
										<tr name="th">
											<th>名称</th>
											<th>编码</th>
											<th>一级分类编码</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:choose >
											<c:when test="${ !empty sortsTwoList }">
												<c:forEach items="${sortsTwoList }" var="sortsTwo" varStatus="loop">
													<tr class="tr-two-gray" code="${sortsTwo.twoCode }" parentcode="${sortsTwo.sortsOne.oneCode }">
														<td>${sortsTwo.twoName }</td>
														<td>${sortsTwo.twoCode }</td>
														<td>${sortsTwo.sortsOne.oneCode }</td>
														<td>
															<a class="link-a" href="javascript:void(0)" onclick="toEditTwo('${sortsTwo.twoCode }')">修改</a>
															<a class="link-a" href="javascript:void(0)" onclick="doDeleteTwo('${sortsTwo.twoId}')">删除</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<h3>二级分类列表暂时没有数据</h3>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
		    	</div>
				<!-- 右边内容 end -->
				
				
				<!-- 添加弹出层 -start -->
				<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal_wapper">
						<div class="modal-dialog w-8">
							<div class="modal-content">
								<!-- 表单 -->
								<form role="form" id="myForm" method="post" action="<%=request.getContextPath() %>/manager/classify/add">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">课程分类</h4>
									</div>
									<div class="modal-body">
										<input type="hidden" name="id" value="42">
										<div class="form-group">
											<label for="name">一级分类</label> 
											<select name="classId" class="form-control" required type="select">
												<option value="1">总分类</option>
												<c:choose >
													<c:when test="${ !empty sortsOneList }">
														<c:forEach items="${sortsOneList }" var="sortsOne" varStatus="loop">
															<option value="${sortsOne.oneCode }">${sortsOne.oneName }</option>
														</c:forEach>
													</c:when>
												</c:choose>
											</select>
										</div>
										<div class="form-group">
											<label for="name">名称</label> 
											<input type="text" class="form-control" required name="className" id="className" placeholder="请输入名称">
										</div>
										<div class="form-group">
											<label for="name">编码</label> 
											<input type="text" class="form-control" required name="classCode" id="classCode" placeholder="请输入编码,保证编码不能重复">
										</div>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary" onclick="return submitBefore()">保存</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 添加弹出层 -end -->
				
				<!-- 一级分类编辑弹出层 -start -->
				<div class="modal fade infoForm" id="editModalOne" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<!-- 表单 -->
						<form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/sortsone/update" method="post">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										&times;
									</button>
									<h4 class="modal-title" id="myModalLabel">
										课程分类
									</h4>
								</div>
								<div class="modal-body">
									<input type="hidden" name="oneId" id="oneId">
									<div class="form-group">
										<label for="name">名称</label> 
										<input type="text" class="form-control" value="1" name="oneName" id="oneName" placeholder="请输入名称">
									</div>
									<div class="form-group">
										<label for="name">编码</label> 
										<input type="text" class="form-control" name="oneCode" id="oneCode" placeholder="请输入编码" disabled="disabled">
									</div>
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-primary">保存</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 一级分类编辑弹出层 -end -->
				
				<!-- 二级分类编辑弹出层 -start -->
				<div class="modal fade" id="editModalTwo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal_wapper">
						<div class="modal-dialog w-8">
							<div class="modal-content">
								<!-- 表单 -->
								<form class="oc-form infoForm" action="<%=request.getContextPath() %>/manager/sortstwo/update" method="post">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
										<h4 class="modal-title" id="myModalLabel">课程分类</h4>
									</div>
									<div class="modal-body">
										<input type="hidden" name="twoId" id="twoId">
										<div class="form-group">
											<label for="name">名称</label> 
											<input type="text" class="form-control" name="twoName" id="twoName" placeholder="请输入名称">
										</div>
										<div class="form-group">
											<label for="name">编码</label> 
											<input type="text" class="form-control" name="twoCode" id="twoCode" placeholder="请输入编码" disabled="disabled">
										</div>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary">保存</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 二级分类编辑弹出层 -end -->
			
				<!-- 一级分类删除弹出层 alert 信息 -->
				<div class="modal fade" id="deleteModalOne" tabindex="-1" aria-hidden="true">
					<div class="modal_wapper">
						<div class="modal-dialog w-4">
							<div class="modal-content">
								<!-- 表单 -->
								<form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/sortsone/delete" method="post">
									<input type="hidden" name="oneId" id="deleteOneId">
									<div class="modal-header">
										<div class="modal-title f-16">提示信息</div>
									</div>
									<div class="modal-body">
										<div><span class="color-oc f-16 oc-content">确定删除？</span></div>
									</div>
									<div class="modal-footer modal-center">
										<button type="submit" class="btn btn-primary oc-ok">确 定</button>
										<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 一级分类弹出层 alert 信息 -->
				
				<!-- 二级分类删除弹出层 alert 信息 -->
				<div class="modal fade" id="deleteModalTwo" tabindex="-1" aria-hidden="true">
					<div class="modal_wapper">
						<div class="modal-dialog w-4">
							<div class="modal-content">
								<!-- 表单 -->
								<form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/sortstwo/delete" method="post">
									<input type="hidden" name="twoId" id="deleteTwoId">
									<div class="modal-header">
										<div class="modal-title f-16">提示信息</div>
									</div>
									<div class="modal-body">
										<div><span class="color-oc f-16 oc-content">确定删除？</span></div>
									</div>
									<div class="modal-footer modal-center">
										<button type="submit" class="btn btn-primary oc-ok">确 定</button>
										<button type="button" class="btn btn-default oc-cancel" data-dismiss="modal">取 消</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 二级分类弹出层 alert 信息 -->
				
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
		// 设置左边导航栏样式
		$("#dashboard-menu li:eq(2)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
	$(function(){
		//一级分类点击，过滤二级分类 
		$('.tr-bg-gray').click(function(){
			var code = $(this).attr('code');
			$('#subClassifysTable').find('tr').each(function(i,item){
				if($(item).attr('parentCode') == code){
					$(item).show();
				}else{
					if($(item).attr('name') != 'th'){
						$(item).hide();
					}
				}
			});
		});
		
	});
	
	// 添加分类信息之前校验分类编码是否存在
	function submitBefore(){
		// 获取到分类编码,判断分类编码是否存在
		var classCode = $('#classCode').val();
		console.log(classCode);
		// alert(classCode);
		var flag = true;
		$.ajax({
			url: '${pageContext.request.contextPath}/manager/classify/addValidate',
			type:'POST',
		    dataType:'json',
		    async: false,	//同步
		    data:{"classCode":classCode},
		    success:function(result){
		    	if( result.res == 1 ){
		    		alert('分类编码已存在！！');
		    		flag = false;
		    		$('#classCode').focus();
		    	}
		    },
		    error: function(){
		    	
		    }
		});
		return flag;
	}
	
	//一级分类编辑
	function toEditOne(id){
		$.ajax({
			url:'${pageContext.request.contextPath}/manager/classify/getSortsOneByCode',
		    type:'POST',
		    dataType:'json',
		    data:{"code":id},
		    success:function(data){
		    	$('#editModalOne').modal('show');
		    	/* $('#editModalOne').show(); */
		    	$('#oneName').val(data.oneName);
		    	$('#oneCode').val(data.oneCode);
		    	$('#oneId').val(data.oneId);
		    },
		    error: function(){
		    	alert("请求出错");
		    }
		});
	}
	
	//二级分类编辑
	function toEditTwo(id){
		$.ajax({
			url:'${pageContext.request.contextPath}/manager/classify/getSortsTwoByCode',
		    type:'POST',
		    dataType:'json',
		    data:{"code":id},
		    success:function(data){
		    	$('#editModalTwo').modal('show');
		    	$('#twoName').val(data.twoName);
		    	$('#twoCode').val(data.twoCode);
		    	$('#twoId').val(data.twoId);
		    },
		    error: function(){
		    	alert("请求出错");
		    }
		});
	}
	
	//保存
	/* function doSave(){
		$('#myForm').ajaxSubmit({
			datatype : 'json',
			success : function(resp) {
				var resp = $.parseJSON(resp);
				if (resp.errcode == 0) {
					$('#myModal').modal('hide');
					window.location.reload();//刷新
				} else {
					Modal.tipFailure(resp.message);//失败提示 
				}
			},
			error: function(){
				Modal.tipFailure('保存失败');
                //alert(arguments[0].responseText);
            }
		});			
	} */
	
	//删除一级分类 
	function doDeleteOne(id){
		$('#deleteModalOne').modal('show');
		$('#deleteOneId').val(id);
	}
	
	//删除二级分类 
	function doDeleteTwo(id){
		$('#deleteModalTwo').modal('show');
		$('#deleteTwoId').val(id);
	}
	
	/* //删除二级分类 
	function doDeleteTwo(id){
		Modal.confirm('确定删除?',function(){
			$.ajax({
				url:'/classify/deleteLogic.html',
			    type:'POST',
			    dataType:'json',
			    data:{"id":id},
			    success:function(resp){
			    	var errcode = resp.errcode;
			    	if(errcode == 0){
			    		Modal.alert('删除成功!',function(){
			    			window.location.reload();//刷新
			    		});
			    		window.location.reload();//刷新
			    	}
			    } 
			});
		});
	} */
	
</script>
</html>
	
	