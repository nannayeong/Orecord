<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user_id}님의 페이지</title>
<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script>

</script>
</head>
<body style="background-color:#f2f2f2;">
	<div>
		<div class="content">
			<div class="profile" style="background-color:brown;">
				<%@include file="/resources/jsp/mypageProfile.jsp" %>
			</div>
			<div>
				<c:if test="${ artists.size() eq 0}">
		<h4>팔로우한 아티스트가 없습니다.</h4>
		</c:if>
		<c:forEach var="a" items="${artists}">
			<table
				style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
				class="feed">
				<tr>
					<td rowspan="4"
						style="width: 7em; padding-left: 1em; padding-right: 1em">
						<img src="./resources/default.jpg" alt="" style="width: 6em" />
					</td>
					<td><h3 style="padding-top: 1em;"><a href="../${a.id}/record">${a.nickname}</a></h3></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td style="padding-top: 1em; padding-bottom: 1em;">
               <button type="button" class="btn btn-outline-secondary btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로우</button>
					<td style="text-align: center">
						<h6 class="pCount ${a.id}">팔로워 : ${memberMap[a]}</h6>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					</td>
				</tr>
			</table>
		</c:forEach>
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