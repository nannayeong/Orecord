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
						<tr>
							<td rowspan="4" style="width:7em;padding-left:1em;padding-right:1em">
								<img src="./resources/img/default.jpg" alt="" style="width:6em"/>
							</td>
							<td>안녕안녕안녕안녕 - 아영</td>
						</tr>
						<tr>
							<td colspan="2">
								<audio src="" controls style="width:95%" >
									<source src="">
								</audio>
							</td>
						</tr>
						<tr>
							<td>
								<button type="button" class="btn btn-secondary btn-sm" >좋아요</button>
								<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
								<button type="button" class="btn btn-secondary btn-sm">참여</button>
							</td>
							<td style="text-align:center">
								재생수 : 3 좋아요수 : 5
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" style="width:80%;"/>&nbsp&nbsp<input type="button" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</td>
						</tr>
					</table>
					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em">
						<tr>
							<td rowspan="4" style="width:7em;padding-left:1em;padding-right:1em">
								<img src="./resources/img/default.jpg" alt="" style="width:6em"/>
							</td>
							<td>안녕안녕안녕안녕 - 아영</td>
						</tr>
						<tr>
							<td colspan="2">
								<audio src="" controls style="width:95%" >
									<source src="">
								</audio>
							</td>
						</tr>
						<tr>
							<td>
								<button type="button" class="btn btn-secondary btn-sm" >좋아요</button>
								<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
								<button type="button" class="btn btn-secondary btn-sm">참여</button>
							</td>
							<td style="text-align:center">
								재생수 : 3 좋아요수 : 5
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" style="width:80%;"/>&nbsp&nbsp<input type="button" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</td>
						</tr>
					</table>
					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em">
						<tr>
							<td rowspan="4" style="width:7em;padding-left:1em;padding-right:1em">
								<img src="./resources/img/default.jpg" alt="" style="width:6em"/>
							</td>
							<td>안녕안녕안녕안녕 - 아영</td>
						</tr>
						<tr>
							<td colspan="2">
								<audio src="" controls style="width:95%" >
									<source src="">
								</audio>
							</td>
						</tr>
						<tr>
							<td>
								<button type="button" class="btn btn-secondary btn-sm" >좋아요</button>
								<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
								<button type="button" class="btn btn-secondary btn-sm">참여</button>
							</td>
							<td style="text-align:center">
								재생수 : 3 좋아요수 : 5
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" style="width:80%;"/>&nbsp&nbsp<input type="button" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 오른쪽 컨텐츠 -->
			<div class="right-content-back">
				<div class="right-content">
					첫하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />막하이<br />
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