<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<div class="header">
			<div class="headerContent">
				<a href="home" target="_self" title="首页">  
					<img src="<%=request.getContextPath() %>/static/images/logo4.png"/>   
				</a>
				<span class="span-title">慕课网后台管理</span>
				<span class="span-name">
				<c:choose>
					<c:when test="${!empty manager.managerName}">
						管理员：${manager.managerName}
					</c:when>
					<c:otherwise>
						管理员：xxx
					</c:otherwise>
				</c:choose>
				</span>
			</div>
		</div>
