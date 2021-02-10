<%@page import="org.springframework.web.bind.annotation.SessionAttribute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/favicon.png">
	
	<title>Home</title>
	
	<!-- jquery, bootstrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!--     Fonts and icons     -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800" rel="stylesheet" />
	<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<!-- Nucleo Icons -->
	<link href="${pageContext.request.contextPath}/assets/css/nucleo-icons.css" rel="stylesheet" />
	<!-- CSS Files -->
	<link href="${pageContext.request.contextPath}/assets/css/black-dashboard.css?v=1.0.0" rel="stylesheet" />
	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link href="${pageContext.request.contextPath}/assets/demo/demo.css" rel="stylesheet" />
	<style>
	a{
	color: white;
	}
	.miniinfos{
	margin-left: 120px;
	width: 100%;
	text-align: left;
	padding-left: 60px;
	}
	
	@media (max-width: 991.98px) {
	.minibuttons{
	width: 150px;
	float: right;
	}
	.miniinfos{
	max-width: 120px!important;
	margin-left: 0!important;
	margin-top : 0!important;
	vertical-align: middle;
	padding-bottom: 10px;
	text-align: left;
	padding-left: 0px;
	}
	.miniinfo{
	display: inline;
	}
	.cnt{
	float: left; 
	position: relative;
	left: 0px;
	}
	}
	.minibtn.heart{
	background: white;
	color: #e14eca;
	}
	.minibtn.following{
	background: white;
	color: #e14eca;
	}
	.col-lg-4.photo{
	width: 33% !important;
	padding-right: 0px;
	}
	.sidebarimg{
	border-radius: 49%;
	width: 58px;
	height: 68px;
	}
	.sidepro{
	width: 67% !important;
	padding-left: 0px;
	margin-top: 5px;}
	.logo.followlist{
	padding-left: 16px;
	padding-right: 16px;}
	} 
	</style>
</head>
<script type="text/javascript">
function heartbtn(audioIdx) {
	var a = audioIdx;
	var clas = document.getElementsByClassName("minibtn heart "+a);
	if("${pageContext.request.userPrincipal.name}"==""||"${pageContext.request.userPrincipal.name}"==null){
		alert("로그인후 이용하세요");
		location.href="${pageContext.request.contextPath}/member/login.do";
	}else{
   		if(clas.length==0){
   			like(a);
   		}else{
   			nolike(a);
   		}
	}
}
function like(audioIdx){
 	var a = audioIdx;
	var count;
	 $.ajax({
	      url : "./like.do",
	      type : "get",
	      contentType : "text/html;charset:utf-8",
	      data : { audio_idx :a,like_id:"${pageContext.request.userPrincipal.name}"}, 
	      dataType : "json",
	      success : function sucFunc(resData) {
	    	 var section1s = document.getElementsByClassName("minibtn noheart "+a);
	    	 for(var i = section1s.length-1; i>=0; i--){
	         var sec1 = section1s.item(0);
	         sec1.className="minibtn heart "+a;
	          count = resData.likecount;
	          $( '.miniinfo.heart.'+a ).html( '<i class="tim-icons icon-heart-2"></i> : '+count );
	    	  }
	      }    
	 });   
}
function nolike(audioIdx){
   var a = audioIdx;  
   var count;
   $.ajax({
      url : "./nolike.do",
      type : "get",
      contentType : "text/html;charset:utf-8",
      data : { audio_idx :a,like_id:"${pageContext.request.userPrincipal.name}"}, 
      dataType : "json",
      success : function sucFunc(resData){
    	 var section1s = document.getElementsByClassName("minibtn heart "+a);
    	 for(var i = section1s.length-1; i>=0; i--){
         var sec1 = section1s.item(0);
         sec1.className="minibtn noheart "+a;
          count = resData.likecount;
          $( '.miniinfo.heart.'+a ).html( '<i class="tim-icons icon-heart-2"></i> : '+count );
    	 }
      }
   });
}
	</script>
	<script type="text/javascript">
	/* 버튼눌렀을때 팔로잉중인경우 언팔로우, 팔로우 안하는중이면 팔로우 함수로 이동 */
function fBtn(follow) {
	var f = follow;
	var clas = document.getElementsByClassName("minibtn following "+f);
	if("${pageContext.request.userPrincipal.name}"==""||"${pageContext.request.userPrincipal.name}"==null){
	alert("로그인후 이용하세요");
	location.href="${pageContext.request.contextPath}/member/login.do";
	}else{
		if(clas.length==0){
			followbtn(f);
		}else{
			unfollowbtn(f);
		}
	}
}
function followbtn(follow){
  var f = follow;
     
	$.ajax({
		url : "./addFollower.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : { followId :"${pageContext.request.userPrincipal.name}",followerId:f}, 
		dataType : "json",
		success : function a(resData) {
			var section1s = document.getElementsByClassName("minibtn unfollowing "+f);
			  for(var i = section1s.length-1; i>=0; i--){
				  var sec1 = section1s.item(i);
				  sec1.className="minibtn following "+f;
				  }
		} 
		
	});	
}
function unfollowbtn(follow){
	var f = follow;
	$.ajax({
		url : "./unFollow.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : { followId :"${pageContext.request.userPrincipal.name}",followerId:f}, 
		dataType : "json",
		success : function sucFunc(resData){
			 var section1s = document.getElementsByClassName("minibtn following "+f);
			  for(var i = section1s.length-1; i>=0; i--){
			    var sec1 = section1s.item(i);
			    sec1.className="minibtn unfollowing "+f;
			  }
		}
	});
}
	
function donatebtn(audio_idx){
	 if("${pageContext.request.userPrincipal.name}"==""||"${pageContext.request.userPrincipal.name}"==null){
		   alert("로그인후 이용하세요");
		   location.href="${pageContext.request.contextPath}/member/login.do";
	 }else{
		 var win = window.open("./"+"/donate.do", "PopupWin", "width=500,height=600");
	 }
}
</script>
<body class="">
  
  <!-- 상단 -->
  <%@include file="/resources/include/top.jsp" %>
        <!-- top searchModal -->
	  <%@include file="/resources/include/searchModal.jsp" %> 
  
  <div class="wrapper">
  	<!-- 사이드바 -->
    <%@include file="/resources/include/left_sidebar.jsp" %>
    
    <!-- 메인보드 -->
    <div class="main-panel">
	  
      <!-- 본문-->
      <!-- 아티스트명, 곡명, 앨범이름, 재생횟수, 추천수, 해시태그, 댓글수, 재생버튼,플레이리스트 추가, 하트버튼 표시 -->
      
      <div class="content">
        <c:forEach var="a" begin="0" end="${popMap.size()}" step="1">
        <c:forEach var="b" items="${popMap}">
        <c:if test="${a eq b.key }">
         <div class="card">
           <div class="card-header">
             <div class="row">
               <!-- 본문 제목 -->
               <div class="col-lg-7 text-left">
                 <h5 class="card-category">${ b.value.category}</h5>
                 <h2 class="card-title"><a href="./board/view.do?audio_idx=${b.value.audio_idx }">${ b.value.audiotitle}</a> - <a href="./${b.value.id }/record">${ b.value.artistname}</a> </h2>
                 <c:forEach var="al" items="${album }">
                 <c:if test="${al.album_idx eq b.value.album_idx }">
                 <h4 class="stats"> <a href="./${b.value.id }/album"> ${al.albumName}</a></h4></c:if>
                 </c:forEach>
                 
                 
               </div>
               <!-- 본문 제목 종료 -->
               <!-- 본문 내부 버튼 -->
               <div class="col-lg-5 subinfo">
               <div class="minibuttons">
               <!-- 하나라도 일치하는 팔로우 정보가 있으면 followB가 true로 바뀜 -->
               <c:set var="followB" value="false"/>
        		<c:forEach var="f" items="${follows }">
        		<c:if test="${pageContext.request.userPrincipal.name eq f.user_id and b.value.id eq f.following_id}">
        		<c:set var="followB" value="true"/>
        		</c:if>
        		</c:forEach>
        		<c:set var="likeB" value="false"/>
        		<c:forEach var="l" items="${likes }">
        		<c:if test="${b.value.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
               <c:choose>
               <c:when test="${followB}">
                 <button type="button" class="minibtn following ${b.value.id}" id="follow${b.value.id}" name="minibtn" title="팔로우" onclick="fBtn('${b.value.id}')" 
                 	name="${b.value.id}"><i class="tim-icons icon-link-72"></i></button>
                 </c:when>
                 <c:otherwise>
                 <button type="button" class="minibtn unfollowing ${b.value.id}" id="follow${b.value.id}" name="minibtn" title="팔로우" onclick="fBtn('${b.value.id}')" 
                 	name="${b.value.id}"><i class="tim-icons icon-link-72"></i></button>
                 </c:otherwise>
               </c:choose>
                
                 <button type="button" class="minibtn" title="후원" onclick="donatebtn('${b.value.id}')"  name="minibtn"><i class="tim-icons icon-gift-2"></i></button>
               <c:choose>
               <c:when test="${likeB}">
                      <button type="button" class="minibtn heart ${b.value.audio_idx}" title="좋아요" onclick="heartbtn('${b.value.audio_idx}')" name="heart-btn" name="minibtn"><i class="tim-icons icon-heart-2"></i></button> 
                 </c:when>
                 <c:otherwise>
                      <button type="button" class="minibtn noheart ${b.value.audio_idx}" title="좋아요" onclick="heartbtn('${b.value.audio_idx}')"  name="minibtn"><i class="tim-icons icon-heart-2"></i></button> 
                 </c:otherwise>
               </c:choose>
                 <button type="button" class="minibtn addlistbtn" title="플레이리스트 추가" onclick="addlistbtn('${b.value.audio_idx}')"  name="minibtn"><i class="tim-icons icon-bullet-list-67"></i></button>
               </div>
               <div class="miniinfos">
               <h4 class="miniinfo"><i class="tim-icons icon-tap-02"></i> : ${b.value.play_count}  </h4><h4 class="miniinfo heart ${b.value.audio_idx}"><i class="tim-icons icon-heart-2"></i> : ${b.value.like_count }</h4>
               </div>
               </div>
               <!-- 본문 내부 버튼 종료 -->
             </div>
             
             <!-- 본문내용 -->

             <!-- 본문내용종료 -->
           </div>
             <div class="card-body">
           	<h4> <a href="">댓글 
         	<c:forEach var="d" items="${commentC}">
           	<c:if test="${b.value.audio_idx eq d.key}">
           	${d.value }
           	</c:if>
           	</c:forEach>
           	개</a>  </h4>
           </div>
           </div>
            </c:if>
           </c:forEach>
         </c:forEach>
      </div>
      <!-- 본문종료 -->
	</div>
  </div>
<!--   Core JS Files   -->
<%@include file="/resources/include/script.jsp" %>
</body>
</html>

