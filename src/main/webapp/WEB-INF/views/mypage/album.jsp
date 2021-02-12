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

function deleteAlbumFunc(aidx){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		if(confirm('앨범을 삭제하시겠습니까?')){
			$.ajax({
			     url : "../deleteAlbum.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {album_idx:aidx}, 
			     dataType : "json",
			     success : function sucFunc(resData) {
					 if(resData.result==1){
						alert("정상적으로 삭제되었습니다");
						location.href="./album";
					 }
			     }    
			});
		}
	}
}
function clickAudio(audioFileName,playerName){
	$('#'+playerName).attr('src',audioFileName).attr('autoplay',true);
}
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
		else if(bt.innerHTML=='언팔로우'){
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
function clickAudio(audioFileName,playerName){
	$('#'+playerName).attr('src',audioFileName).attr('autoplay',true);
}
function pointCheck(){
	if($('#doneError').html()!=''){
		alert('보유 포인트를 확인해주세요');
		return false;
	}
	if($('#donePoint').val()==''){
		alert('후원 포인트를 입력해주세요');
		return false;
	}
}

function likeFunc(a){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		if($('#likeIcon'+a).hasClass('on')){//이미 좋아요상태일 때
			$.ajax({
			      url : "../nolike.do",
			      type : "get",
			      contentType : "text/html;charset:utf-8",
			      data : { audio_idx :a}, 
			      dataType : "json",
			      success : function sucFunc(resData){
			    	  if(resData.result==1){
			    	  	$('#likeIcon'+a).removeClass('on');
			    	  	$('#likecount'+a).html(resData.likecount);
			    	  }
			      }
			   });
		}
		else{
			$.ajax({
			     url : "../like.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : { audio_idx :a}, 
			     dataType : "json",
			     success : function sucFunc(resData) {
			    	if(resData.result==1){
						$('#likeIcon'+a).addClass('on');
						$('#likecount'+a).html(resData.likecount);
			    	}
			     }    
			});  
		}
	}
}

$(function(){
	/* 페이징 */
	var nowP = 1;
	$(window).scroll(function(){
		var scrollHeight = $(document).height();
		var scrollPosition = $(window).height() + $(window).scrollTop();		
		if(scrollPosition > scrollHeight -1){
			nowP = nowP + 1;
			$.ajax({
			     url : "../mypageAlbum.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {user_id:"${user_id}", 
			    	 	nowPage:nowP},
			     dataType : "html",
			     success : function sucFunc(resData) {
			    	 $('#albumList').append(resData);
			     }    
			});
		}
	});
	
	$('#follow').mouseenter(function(){
		if($('#follow').html()=='팔로워'){
			$('#follow').html('언팔로우');
		}
	});
	$('#follow').mouseleave(function(){
		if($('#follow').html()=='언팔로우'){
			$('#follow').html('팔로워');
		}
	});
	
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
	     url : "../mypageAlbum.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {user_id:"${user_id}", 
	    	 	nowPage:"${nowPage eq null?1:nowPage}"},
	     dataType : "html",
	     success : function sucFunc(resData) {
	    	 $('#albumList').html(resData);
	     }    
	});
	
	$('#donePoint').keyup(function(){
		if($('#donePoint').val()>$('#myPoint').html()){
			$('#doneError').html('보유 포인트가 부족합니다.');
		}
		else{
			$('#doneError').html('');
		}
	});
});
</script>
</head>
<body style="background-color:#f2f2f2;">
	<div>
		<div class="content">
			<div class="profile" style="background-color:brown;">
				<%@include file="/resources/jsp/mypageProfile.jsp" %>
			</div>
			<div>
				<div class="my-menu">
					<span onclick="location.href='../${user_id}/record'">record</span>
					<span onclick="location.href='../${user_id}/album'" style="color:orange;">album</span>
					<span onclick="location.href='../${user_id}/playlist'">playlist</span>
					
					<div style="float:right;margin-right:1em;">
						<c:choose>
						<c:when test="${user_id ne pageContext.request.userPrincipal.name}">
						<button type="button" onclick="logincheck(this)" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#done">후원하기</button>
						<!-- The Modal -->
						<c:if test="${not empty pageContext.request.userPrincipal.name}">
						<div class="modal" id="done">
						  <div class="modal-dialog">
						    <div class="modal-content">
						
						      <!-- Modal Header -->
						      <div class="modal-header">
						        <h4 class="modal-title">${memberDTO.nickname }(${user_id })님에게 후원하기</h4>
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						      </div>
						
						      <!-- Modal body -->
						      <form action="?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return pointCheck();">
						      <div class="modal-body">
						        <div>${pageContext.request.userPrincipal.name}님의 잔여 포인트 :<span id="myPoint">${loginDTO.mypoint }원</span>&nbsp&nbsp
						        	<button type="button" class="btn btn-info btn-sm" style="margin-bottom:5px"onclick="location.href='../chargeLog.do'">충전하기</button>
						        </div>
						        
						        <div>후원하실 포인트를 입력해주세요 : <input type="text" id="donePoint" name="donePoint" style="width:7em"/> 원</div>
								<div id="doneError"></div>
						      </div>
						
						      <!-- Modal footer -->
						      <div class="modal-footer">
						        <button type="submit" class="btn btn-warning btn-sm">후원하기</button>
						      </div>
							</form>
						    </div>
						  </div>
						</div>
						</c:if>
						<button type="button" onclick="logincheck(this)" id="follow" class="btn btn-success btn-sm">팔로우</button>
						</c:when>
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