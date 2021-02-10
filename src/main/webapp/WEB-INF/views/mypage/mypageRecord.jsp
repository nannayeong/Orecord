<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
#list{
border:2px #f2f2f2 solid
}
#list:hover{
background-color: #f2f2f2;cursor:pointer
}
</style>
</head>
<body>
<table style="width:95%;margin:auto;margin-bottom:1em;">
<c:choose>
<c:when test="${empty audioList }">
	<tr>
		<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
			<div>등록된 레코드가 없습니다.</div><br />
			<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
			<div><button type="button" onclick="location.href='../upload.do'" class="btn btn-outline-dark">업로드하기</button></div>
			</c:if>
		</td>
	</tr>
</c:when>
<c:otherwise>
<c:forEach items="${audioList }" var="audio" varStatus="status">
	<tr id="list">
		<td style="padding-left:1em;">
			${status.count}
		</td>
		<td>
			<img src="${audio.imagename }" style="width:30px;" />
		</td>
		<td>
			<audio controls style="background-color:white;width:50px;height:50px" id="${audio.albumName }">
    			<source src="${audio.audiofilename }" type="audio/mp4"/>
    		</audio>
		</td>
		<td onclick="location.href='../board/view.do?audio_idx=${audio.audio_idx}'">
			${audio.audiotitle }
		</td>
		<td>
			${audio.artistname }
		</td>
		<td>
			${audio.regidate }
		</td>
		<td>
			${audio.party eq 0 ? '협업불가' : '협업중'}
		</td>
		<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
		<td>
			<button type="button">수정</button>
			<button type="button">삭제</button>
		</td>
		</c:if>
	</tr>
</c:forEach>
</c:otherwise> 
</c:choose>
</table>

</body>
</html>