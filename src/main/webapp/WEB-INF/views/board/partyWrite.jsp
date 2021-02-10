<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>협업신청</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<style>
.col-5{
  margin:15px 0 0 50px;
}
.form-group p {
  margin-top:37px; color:gray;
  font-size:16px;
}
</style>
<script type="text/javascript">
var writeValidate = function(f){
	if(f.kind.selectedIndex == 0){
        alert("협업분야를 선택하세요.");
        f.kind.focus();
        return false;
    }
	if(f.point.value==""){
		alert("포인트를 입력해주세요");
		f.point.focus();
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus();
		return false;
	}
	
	/* if($("#audiofilename").val != ""){ */
    	var ext = $('#audiofilename').val().split('.').pop().toLowerCase();
    	if($.inArray(ext, ['mp4','mp3','wav'])==-1){
    		if($("#audiofilename").val() = null){
    			return true;
    		}
    		else{
	    		alert("지정된 확장자의 파일만 업로드 가능합니다.");
	    		$("#audiofilename").val("");
	    		return false;
    		}
    	}
    /* } */
}
/* function partyRow(audio_idx){
	if(confirm("신청 하시겠습니까?")){
		location.href="partyWriteAction.do?audio_idx="+ audio_idx;
	}
} */
</script>
</head>
<body>
<div>
	<div class="content">
		<!-- 본문 제목 -->
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">Party</h5>
					<h2>협업신청</h2>
				</div>
			</div>
		</div>
		<br>
		<hr color="green">
		<!-- 본문 제목 종료 -->
		<form name="regiform" onsubmit="return writeValidate(this);"
			method="post" enctype="multipart/form-data"
			action="<c:url value="/board/partyWriteAction.do"/>">
			<s:csrfInput />
			<input type="hidden" name="audio_idx" value="${party.audio_idx}">
			<input type="hidden" name="idx" value="${pageContext.request.userPrincipal.name}">
			
			<!-- content -->
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>받는사람</label>
						<input type="text" class="form-control"
							name="id" value="${party.id}" readonly style="font-size: 14px;">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>작성자</label>
						<input type="text" class="form-control"
							value="${pageContext.request.userPrincipal.name }" readonly style="font-size: 14px;">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>협업분야</label> <select name="kind" id="kind"
							class="form-control">
							<option style="color: black;" value="noValue">선택해주세요</option>
							<option style="color: black;" value="작곡">작곡</option>
							<option style="color: black;" value="작사">작사</option>
						</select>
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<p>* 협업 분야 선택</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>포인트</label> <input type="text" class="form-control"
							name="point" value="" placeholder="포인트를 입력해주세요">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<p>* 요구할 포인트 입력</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>음원파일 &nbsp;
						<span style="color: green;">
							* 작곡 선택시</span>
						</label>
						<input type="file" class="form-control"
							name="audiofilename" id="audiofilename" accept=".mp4,.mp3,.wav">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<p>* mp4, mp3, wav 파일만 가능</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-10">
					<div class="form-group" style="margin-left: 50px;">
						<label>가사 &nbsp; <span style="color: green;"> * 작사
								선택시</span></label>
						<textarea class="form-control" rows="6" id="audiocontents"
							name="audiocontents" placeholder="가사를 입력해주세요"></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>제목</label> <input type="text" class="form-control"
							name="title" value="" placeholder="제목을 입력해주세요">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<p>* 제목 입력</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-10">
					<div class="form-group" style="margin: 10px 0 0 50px;">
						<label>내용 &nbsp; <span style="color: green;"> *
								전달할 메세지</span></label>
						<textarea name="contents" id="contents" class="form-control"
							rows="6"></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-10">
					<div class="form-group" align="right"
						style="margin: 40px 30px 0 0;">
						<input type="button" class="btn btn-outline-info" value="취소"
							onclick="location.href='./view.do?audio_idx=${party.audio_idx}'">
						&nbsp;&nbsp; <input type="submit" class="btn btn-outline-info"
							value="신청하기">
					</div>
				</div>
			</div>
				
				
			<br>
			<br>
			<hr color="green">
		</form>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
</div>
	
	
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp"%>
	</header>
	
</body>
</html>