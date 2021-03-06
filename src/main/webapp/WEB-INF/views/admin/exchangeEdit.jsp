<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin - exchange</title>

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
		f.kind.value == ${partyBoardDTO.kind};
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
	var point = f.point.value;
	if(point < "0" || point > "9"){
		alert("숫자만 입력 가능합니다.");
		f.point.focus();
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
					<h5 style="margin-left: 5px;">exchange</h5>
					<h2>환전</h2>
				</div>
			</div>
		</div>
		<br>
		<hr color="green">
		<!-- 본문 제목 종료 -->
		<form name="regiform" onsubmit="return writeValidate(this);" method="post" enctype="multipart/form-data"
			action="<c:url value="/admin/exchangeEditAction.do?idx=${exchangeDTO.idx}"/>">
			<s:csrfInput />
			<input type="hidden" name="idx" value="${exchangeDTO.idx}">		
			<!-- content -->
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>아이디</label>
						<input type="text" class="form-control"
							name="id" value="${exchangeDTO.id}" readonly style="font-size: 14px;">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>환전요청포인트</label>
						<input type="text" class="form-control" name="exchangePoint" value="${exchangeDTO.exchangePoint }">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>입금금액</label> 
						<input type="text" class="form-control" name="exchangedMoney" value="${exchangeDTO.exchangedMoney }">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>수수료</label>
						<input type="text" class="form-control" name="exchangeFee" value="${exchangeDTO.exchangeFee }">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>은행명</label> 
						<input type="text" class="form-control" name="accountBank" value="${exchangeDTO.accountBank }">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>계좌번호</label>
						<input type="text" class="form-control" name="accountNumber" value="${exchangeDTO.accountNumber }">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-5">
					<div class="form-group">
						<label>계좌주</label> 
						<input type="text" class="form-control" name="accountName" value="${exchangeDTO.accountName }">
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>결제일</label>
						<input type="text" class="form-control" name="regidate" value="${exchangeDTO.regidate }">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-10">
					<div class="form-group" style="margin: 40px 30px 0 430px;">
						<input type="submit" class="btn btn-outline-info" value="수정하기">
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