<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="menu-back">
	<!-- 오른정렬 -->
	<a href=""><div class="logo">Orecord</div></a>
	<a href=""><div class="menu">menu1</div></a>
	<a href=""><div class="menu">menu2</div></a>
	<div class="search">
		<form action="">
			<input type="text" value="" type="search" style="width:18em"/>
			<button type="button" onclick="" class="btn btn-secondary btn-sm" style="margin-bottom:4px"><i class="fas fa-search"></i></button>
		</form>
	</div>
	<!-- 왼정렬 -->
	<c:choose>
	<c:when test="${not empty pageContext.request.userPrincipal.name}">
	<div class="noti" id="setting" onclick="settingFunc();">
		<i class="fas fa-ellipsis-h fa-lg"></i>
		<div style="position:relative;background-color:red;visibility:hidden" class="setting-down">
			<li>1</li>
			<li>2</li>
		</div>
	</div>
	<div class="noti" id="noti" onclick="notiFunc();">
		<i class="fas fa-bell fa-lg"></i>
		<div style="position:relative;background-color:red;visibility:hidden" class="noti-down">
			<li>1</li>
			<li>2</li>
		</div>
	</div>
	<div class="noti" id="user"onclick="userFunc();">
		<img src="./resources/default.jpg" alt="" style="width:1.5em;border-radius:15px;margin-left:5px" />
		<i class="fas fa-caret-down"></i>
		<div style="position:relative;background-color:red;visibility:hidden" class="user-down">
			<li>1</li>
			<li>2</li>
		</div>
	</div>
	<a href="${pageContext.request.contextPath}/upload.do"><div class="menu-r">Upload</div></a>
	</c:when>
	<c:otherwise>
	<div class="menu-unlogin">
		<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath}/member/membership.do'">회원가입</button>
	</div>
	<div class="menu-unlogin">
		<button type="button" class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">로그인</button>
	</div>
	</c:otherwise>
	</c:choose>
</div> 