<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - main</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>

</head>
<body>
	<div>
		<div class="content">
			<!-- 왼쪽 컨텐츠 -->
			<div class="left-content-back">
				<div class="left-content">
					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em">
						
					</table>
				</div>
			</div>
			<!-- 오른쪽 컨텐츠 -->
			<div class="right-content-back">
				<div class="right-content">
					
				</div>
			</div>
			<!-- 오른쪽 컨텐츠종료 -->
		</div>
		<!-- 본문종료 -->
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 