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
function plAudioDeleteFunc(pidx,index){
	$.ajax({
	     url : "./plAudioDelete.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {idx:pidx}, 
	     dataType : "json",
	     success : function sucFunc(resData) {
			 if(resData.result==1){
				 location.reload();
			 }
	     }    
	});
}

function noEvent() {
	if (event.keyCode == 116) {
		event.keyCode= 2;
		return false;
	}
	else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82)){
		return false;
	}
}
	document.onkeydown = noEvent;

/* 오디오파일배열 */
var nas = new Array();
var img = new Array();
var title = new Array();
var artist = new Array();

function playstop(){	
	//var nas = document.getElementById(nowIdx);	
	var nowIdx = document.getElementById("nowIdx").value;
	var progress = document.getElementById("progress");
	
	if($('#playstop').hasClass('fa-play')){
		$('#playstop').removeClass('fa-play');
		$('#playstop').addClass('fa-pause');
		nas[nowIdx].play();
		$('#artist').html(artist[nowIdx]);
		$('#title').html(title[nowIdx]);
		$('#nowaudioimg').attr('src', img[nowIdx]);
		$('#'+nowIdx).addClass('bg-light');
		var listsize = '${listsize}';
		for(var i=0;i<listsize;i++){
			if(i!=nowIdx){
				$('#'+i).removeClass('bg-light');
			}
		}
		
	}
	else if($('#playstop').hasClass('fa-pause')){
		$('#playstop').removeClass('fa-pause');
		$('#playstop').addClass('fa-play');
		nas[nowIdx].pause();
	} 
		 	 
	nas[nowIdx].addEventListener("timeupdate", function () {
 		console.log(nas[nowIdx].duration);
 		console.log(nas[nowIdx].currentTime);
 		//progress 태그에 오디오의 전체 재생시간을 설정한다. 
		progress.max = nas[nowIdx].duration;
        //현재 재생시간을 설정한다. 
        progress.value = nas[nowIdx].currentTime;
     });
	nas[nowIdx].addEventListener("ended",function(){
		playnext();
	})
}

//이전곡
function playprev(){
	var progress = document.getElementById("progress");
	var nowIdx = document.getElementById("nowIdx").value;
	nas[nowIdx].pause();
	nas[nowIdx].currentTime = 0;
	
	document.getElementById("nowIdx").value=--nowIdx;
	if(nowIdx<0){
		nowIdx = 0;
		$('#nowIdx').val(nowIdx);
	}
	
	go();
}
//다음곡
function playnext(){
	var progress = document.getElementById("progress");
	var nowIdx = document.getElementById("nowIdx").value;
	nas[nowIdx].pause();
	nas[nowIdx].currentTime = 0;
	
	document.getElementById("nowIdx").value=++nowIdx;
	
	var listsize = '${listsize}'
	if(nowIdx>=listsize){
		nowIdx = 0;
		$('#nowIdx').val(nowIdx);
	}
	
	go();
}

function go(){
	var nowIdx = document.getElementById("nowIdx").value;
	var progress = document.getElementById("progress");
	
	$('#playstop').removeClass('fa-play');
	$('#playstop').addClass('fa-pause');
	nas[nowIdx].play();
	$('#artist').html(artist[0]);
	$('#title').html(title[0]);
	$('#nowaudioimg').attr('src', img[0]);
	
	$('#'+nowIdx).addClass('bg-light');
	var listsize = '${listsize}';
	for(var i=0;i<listsize;i++){
		if(i!=nowIdx){
			$('#'+i).removeClass('bg-light');
		}
	}
	
	nas[nowIdx].addEventListener("timeupdate", function () {
 		console.log(nas[nowIdx].duration);
 		console.log(nas[nowIdx].currentTime);
 		//progress 태그에 오디오의 전체 재생시간을 설정한다. 
		progress.max = nas[nowIdx].duration;
        //현재 재생시간을 설정한다. 
        progress.value = nas[nowIdx].currentTime;
     });
	nas[nowIdx].addEventListener("ended",function(){
		playnext();
	});
}

function playAudio(clickidx){	
	var nowIdx = document.getElementById("nowIdx").value;
	var progress = document.getElementById("progress");
	
	if($('#playstop').hasClass('fa-pause')){
		$('#playstop').removeClass('fa-pause');
		$('#playstop').addClass('fa-play');
		nas[nowIdx].pause();
		nas[nowIdx].currentTime = 0;
	}
	
	$('#nowIdx').val(clickidx);
	
	go();
}
function plLoginC(){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		if(opener.closed) {   //부모창이 닫혔는지 여부 확인
		      // 부모창이 닫혔으니 새창으로 열기
		      window.open('${pageContext.request.contextPath}/member/login.do', "openWin");
		} 
		else {
        opener.location.href = '${pageContext.request.contextPath}/member/login.do';
	    opener.focus();
	    }
		self.close();
	}
	else{
		location.href="./musicbox?state=playlist";
	}
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
				<td style="width:50%;cursor:pointer;" class="bg-warning" onclick="plLoginC();">나의 플레이리스트</td>
			</tr>
		</table>
	</div>
	<!-- 본문 -->
	<div id="here">
	<div>
		<table style="width:100%">
			<tr>
				<td style="width:90px"><img src="${pageContext.request.contextPath}/resources/img/default.jpg" alt="" style="width:90px;height:90px;" id="nowaudioimg"/></td>
				<td>
					<span id="title">${firstAudio.audiotitle }</span><br />
					<span id="artist">${firstAudio.artistname }</span><br />
					<span>
						<i class="fas fa-fast-backward" onclick="playprev()"></i>
						<i id="playstop" class="fa fa-play" onclick="playstop()"></i>
						<i class="fas fa-fast-forward" onclick="playnext();"></i>
						<audio id="nowaudiosource" ${not empty audioparam ? 'autoplay' : '' } src=""></audio>
						<input type="hidden" id="nowIdx" value="0" style="border:1px solid red;"/>
					</span>
				</td>
			</tr>
		</table>
		<progress value="0" id="progress" style="width:100%;"></progress>
	</div>
	<div id="audioList">
		<table style="width:100%">
		<c:forEach items="${audioList}" var="a" varStatus="status">
		<tr id="${status.index}" style="cursor:pointer;border:2px solid #f1f1f1">
			<td onclick="playAudio(${status.index})" >
				<img src="${pageContext.request.contextPath}/resources/upload/${a.imagename}" alt="" style="width:35px;height:35px;" />
				${a.audiotitle } - ${a.artistname }
			</td>
			<td style="width:15px;">
				<a href="javascript:plAudioDeleteFunc(${a.idx},${status.index});">
			  		<i class="fas fa-trash-alt"></i>
			    </a>
			</td>
		</tr>
		<script>
			var i = '${status.index}';
			var audiofilename = '${a.audiofilename}';
			var imgname = '${a.imagename}';
			nas[i] = new Audio('${pageContext.request.contextPath}/resources/upload/'+audiofilename);
			img[i] = '${pageContext.request.contextPath}/resources/upload/'+imgname;
			title[i] = '${a.audiotitle}'
			artist[i] = '${a.artistname}'
			
		</script>
		</c:forEach>
		</table>
	</div>
	</div>
	
<script>
$(function(){
	var ap = '${audioparam}';
	if(ap==null||ap==""){
		nas[0].pause();
		$('#artist').html(artist[0]);
		$('#title').html(title[0]);
		$('#nowaudioimg').attr('src', img[0]);
		$('#0').addClass('bg-light');
	}
	else{
	   	$('#playstop').removeClass('fa-play');
		$('#playstop').addClass('fa-pause');
		nas[0].play();
		$('#artist').html(artist[0]);
		$('#title').html(title[0]);
		$('#nowaudioimg').attr('src', img[0]);
		$('#0').addClass('bg-light');
	}
});


</script>
</body>
</html>