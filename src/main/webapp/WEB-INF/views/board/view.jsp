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
</script>
</head>
<body>
<div>
	<div class="content">
		<!-- 왼쪽 컨텐츠 -->
		<input type="hidden" name="audio_idx" value="${audio.audio_idx}">
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div class="col-8" style="padding: 20px 0 0 40px; font-size: 20px;">
					<div class="row">
						<div class="col-2" width="50" style="margin-left: 15px;">
							<img src="../resources/img/play.png" alt="재생버튼" width="70"
								height="70" style="padding: 5px 0 0 15px;">
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
							id="${album.albumName}">
							<source src="${audio.audiofilename }"/>
						</audio>
					</div>
					<div style="padding: 10px 0 0 35px;">
						<img src="../resources/img/like.png" alt="좋아요 수" width="30">
						<span>${audio.like_count}</span>
						<img src="../resources/img/playcount.png" alt="재생횟수" width="50">
						<span>${audio.play_count}</span>
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
		<div style="padding-left: 50px;">
			<p>${audio.contents }</p>
		</div>
		<hr align="center" color="gray" size="10px">
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal.name eq audio.id}">
				<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
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
					<div style="margin-right: 10px;">
						<button type="button" class="btn btn-outline-info"
							onclick="location.href='partyList.do?audio_idx=${audio.audio_idx}';">
							협업신청목록
						</button>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
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
			<div class="row">
				<div class="col-3" style="text-align: center; padding-left: 50px;">
					<img src="../resources/img/2.png" alt="프로필사진"
						class="rounded-circle" width="100">
					<h6 style="margin-top: 8px;">${audio.id }</h6>
					<hr width="100%" align="center" color="orange" size="10px">
					<h6 style="color:gray;">협업자</h6>
					<img src="../resources/img/2.png" alt="프로필사진"
						class="rounded-circle" width="100">
					<h6 style="margin:8px 0 7px 0;">${audio.id }</h6>
					<img src="../resources/img/2.png" alt="프로필사진"
						class="rounded-circle" width="100">
					<h6 style="margin-top: 8px;">${audio.id }</h6>
				</div>
				<!-- 댓글 작성 -->
				<div class="col-8">
					<div class="row" style="padding-top: 10px;">
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
						<hr width="100%" align="center" color="#17A2B8" size="10px">
					</div>

					<!-- 댓글영역 -->
					<c:forEach items="${comments}" var="row">
						<input type="hidden" name="comment_idx"
							value="${row.comment_idx }" />
						<div class="row">
							<div class="col-2" style="padding: 15px 0 0 30px;"
								align="center">
								<img src="../resources/img/4.png" alt="작성자프로필" width="50"
									class="rounded-circle">
								<p style="font-size: 12px;">${row.id}</p>
							</div>
							<div class="col-8" style="padding-top: 22px;">
								<input type="text" class="form-control" readonly
									value="${row.contents}">
							</div>
							<c:if test="${pageContext.request.userPrincipal.name eq row.id}">
							<div class="col-2" style="padding: 22px 0 0 0;" align="left">
								<img src="../resources/img/delete.png" alt="삭제" width="20" style="padding-top:5px; cursor:pointer;"
									onclick="javascript:deleteRow(${row.comment_idx}, ${row.audio_idx });" />
							</div>
							</c:if>
						</div>
					</c:forEach>

				</div>
			</div>
		</form>
		<!-- 왼쪽 컨텐츠 종료 -->
	</div>
	<!-- 본문종료 -->
</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>
	
</body>
</html>