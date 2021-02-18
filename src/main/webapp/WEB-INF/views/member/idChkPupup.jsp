<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - main</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>

</head>
<body>

<script>
function no() {
	
	opener.document.registFrm.id.value = "";
	//셀프로 창닫음.
	self.close();
}

function ok() {
	
	//부모객체의 form에 id인 registFrm, 폼안의 input태그의 name이 id인 value값에 넣겠다.
	opener.document.registFrm.id.value = 
		//id가 retype_id2인 태그안의 innerHTML인 ${id } 값을 가져옴.
		document.getElementById("retype_id2").innerHTML;
		
	//셀프로 창닫음.
	self.close();
}
</script>


<div class="container" style="text-align: center; margin: 5px; border: 2px solid rgb(54, 54, 86); border-radius: 10px;" > 
		<br>
		<!-- 
		아이디, 패스워드를 입력후 submit 한후 EL식을 통해 파라미터로 받은후
		"kosmo", "1234" 인 경우에는 "kosmo님 하이룽~" 이라고 출력한다. 
		만약 틀렸다면 "아이디와 비번을 확인하세요" 를 출력한다. 
		EL과 JSTL의 if태그만을 이용해서 구현하시오.
		 -->
		
		<c:if test="${jungbokId==1 }">
			<div style="color: black; border: 1px solid rgb(54, 54, 86); border-radius: 10px;">
				<h6><span id="retype_id1" >${id }</span>이미 사용중인 아이디 입니다.<input type="button" style="border-radius: 10px; border: 1px solid rgb(54, 54, 86);" value="다시입력" class="cancel btn btn-fill btn-primary" onclick="no()" /></h6>
			</div>
		</c:if>
		<c:if test="${jungbokId==0 }">
			<div style="color: black; border: 1px solid rgb(54, 54, 86); border-radius: 10px;">
				<h6><span id="retype_id2" >${id }</span>사용 가능한 아이디 입니다.<input type="button" style="border-radius: 10px; border: 1px solid rgb(54, 54, 86);" value="사용" class="cancel btn btn-fill btn-primary" onclick="ok()" /></h6>
			</div>
		</c:if>
		<br>
</div>	
						

</body>
</html> 