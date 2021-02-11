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
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th class="text-center">번호</th>
                    <th class="text-center">신고한 아이디</th>
                    <th class="text-center">신고이유</th>
                    <th class="text-center">수정</th>
                    <th class="text-center">삭제</th>
                  </tr>
                </thead>
                <tfoot>
                	<tr>
                    <th class="text-center">번호</th>
                    <th class="text-center">신고한 아이디</th>
                    <th class="text-center">신고이유</th>
                    <th class="text-center">수정</th>
                    <th class="text-center">삭제</th>
                  </tr>
                <tbody>
                
                <!-- 방명록 반복 부분 s -->
				<c:forEach items="${report }" var="row">
						<div class="media">
							<div class="media-body">
							  <tr>				 	
							 	<td class="text-center">${row.r_idx }</td>
							 	<td class="text-center">${row.r_id }</td>
							 	<td class="text-center">${row.kind }</td>
							 	<td class="text-center"><button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/report/reportModify.do?id=${row.id}';">수정</button></td>
								<td class="text-center"><button class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/report/reportDelete.do?id=${row.id}';">삭제</button></td>
							 </tr>
							</div>	
						</div>
				</c:forEach>
	             </tbody>
	            </table>
				
				</div>
			</div>
		</div>
	</div>
	<!-- 오른쪽 컨텐츠 -->
	<div class="right-content-back">
		<div class="right-content">
			
		</div>
	</div>
	<!-- 오른쪽 컨텐츠종료 -->

<!-- 본문종료 -->
	

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 