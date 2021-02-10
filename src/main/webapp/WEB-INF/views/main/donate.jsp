<%@page import="org.springframework.web.bind.annotation.SessionAttribute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/favicon.png">
	
	<title>Home</title>
	
	<!-- jquery, bootstrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!--     Fonts and icons     -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800" rel="stylesheet" />
	<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<!-- Nucleo Icons -->
	<link href="${pageContext.request.contextPath}/assets/css/nucleo-icons.css" rel="stylesheet" />
	<!-- CSS Files -->
	<link href="${pageContext.request.contextPath}/assets/css/black-dashboard.css?v=1.0.0" rel="stylesheet" />
	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link href="${pageContext.request.contextPath}/assets/demo/demo.css" rel="stylesheet" />
	<style>
	.donatop{
	width: 100%;
	height: 30px;
	border-bottom: 1px solid white; }
	</style>
</head>
<body class="">
  
  <!-- 상단 -->
<div class="donatop">
<h3 align="center">${todonate.nickname}에게 후원하기</h3>
</div>
  <div class="">
  	<!-- 사이드바 -->
    
    <!-- 메인보드 -->
    <div class="">

      <!-- 본문종료 -->
	</div>
  </div>
<!--   Core JS Files   -->
<%@include file="/resources/include/script.jsp" %>
</body>
</html>

