<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
		<div class="content" style="padding-top:3em;">
			<div style="width:80%;height:500px;">
			<c:choose>
			<c:when test="${empty pageContext.request.userPrincipal.name }">
			<c:url value="/loginAction.do" var="loginUrl" />
			<form:form name="loginFrm" action="${loginUrl }" method="post">
			<c:if test="${param.error != null }">
				<p>아이디와 패스워드가 잘못되었습니다.</p>
			</c:if>
			<c:if test="${param.login != null }">
				<p>로그아웃 하였습니다.</p>
			</c:if>
				<table>
					<tr>
						<td>
							<input type="text" name="id"/>
						</td>
						<td>
							<input type="submit" value="로그인" />
						</td>
					</tr>
					<tr>
						<td><input type="password" name="pw" /></td>
					</tr>
				</table>
			</form:form>
			</c:when>
			<c:otherwise>
				${pageContext.request.userPrincipal.name }님, 로그인 되셨습니다.
			</c:otherwise>
			</c:choose>
			</div>
		</div>
		<!-- 본문종료 -->
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 