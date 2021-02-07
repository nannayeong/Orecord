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
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>

<script>

function logincheck(bt){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		if(bt.innerHTML=='후원하기'){
			
		}
		else if(bt.innerHTML=='팔로우'){
			bt.innerHTML = '팔로워';
		}
		else if(bt.innerHTML=='팔로워'){
			bt.innerHTML = '팔로우';
		}
		 
	}
}
</script>
</head>
<body>
	<div>
		<div class="content">
			<div class="profile">
				<table style="">
					<tr>
						<td rowspan="2">
							<img src="${pageContext.request.contextPath}/resources/img/default.jpg" alt="" style="width:200px"/>
						</td>
						<td>
							${user_id }
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
			</div>
			<div>
				<div class="my-menu">
					<span style="color:orange;" onclick="location.href='./'">record</span>
					<span onclick="location.href='./${user_id}/album'">album</span>
					<span onclick="location.href='./${user_id}/playlist'">playlist</span>
					<span onclick="location.href='./${user_id}/like'">like</span>
					
					<div style="float:right;margin-right:1em;">
						<c:choose>
						<c:when test="${user_id ne pageContext.request.userPrincipal.name}">
						<button type="button" onclick="logincheck(this)" id="done">후원하기</button>			
						<button type="button" onclick="logincheck(this)" id="follow">팔로우</button>
						</c:when>
						<c:otherwise>
						<button type="button">업로드하기</button>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="my-content">
					<table style="width:100%;margin:1em 0 3em 2em;">
						<tr>
							<td class="my-con-left"></td>
							<td class="my-con-right">
								<table style="margin:auto;width:90%">
									<tr>
										<td style="border-right:2px solid #f2f2f2;padding-right:1em">
											<div style="font-size:0.8em">Followers</div>
											<div>100</div>
										</td>
										<td style="border-right:2px solid #f2f2f2;padding-left:1em;padding-right:1em">
											<div style="font-size:0.8em">Following</div>
											<div>100</div>
										</td>
										<td style="padding-left:1em">
											<div style="font-size:0.8em;">Tracks</div>
											<div>100</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
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