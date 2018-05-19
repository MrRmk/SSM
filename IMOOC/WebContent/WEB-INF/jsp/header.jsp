<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
		<div class="header">
			<div class="headerContent">
				<!-- logo -->
				<div class="logo">
					<a href="<%=request.getContextPath() %>/home" target="_self" title="首页">  
						<img src="<%=request.getContextPath() %>/static/images/logo.png"/>   
					</a>
				</div>
				<!-- 菜单导航栏 -->
				<div class="bs-module">
					<ul id="portalmenu" class="nav">
						<li class="item"><a target="_self" href="<%=request.getContextPath() %>/home">首页</a> </li>
						<li class="item "><a target="_self" href="<%=request.getContextPath() %>/course">课程</a> </li>
						<li class="item "><a target="_self" href="<%=request.getContextPath() %>/question">猿问</a> </li>
						<li class="item "><a target="_self" href="<%=request.getContextPath() %>/note">手记</a> </li>
						<li class="item "><a target="_self" href="<%=request.getContextPath() %>/login">我的</a> </li>
						<li class="item "><a target="_self" href="<%=request.getContextPath() %>/manager">后台管理</a> </li>
					</ul>
				</div>
				<!-- 菜单 头像 -->
				<div class="bs-module header-right">
					<div class="login login-hearder">
						<div class="unLogin unLogin1" style="display: block;">
							<a class="loginlink login-item" href="<%=request.getContextPath() %>/login">登录</a>/
							<a class="loginlink login-item" href="<%=request.getContextPath() %>/register">注册</a>
						</div>
						<div class="unLogin unLogin2" style="display: none;">
							<a class="loginlink login-img" href="javascript:void(0)">
								<c:choose>
									<c:when test="${!empty user.userPhoto}">
										<img class="headPortrait img-circle" src="/imgUrl/images/${user.userPhoto }"/>
									</c:when>
									<c:otherwise>
										<img class="headPortrait img-circle" src="<%=request.getContextPath() %>/static/images/anonymous-photo.png"/>
									</c:otherwise>
								</c:choose>
							</a>
						</div>
					</div>
				</div>
				
				<!-- 登录之后显示用户的基本信息-start -->
				<div class="popover pull-right" style="display: none;">
					<div style="padding:10px;">
						<div style="margin-top:10px;">
							<span style="font-size: 16px;">
								<c:choose>
									<c:when test="${!empty user.userRealName}">用户名：${user.userRealName}</c:when>
									<c:otherwise>用户名：无</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div style="margin-top:10px;">
							<a href="<%=request.getContextPath() %>/me" style="height: 22px; margin-bottom: -10px;">
								<span style="font-size: 16px;color: #337ab7;">个人主页</span>
							</a>
						</div>
						<div style="margin-top:20px;border-top:1px solid #eee;width:200px; height: 40px; padding-top:10px;">
							<a style="height: 22px;" class="link-a" href="<%=request.getContextPath() %>/layout">
							<span style="font-size: 16px;color: #337ab7;">退出</span>
							</a>
						</div>
					</div>
				</div>
				<!-- 登录之后显示用户的基本信息-end -->
				
				<!-- 消息 -->
				<!-- <div class="header-right">
					<ul class="nav nav-pills">
						<li><a href="#">消息 <span class="badge">3</span></a></li>
					</ul>
				</div> -->
			</div>
		</div>

