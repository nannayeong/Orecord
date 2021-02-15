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
function fBtn(follow) {
	var f = follow;
	var clas = document.getElementsByClassName("btn btn-outline-secondary btn-sm follow " + f);
	if ("${pageContext.request.userPrincipal.name}" == ""
			|| "${pageContext.request.userPrincipal.name}" == null) {
		alert("로그인후 이용하세요");
		location.href = "${pageContext.request.contextPath}/member/login.do";
	} else {
		if (clas.length == 0) {
			followbtn(f);
		} else {
			unfollowbtn(f);
		}
	}
}
function followbtn(follow) {
	var f = follow;

	$.ajax({
		url : "../addFollower.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : {
			followId : "${pageContext.request.userPrincipal.name}",
			followerId : f
		},
		dataType : "json",
		success : function sucFunc(resData) {
			var section1s = document
					.getElementsByClassName("btn btn-secondary btn-sm follow " + f);
			for (var i = section1s.length - 1; i >= 0; i--) {
				var sec1 = section1s.item(i);
				sec1.className = "btn btn-outline-secondary btn-sm follow " + f;
			}
			count = resData.followcount;
			$('.pCount.' + f).html('팔로워 : ' + count);
		}

	});
}
function unfollowbtn(follow) {
	var f = follow;
	$.ajax({
		url : "../unFollow.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : {
			followId : "${pageContext.request.userPrincipal.name}",
			followerId : f
		},
		dataType : "json",
		success : function sucFunc(resData) {
			var section1s = document
					.getElementsByClassName("btn btn-outline-secondary btn-sm follow " + f);
			for (var i = section1s.length - 1; i >= 0; i--) {
				var sec1 = section1s.item(i);
				sec1.className = "btn btn-secondary btn-sm follow " + f;
			}
			count = resData.followcount;
			$('.pCount.' + f).html('팔로워 : ' + count);
		}
	});
}
function deleteFollow(t,deleteId) {
	$(t).parent().parent().parent().remove()
	$.ajax({
		url : "../deleteFollow.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : {
			followingId : "${pageContext.request.userPrincipal.name}",
			userId : deleteId
		},
		dataType : "json",
		success : function sucFunc(resData) {
			alert("성공");
		}
	});
}
</script>
</head>
<body style="background-color:#f2f2f2;">
	<div>
		<div class="content">
			<div class="profile" style="background-color:brown;">
				<%@include file="/resources/jsp/mypageProfile.jsp" %>
			</div>
			<div style="padding-bottom:2em">
				<div style="text-align:center;margin-top:2em">
					<div class="btn-group" style="margin-bottom:1em;margin-left:1em;text-size:16px;">
					  <button type="button" class="btn btn-dark" onclick="location.href='./myFollowers'" style="width:8em">follower</button>
					  <button type="button" class="btn btn-outline-dark" onclick="location.href='./myFollowing'" style="width:8em">following</button>
					</div>
				</div>
				<c:if test="${artists.size() eq 0}">
				<h4>나를 팔로우한 아티스트가 없습니다.</h4>
				</c:if>
				<c:forEach var="a" items="${artists}">
				<table style="width: 60%; border: 2px #f2f2f2 solid;margin: auto;" class="feed">
					<tr>
						<td style="padding-top:1em; padding-bottom:1em">
							<img src="${a.img }" alt="" style="width: 2em" />
						</td>
						<td><div style="text-size:20px"><a href="../${a.id}/record">${a.nickname}(${a.id })</a></div></td>
						<td>
							${a.intro}
						</td>
						<td style="text-align:right;padding-right:1em;">
	               			<button type="button" class="btn btn-outline-secondary btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로워</button>
	               		</td>
						<td style="text-align:right;padding-right:1em;">
	               			<button type="button" class="btn btn-warning btn-sm" onclick="deleteFollow(this,'${a.id}')" >팔로워</button>
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