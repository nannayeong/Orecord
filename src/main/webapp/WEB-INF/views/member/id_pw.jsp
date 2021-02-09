<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - main</title> 

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
<script>
// 아이디 찾기버튼
function idSearch(frm){
	var frm1 = document.idfindscreen;
	if(frm1.nickname.value.length < 1){
		alert("닉네임을 입력해주세요.");
		frm1.name.focus();
		return false;
	}
	if(frm1.email.value.length < 1){
		alert("이메일을 입력해주세요.");
		frm1.email.focus();
		return false;
	}
	
	var idSearch = document.getElementById('id1').value; 
	var username = document.getElementById('name2').value;  
	alert(username+'님의 아이디는 '+ idSearch + ' 입니다.');
	
}

// 비번찾기 버튼
function passSearch(frm){
	var frm = document.passfindscreen;
	if(frm.id.value.length < 1){
		alert("아이디를 입력해주세요.");
		frm.id.focus();
		return false;
	}
	if(frm.name1.value.length < 1){
		alert("닉네임을 입력해주세요.");
		frm.name1.focus();
		return false;
	}
	if(frm.email1.value.length < 1){
		alert("이메일을 입력해주세요.");
		frm.email1.focus();
		return false;
	}
	
}



</script>
	<div>
		<div class="content">
			<!-- 왼쪽 컨텐츠 -->
			<div class="left-content-back">
				<div class="left-content">
					<div class="contents_box">
			<div class="left_contents">
			</div>
			<div class="right_contents">
				<div class="top_title">
					<input type="image" src="/resources/img/id_pw_title.gif" alt="" class="con_title" /><p class="location">&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				<br />
				</div>
				<div class="row" style="border: 1px solid gray; padding: 30px;">
					<div class="col-md-6 pr-md-1" style="margin-top: 15px;">
					<form action="${pageContext.request.contextPath}/member/idSearch.do" onsubmit="return idSearch(this);" name="idfindscreen" method="post" >
					<s:csrfInput />
						<input type="hidden" id="id1" value="${idSearch.id }" />
						<input type="hidden" id="name2" value="${idSearch.nickname }" />
						<div><span>닉네임&nbsp;&nbsp;<input type="text" name="nickname" value="" class="login_input01" /></span></div>
						<br />
						<div><span>이메일&nbsp;&nbsp;<input type="text" name="email" value="" class="login_input01" /></span></div>
						<br />
						<div style="align-content: center; margin-left: 70px; margin-top: 40px;">
							<input type="submit" class="btn btn-warning" value="아이디찾기" name="idSearch" style="color: white;"/></div>						
					</form>	
					</div>
					
					<div class="col-md-6 pl-md-1">
						<form action="${pageContext.request.contextPath}/idSearch.do" onsubmit="return passSearch(this);" name="passfindscreen" method="post">
						<s:csrfInput />
							<div><span>아이디&nbsp;&nbsp;<input type="text" name="id" value="" class="login_input01" /></span></div>
							<br />
							<div><span>닉네임&nbsp;&nbsp;<input type="text" name="name1" value="" class="login_input01" /></span></div>
							<br />
							<div><span>이메일&nbsp;&nbsp;<input type="text" name="email1" value="" class="login_input01" /></span></div>
							<br />
							<div style="align-content: center; margin-left: 70px;"><input type="submit" class="btn btn-warning" value="비밀번호찾기" name="pwSearch" style="color: white;"/></div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
			<!-- 오른쪽 컨텐츠종료 -->
			<div class="right-content-back">
				<div class="right-content">
					첫하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />막하이<br />
				</div>
			</div>
		</div>
		<!-- 본문종료 -->
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 