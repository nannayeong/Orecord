<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - 환전 신청하기</title>

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
<!-- 아임포트 결제 API 추가 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 날짜 선택기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
h2 {
	font-size: 1.5em;
	margin-bottom: 0.2em;
	margin-left: 0.2em;
	font-weight: bold;
}

h4 {
	margin-top: 0.2em;
	margin-bottom: 0;
	margin-left: 0.2em;
	margin-right: 0;
}

.content {
	width: 750px;
	height: 800px;
}

.content-header {
	width: 75%;
	margin: auto;
	color: #333333;
	padding-top: 2em;
}

.content-body {
	width: 75%;
	margin: auto;
	height: 620px;
	border: 2px solid #969696;
  border-radius: 10px;
}

#textBox {
	text-align: center;
	border: 0px;
	margin-left: 130px;
	color: #138496;
}

.input-row{
margin-top: 20px;
margin-left: 20px;
margin-right: 20px;
}

.textTitle {
	text-align: left;
	border: 0px;
	font-family: sans-serif;
	font-size: 17px; 	
	color: 5A6268;
	margin-left: 30px; 
}

.textInput, .textDisable {
	text-align: center;
	border: 2px solid #B1B1B1;
	border-radius: 5px;
	background-color: #F9F9F9; 
	/* border-bottom: 1px solid #b9b9b9; */
	font-family: sans-serif;
	font-size: 17px;
}

.textDisable:focus {
  outline: none;
}

.textInput:focus {
	border: 2px solid #C4D2E1;
}

.inform {
font-size: 13px;
color: #5A6268;
margin: 6px 0px 0px 10px;

}

</style>
<script>
	$(document).ready(function() {
		document.getElementById("regidate").value = today(); // 문서 로드되면 신청일 오늘로 자동 설정
	});
</script>
</head>
<body>
	<div>
		<div class="content">
			<!-- 본문 제목 시작-->
			<div class="content-header">
				<div class="pointMainMenu" style="border-bottom: 2px solid #545B62; padding-bottom: 10px;">
					<h2>${MemberDTO.id }님</h2> 
					<h4>보유 포인트 : ${MemberDTO.mypoint }Point</h4> 
				</div>
				<div class="pointSubMenu" style="margin-top:20px;">
				</div>
			</div>
			<!-- 본문 제목 종료 -->
			<!-- 본문내용 시작 -->
			<div class="content-body" style="margin-top: 10px;">
				<form action="<c:url value="/insertExchangeLog.do" />" method="post" id="exchangeForm" onsubmit="return valiCheck(this);">
					<s:csrfInput />
					<div class="input-row">
						<span class="textTitle">신청 아이디</span>
						<input type="text" class="textDisable" id="exchangeId" name="exchangeId" value="${MemberDTO.id }" style="margin-left: 120px" readonly />
						<input type="hidden" id="myPoint" value="${MemberDTO.mypoint }"/>
					</div> 
					<div class="input-row">
						<span class="textTitle">신청일</span>
						<input type="text" class="textDisable" id="regidate" name="regidate" value="" style="margin-left: 160px" readonly />
					</div> 
					<div class="input-row">
						<span class="textTitle">환전 요청 포인트</span>
						<input type="text" class="textInput" id="exchangePoint" name="exchangePoint" value="ex) 120000" onFocus="value=''" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="margin-left: 80px"/>
					</div> 
					<div class="input-row">
						<span class="textTitle">입금은행명</span>
						<input type="text" class="textInput" id="bankName" name="bankName" value="ex) 우리" onFocus="value=''" style="margin-left: 126px"/>
					</div> 
					<div class="input-row">
						<span class="textTitle">계좌주</span>
						<input type="text" class="textInput" id="accountName" name="accountName" value="ex) 코스모" onFocus="value=''" style="margin-left: 160px"/>
					</div> 
					<div class="input-row">
						<span class="textTitle">계좌번호</span>
						<input type="text" class="textInput" id="accountNum" name="accountNum" value="ex) 0024675907244" onFocus="value=''" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="margin-left: 142px"/> 
					</div> 
				
					<!-- 확인하기, 취소하기 버튼 -->
					<div class="input-row">
						<button type="button" class="btn btn-secondary" onClick="cancelation();" style="display: block; float: right; margin-right: 0px;">취소하기</button>
						<button type="submit" class="btn btn-success" style="display: block; float: right; margin-right: 10px;">환전 신청하기</button>
					</div> 
					
					<!-- 안내문 -->
					<div class="input-row" style="border-top: 1px solid gray; margin-top: 80px; padding-top: 10px;">
						<p class="inform">환전은 10만포인트부터 1만포인트 단위로 신청가능합니다.</p>
						<p class="inform">환전 수수료 30%를 제외한 환전 요청금액의 70%가 입금됩니다.</p>
						<p class="inform">입금 처리는 매주 월요일 09:00기준 신청건에 한하여 일괄 처리합니다.</p>
						<p class="inform">단, 월요일이 휴무일인 경우 영업일 기준 익일에 처리됩니다.</p>
						<p class="inform">본인 명의의 계좌가 아닌 경우 입금처리가 불가합니다.</p>
						<p class="inform">계좌정보의 불일치로 입금처리가 불가한 경우가 발생하지 않도록</p>
						<p class="inform" style="margin-top: 0px;">다시 한 번 신청내용을 확인해주시기 바랍니다.</p>
						<p class="inform">기타 문의사항은 1:1 문의하기를 이용해주시기 바랍니다.</p>
					</div> 
				</form>
   		</div>
			<!-- 본문내용 종료 -->
		</div>
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
<script>
// 오늘 날짜 문자열로 구하기
function today() {
  var fullDate = new Date()
  return changeFormat(fullDate)
}
//날짜 포맷으로 변경후 반환하는 함수
function changeFormat(param){
	var changeYear = param.getFullYear()
	var changeMonth = param.getMonth() + 1
	var changeDate = param.getDate()
	
	if (changeMonth < 10) {
		var changeMonth = '0' + changeMonth
	}
	if (changeDate < 10) {
		var changeDate = '0' + changeDate
	}

	return (changeYear + '-' + changeMonth + '-' + changeDate)
}
</script>

<script>
// 취소버튼 클릭시
function cancelation(){
	if (confirm("환전신청을 취소하고 메인화면으로 돌아가시겠습니까?")){
		location.href="./main.do";
	}
}
</script>

<script>
// 폼값 전송시 적합성 체크
function valiCheck(){
	var exchangePoint = $("#exchangePoint").val();
	var myPoint = $("#myPoint").val();
	var checkPoint = myPoint - exchangePoint;
	var bankName = $("#bankName").val();
	var accountName = $("#accountName").val();
	var accountNum = $("#accountNum").val();
	
	if(exchangePoint == '' || exchangePoint =='0'){
		alert('환전 포인트를 입력해주세요.');
		$('#exchangePoint').focus();
		return false;
	}
	if(exchangePoint < 100000){
		alert('환전신청은 100000포인트 이상부터 가능합니다.');
		$('#exchangePoint').focus();
		return false;
	}
	if((exchangePoint % 10000) != 0){
		alert('환전 포인트는 10000포인트 단위로 입력해주세요.');
		$('#exchangePoint').focus();
		return false;
	}
	if(checkPoint < 0){
		alert('보유 포인트가 부족합니다.');
		$('#exchangePoint').focus();
		return false;
	}
	if(isNaN(exchangePoint)){
		alert('환전포인트는 숫자만 입력해주세요.');
		$('#exchangePoint').focus();
		return false;
	}
	
	if (bankName == '' || bankName == "ex) 우리"){
		alert("은행명을 입력해주세요");
		$("#bankName").focus();
		return false;
	}
	if (accountName == "" || accountName == "ex) 코스모"){
		alert("계좌주를 입력해주세요");
		$("#accountName").focus();
		return false;
	}
	if (accountNum == ""){
		alert("계좌번호를 입력해주세요");
		$("#accountNum").focus();
		return false;
	}
	if(isNaN(accountNum)){
		alert('계좌번호는 숫자만 입력해주세요.');
		$('#accountNum').focus();
		return false;
	}
}
</script>
</html>