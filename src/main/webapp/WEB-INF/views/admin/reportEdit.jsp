<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin - report</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>


</head>
<body>

<script type="text/javascript">
function writeValidate(f)
{
	var frm = document.writeFrm;
	
	if(frm.r_id.value=="" || frm.r_id.value==null ){
		alert("신고할사람 아이디를 입력하세요");
		frm.r_id.focus();
		return false;
	}
	
	var isReason = false;
	for(var i=0 ; i<frm.kind.length; i++){
		if(frm.kind[i].checked==true){
			isReason=true;
			break;
		}
	}
	if(frm.kind.selectedIndex == 0){
		frm.kind.value == ${reportDTO.kind};
    }
	if(isReason != true){
		alert("신고이유를 선택해주세요");
		frm.kind[0].focus();
		return false;
	}
}





</script>
	<div>
		<div class="content">
			<!-- 왼쪽 컨텐츠 -->
			<div class="left-content-back">
				<div class="left-content">
<!-- <table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em"> -->
		<form name="writeFrm" method="post" onsubmit="return writeValidate(this);" action="<c:url value="/report/reportEditAction.do?r_idx=${reportDTO.r_idx}" />" >
		<s:csrfInput />
		<table class="table table-bordered">
	<tbody>
		<tr>
			<th class="text-center" style="vertical-align:middle;">신고한사람 아이디</th>
			<td>
				${reportDTO.s_id }
			</td>
			<td><input type="hidden" name="r_idx" value="${reportDTO.r_idx}"></td>
		</tr>
		<tr>
			<th class="text-center" style="vertical-align:middle;">신고할사람 아이디</th>
			<td>
				<input type="text" class="form-control" style="width:100px;" name="r_id" value="${reportDTO.r_id }" />
			</td>
		</tr>
		<tr>
			<th class="text-center" style="vertical-align:middle;">신고 사유</th>
			<td>
            <input type="radio" name="kind" value="${reportDTO.kind }" id="rad_1" />
            <label for="rad_1">욕설</label>
            <input type="radio" name="kind" value="${reportDTO.kind }" id="rad_2" />
            <label for="rad_2">음란물</label>
            <input type="radio" name="kind" value="${reportDTO.kind }" id="rad_3" />
            <label for="rad_3">불법/사기</label>
            <input type="radio" name="kind" value="${reportDTO.kind }" id="rad_4" />
            <label for="rad_4">표절</label>
            <input type="radio" name="kind" value="${reportDTO.kind }" id="rad_5" />
            <label for="rad_5">기타</label>
			</td>
		</tr>
        
		<tr>
			<th class="text-center" style="vertical-align:middle;">기타</th>
			<td>
				<textarea rows="10" class="form-control" name="reason" >${reportDTO.reason }</textarea>
			</td>
			
		</tr>	
	</tbody>
	</table>
	
	<div class="row text-center" style="">
		<!-- 각종 버튼 부분 -->
		<button type="submit" class="btn btn-danger">수정하기</button><br />
	</div>
	</form> 
</div>
	</div>
				</div>
			</div>

		
		<!-- 본문종료 -->
	

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 