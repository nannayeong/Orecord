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
			<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">Report</h5>
					<h2>신고하기</h2>
				</div>
			</div>
		</div>
		<br />
		<hr color="gray">
			
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
                </tfoot>
                <tbody>
                
                <!-- 방명록 반복 부분 s -->
				<c:forEach items="${report }" var="row">
						<div class="media">
							<div class="media-body">
							  <tr>				 	
							 	<td class="text-center">${row.r_idx }</td>
							 	<td class="text-center">${row.r_id }</td>
							 	<td class="text-center">${row.kind }</td>
							 	<td class="text-center"><button class="btn btn-outline-primary" onclick="location.href='reportModify.do?r_idx=${row.r_idx}'">수정</button></td>
								<td class="text-center"><button class="btn btn-outline-danger" onclick="location.href='./deleteAction.do?r_idx=${row.r_idx}&s_id=${pageContext.request.userPrincipal.name}'">삭제</button></td>
								<td><input type="hidden" value="${row.r_idx }" name="r_idx"></td>
							 </tr>
							</div>	
						</div>
				</c:forEach>
	             </tbody>
	            </table>
	            <div>
					<tr>
						<td><input type="button" class="btn btn-warning" style="color: white; align-content: center; margin-left: -0.1em;" value="신고하기" onclick="location.href='./write.do?s_id=${pageContext.request.userPrincipal.name}';"></td>
					</tr>
					<br /><br />
				</div>
				
				</div>
			</div>
		</div>
	
	<!-- 오른쪽 컨텐츠 -->
	
	<!-- 오른쪽 컨텐츠종료 -->

<!-- 본문종료 -->
	

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 