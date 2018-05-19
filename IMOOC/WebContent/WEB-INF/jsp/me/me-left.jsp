<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 页面左边 start -->
	<div class="setting-left">
		<c:choose>
			<c:when test="${!empty user.userPhoto}">
				<img id="userNavHeader" class="setting-header" src="/imgUrl/images/${user.userPhoto }"/>
			</c:when>
			<c:otherwise>
				<img id="userNavHeader" class="setting-header" src="<%=request.getContextPath() %>/static/images/anonymous-photo.png"/>
			</c:otherwise>
		</c:choose>
		<div>
			<c:choose>
			<c:when test="${!empty user.userRealName}">${user.userRealName}</c:when>
			<c:otherwise>${user.userId }</c:otherwise>
			</c:choose>
		</div>
		<div class="split-line" style="margin-bottom: 20px;"></div>
		<ul class="user-menu-nav-block">
			<a href="<%=request.getContextPath() %>/me" class="me-home">
				<li class="user-menu-nav">我的主页 <span>&gt;</span></li>
			</a>
			<a href="<%=request.getContextPath() %>/me/course" class="me-course">
				<li class="user-menu-nav">我的课程  <span	>&gt;</span></li>
			</a>
			<a href="<%=request.getContextPath() %>/me/collect" class="me-collect">
				<li class="user-menu-nav">我的收藏  <span>&gt;</span></li>
			</a>
			<a href="<%=request.getContextPath() %>/me/message" class="me-message">
				<li class="user-menu-nav">个人信息  <span>&gt;</span></li>
			</a>
			<a href="<%=request.getContextPath() %>/me/answer" class="me-answer">
				<li class="user-menu-nav">我的猿问<span>&gt;</span></li>
			</a>
			<a href="<%=request.getContextPath() %>/me/note" class="me-note">
				<li class="user-menu-nav">我的笔记<span>&gt;</span></li>
			</a>
		</ul>
	</div>
	<!-- 页面左边 end -->
					

