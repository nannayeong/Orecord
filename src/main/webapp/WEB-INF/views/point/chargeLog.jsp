<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
	margin-right: 0;
	font-weight: bold;
}

h4 {
	margin-top: 0.2em;
	margin-bottom: 0;
	margin-left: 0.2em;
	margin-right: 0;
}

#paymentButton {
	font-size: 20px;
	width: 140px;
	height: 50px;
	display: block; 
	float: right;
}

.left-content-header {
	width: 95%;
	margin: auto;
}

.left-content-body {
	width: 95%;
	margin: auto;
}
.datepicker {
margin-left: -15px;
}
</style>
<script>
	$(document).ready(function() {
		selectLastWeek(); // 문서 로드되면 기본 조회일자 1주일전으로 설정
	});
</script>
</head>
<body>
	<div>
		<div class="content">
			<!-- 왼쪽 컨텐츠 시작-->
			<div class="left-content-back">
				<div class="left-content">
					<!-- 본문 제목 시작-->
					<div class="left-content-header">
						<button type="button" class="btn btn-primary" id="paymentButton" data-toggle="modal" data-target="#paymentModal">결제하기</button>
						<h2>${loginId }님</h2> 
						<h4>보유 포인트 : 2000Point</h4> <!-- 마이 포인트 얻어오기 -->
					</div>
					<!-- 본문 제목 종료 -->
					<!-- 본문내용 시작 -->
					<div class="left-content-body">
						<div class="pointSubMenu" style="margin-top:10px;">
							<div class="btn-group btn-group-sm"> 
								<button type="button" class="btn btn-outline-primary" disabled>결제 내역</button>
								<button type="button" class="btn btn-outline-primary" onClick="location.href='./sponsorLog.do'">후원한 내역</button>
								<button type="button" class="btn btn-outline-primary" onClick="location.href='./patronLog.do'">후원 받은 내역</button>
								<button type="button" class="btn btn-outline-primary" onClick="location.href='./exchangeLog.do'">환전 내역</button>
							</div>
							<div class="container">
								<div class="datepicker">
									<p>
										<button type="button" class="btn btn-primary btn-sm" id="btnToday" onClick="selectToday()">오늘</button>
										<button type="button" class="btn btn-primary btn-sm" id="btnWeek" onClick="selectLastWeek()">1주일</button>
										<button type="button" class="btn btn-primary btn-sm" id="btnMonth" onClick="selectLastMonth()">1개월</button>
										<button type="button" class="btn btn-primary btn-sm" id="btnYear" onClick="selectLastYear()">1년</button>
										&nbsp;&nbsp;&nbsp;&nbsp; 기간 : 
											<input type="text" id="date_from" size="7" 	style="text-align: center;">
										~ <input type="text" id="date_to" size="7" style="text-align: center;">
											<button type="button" class="btn btn-primary btn-sm" id="search" style="margin-right: -14px; float: right;" onClick='searchingLog();'>조회</button> 
									</p>
								</div>
							</div>
							<table class="table text-center" id="changingTableId">
								<thead class="thead-light text-center">
						      <tr>
						        <th width="30%">날짜</th>
						        <th width="40%">결제수단</th>
						        <th width="30%">충전포인트</th>
						      </tr>
								</thead>
						    <tbody>
									<tr>
										<td colspan="3" align="center"> 기간을 설정하고 조회버튼을 클릭해주세요 </td>
									</tr>
								</tbody>
							</table>
         		</div>
      		</div>
					<!-- 본문내용 종료 -->
				</div>
			</div>
			<!-- 왼쪽 컨텐츠 종료 -->
			<!-- 오른쪽 컨텐츠 -->
			<div class="right-content-back">
				<div class="right-content">
					첫하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />
					하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />하이<br />막하이<br />
				</div>
			</div>
			<!-- 오른쪽 컨텐츠종료 -->
		</div>
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
<!-- 아임포트 결제창 로드 시작 -->
<script>
	$("#paymentButton").click(function () {
    var IMP = window.IMP; // 생략가능
    IMP.init('imp83561682'); 
    IMP.request_pay({
      pg: 'inicis', // version 1.1.0부터 지원.
      pay_method: 'card',
      merchant_uid: 'merchant_' + new Date().getTime(),
      name: 'orecord : 포인트 구매',
      amount: 100, 
      buyer_email: 'test@test.com',
      buyer_name: '',
      buyer_tel: '',
      buyer_addr: '',
      buyer_postcode: '',
      m_redirect_url: '결제완료 매핑명'
     }, 
     function (rsp) {
      console.log(rsp);
      if (rsp.success) {
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
      } 
      else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
      }
      alert(msg);
     });
 	});
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
		console.log(selectPage);
		$.ajax({
			url: "searchingLog.do",
		  data : {fromDate : $("#date_from").val(), 
			  			toDate : $("#date_to").val(), 
			  			selectPage : selectPage,
			  			selectLog : "chargeLog"},
		  type : "get",
		  dataType : "json",
		  success: function (data) {
		    if (data != null) {
		    	changingTableFunc(data); // HTML 테이블 작성 함수 호출
				}
				else {
					alert("조회된 내역이 없습니다.");
				}
			},
			error : function(error) {
				alert("error : " + error);
			}
		});
	}
</script>

<!-- ajax 콜백 데이터로 받은 조회내역으로 뷰테이블을 대체하기 위해 HTML 작성 함수-->
<script >
function changingTableFunc(obj) {
	var table = document.querySelector('#changingTableId');
  var resultLog = obj.list;
	var html = '<table class="table text-center" id="changingTableId">';
			html += '	<thead class="thead-light text-center">';
			html += '		<tr><th width="30%">날짜</th><th width="40%">결제수단</th><th width="30%">충전포인트</th></tr></thead>';
			html += '	<tbody>';
	for (var i=0; i<resultLog.length; i++) {
	    html += '<tr><td>' + resultLog[i].regidate + '</td><td>' + resultLog[i].paymentType
           + '</td><td> ' + resultLog[i].chargePoint+ '</td></tr>';
	}
			html += '<tr><td colspan="3">';
			html += '<ul class="pagination justify-content-center pagination-sm" style="color: red; border: 2px; font-size:20px; margin-bottom: 0px; margin-top: 30px">';
			
				if(obj.startpageInBlock = 1) {
					html += '<li class="page-item disabled">';
				}
				else {
					html += '<li class="page-item">';
				}
					html += '<a class="page-link" href="#" aria-label="Previous">';
					html += '	<span aria-hidden="true">&laquo;</span>';
					html += '		<span class="sr-only">Previous</span></a></li>';
	
				for (var i=obj.startpageInBlock; i<=obj.endpageInBlock; i++) {
					if(i==obj.currentPage) {
						html += '<li class="page-item disabled"><a class="page-link" onClick="searchingLog(' + i + ');">' + i + '</a></li>';
					}
					else {
						html += '<li class="page-item"><a class="page-link" onClick="searchingLog(' + i + ');">' + i + '</a></li>';
					}
				}
				
				if(obj.endpageInBlock >= obj.totalPage) {
					html += '<li class="page-item disabled">';
				}
				else{
					html += '<li class="page-item">';
				}
					html += '	<a class="page-link" href="#" aria-label="Next">';
					html += '		<span aria-hidden="true">&raquo;</span>';
					html += '		<span class="sr-only">Next</span></a>';
							
			html +=  '</li></ul></td></tr>';
			html += '	</tbody>';
			html += '</table>';
	
	table.innerHTML = html;
}
</script>
<script>
function changePaymentMoney(param){
	document.getElementById("displayMoney").value = param;
}	
</script>
</html>