<%@page import="impl.ViewImpl"%>
<%@page import="model.AudioBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>곡 상세페이지</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script type="text/javascript">
function comentValidate(f){
	
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus();
		return false;
	}
	
}
function deleteRow(comment_idx, audio_idx){
	if(confirm("정말로 삭제하시겠습니까?")){
		location.href="delete.do?comment_idx="+ comment_idx+ "&audio_idx="+ audio_idx;
	}
}
$(document).ready(function(){
	/* 웹페이지를 열었을때 */
	$("#img1").show();
	$("#img2").hide();
	
	/* img1을 클릭했을때 img2를 보여줌 */
	$("#img1").click(function(){
		$("#img1").hide();
		$("#img2").show();
	});
	
	/* img2를 클릭했을때 img1을 보여줌 */
	$("#img2").click(function(){
		$("#img1").show();
		$("#img2").hide();
	});
});
$(function(){
	$('#img1').click(function(){
		$.ajax({
			url : "../board/playAction.do",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : { audio_idx : $("#audio_idx").val()},
			dataType : "json",
			success : function(resData){
	            if(resData!=null){
					$('#playC').html(resData.playCount);
	            }	
			},
			error : function(error) {
				alert("error : " + error);
			}   
		});
	});
});

</script>
</head>
<body>
<div>
	<div class="content">
		<!-- 왼쪽 컨텐츠 -->
		<input type="hidden" name="audio_idx" id="audio_idx" value="${audio.audio_idx}">
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div class="col-8" style="padding: 20px 0 0 40px; font-size: 20px;">
					<div class="row">
						<div class="col-2" style="margin-left: 15px;">
							<img src="../resources/img/play.png" alt="재생버튼" width="80px"
								height="70px" style="padding: 5px 0 0 15px; cursor:pointer;"
								id="img1" onclick="control(event)">
							<img src="../resources/img/stop.png" alt="정지버튼" width="80px"
								height="70px" style="padding: 5px 0 0 15px; cursor:pointer;"
								id="img2" onclick="control(event)">
						</div>
						<div class="col-9"
							style="padding-left: 20px;">
							<div class="row">
								<!-- 가수명, 곡 이름 -->
								<div class="col-8">
									<div style="padding:8px 0 5px 0;">
										<span
											style="background-color: black; color: white; padding: 5px; border-radius: 20px;">
											${audio.artistname} </span>
									</div>
									<div style="margin-top: 5px;">
										<span
											style="background-color: black; color: white; padding: 5px; border-radius: 20px;">
											${audio.audiotitle} </span>
									</div>
								</div>
								<!-- 작성일, 카테고리 -->
								<div class="col-4" style="padding:3px 0 0 0;">
									<span class="badge badge-dark"
										style="border-radius: 25px; padding: 7px;">
										${audio.regidate}
									</span>
									<span class="badge badge-dark"
										style="border-radius: 25px; padding: 7px;">
										#&nbsp;${audio.category}
									</span>
								</div>
							</div>
						</div>
					</div>
					<!-- 오디오태그 -->
					<div style="padding: 10px 0 0 10px;">
						<audio controls
							style="width: 95%; height: 60px; padding-left: 12px;"
							id="audio" src="${audio.audiofilename }">
						</audio>
					</div>
					<div style="padding: 10px 0 0 35px;">
						<div id="msg" style="color:white; font-size:16px;"></div>
						<button type="button" onclick="control(event)" class="btn btn-outline-dark"
							style="color:white;" id="play">
							play
						</button>
						<button type="button" onclick="control(event)" class="btn btn-outline-dark"
							style="color:white;" id="pause">
							pause
						</button>
						<button type="button" onclick="control(event)" class="btn btn-outline-dark"
							style="color:white;" id="replay">
							replay
						</button>
						<button type="button" onclick="control(event)" class="btn btn-outline-dark"
							style="color:white;" id="vol+">
							vol+
						</button>
						<button type="button" onclick="control(event)" class="btn btn-outline-dark"
							style="color:white;" id="vol-">
							vol-
						</button>
						<img src="../resources/img/like.png" alt="좋아요 수" width="30" style="margin-left:50px;">
						<span>${audio.like_count}</span>
						<img src="../resources/img/playcount.png" alt="재생횟수" width="50">
						<span id="playC">${audio.play_count}</span>
					</div>
				</div>
				<!-- 앨범사진 -->
				<div class="col-4">
					<img src="${audio.imagename }" alt="앨범사진" width="300px"
						height="300px" style="padding: 20px 20px 20px 0;">
				</div>
			</div>
		</div>
		<br>
		<!-- 참여자 목록 -->
		<div class="row">
			<div class="col-7">
				<div style="padding-left: 50px;padding-bottom:1em">
					<div style="height:13em">${audio.contents }</div>
				</div>
			</div>
			<div class="col-5" style="padding-right:3em">
				<c:choose>
				<c:when test="${audio.party eq 1 and notChoice.count ne 0 }">
				<c:forEach items="${partyMember }" var="mem">
				<div id="accordion">
				  <div class="card" style="text-align:center">
				  	<div class="card-header">
					    <a class="collapsed card-link" data-toggle="collapse" href="#collapse${mem.party_idx }">
							${mem.nickname}(${mem.id })님의 ${mem.kind }
					    </a>
				   	</div>
				    <div id="collapse${mem.party_idx }" class="collapse show" data-parent="#accordion">
				      <div style="text-align:center;padding-bottom:1em">
				      	<div style="padding-top:1em">
					      <c:if test="${not empty mem.audiofilename}">
					      	<audio src="${mem.audiofilename}" controls style="width:20em"></audio>
					      </c:if>
					    </div>
					    <div style="padding-top:1em">
					      <c:if test="${not empty mem.audiocontents }">
					      	${mem.audiocontents}
					      </c:if>
				      	</div>
				      </div>
				    </div>
				  </div>
				</div>
				</c:forEach>
				</c:when>
				</c:choose>
			</div>
		</div>
		<!-- #17A2B8 -->
		<hr align="center" width="90%" style="border:outset 1px gray;">
		<!-- 협업신청, 목록, 수정 버튼 -->
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal.name eq audio.id}">
				<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
					<c:if test="${audio.party eq 1 }">
					<div style="margin-right: 60px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='deleteBoard.do?audio_idx=${audio.audio_idx}'">
							삭제
						</button>
					</div>
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='modify.do?audio_idx=${audio.audio_idx}'">
							수정
						</button>
					</div>
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='/orecord/main.do'">목록</button>
					</div>
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='partyList.do?audio_idx=${audio.audio_idx}';">
							협업신청목록
						</button>
					</div>
					</c:if>
					<!-- 협업하기 불가능일때 -->
					<c:if test="${audio.party ne 1 }">
					<div style="margin-right: 60px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='modify.do?audio_idx=${audio.audio_idx}'">
							수정
						</button>
					</div>
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='/orecord/main.do'">목록</button>
					</div>
					</c:if>
				</div>
			</c:when>
			<c:otherwise>
				<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
					<c:choose>
					<c:when test="${audio.party eq 1 }">
					<div style="margin-right: 60px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='partyWrite.do?audio_idx=${audio.audio_idx}';">
							협업신청
						</button>
					</div>
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='/orecord/main.do'">
							목록
						</button>
					</div>
					</c:when>
					<c:otherwise>
					<div style="margin-right: 60px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='/orecord/main.do'">
							목록
						</button>
					</div>
					</c:otherwise>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
		<br>
		<br>
		<!-- 하단영역 -->
		<form method="post"
			action="<c:url value="/board/commentAction.do" />" name="writeFrm"
			onsubmit="return comentValidate(this);">
			<s:csrfInput />
			<input type="hidden" name="audio_idx" value="${audio.audio_idx}">
			<!-- 작성자 프로필 -->
<!-- 			<div class="row"> -->
				<!-- 댓글 작성 -->
<!-- 				<div class="col-12"> -->
					<c:if test="${not empty pageContext.request.userPrincipal.name}">
					<div class="row" style="padding:10px 0 0 70px;">
						<div class="col-2" style="padding: 0px; margin-left: 50px;">
							<input type="text" readonly class="form-control"
								value="${pageContext.request.userPrincipal.name}"
								style="text-align: center;">
						</div>
						<div class="col-7" style="padding: 0px;">
							<input type="text" class="form-control" placeholder="댓글을 입력하세요"
								name="contents">
						</div>
						<div class="col-2" style="padding: 0px;">
							<input type="submit" class="btn btn-outline-secondary"
								value="입력">
						</div>
					</div>
						<hr align="center" width="90%" style="border:outset 1px gray;">
					<!-- 댓글영역 -->
					
					<c:forEach items="${comments}" var="row">
						<input type="hidden" name="comment_idx"
							value="${row.comment_idx }" />
						<div class="row">
							<div class="col-2" style="padding:23px 0 0 90px;text-align:center">
								<img src="${row.img}" alt="작성자프로필" width="50"
									class="rounded-circle">
								<p style="font-size: 12px;">${row.id}</p>
							</div>
							<div class="col-8" style="padding-top: 22px;">
								<p style="margin-bottom:1px; font-size:10px; color:gray;">${row.regidate }</p>
								<input type="text" class="form-control" readonly
									value="${row.contents}">
							</div>
							<c:if test="${pageContext.request.userPrincipal.name eq row.id}">
							<div class="col-2" style="padding:37px 0 0 0;" align="left">
								<img src="../resources/img/delete.png" alt="삭제" width="20" style="padding-top:5px; cursor:pointer;"
									onclick="javascript:deleteRow(${row.comment_idx}, ${row.audio_idx });" />
							</div>
							</c:if>
						</div>
					</c:forEach>
					</c:if>
<!-- 				</div> -->
<!-- 			</div> -->
		</form>
		<!-- 왼쪽 컨텐츠 종료 -->
	</div>
	<!-- 본문종료 -->
</div>
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

<script>
var div = document.getElementById("msg");
var audio = document.getElementById("audio");
function control(e){
	var id = e.target.id;
	if(id == "img1"){
		audio.play();
		div.innerHTML = "재생중입니다.";
	}
	else if(id == "img2"){
		audio.pause();
		div.innerHTML = "일시중지되었습니다.";
	}
	else if(id == "replay"){
		audio.load();
		audio.play();
		div.innerHTML = "처음부터 재생합니다.";
	}
	else if(id == "vol+"){
		audio.volume += 0.1;
		if(audio.volume > 0.9) audio.volume = 1.0;
		div.innerHTML = "음량  증가 ";
		if(audio.volume==1.0){
			div.innerHTML = "최대음량입니다.";
		}
	}
	else if(id == "vol-"){
		audio.volume -= 0.1; 
		if(audio.volume < 0.1) audio.volume = 0;
		div.innerHTML = "음량 감소 ";
		if(audio.volume==0){
			div.innerHTML = "음소거";
		}
	}
}
</script>

</body>
</html>