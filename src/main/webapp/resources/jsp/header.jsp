<%@page import="java.security.Principal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<!-- <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> -->

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<style>
a:link { color: red; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: blue; text-decoration: underline;}
.menu.active{
    background-color:#6c757d;
}
</style>
<script type="text/javascript">
function checkNull(t) {
	if(t.searchWord.value==""||t.searchWord.value==null){
		alert("검색어를 입력하세요");
		return false;
	}
}

</script>
<%
String a="", b="";
if(request.getParameter("partyType")!=null){
if(request.getParameter("partyType").equals("1")){
	a= " active";
}else if(request.getParameter("partyType").equals("0")){
	b= " active";
}}
%>
<div class="menu-back">
	<!-- 오른정렬 -->
	<a href="${pageContext.request.contextPath}/main.do"><div class="logo">Orecord</div></a>
	<a href="${pageContext.request.contextPath}/Co_op_Main.do?partyType=1"><div class="menu<%=a%>">협업</div></a>
	<a href="${pageContext.request.contextPath}/Co_op_Main.do?partyType=0"><div class="menu<%=b%>">최신음악</div></a>
	
	<div class="search">
		<form action="${pageContext.request.contextPath}/search.do" onsubmit="return checkNull(this)">
			<input type="text" value="" type="search" style="width:15em" name="searchWord"/>
			<button type="submit" onclick="" class="btn btn-secondary btn-sm" style="margin-bottom:4px"><i class="fas fa-search"></i></button>
		</form>
	</div>
	<!-- 왼정렬 -->
	<c:choose>
	<c:when test="${not empty pageContext.request.userPrincipal.name}">
	<div class="noti2" id="musicbox">
		<i class="fas fa-music fa-lg" onclick="openmusicboxnull();"></i>
	</div>
	<div class="noti2" id="noti">
		<div class="dropdown">
		  <span class="dropdown-toggle" data-toggle="dropdown">
		    <i class="fas fa-bell fa-lg" style="margin-left:15px"></i>
		  </span>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="">알림</a>
		  </div>
		</div>
	</div>
	<div class="noti" id="user">
		<div class="dropdown">
		  <span class="dropdown-toggle" data-toggle="dropdown">
		 	<img src="${sessionScope.user.img }" alt="" style="width:1.8em;height:1.8em;border-radius:15px;margin-left:5px" />
		 	<span style="cursor:pointer">${sessionScope.user.nickname }님</span>
		  </span>
		  <div class="dropdown-menu" style=";cursor:pointer">
		  	<div class="dropdown-item" style="text-align:center">보유포인트 <br /> ${sessionScope.user.mypoint}원</div>
		  	<hr />
		    <c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities eq '[ROLE_ADMIN]'}">
			<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/main">어드민페이지</a>
			</c:if>
			<a class="dropdown-item" href="${pageContext.request.contextPath}/${pageContext.request.userPrincipal.name}/record">마이페이지</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath}/board/partyList.do">협업신청서조회</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath }/chargeLog.do">포인트 조회</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath }/pwCheck.do">정보수정</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath }/logout.do">로그아웃</a>
			<a class="dropdown-item" href="${pageContext.request.contextPath}/report/reportlist.do">신고하기</a>
		  </div>
		</div>
	</div>
	<a href="${pageContext.request.contextPath}/upload.do"><div class="menu-r">Upload</div></a>
	</c:when>
	<c:otherwise>
	<div class="menu-unlogin">
		<i class="fas fa-music fa-lg" onclick='openmusicboxnull();'></i>
	</div>
	<div class="menu-unlogin">
		<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath}/member/membershipsub.do'">회원가입</button>
	</div>
	<div class="menu-unlogin">
		<button type="button" class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/member/login.do'">로그인</button>
	</div>
	</c:otherwise>
	</c:choose>
</div> 