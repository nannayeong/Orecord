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
<title>협업상세페이지</title>

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
<script type="text/javascript">
</script>
<script type="text/javascript">
function choiceAction(f){
	var youPoint = f.point.value;
	var myPoint = f.myPoint.value;
	var audio_idx = f.audio_idx.value;
	var r_id = f.id.value;
	if(myPoint < youPoint){
		var pointCon = confirm("포인트가 부족합니다. 충전하시겠습니까?");
		if(pointCon==true){
			location.href="/orecord/chargeLog.do";
			return false;
		}
		else{
			return false;
		}
	}
	var choice = confirm("채택하시겠습니까?");
	if(choice==true){
		return true;
	}
	else{
		return false;
	}
}
</script>
<style>
.form-group label{
	color:blue;
}
</style>
</head>
<body>
<div>
	<div class="content">
		<!-- 본문 제목 -->
		<form method="post"
			action="<c:url value="/board/choiceAction.do"/>"
			name="choiceFrm" onsubmit="return choiceAction(this);">
			<s:csrfInput />
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">PartyView</h5>
					<h2>${partyView.id} 님의 협업 신청서</h2>
					<br>
				</div>
			</div>
		</div>
		<br>
		<hr color="green">
		<!-- 본문 제목 종료 -->
		<input type="hidden" name="myPoint" value="${myPoint.mypoint }" />
		<input type="hidden" name="audio_idx" value="${partyView.audio_idx }">
		<input type="hidden" name="party_idx" value="${partyView.party_idx }" />
		<input type="hidden" name="id" value="${partyView.id }">
		<input type="hidden" name="name" value="${pageContext.request.userPrincipal.name}">
		<input type="hidden" name="choice" value=${partyView.choice } />

		<!-- content -->
		<div class="row" style="margin-left:35px;">
			<div class="col-5">
				<div class="form-group">
					<label>작성일</label>
					<input type="text" class="form-control"
						value="${partyView.regidate }" readonly style="font-size: 16px;">
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
					<label>채택 유효기간</label>
					<input type="text" class="form-control"
						value="${partyView.exdate }" readonly style="font-size: 16px;">
				</div>
			</div>
		</div>
		<div class="row" style="margin-left:35px;">
			<div class="col-5">
				<div class="form-group">
					<label>협업분야</label>
					<input type="text" class="form-control"
						value="${partyView.kind }" readonly style="font-size: 16px;">
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
					<label>요청 포인트</label>
					<input type="text" class="form-control"
						readonly name="point" id="point" value="${partyView.point }">
				</div>
			</div>
		</div>
		<div class="row" style="margin-left:35px;">
			<div class="col-5">
				<div class="form-group">
					<label>제목</label>
					<input type="text" class="form-control" readonly
						name="title" value="${partyView.title }">
				</div>
			</div>
		</div>
		<div class="row" style="margin: 20px 0 0 35px;">
			<div class="col-10">
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" name="contents" id="contents"
						rows="6" readonly>${partyView.contents }</textarea>
				</div>
			</div>
		</div>
		<div class="row" style="margin: 30px 0 30px 0;">
			<div class="col-10">
				<div class="row">
					<div class="col-8" align="center" style="margin: 10px 0 0 35px;">
						<div class="form-group">
							<span style="color:blue;">음원파일</span>
							<p style="color:gray; font-size:12px;"> * 채택시 다운로드가 가능합니다.</p>
							<audio controls style="width: 500px;">
								<source src="${partyView.audiofilename }"/>
							</audio>
						</div>
					</div>
					<c:if test="${partyView.choice eq 1 }">
					<div class="col-2" style="padding-top:80px;" align="center">
						<div>
							<a href="download.do?audiofilename=${partyView.audiofilename }&oriFileName=${partyView.id}님의작곡">
								[다운로드]
							</a>
						</div>
					</div>
					</c:if>
				</div>
			</div>
		</div>
		<div class="row" style="margin-left: 35px;">
			<div class="col-10">
				<div class="form-group">
					<label>가사</label>
					<textarea class="form-control" name="audiocontents"
						id="audiocontents" rows="8" readonly>${partyView.audiocontents }</textarea>
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-10">
				<div class="form-group">
					<div class="d-flex flex-row-reverse">
					<c:choose>
						<c:when test="${partyView.choice eq 1 }">
							<button type="button" class="btn btn-outline-danger"
								onclick="location.href='./SendMessage.do?audio_idx=${partyView.audio_idx}&r_id=${partyView.id }&s_id=${pageContext.request.userPrincipal.name }'">
								메세지 보내기
							</button>
							<button type="button" class="btn btn-outline-primary"
								onclick="location.href='partyList.do?audio_idx=${partyView.audio_idx}'"
								style="margin-right: 10px;">
								뒤로가기
							</button>
						</c:when>
						<c:otherwise>
							<button type="submit" class="btn btn-outline-danger">
							채택하기
							</button>
							<button type="button" class="btn btn-outline-primary"
							style="margin-right: 10px;"
							onclick="location.href='partyList.do?audio_idx=${partyView.audio_idx}'">
							뒤로가기
						</button>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
		</form>
		<br>
		<hr color="green">
		<br>
		<br>
	</div>
</div>


	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>
</body>
</html>