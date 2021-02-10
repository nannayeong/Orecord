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

<script type="text/javascript">
	function deleteRow(idx) {
		if(confirm('삭제하시겠습니까?')){
			location.href='delete.do?idx='+idx;
		}
	}
</script>
</head>
<body>
	<div>
		<div class="content">
			<!-- 왼쪽 컨텐츠 -->
			<div class="left-content-back">
				<div class="left-content">
<!-- 					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em"> -->
						<form method="get">
		<select name="searchField">
			<option value="contents">내용</option>
			<option value="name">작성자</option>
		</select>
		<input type="text" name="searchTxt" />
		<input type="submit" value="검색" />
	</form>
	여러 단어를 검색하고 싶을때는 스페이스로 구분해주세요
	</div>
		
	<div class="text-right">
		<c:choose>
			<c:when test="${not empty sessionScope.siteUserInfo }">
				<button class="btn btn-danger"
					>
					로그아웃
				</button>
			</c:when>
			<c:otherwise>
				<button class="btn btn-info"
					>
					로그인	
				</button>
			</c:otherwise>
		</c:choose>
		&nbsp;&nbsp;
		
	</div>
	<!-- 방명록 반복 부분 s -->
	<c:forEach items="${lists }" var="row">		
		<div class="border mt-2 mb-2">
			<div class="media">
				<div class="media-left mr-3">
					<img src="../images/img_avatar3.png" class="media-object" style="width:60px">
				</div>
				<div class="media-body">
					<h4 class="media-heading">작성자:${row.name }(${row.id })</h4>
					<p>${row.contents }</p>
				</div>	  
				<!--  수정,삭제버튼 -->
				<div class="media-right">
				<!-- 작성자 본인에게만 수정/삭제 버튼 보임처리 -->
					<c:if test="${sessionScope.siteUserInfo.id eq row.id }">
						<button class="btn btn-primary" 
						onclick="location.href='modify.do?idx=${row.idx}'">
						수정</button>
						<button class="btn btn-danger" 
						onclick="javascript:deleteRow(${row.idx});">
						삭제</button>
					</c:if>
				</div>
			</div>
		</div>
	</c:forEach>
<!-- 			</table> -->
		
	</div>
						
						
						
<!-- 					</table> -->
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