<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - 협업 진행</title>
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
<style>
body{
	background-color:#f2f2f2;
}

.content{
	background-color:white;
	margin:auto;
	width:960px;
	margin-top: 3em;
}
.left-content-back{
	background-color:white;
	width:70%;
	float:left;
	display:inline-block;
}
.left-content{
	background-color:white;
	width:95%;
	max-width: 800px;
	margin:auto;
	padding-top:1em;
	content-align:center;
	padding-bottom:1em;
}
.right-content-back{
	background-color:white;
	max-width:288px;
	height : 100%;
	width:30%;
	display:inline-block;
	position: fixed;
	top: 0px;
	float: left;
}
.right-content{
	background-color:white;
	width:100%;
	height : 960px!;
	margin:auto;
	padding-top:4em!important;
	padding-bottom:1em;
	text-align: center;
}
.fix{ 
 	position:fixed;
 	right:0;
}
header{
	background-color:#333333;
	height:3em;
	position:fixed;
	top:0;
	left:0;
	right:0;
}
.menu-back{
	width:960px;
	margin:auto;
}
.logo{
	color: white;
    background-color:orange;
    height:3em;
    width:6em;
    float:left;
    vertical-align:middle;
    padding-top:0.5em;
    text-align:center;
}
.menu{
    color: white;
    background-color:#333333;
    height:3em;
    width:6em;
    float:left;
    vertical-align:middle;
    padding-top:0.5em;
    text-align:center;
}
.menu-r{
    color: white;
    background-color:#333333;
    height:3em;
    width:6em;
    float:right;
    vertical-align:middle;
    padding-top:0.5em;
    text-align:center;
}
.search{
	color: white;
    background-color:#333333;
    height:3em;
    float:left;
    padding-top:0.5em;
    padding-left:7px;
    text-align:center;
}
.noti{
	color:white;
	background-color:#333333;
	height:3em;
	width:4em;
	float:right;
    vertical-align:middle;
    padding-top:0.6em;
    text-align:center;
}
.menu-unlogin{
	color:white;
	background-color:#333333;
	height:3em;
	float:right;
    vertical-align:middle;
    padding-top:0.6em;
    text-align:center;
    padding-right:1em;
}
.sidebar{
width: 100%;
}
h6{
display: inline;}
li{list-style:none;color:black;background-color:white;width:8em;border:2px #f2f2f2 solid;}
</style>


<script type="text/javascript">
/* function test() {
	var length = $(".pcount").length;
	alert("피드갯수"+length);
	var loadingNum = $(".loadingTotalNum").val();
	alert(loadingNum);
} */

$(window).on("scroll", function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();		
	var loadedSize = $('.feed').length;
	var feedEnd = $(".feedEnd").val();
	$("#scrollHeight").text(scrollHeight);
	$("#scrollPosition").text(scrollPosition);
	$("#bottom").text(scrollHeight - scrollPosition);
	if (scrollPosition > scrollHeight -1) {	
		 $.ajax({
		      url : "./Co_op_Main.do",
		      type : "get",
	            contentType : "text/html;charset:utf-8",
		      data : { loadlength :loadedSize,id:"${pageContext.request.userPrincipal.name}"}, 
		      dataType : "html",
		      async    : false,
		      success : function(resData) {
		    	  $('.feed').last().after(resData);
		    	  $.checktotalLoad();
		      },
		      error : function(e) {
			}
		      
		 }); 
	
	
	}
	
});


$($.checktotalLoad = function () {
	var loadedSize = $('.feed').length;
	var end = $('.end').val();
	 $.ajax({
	      url : "./loadMainCount.do",
	      type : "get",
           contentType : "text/html;charset:utf-8",
	      data : { loadlength :loadedSize, partyType:<%=request.getParameter("partyType")%>}, 
	      dataType : "json",
	      success : function(resData) {
	    	  if(resData.nomoreFeed!=null){
	    	  if(end==undefined){
	    		  $('.feed').last().after("<h3 class='end'>"+resData.nomoreFeed+"</h3>");
	    	  }}
	    	  
	      },
	      error : function(e) {
		}
	      
	 });
});
</script>



<script> 
function checknull(form) {
	if(form.searchWord.value==null||form.searchWord.value==""){
		alert("검색어를 입력하세요");
		return false;
	}
}
</script>
<script type="text/javascript">
function heartbtn(audioIdx) {
	var a = audioIdx;
	var clas = document.getElementsByClassName("btn btn-warning btn-sm heart "+a);
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
	    	 var section1s = document.getElementsByClassName("btn btn-secondary btn-sm heart "+a);
	    	 for(var i = section1s.length-1; i>=0; i--){
	         var sec1 = section1s.item(0);
	         sec1.className="btn btn-warning btn-sm heart "+a;
	          count = resData.likecount;
	          $(sec1).html("좋아요&nbsp;&nbsp;&nbsp;"
                      +count);
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
    	 var section1s = document.getElementsByClassName("btn btn-warning btn-sm heart "+a);
    	 for(var i = section1s.length-1; i>=0; i--){
         var sec1 = section1s.item(0);
         sec1.className="btn btn-secondary btn-sm heart "+a;
          count = resData.likecount;
          $(sec1).html("좋아요&nbsp;&nbsp;&nbsp;"
                  +count);
    	 }
      }
   });
}
	</script>
	<script type="text/javascript">
	/* 버튼눌렀을때 팔로잉중인경우 언팔로우, 팔로우 안하는중이면 팔로우 함수로 이동 */
function fBtn(follow) {
	var f = follow;
	var clas = document.getElementsByClassName("btn btn-warning btn-sm follow " + f);
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
function followbtn(follow) {
	var f = follow;

	$.ajax({
		url : "./addFollower.do",
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
				sec1.className = "btn btn-warning btn-sm follow " + f;
			}
			count = resData.followcount;
			$('.pCount.' + f).html('팔로워 : ' + count);
		}

	});
}
function unfollowbtn(follow) {
	var f = follow;
	$.ajax({
		url : "./unFollow.do",
		type : "get",
		contentType : "text/html;charset:utf-8",
		data : {
			followId : "${pageContext.request.userPrincipal.name}",
			followerId : f
		},
		dataType : "json",
		success : function sucFunc(resData) {
			var section1s = document
					.getElementsByClassName("btn btn-warning btn-sm follow " + f);
			for (var i = section1s.length - 1; i >= 0; i--) {
				var sec1 = section1s.item(i);
				sec1.className = "btn btn-secondary btn-sm follow " + f;
			}
			count = resData.followcount;
			$('.pCount.' + f).html('팔로워 : ' + count);
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

function commentNcheck(c) {
	if("${pageContext.request.userPrincipal.name}"==""||"${pageContext.request.userPrincipal.name}"==null){
		   alert("로그인후 이용하세요");
		   location.href='${pageContext.request.contextPath}/member/login.do';
		   return false
	}else if(c.cInput.value==""||c.cInput.value==null){
		alert("내용을 입력하세요")
		c.focus();
		return false;
	}
	
}
</script>
<script>
$(function(){
	if($('.right-content').height()>$('.left-content').height()){
		$('.right-content-back').css("border-left","3px #f2f2f2 solid");
	}
	else{
		$('.left-content-back').css("border-right","3px #f2f2f2 solid");
	}
});

var count_setting = 0;
function settingFunc(){
	count_setting = count_setting+1;
	if(count_setting%2==1){
		$('.setting-down').css('visibility','');
		$('.setting-down').css('visibility','visibility');
	}
	else{
		$('.setting-down').css('visibility','');
		$('.setting-down').css('visibility','hidden');
	}
}
var count_noti = 0;
function notiFunc(){
	count_noti = count_noti+1;
	if(count_noti%2==1){
		$('.noti-down').css('visibility','');
		$('.noti-down').css('visibility','visibility');
	}
	else{
		$('.noti-down').css('visibility','');
		$('.noti-down').css('visibility','hidden');
	}
}

var count_user = 0;
function userFunc(){
	count_user = count_user+1;
	if(count_user%2==1){
		$('.user-down').css('visibility','');
		$('.user-down').css('visibility','visibility');
	}
	else{
		$('.user-down').css('visibility','');
		$('.user-down').css('visibility','hidden');
	}
}

</script>

</head>
<body>
	<div>
		<div class="content">
			<div class="left-content-back">
				<div class="left-content">
				<%@include file="./Co_op_MainAdd.jsp"%>
				</div>
			</div>
			<div class="right-content-back">
				<div class="right-content">
					<div class="sidebar recF">
					<c:forEach var="rf" items="recommendF">
					<div class=""></div>
					</c:forEach>
					</div>
					<div class="sidebar myF"> 
					</div>
		
				<%@include file="/resources/jsp/rightbar.jsp"%>
				</div>
			</div>
		</div>
			 
	</div>
	
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<div class="menu-back">
			<%@include file="/resources/jsp/header.jsp" %>
		</div>
	</header>
</body>
</html>