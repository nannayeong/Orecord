<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - memberEdit</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

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
	var length = /^[a-z0-9]{4,12}$/;
	var space = /\s/;
	
	var idCheckButton = 0;
	var nickCheckButton = 0;
	
	
	
	function isValidate(frm1){
		
		var frm = document.registFrm;
//////////공백 체크////////////
		var pw = document.getElementById("pw").value;
		if(frm.pw.value=='' || frm.pw2.value==''){
			alert('비밀번호를 입력하세요');
			frm.pw.focus();
			return false;
		}
		
		//비밀번호 유효성 검사//
		if(!length.test(frm.pw.value) || space.test(frm.pw.value)==true){
		    alert("비밀번호는 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 입력하세요.");
		    frm.pw.focus();      
		    return false;
		}
		if(frm.email_1.value=='' || frm.email_2.value==''){
			alert('이메일을 입력하세요');
			frm.email_1.focus();
			return false;
		}
		if(frm.phone.value==''){
			alert('전화번호를 입력하세요');
			frm.phone.focus();
			return false;
		}
		if(frm.address.value=='' || frm.addr1.value=='' || frm.addr2.value==''){
			alert('주소를 입력하세요');
			frm.address.focus();
			return false;
		}
	}
	
////////주소입력은 DAUM우편번호 API 사용/////////////////////////////////
	function zipcodeFind(){     
	    new daum.Postcode({
	        oncomplete: function(data) {
	            //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력.
	            console.log(data.zonecode);
	            console.log(data.address);
	            console.log(data.sido);
	            console.log(data.sigungu);
				      
	            //폼값의 name으로 지정되있는 registFrm 가져온다. - document.registFrm
	            var f = document.registFrm;
	            f.address.value = data.zonecode;
	            f.addr1.value = data.address;
	            
	            //상세주소입력하기위해 다음 텍스트로 스크롤이 자동으로
	            //넘어가기위해focus()를 준다.
	            f.addr2.focus();
	        }
	    }).open();
	} 
	
////////////////이메일 셀렉옵션 체인지시 설정함수./////////////////////////
function email(str) {
	if(str != "직접입력") {
		document.getElementById("email_2").value = str;
		document.getElementById("email_2").readOnly = true;
	} else {
		document.getElementById("email_2").value = "";
		document.getElementById("email_2").readOnly = false;
		document.getElementById("email_2").focus();
	}	
}

$(function(){
    $('#pw').keyup(function(){
      $('#chkNotice').html('');
    });

    $('#pw2').keyup(function(){

        if($('#pw').val() != $('#pw2').val()){
          $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
          $('#chkNotice').attr('color', '#f82a2aa3');
        } else{
          $('#chkNotice').html('비밀번호 일치함<br><br>');
          $('#chkNotice').attr('color', '#199894b3');
        }
    });
});

function memberDeleteFunc(){
	
	var f = document.getElementById("delete").value;
	
	var answer = window.confirm("정말로 탈퇴하시겠습니까?");
	
    if(answer==true){
    	
        alert("탈퇴되었습니다.")
        location.href="${pageContext.request.contextPath}/memberDelete.do";
    }
    else if(answer==false){
        alert("탈퇴를 취소하였습니다.")
       
    }
	
}
</script>


</head>
<body>
	<div>
		<div class="content">
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">memberEdit</h5>
					<h2>회원수정</h2>
					<br />
				</div>
			</div>
		</div>
		<br>
		<hr color="gray">
			<form name="registFrm" onsubmit="return isValidate(this);" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/{user_id}/memberEditAction.do">
			<s:csrfInput />
				<!-- 아이디 -->
				<div class="row">
					<div class="col-5">
						<label>아이디</label>
						${pageContext.request.userPrincipal.name }
					</div>
					<div class="col-5">
						<label>닉네임</label>
						${dto.nickname }
					</div>
				</div>
					
				<div class="row">
					<div class="col-5">
						<label>비밀번호</label>
						<input type="password" class="form-control" id="pw" value="${dto.pw }"
							name="pw" min="4" maxlength="20" placeholder="비밀번호를 입력해주세요.">
						<font id="chkNotice" size="2"></font>	
						<br />						
					</div>
					<div class="col-5">
						<label>비밀번호 확인</label>
						<input type="password" class="form-control" id="pw2"
							name="pw2" min="4" maxlength="20" placeholder="비밀번호를 확인하세요">
					</div>
				</div>
					
				<div class="row" style="margin: 0 -15px 0 35px;">
					<div class="input-field col-md-4 pr-md-1">
						<label>이메일</label>
						<input type="text" name="email_1" id="email_1"
							class="form-control" placeholder="이메일 입력" value="${emailArr[0] }">
							<br />
					</div>
					<div style="margin-top: 35px;">@</div>
					<div class="input-field col-md-4 px-md-1">
						<input type="text" class="form-control" name="email_2" id="email_2" value="${emailArr[1] }" style="margin-top: 32px;" readonly>
					</div>
					<div class="input-field col-md-3 pl-md-1" style="">
						<select name="select_email" id="select_email" class="form-control" onchange="email(this.value);" style="margin-top: 32px;" value="">
							<option value="no">선택해주세요</option>
							<option value="직접입력">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
					</div>
				</div>
				
				<div class="row">
					<div class="col-5">
						<label>휴대폰 번호</label>
						<input type="text" class="form-control" id="phone" name="phone" maxlength="11" placeholder="'-' 없이 번호만 입력해주세요" value="${dto.phone }"> <br />
					</div>
					<div class="col-5">
						<label>프로필 이미지</label> <input type="file" class="form-control" name="img" id="img" value="${dto.img }" accept=".jpeg,.jpg,.png">
					</div>
				</div>
				
				<div class="row">
					<div class="col-5">
						<label>주소</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind()" onkeypress="">[우편번호검색]</a>
					</div>
				</div>
				<div class="row">
					<div class="col-5" >
						<input type="text" name="address" id="address" class="form-control" value="${addArr[0] }">
					<br />
					</div>
				</div>
				
				<div class="row">
					<div class="col-5">
						<input type="text" name="addr1" id="addr1" value="${addArr[1] }" class="form-control" />
					</div>
					<div class="col-5">
						<input type="text" name="addr2" id="addr2" value="${addArr[2] }" class="form-control" />
					</div>
				</div>
				
				<div class="row">
					<div class="col-11">
						<div class="form-group" style="margin: 15px -15px 0 50px;">
							<label>자기소개</label>
							<textarea rows="4" cols="80" class="form-control" maxlength="50" placeholder="내용을 적어주세요." name="intro" >${dto.intro }</textarea>
							<br /><br />
						</div>
					</div>
				</div>
				
				<div align="center">
					<input type="submit" class="btn btn-warning" value="수정하기" style="color: white;"> &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-warning" value="탈퇴하기" id="delete" name="delete" style="color: white;" onclick="memberDeleteFunc();"/>
				</div>
					<br /><br />
				<hr color="gray">
			</form>
		</div>
	</div>
	<!-- 본문종료 -->
	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 