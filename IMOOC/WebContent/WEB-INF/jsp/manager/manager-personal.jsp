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
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/BootStrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/me.css">
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
					<div style="padding-top: 10px;">
						<span class="f-16"><strong>个人信息</strong>
							<!-- 按钮触发模态框 -->
							<a href="javascript: void(0);" class="pull-right js-edit-info" onclick="show()" data-toggle="modal" data-target="#myModal"  >
								<span class="glyphicon glyphicon-pencil" style="font-size: 11px;margin-right: 0px;color: #337ab7;"></span>
								<span class="message-edit">编辑</span>
							</a>
						</span>
					</div>
					<div class="split-line" style="margin: 20px 0px;"></div>
					
					<div class="oc-form" >
						<ul>
							<li><label>账号</label> 
								<input name="managerAccount" value="${manager.managerAccount }" type="text" readonly="readonly" class="input-text2" />
							</li>
							<li><label>密码</label> 
								<input name="managerPassword" value="${manager.managerPassword }" type="password" readonly="readonly" class="input-text2 managerPassword">
							</li>
							<li><label>姓名</label> 
								<input name="managerName" value="${manager.managerName }" type="text" readonly="readonly" class="input-text2 managerName">
							</li>
							<li><label>性别</label> 
								<input name="managerSex" value="${manager.managerSex }" type="text" readonly="readonly" class="input-text2 managerSex">
							</li>
						</ul>	
							
						<!-- 模态框（Modal） -->
						<div class="modal fade infoForm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<!-- 表单 -->
								<form class="oc-form infoForm" id="infoForm"  action="<%=request.getContextPath() %>/manager/personal/update" method="post">
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
											<input name="managerAccount" value="${manager.managerAccount }" type="text" readonly="readonly" class="input-text2" style="background-color: #d9dde1;" />
										</li>
										<li><label>密码</label> 
											<input name="managerPassword" value="${manager.managerPassword }" type="password" class="input-text2">
										</li>
										<li><label>姓名</label> 
											<input name="managerName" value="${manager.managerName }" type="text" class="input-text2">
										</li>
										<li><label>性别</label> 
											<select class="input-select" name="managerSex">
												<option value="男" <c:if test='${manager.managerSex == "男"}'>selected='selected'</c:if> >男</option>
												<option value="女" <c:if test='${manager.managerSex == "女"}'>selected='selected'</c:if> >女</option>
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
		$("#accounts-menu li:eq(0)").addClass('active');
		
		// 左边导航栏控制
		$('.sidebar-nav ul li').click(function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			$(this).parent('ul').siblings().find('li').removeClass('active');
		});
	});
</script>
<script type="text/javascript">

/* function show(){
	debugger();
	$('.infoForm').modal('show'); 	// 显示模态框上面的对话框
	
} */
//调用
/* $(document).ready(function(){
	// 当表单提交时执行
    $('.infoForm').bind('submit', function(){
    	var dataPara = getFormJson(this);
        $.ajax({
            url: this.action,
            type: this.method,
            data: dataPara,
            success: function(data){
                // alert(data);
                var jsondata = $.parseJSON(data);
                // 页面显示数据
                $('.managerPassword').val(jsondata.managerPassword);
                $('.managerName').val(jsondata.managerName);
                $('.managerSex').val(jsondata.managerSex);
                alert("12");
                // 关闭模态框
                $('.infoForm').modal('hide'); 	// 去掉模态框上面的对话框
                $(".modal-backdrop").remove();	// 去掉模态框遮罩
            },
            error: function(){
            	
            }
        });
        return false;
    });
}); */
//将form转为AJAX提交
function ajaxSubmit(frm, fn) {
    var dataPara = getFormJson(frm);
    $.ajax({
        url: frm.action,
        type: frm.method,
        data: dataPara,
        success: fn
    });
}

//将form中的值转换为键值对。
function getFormJson(frm) {
    var o = {};
    var a = $(frm).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });

    return o;
}
</script>
</html>
	

	