<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
body{
	background-color:#f2f2f2;
}
a{
color: #333333;}
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
	width:30%;
	display:inline-block;
}
.right-content{
	background-color:white;
	width:100%;
	max-width:288px;
	margin:auto;
	padding-top:3em;
	padding-bottom:1em;
	position: fixed;
	top: 0px;
	float: left;
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
	var loadedSize = $('table').length;
	var feedEnd = $(".feedEnd").val();
	$("#scrollHeight").text(scrollHeight);
	$("#scrollPosition").text(scrollPosition);
	$("#bottom").text(scrollHeight - scrollPosition);
	if (scrollPosition > scrollHeight -1) {	
		 $.ajax({
		      url : "./audiolistAdd.do",
		      type : "get",
	            contentType : "text/html;charset:utf-8",
		      data : { loadlength :loadedSize,id:"${pageContext.request.userPrincipal.name}"}, 
		      dataType : "html",
		      async    : false,
		      success : function(resData) {
		    	  $('table').last().after(resData);
		    	  $.checktotalLoad();
		      },
		      error : function(e) {
				alert("실패"+e);
			}
		      
		 }); 
	
	
	}
	
});



$($.checktotalLoad = function () {
	var loadedSize = $('table').length;
	var end = $('.end').val();
	 $.ajax({
	      url : "./loadCount.do",
	      type : "get",
           contentType : "text/html;charset:utf-8",
	      data : { loadlength :loadedSize}, 
	      dataType : "json",
	      success : function(resData) {
	    	  if(resData.nomoreFeed!=null){
	    	  if(end==undefined){
	    		  $('table').last().after("<h3 class='end'>"+resData.nomoreFeed+"</h3>");
	    	  }}
	    	  
	      },
	      error : function(e) {
			alert("실패"+e);
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
	var clas = document.getElementsByClassName("btn btn-outline-secondary btn-sm heart "+a);
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
	         sec1.className="btn btn-outline-secondary btn-sm heart "+a;
	          count = resData.likecount;
	          $( '.lCount.'+a ).html( '좋아요 : '+count );
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
    	 var section1s = document.getElementsByClassName("btn btn-outline-secondary btn-sm heart "+a);
    	 for(var i = section1s.length-1; i>=0; i--){
         var sec1 = section1s.item(0);
         sec1.className="btn btn-secondary btn-sm heart "+a;
          count = resData.likecount;
          $( '.lCount.'+a ).html( '좋아요 : '+count );
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
        <c:forEach var="b" items="${audiolist}">
					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="pcount">
						<tr>
							<td rowspan="4" style="width:7em;padding-left:1em;padding-right:1em">
								<img src="./resources/default.jpg" alt="" style="width:6em"/>
							</td>
							<td><a href="./board/view.do?audio_idx=${b.audio_idx }">${ b.audiotitle}</a> - <a href="./${b.id }/record">${b.artistname}</a></td>
						</tr>
						<tr>
							<td colspan="2">
								<audio src="" controls style="width:95%" >
									<source src="">
								</audio>
							</td>
						</tr>
						<tr>
							<td>
							<c:set var="likeB" value="false"/>
								<c:forEach var="l" items="${likes }">
        		<c:if test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
					<c:choose>
               			<c:when test="${likeB}">
                      		<button type="button" class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">좋아요</button> 
                 		</c:when>
                 <c:otherwise>
                      <button type="button" class="btn btn-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')"  name="minibtn">좋아요</button> 
                 </c:otherwise>
               		</c:choose>
								<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
								<button type="button" class="btn btn-secondary btn-sm" onclick="coOp('${b.audio_idx}')">참여</button>
							</td>
							<td style="text-align:center">
								<h6 class="pCount ${b.audio_idx }">재생 : ${b.play_count} </h6> <h6 class="lCount ${b.audio_idx }">좋아요 : ${b.like_count }</h6> 
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
								
								</form>
							</td>
						</tr>
					</table>
           </c:forEach>
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
					첫하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />막하이<br />
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