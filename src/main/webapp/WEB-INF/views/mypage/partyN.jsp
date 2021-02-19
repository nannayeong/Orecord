<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${memberDTO.nickname }(${user_id })님의 페이지</title>
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
function recordDeleteFunc(aidx){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		if(confirm('삭제하시겠습니까?')){
			$.ajax({
			     url : "../recordDelete.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {audio_idx:aidx},
			     dataType : "json",
			     success : function sucFunc(resData) {
			    	 if(resData.result==1){
							alert("정상적으로 삭제되었습니다");
							location.href="./record";
					 }
			     }    
			});
		}
	}
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
function pointCheck(){
	var sponPoint = $("#sponPoint").val();
	var myPoint = $("#myPoint").val();
	var checkPoint = myPoint - sponPoint;
	if(sponPoint == '' || sponPoint =='0'){
		alert('후원 포인트를 입력해주세요.');
		$('#sponPoint').focus();
		return false;
	}
	else if((sponPoint % 100) != 0){
		alert('후원 포인트는 100포인트 단위로 입력해주세요.');
		$('#sponPoint').focus();
		return false;
	}
	else if(checkPoint < 0){
		alert('보유 포인트가 부족합니다.');
		$('#sponPoint').focus();
		return false;
	}
	else {
		var patronId = document.getElementById("patronId").value;
		$.ajax({
			url : "../insertSponsorshipLog.do",
			type : "post",
			data : {patronId : patronId,
							sponPoint : sponPoint},
		  beforeSend : function(xhr)
              {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                  xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              },
			success : function(data) {
				if (data != null) {
					alert(patronId + "님에게 " + sponPoint + "포인트를 후원하였습니다.");
					location.reload();
				}
				else {
					alert("후원에 실패하였습니다.");
				}
			},
			error : function(error) {
				alert("error : " + error);
			}
		});
	}
}

function commentNcheck(c) {
	if("${pageContext.request.userPrincipal.name}"==""){
		   alert("로그인후 이용하세요");
		   location.href='${pageContext.request.contextPath}/member/login.do';
		   return false
	}else if(c.cInput.value==""||c.cInput.value==null){
		alert("내용을 입력하세요")
		c.focus();
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
	/*팔로우*/
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
				<%@include file="/resources/jsp/mypageProfile.jsp" %>

			<div>
				<div class="my-menu">
					<span onclick="location.href='../${user_id}/record'">record</span>
					<span onclick="location.href='../${user_id}/album'">album</span>
					<span onclick="location.href='../${user_id}/playlist'">playlist</span>
					<c:if test="${user_id eq pageContext.request.userPrincipal.name}">
					<span onclick="location.href='../${user_id}/yParty'" style="color:orange;">party</span>
					</c:if>
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
						        <input type="hidden" id="patronId" value="${user_id }" />
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						      </div>
						
						      <!-- Modal body -->
						      <div class="modal-body">
						        <div>${pageContext.request.userPrincipal.name}님의 잔여 포인트 :
						        	<input type="text" id="myPoint" value="${loginDTO.mypoint }" size="3" style="border: 0px;">원
						        	<button type="button" class="btn btn-info btn-sm" style="margin-bottom:5px; margin-left:130px;"onclick="location.href='../chargeLog.do'">충전하기</button>
						        </div>
						        
						        <div>후원하실 포인트를 입력해주세요 : <input type="text" id="sponPoint" name="sponPoint" value="" style="width:7em" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/> 원</div>
										<div id="doneError"> </div>
						      </div>
						
						      <!-- Modal footer -->
						      <div class="modal-footer">
						        <button type="button" class="btn btn-warning btn-sm" onClick="pointCheck();">후원하기</button>
						        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">취소하기</button>
						      </div>
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
								<div style="text-align:center">
									<div class="btn-group" style="margin-bottom:1em;margin-left:1em;text-size:16px;">
									  <button type="button" class="btn btn-outline-dark" onclick="location.href='./yParty'" style="width:10em">참여완료</button>
									  <button type="button" class="btn btn-dark" onclick="location.href='./nParty'" style="width:10em">참여신청</button>
									</div>
								</div>
								<div id="albumList">
									<table class="table table-hover" style="width:90%; margin:auto; text-align:center">
										<c:choose>
										<c:when test="${empty plist}">
										<tr>
											<th style="text-align:center"><h3>참여 신청글이 없습니다.</h3></th>
										</tr>
										</c:when>
										<c:otherwise>
										<thead>
									      <tr>
									      	<th></th>
									        <th>원곡</th>
									        <th>종류</th>
									        <th>제목</th>
									        <th>포인트</th>
									        <th>채택기한</th>
									      </tr>
									    </thead>
									    </c:otherwise>
									    </c:choose>
										<c:forEach items="${plist }" var="p" varStatus="status">
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowDate" />
										<fmt:formatDate value="${p.exdate}" pattern="yyyyMMdd" var="exDate" /> 
									    <tbody>
									      <tr>
									      	<td>${status.count }</td>
									      	<td><a href="../board/view.do?audio_idx=${p.audio_idx}">${p.audiotitle}</a></td>
									        <td>${p.kind }</td>
									        <td><a href='../board/partyView.do?party_idx=${p.party_idx}&id=${pageContext.request.userPrincipal.name}'>
									        ${p.title }</a></td>
									        <td>${p.point }p</td>
									        <td>${exDate < nowDate ? '기한종료' : p.exdate}</td>
									      </tr>
									    </tbody>
										</c:forEach>
									</table>
									<br />
									<div style="text-align:center">
										${pagingUtil }
									</div>
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
	</div>
		<!-- 본문종료 -->
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 