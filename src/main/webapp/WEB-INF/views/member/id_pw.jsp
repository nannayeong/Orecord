<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - 아이디/비번 찾기</title> 

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- cdn 추가 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>


</head>
<body>

<script type="text/javascript">
// 아이디 찾기버튼

function idSearch(frm1){
	console.log(333);
	
	
	if(frm1.nickname.value=="" || frm1.nickname.value==null){
		alert("닉네임을 입력해주세요.");
		frm1.nickname.focus();
		return false;
	}
	if(frm1.email1.value=="" || frm1.email1.value==null){
		alert("이메일을 입력해주세요.");
		frm1.email1.focus();
		return false;
	}
	
	
	
}

// 비번찾기 버튼
function passSearch(frm2){
	
	
	if(frm2.id.value=="" || frm2.id.value==null){
		alert("아이디를 입력해주세요.");
		frm2.id.focus();
		return false;
	}
	if(frm2.nickname1.value==""|| frm2.nickname1.value==null){
		alert("닉네임을 입력해주세요.");
		frm2.nickname1.focus();
		return false;
	}
	if(frm2.email2.value==""|| frm2.email2.value==null){
		alert("이메일을 입력해주세요.");
		frm2.email2.focus();
		return false;
	}
	
}
</script>

<script type="text/javascript">
/* 아이디찾기 */
/**/
<c:if test="${not empty idSearch }">
	alert( '${nickname}'+'님의 아이디는 '+ '${idSearch.id}' + ' 입니다.');
</c:if>
<c:if test="${not empty pwSearch }">
alert( '${id}'+'님의 비밀번호는 '+ '${pwSearch.pw}' + ' 입니다.');
</c:if>
</script>
	
		
			<!-- 왼쪽 컨텐츠 -->
			<div class="content">
			<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 60px;">
					<h5 style="margin-left: 3px;">ID/Passward Find</h5>
					<h2>아이디/비밀번호찾기</h2>
				</div>
				</div>
			</div>
			<br />
			<hr color="gray">
				<div class="left-content">
				
					<!-- <div class="col-md-6 pr-md-1" style="margin-top: 15px;"> -->
					<form onsubmit="return idSearch(this);" name="idfindscreen" method="post" action="${pageContext.request.contextPath}/member/idSearch.do" >
					<s:csrfInput />
					
						<div class="input-field col-md-6 pr-md-1">
						<label>닉네임</label>&nbsp;&nbsp;<input type="text" name="nickname" class="login_input01" /></div>
						<br />
						<div class="input-field col-md-6 pr-md-1"><label>이메일</label>&nbsp;&nbsp;<input type="text" name="email1" class="login_input01" /></div>
						
						<div class="input-field col-md-6 pr-md-1" style="align-content: center; margin-left: 70px; margin-top: 40px;">
							<input type="submit" class="btn btn-warning" value="아이디찾기" style="color: white;"/></div>						
					</form>	
					<br /> 
					<!-- </div> -->
					
					<div class="col-md-6 pl-md-1">
						<form onsubmit="return passSearch(this);" name="passfindscreen" id="passfindscreen" method="post" action="${pageContext.request.contextPath}/member/pwSearch.do" >
						<s:csrfInput />
							<div><label>아이디</label>&nbsp;&nbsp;<input type="text" name="id" class="login_input01" /></div>
							<br />
							<div><label>닉네임</label>&nbsp;&nbsp;<input type="text" name="nickname1" class="login_input01" /></div>
							<br />
							<div><label>이메일</label>&nbsp;&nbsp;<input type="text" name="email2" class="login_input01" /></div>
							<br />
							<div style="align-content: center; margin-left: 70px;"><input type="submit" class="btn btn-warning" value="비밀번호찾기" name="pwSearch" style="color: white;"/></div>
						</form>
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