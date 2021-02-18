<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
 
<script type="text/javascript">
	
	function isValidate(frm1){
		
		var frm = document.registFrm;
		
		var pw = document.getElementById("pw").value;
		
		if(frm.pw2.value==''){
			alert('비밀번호를 입력하세요');
			frm.pw2.focus();
			return false;
		}
		
		if(frm.pw.value != frm.pw2.value){
			alert('비밀번호가 일치하지 않습니다.');
			frm.pw2.focus();
			return false;
		}
		
		if(frm.pw.value == frm.pw2.value){
			
			frm.action='${pageContext.request.contextPath}/memberEdit.do';
		}
		
		
	}
	
</script>


</head>
<body>
	<div>
		<div class="content">
					<!-- <table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em"> -->
					<form name="registFrm" onsubmit="return isValidate(this);" method="post" enctype="multipart/form-data" action="">
						<s:csrfInput />
						<div align="center">
							<div >
								<input type="hidden" class="form-control" id="pw" value="${dto.pw }" name="pw" min="4" maxlength="20">	
								<br /><br /><br />						
							</div>
							<div class="input-field col-md-6 pl-md-1">
								<label>비밀번호를 입력해주세요.</label>
								<div><input type="password" class="form-control" id="pw2" name="pw2" min="4" maxlength="20"></div>
								<br />
								<div><input type="submit" class="btn btn-warning" value="확인" style="color: white;"></div>
								<br /><br /><br />
							</div>
							
						</div>
						
					</form>	
						
					<!-- </table> -->
				</div>
			</div>
		<!-- 본문종료 -->
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 