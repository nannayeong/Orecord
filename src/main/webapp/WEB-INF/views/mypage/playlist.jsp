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

function logincheck(bt){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		if(bt.innerHTML=='후원하기'){
			
		}
		else if(bt.innerHTML=='팔로우'){
			$.ajax({
			     url : "../addFollower.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {followerId:"${user_id}"},
			     dataType : "html",
			     success : function sucFunc(resData) {
			    	 bt.innerHTML = '팔로워';
			    	 $('#follow').removeClass();
		    		 $('#follow').addClass('btn btn-outline-success btn-sm');
			     }    
			});
			
			/* 팔로잉/팔로워/게시물 숫자 불러오기 */
			$.ajax({
			     url : "../mypageFollowTrack.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {user_id:"${user_id}"}, 
			     dataType : "json",
			     success : function sucFunc(resData) {
			   	  $('#following').html(resData.followingCount);
			   	  $('#followers').html(resData.followerCount);
			   	  $('#track').html(resData.trackCount);
			     }    
			});
		}
		else if(bt.innerHTML=='팔로워'){
			$.ajax({
			     url : "../unFollow.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {followerId:"${user_id}"},
			     dataType : "html",
			     success : function sucFunc(resData) {
			    	 bt.innerHTML = '팔로우';
			    	 $('#follow').removeClass();
			    	 $('#follow').addClass('btn btn-success btn-sm');
			     }    
			});
			
			/* 팔로잉/팔로워/게시물 숫자 불러오기 */
			$.ajax({
			     url : "../mypageFollowTrack.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {user_id:"${user_id}"}, 
			     dataType : "json",
			     success : function sucFunc(resData) {
			   	  $('#following').html(resData.followingCount);
			   	  $('#followers').html(resData.followerCount);
			   	  $('#track').html(resData.trackCount);
			     }    
			});
		}		 
	}
}

$(function(){
	/*로그인 아이디의 팔로우여부 확인하기*/
	$.ajax({
	     url : "../checkFollow.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {user_id:"${user_id}"},
	     dataType : "json",
	     success : function sucFunc(resData) {
	    	 //언팔상태
	    	 if(resData.follow==0){
	    		 $('#follow').html('팔로우');
	    		 $('#follow').addClass('btn btn-success btn-sm');
	    	 }
	    	 else if(resData.follow==1){
	    		 $('#follow').html('팔로워');
	    		 $('#follow').removeClass();
	    		 $('#follow').addClass('btn btn-outline-success btn-sm');
	    	 }	 
	     }    
	});		
	
	/* 팔로잉/팔로워/게시물 숫자 불러오기 */
	$.ajax({
	     url : "../mypageFollowTrack.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {user_id:"${user_id}"}, 
	     dataType : "json",
	     success : function sucFunc(resData) {
	   	  $('#following').html(resData.followingCount);
	   	  $('#followers').html(resData.followerCount);
	   	  $('#track').html(resData.trackCount);
	     }    
	});
	
	/* 리스트페이지 */
	$.ajax({
	     url : "../mypagePlay.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {user_id:"${user_id}", 
	    	 	nowPage:"${nowPage==null?1:nowPage}"},
	     dataType : "html",
	     success : function sucFunc(resData) {
	    	 $('#albumList').html(resData);
	     }    
	});
});
</script>
</head>
<body>
	<div>
		<div class="content">
			<div class="profile" style="background-color:brown;">
				<table style="">
					<tr>
						<td rowspan="2" style="padding-top:2em;padding-left:2em">
							<img src="${pageContext.request.contextPath}/resources/img/default.jpg" alt="" style="width:200px;border-radius:50%"/>
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
					<span onclick="location.href='../${user_id}/record'">record</span>
					<span onclick="location.href='../${user_id}/album'">album</span>
					<span onclick="location.href='../${user_id}/playlist'" style="color:orange;">playlist</span>
					<span onclick="location.href='../${user_id}/like'">like</span>
					
					<div style="float:right;margin-right:1em;">
						<c:choose>
						<c:when test="${user_id ne pageContext.request.userPrincipal.name}">
						<button type="button" onclick="logincheck(this)" id="done" class="btn btn-warning btn-sm">후원하기</button>			
						<button type="button" onclick="logincheck(this)" id="follow" class="btn btn-success btn-sm">팔로우</button>
						</c:when>
						<c:otherwise>
						<button type="button" onclick="location.href='../upload.do'">업로드하기</button>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="my-content">
					<table style="width:100%;margin:1em 0 3em 0em;">
						<tr>
							<td class="my-con-left">
								<div id="albumList">
								
								</div>
							</td>
							<td class="my-con-right">
								<%@include file="/resources/jsp/mypageFollowTrack.jsp" %>
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