<%@page import="impl.ViewImpl"%>
<%@page import="model.AudioBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>협업신청목록</title>

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
		<!-- 페이지 제목 -->
		<input type="hidden" name="audio_idx" value="${audio_idx}">
		<input type="hidden" name="name" value="${pageContext.request.userPrincipal.name}">
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">PartyList</h5>
					<h2 style="margin-bottom: 20px;">협업신청목록</h2>
				</div>
			</div>
		</div>
		<br>
		<hr color="gray" width="95%">
		<br>
		<!-- 협업신청목록 시작 -->
		<div class="row" style="padding: 15px;">
			<div class="col-12">
				<!-- <h3 style="padding-left: 5px;">협업신청리스트</h3> -->
				<table class="table table-hover">
					<colgroup>
						<col width="10px">
						<col width="80px">
						<col width="150px">
						<col width="*">
						<col width="60px">
						<col width="75px">
						<col width="110px">
						<col width="110px">
					</colgroup>
					<thead class="thead-light">
						<tr>
							<th>No</th>
							<th>작성자</th>
							<th>제목</th>
							<th>내용</th>
							<th>분야</th>
							<th>포인트</th>
							<th>작성일</th>
							<th>유효기간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${partyList }" var="par">
						<input type="hidden" name="" />
						<c:choose>
							<c:when test="${par.choice eq 1 }">
								<tr class="table-success">
									<td>${par.party_idx }</td>
									<td>
										<a href="./partyView.do?party_idx=${par.party_idx}&id=${par.id}">
											${par.id }
										</a>
									</td>
									<td>${par.title }</td>
									<td>${par.contents }</td>
									<td>${par.kind }</td>
									<td>${par.point }</td>
									<td>${par.regidate }</td>
									<td>${par.exdate }</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>${par.party_idx }</td>
									<td>
										<a href="./partyView.do?party_idx=${par.party_idx}&id=${par.id}">
											${par.id }
										</a>
									</td>
									<td>${par.title }</td>
									<td>${par.contents }</td>
									<td>${par.kind }</td>
									<td>${par.point }</td>
									<td>${par.regidate }</td>
									<td>${par.exdate }</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<%-- <tr>
							<td>${par.party_idx }</td>
							<td>
								<a href="./partyView.do?party_idx=${par.party_idx}&id=${par.id}">
									${par.id }
								</a>
							</td>
							<td>${par.title }</td>
							<td>${par.contents }</td>
							<td>${par.kind }</td>
							<td>${par.point }</td>
							<td>${par.regidate }</td>
							<td>${par.exdate }</td>
						</tr> --%>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
			<div style="margin-right: 30px;">
				<button type="button" class="btn btn-outline-primary"
					onclick="location.href='view.do?audio_idx=${audio_idx}'">이전으로</button>
			</div>
		</div>
		<br> <br>
		<!-- 왼쪽 컨텐츠 종료 -->
	</div>
	<!-- 본문종료 -->
</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>
</body>
</html>