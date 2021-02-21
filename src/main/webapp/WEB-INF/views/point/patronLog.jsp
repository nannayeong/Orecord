<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - 후원 받은 내역 조회</title>

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

#paymentButton, #exchangeButton {
	font-size: 20px;
	width: 110px;
	height: 50px;
	display: block; 
	float: right;
}

.content {
	width: 750px;
	height: 800px;
}

.content-header {
	width: 95%;
	margin: auto;
	color: #333333;
	padding-top: 2em;
}

.content-body {
	width: 95%;
	margin: auto;
}

.datepicker {
	margin-top:10px;
}

#changingTableId {
	height: 640px;
}

.paginationPostion {
	text-align: center;
	font-size: 5px;
} 

#textBox {
	text-align: center;
	border: 0px;
	margin-left: 130px;
	color: #138496;
}
.displayModalTextbox {
	text-align: center;
	border: 0px;
	font-family: sans-serif;
	font-size: 	
}
</style>
<script>
	$(document).ready(function() {
		searchingLastWeek(); // 문서 로드되면 기본 조회일자 1주일전으로 설정하고 조회
	});
</script>
</head>
<body>
	<div>
		<div class="content">
			<!-- 본문 제목 시작-->
			<div class="content-header">
				<div class="pointMainMenu" style="border-bottom: 2px solid #545B62; padding-bottom: 10px;">
					<!-- 모달로 결제창 띄울 버튼 -->
					<button type="button" class="btn btn-info" id="exchangeButton" onClick="location.href='./exchangeForm.do'">환전하기</button>
					<button type="button" class="btn btn-info" id="paymentButton" style="margin-right:20px"data-toggle="modal" data-target="#paymentModal">결제하기</button>
					<!-- 결제창 모달 -->
					<div class="modal" id="paymentModal">
					  <div class="modal-dialog modal-lg modal-dialog-centered ">
					    <div class="modal-content">
					
					      <!-- Modal Header -->
					      <div class="modal-header">
					        <h4 class="modal-title">구매하실 포인트를 선택해주세요</h4>
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					      </div>
					
					      <!-- Modal body -->
					      <div class="modal-body">
					      	<div class="pointButton">
						        <button type="button" class="btn btn-info" onClick="selectAmount(1000);">1,000</button>
						        <button type="button" class="btn btn-info" onClick="selectAmount(5000);">5,000</button>
						        <button type="button" class="btn btn-info" onClick="selectAmount(10000);">10,000</button>
						        <button type="button" class="btn btn-info" onClick="selectAmount(50000);">50,000</button>
						        <button type="button" class="btn btn-info" onClick="selectAmount(100000);">100,000</button>
					      	</div>
					      	<div class="displayAmount" style="margin-top: 20px;">
					      		<input size="7" class="displayModalTextbox" value="선택금액" style="text-align: left">
					      		<input size="4" class="displayModalTextbox" id="amountText" value="" style="text-align: right">
					      		<input size="13" class="displayModalTextbox" value="원    +   부가세">
					      		<input size="4" class="displayModalTextbox" id="VATText" value="" style="text-align: right">
					      		<input size="1" class="displayModalTextbox" value="원"> 
					      		<input size="8" class="displayModalTextbox" value="총결제금액 : " style="margin-left:140px; font-weight: bold;">
					      		<input size="4" class="displayModalTextbox" id="totalAmountText" value="" style="text-align: right; font-weight: bold; color: red; font-size: 20px;">
					      		<input size="1" class="displayModalTextbox" value="원" style="font-weight: bold;">
					      	</div>
					      </div>
					
					      <!-- Modal footer -->
					      <div class="modal-footer"> 
					        <button type="button" class="btn btn-primary" onClick="paymentConfirm(document.getElementById('totalAmountText').value);" data-dismiss="modal">확인</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
					
					    </div>
					  </div>
					</div>
					<h2>${MemberDTO.id }님</h2>
					<input type="hidden" id="loginId" value="${MemberDTO.id }"/>
					<input type="hidden" id="loginEmail" value="${MemberDTO.email }"/>
					<h4>보유 포인트 : ${MemberDTO.mypoint }Point</h4>
				</div>
				<div class="pointSubMenu" style="margin-top:20px;">
					<div class="btn-group btn-group-sm"> 
						<button type="button" class="btn btn-secondary" onClick="location.href='./chargeLog.do'">결제 내역</button>
						<button type="button" class="btn btn-secondary" style="margin-left:1px" onClick="location.href='./sponsorLog.do'">후원한 내역</button>
						<button type="button" class="btn btn-secondary" style="margin-left:1px" disabled>후원 받은 내역</button>
						<button type="button" class="btn btn-secondary" style="margin-left:1px" onClick="location.href='./contributorLog.do'">협업한 내역</button>
						<button type="button" class="btn btn-secondary" style="margin-left:1px" onClick="location.href='./receiverLog.do'">협업 받은 내역</button>
						<button type="button" class="btn btn-secondary" style="margin-left:1px" onClick="location.href='./exchangeLog.do'">환전 내역</button>
					</div>
					<div class="datepicker">
						<button type="button" class="btn btn-info btn-sm" id="btnToday" onClick="searchingToday()">오늘</button>
						<button type="button" class="btn btn-info btn-sm" id="btnWeek" onClick="searchingLastWeek()">1주일</button>
						<button type="button" class="btn btn-info btn-sm" id="btnMonth" onClick="searchingLastMonth()">1개월</button>
						<button type="button" class="btn btn-info btn-sm" id="btnYear" onClick="searchingLastYear()">1년</button>
							<input type="text" id="textBox" value="기간 :" size="3">  
							<input type="text" id="date_from" size="8" style="text-align: center;">
						~ <input type="text" id="date_to" size="8" style="text-align: center;">
							<button type="button" class="btn btn-info btn-sm" id="search" style="float: right;" onClick='searchingLog();'>조회</button> 
					</div>
				</div>
			</div>
			<!-- 본문 제목 종료 -->
			<!-- 본문내용 시작 -->
			<div class="content-body" style="margin-top: 10px;">
				<div class="table" id="changingTableId">
					<table class="table table-hover text-center">
						<thead class="thead-light text-center">
				      <tr>
				        <th width="30%">날짜</th>
				        <th width="40%">나를 후원해준 유저</th>
				        <th width="30%">후원포인트</th>
				      </tr>
						</thead>
				    <tbody>
							<tr>
								<td colspan="3" align="center"></td>
							</tr>
						</tbody>
					</table>
				</div>
   		</div>
			<!-- 본문내용 종료 -->
		</div>
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
<!-- 아임포트 결제창 로드 시작 -->
<script>
function paymentConfirm(param) {
	var IMP = window.IMP; // 생략가능
	var lastAmount = parseInt(param);
	var loginId = document.getElementById("loginId").value;
	var loginEmail = document.getElementById("loginEmail").value;
	IMP.init('imp83561682'); 
	IMP.request_pay({
		pg: 'inicis', // version 1.1.0부터 지원.
    pay_method: 'card',
    merchant_uid: 'merchant_' + new Date().getTime(),
    name: 'orecord : 포인트 구매',
    amount: lastAmount, 
    buyer_email: loginEmail,
    buyer_name: loginId,
    buyer_tel: '',
    buyer_addr: '',
    buyer_postcode: '',
    m_redirect_url: '' // 모바일 환경 결제 성공시 연결될 URL
	}, 
 	function (rsp){
  	console.log(rsp);
    if (rsp.success) {
			console.log("돈 빼감");
			$.ajax({
				url: "insertChargeLog.do",
				method: "get",
		    data: {
		    				totalPayment: rsp.paid_amount,
		            paymentType: rsp.pay_method
		    			},
			  success: function () {
	  			alert("결제가 완료되었습니다.");
				},
				error : function(error) {
					console.log(error);
					alert("error : " + error);
				}
			});
		}
	});
}
</script>
<!-- 아임포트 결제창 로드 끝 -->
<!-- 날짜 선택 달력 시작 -->
<script>
$(function() {
	var dateFormat = "yy-mm-dd",
		from = $("#date_from").datepicker({
			"dateFormat" : "yy-mm-dd",
			monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],        
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],        
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],        
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],        
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],       
			showMonthAfterYear : true, // 년/월 순서변경 
	    isRTL : false, // true선택시 날짜 정렬 뒤집어짐   
	    changeYear : true, // 콤보 박스에서 년 선택
	    changeMonth : true, // 콤보 박스에서 월 선택
			maxDate : 0, // 오늘 날짜 이후 선택 불가
			numberOfMonths : 1 // 한달만 달력으로 표시하기
		})
			.on("change", function() {
				to.datepicker("option", "minDate", getDate(this));
			}),
		to = $("#date_to").datepicker({
			"dateFormat" : "yy-mm-dd",
			monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],        
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],        
			dayNames : ['일', '월', '화', '수', '목', '금', '토'],        
			dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],        
			dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],       
			showMonthAfterYear : true,
	    isRTL : false, 
	    changeYear : true,
	    changeMonth : true,
			maxDate : 0,
			numberOfMonths : 1
		})
			.on("change", function() {
				from.datepicker("option", "maxDate", getDate(this));
			});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} 
			catch (error) {
				date = null;
			}

			return date;
		}
});
</script>
<!-- 날짜 선택 달력 끝 -->
<script>
// 오늘 날짜 문자열로 구하기
function today() {
  var fullDate = new Date()
  return changeFormat(fullDate)
}

// 1주일전 문자열로 구하기
function lastWeek() {
  var fullDate = new Date()
  var date = fullDate.getDate()
  fullDate.setDate(date - 7)
  return changeFormat(fullDate)
}

// 1개월전 문자열로 구하기
function lastMonth() {
  var fullDate = new Date()
  var month = fullDate.getMonth()
  fullDate.setMonth(month - 1)
  return changeFormat(fullDate)
}

// 1년전 문자열로 구하기
function lastYear() {
  var fullDate = new Date()
  var year = fullDate.getFullYear()
  fullDate.setFullYear(year - 1)
  return changeFormat(fullDate)
}

// 날짜 포맷으로 변경후 반환하는 함수
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

// 조회기간 오늘 설정
function selectToday() {
	document.getElementById("date_from").value = today();
	document.getElementById("date_to").value = today();
	$("#date_to").datepicker("option", "minDate", 0);
}

//조회기간 1주일 설정
function selectLastWeek() {
	document.getElementById("date_from").value = lastWeek();
	document.getElementById("date_to").value = today();
	$("#date_to").datepicker("option", "minDate", lastWeek());
}

//조회기간 1개월 설정
function selectLastMonth() {
	document.getElementById("date_from").value = lastMonth();
	document.getElementById("date_to").value = today();
	$("#date_to").datepicker("option", "minDate", lastMonth());
}

//조회기간 1년 설정
function selectLastYear() {
	document.getElementById("date_from").value = lastYear();
	document.getElementById("date_to").value = today();
	$("#date_to").datepicker("option", "minDate", lastYear());
}
</script>

<!-- 조회버튼 클릭하면 데이터를 조회하기 위해 호출되는 함수 -->
<script>
	function searchingLog(selectPage){
		$.ajax({
			url: "searchingLog.do",
		  data : {fromDate : $("#date_from").val(), 
			  			toDate : $("#date_to").val(), 
			  			selectPage : selectPage,
			  			selectLog : "patronLog"},
		  type : "get",
		  dataType : "json",
		  success: function (data) {
		    if (data != null) {
		    	changingTableFunc(data); // HTML 테이블 작성 함수 호출
				}
			},
			error : function(error) {
				alert("error : " + error);
			}
		});
	}
</script>

<!-- 기간설정 버튼 클릭시 자동으로 조회까지 실행 -->
<script>
	function searchingToday(){
		selectToday()
		searchingLog()
	}
	function searchingLastWeek(){
		selectLastWeek()
		searchingLog()
	}
	function searchingLastMonth(){
		selectLastMonth()
		searchingLog()
	}
	function searchingLastYear(){
		selectLastYear()
		searchingLog()
	}
</script>

<!-- ajax 콜백 데이터로 받은 조회내역으로 뷰테이블을 대체하기 위해 HTML 작성 함수-->
<script >
function changingTableFunc(obj) {
	var table = document.querySelector('#changingTableId');
  var resultLog = obj.list;
  for (var i=0; i<resultLog.length; i++) {
		resultLog[i].sponPoint = comma(resultLog[i].sponPoint); 
	}
	var html = '<div class="table" id="changingTableId">';
			html = '<table class="table table-hover text-center">';
			html += '	<thead class="thead-light text-center">';
			html += '		<tr><th width="30%">날짜</th><th width="40%">나를 후원해준 유저</th><th width="30%">후원포인트</th></tr>';
			html += '	</thead>';
			html += '	<tbody>';
	if (obj.totalRecord == 0) {
			html += '<tr>';
			html += '	<td colspan="3" align="center"> 조회된 내역이 없습니다. </td>';
			html += '</tr></tbody></table></div>';
	}
	else {
		for (var i=0; i<resultLog.length; i++) {
		    html += '<tr><td>' + resultLog[i].regidate + '</td><td>' + resultLog[i].sponsorId
	           + '</td><td> ' + resultLog[i].sponPoint+ '</td></tr>';
		}
				html += '	</tbody></table></div>';
				html += '<nav class="paginationPostion" style="margin-bottom: 200px;">';
				html += '<ul class="pagination justify-content-center pagination-sm">';
				
					if(obj.startpageInBlock = 1) {
						html += '<li class="page-item disabled"><a class="page-link">&laquo;</a></li>';
					}
					else {
						html += '<li class="page-item"><a class="page-link">&laquo;</a></li>';
					}
		
					for (var i=obj.startpageInBlock; i<=obj.endpageInBlock; i++) {
						if(i==obj.currentPage) {
							html += '<li class="page-item disabled"><a class="page-link" onClick="searchingLog(' + i + ');">' + i + '</a></li>';
						}
						else {
							html += '<li class="page-item"><a class="page-link" onClick="searchingLog(' + i + ');">' + i + '</a></li>';
						}
					}
					
					if(obj.endpageInBlock >= obj.totalPage) {
						html += '<li class="page-item disabled"><a class="page-link">&raquo;</a></li>';
					}
					else{
						html += '<li class="page-item"><a class="page-link">&raquo;</a></li>';
					}
				html +=  '</ul></nav>';
	}
	table.innerHTML = html;
}
function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
    return str;
}
</script>
<!-- 결제 모달창에서 금액 선택시 결제 amount 디스플레이 변경 -->
<script>
function selectAmount(param){
	var amount = parseInt(param);
	document.getElementById("amountText").value = amount;
	document.getElementById("VATText").value = parseInt(amount/10);
	document.getElementById("totalAmountText").value = parseInt(amount*1.1);
}	
</script>
</html>