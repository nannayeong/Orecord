<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord musicbox</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<script>
var i = 1;

function plLoginC(){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="../member/login.do"
	}
	else{
		location.href="./musicbox?state=playlist";
	}
}

function playAudio(imagename, audiofilename, audiotitle, artistname, statecount){
	$('#nowaudioimg').attr('src','${pageContext.request.contextPath}/resources/upload/'+imagename);
	$('#nowaudiosource').attr('src','${pageContext.request.contextPath}/resources/upload/'+audiofilename);
	$('#title').html(audiotitle);
	$('#artist').html(artistname);
	$('#playstop').removeClass('fa-play');
	$('#playstop').addClass('fa-pause');
	$('#'+i).css('background-color','white');
	i = statecount;
	$('#'+i).css('background-color','yellow');
}

$(function(){
	/* free페이지페이징 */
// 	var nowP = 1;
// 	$(window).scroll(function(){
// 		var scrollHeight = $(document).height();
// 		var scrollPosition = $(window).height() + $(window).scrollTop();		
// 		if(scrollPosition > scrollHeight -1){
// 			nowP = nowP + 1;
// 			$.ajax({
// 			     url : "./freeList.do",
// 			     type : "get",
// 			     contentType : "text/html;charset:utf-8",
// 			     data : {nowPage:nowP},
// 			     dataType : "html",
// 			     success : function sucFunc(resData) {
// 			    	 $('#audioList').append(resData);
// 			     }    
// 			});
// 		}
// 	});
	
// 	/* free페이지 */
// 	$.ajax({
// 	     url : "./freeList.do",
// 	     type : "get",
// 	     contentType : "text/html;charset:utf-8",
// 	     data : {nowPage:"${nowPage==null?1:nowPage}"},
// 	     dataType : "html",
// 	     success : function sucFunc(resData) {
// 	    	 $('#audioList').html(resData);
// 	     }    
// 	});
// });

function noEvent() {
	if (event.keyCode == 116) {
	event.keyCode= 2;
	return false;
	}
	else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
	{
	return false;
	}
	}
	document.onkeydown = noEvent;
	
function audioSelectFunc(){
	$('#title').html(audiotitle);
	$('#artist').html(artistname);
}

$(function(){
	var size = '${listsize}';
	$.ajax({
 	     url : "./nextList.do",
 	     type : "get",
 	     contentType : "text/html;charset:utf-8",
 	     data : {arr:i},
 	     dataType : "json",
 	     success : function sucFunc(resData) {
 	    	$('#nowaudioimg').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.imagename);
	 	   	$('#nowaudiosource').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.audiofilename);
	 	   	$('#title').html(resData.dto.audiotitle);
	 	   	$('#artist').html(resData.dto.artistname);
	 	   	$('#'+i).css('background-color','yellow');
 	     }    
 	});
});

function playstop(){
	var nas = document.getElementById('nowaudiosource');
	if($('#playstop').hasClass('fa-play')){
		$('#playstop').removeClass('fa-play');
		$('#playstop').addClass('fa-pause');
		nas.play();
	}
	else if($('#playstop').hasClass('fa-pause')){
		$('#playstop').removeClass('fa-pause');
		$('#playstop').addClass('fa-play');
		nas.pause();
	}
}

function playnext(){
	i+=1;
	var size = '${listsize}';
	
	if(size<i){
		var dum = i-1
		$('#'+dum).css('background-color','white');
		i=1;
	}
	
	$.ajax({
 	     url : "./nextList.do",
 	     type : "get",
 	     contentType : "text/html;charset:utf-8",
 	     data : {arr:i},
 	     dataType : "json",
 	     success : function sucFunc(resData) {
 	    	$('#nowaudioimg').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.imagename);
	 	   	$('#nowaudiosource').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.audiofilename);
	 	   	$('#title').html(resData.dto.audiotitle);
	 	   	$('#artist').html(resData.dto.artistname);
	 		$('#playstop').removeClass('fa-play');
	 		$('#playstop').addClass('fa-pause');
	 	   	if(i==1){
	 	   		$('#'+i).css('background-color','yellow');
	 	   	}
	 	   	else{
		 	   	var prv = i-1;
		 	   	$('#'+i).css('background-color','yellow');
		 	    $('#'+prv).css('background-color','white');
	 	   	}
 	     }    
 	});
}

function playprev(){
	i-=1;
	if(i<0){
		$('#'+i).css('background-color','white');
		i=1
	}
	var size = '${listsize}';
	$.ajax({
 	     url : "./nextList.do",
 	     type : "get",
 	     contentType : "text/html;charset:utf-8",
 	     data : {arr:i},
 	     dataType : "json",
 	     success : function sucFunc(resData) {
 	    	$('#nowaudioimg').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.imagename);
	 	   	$('#nowaudiosource').attr('src','${pageContext.request.contextPath}/resources/upload/'+resData.dto.audiofilename);
	 	   	$('#title').html(resData.dto.audiotitle);
	 	   	$('#artist').html(resData.dto.artistname);
	 		$('#playstop').removeClass('fa-play');
	 		$('#playstop').addClass('fa-pause');
	 	   	if(i==1){
	 	   		var plus = i+1;
	 	   		$('#'+i).css('background-color','yellow');
	 	   		$('#'+plus).css('background-color','white');
	 	   	}
	 	   	else{
		 	   	var next = i+1;
		 	   	$('#'+i).css('background-color','yellow');
		 	    $('#'+next).css('background-color','white');
	 	   	}
	 	    
 	     }    
 	});
}
</script>
</head>
<body style="width:400px;" oncontextmenu="return false">
<!-- 로고 -->
	<div>
		<h3>O!record</h3>
	</div>
	<div>
		<table style="margin:auto;text-align:center;width:100%">
			<tr>
				<td style="width:50%;cursor:pointer;" class="bg-light" onclick="location.href='./musicbox?state=freelist'">재생목록</td>
				<td style="width:50%;cursor:pointer;" class="bg-warning" onclick="location.href='./musicbox?state=playlist'">나의 플레이리스트</td>
			</tr>
		</table>
	</div>
	<!-- 본문 -->
	<div id="here">
		<div class="card-deck">
		  <c:forEach items='${plSet }' var="plName">
		  <div class="card bg-light" style="width:80%;margin:auto;margin-top:1em;cursor:pointer;">
		    <div class="card-body text-center" onclick="location.href='./musicbox?state=playlist&pl=${plName}'">
		      <p class="card-text">
		      ${plName }
		      </p>
		    </div>
		  </div>
		  </c:forEach>
		</div>
	</div>
</body>
</html>