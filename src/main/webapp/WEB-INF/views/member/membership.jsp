<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - 회원 가입</title>

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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
 
<script type="text/javascript">
	var length = /^[a-z0-9]{4,12}$/;
	var space = /\s/;
	var kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; 
	
	var idCheckButton = 0;
	var nickCheckButton = 0;
	
	
	
	function isValidate(frm1){
		
		var frm = document.registFrm;
//////////공백 체크////////////
		var pw = document.getElementById("pw").value;
		
		if(frm.id.value==''){
			alert('아이디를 입력하세요');
			frm.id.focus();
			return false;
		}
		//아이디 중복확인을 하지않았을때..
		if(idCheckButton==0){
			alert('아이디 중복확인을 반드시 확인해주세요.');
			frm.id.focus();
			return false;
		}
		if(frm.nickname.value==''){
			alert('닉네임을 입력하세요');
			frm.nickname.focus();
			return false;
		}
		if(frm.nickname.value.length<2){
			alert('2자 이내로 입력하세요.');
			frm.nickname.focus();
			return false;
		}
		if(frm.nickname.value.kor<2){
			alert('2자 이내로 한글로 입력하세요.');
			frm.nickname.focus();
			return false;
		}
		//닉네임 중복확인을 하지않았을때..
		if(nickCheckButton==0){
			alert('닉네임 중복확인을 반드시 확인해주세요.');
			frm.nickname.focus();
			return false;
		}
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
		 //입력한 패스워드가 일치하지 않으면 둘다 지우고 처음부터 다시 입력하게 한다.
		 
// 		if(pw!=document.getElementById("pw2").value){
//             alert("입력한 패스워드가 일치하지 않습니다.");
            
//             document.getElementById("pw").focus();
            
//             return false;
       // }//비번검증끝
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
		
		
		
		
		
///////////////// 닉네임 글자수 제한////////////////////		
		
		
		
///////////영문/아이디 조합 정규식/////////////////////////
		// a-z 0-9 중에 4자리 부터 12자리만 허용 한다는 뜻///
		   
		   
		////end/////////////////////////////////
	}
		////end/////////////////////////////////
//////////아이디 검증시작//////////////////////////////////////////////
//아이디 중복확인 이미지를 클릭하면!!!!
	
	function id_check_person(){
		
		//아이디에 입력한 값을 id의 value값인 DOM을 통해 가져온다.
		var id = document.getElementById("id").value;
		
		//아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입.
		if(!length.test(id) || space.test(id)==true){
		    alert("아이디는 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 입력하세요.");  
		    return false;
		}
		//중복체크를 누를때 입력된 아이디가 없다면..
		if(id!=''){
			//중복확인창을 띄울때 기존 입력내용을 수정할수 없도록 
			//readonly속성을 걸어준다.
			idCheckButton = 1;
			console.log(idCheckButton);
			/*
			open() : 광고나 공지사항을 게시할 팝업창을 열고싶을때 주로 사용하는 함수.
				형식] window.open("요청명?서블릿에보낼값"+값, 창의이름, 창의속성(모양, 크기, 위치 등));
				-창의이름을 지정하지 않으면 동일한 창이 여러개 띄워질수도 있다.
				-창의이름이 동일하면 여러개의 창이 하나의 창에 띄워질수도 있다.
			*/
			//입력된 아이디를 파라미터로 전달하면서 팝업창을 열어준다.
			window.open("../member/idChk.do?id="+id, "idChk", "width=600, height=150");
		}
		
		
	} 
	
	
/////////////아이디 검증 end ////////////////////////////////////
// a-z 0-9 중에 4자리 부터 12자리만 허용 한다는 뜻///

//////////닉네임 검증시작//////////////////////////////////////////////
//닉네임 중복확인 이미지를 클릭하면!!!!
	
	function nick_check_person(){
		
		//아이디에 입력한 값을 id의 value값인 DOM을 통해 가져온다.
		var nickname = document.getElementById("nickname").value;

		//아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입.
		if(space.test(nickname)==true || !kor.test(nickname)==true){
		    alert("닉네임은 2자 이상 12자 이내로 공백 없이 한글로 입력하세요."); 
		    frm.nickname.focus();
		    return false;
		}
		//중복체크를 누를때 입력된 아이디가 없다면..
		if(nickname!='') {
			//중복확인창을 띄울때 기존 입력내용을 수정할수 없도록 
			//readonly속성을 걸어준다.
			nickCheckButton = 1;
			console.log(nickCheckButton);
			/*
			open() : 광고나 공지사항을 게시할 팝업창을 열고싶을때 주로 사용하는 함수.
				형식] window.open("요청명?서블릿에보낼값"+값, 창의이름, 창의속성(모양, 크기, 위치 등));
				-창의이름을 지정하지 않으면 동일한 창이 여러개 띄워질수도 있다.
				-창의이름이 동일하면 여러개의 창이 하나의 창에 띄워질수도 있다.
			*/
			//입력된 아이디를 파라미터로 전달하면서 팝업창을 열어준다.
			window.open("../member/nickChk.do?nickname="+nickname, "nickChk", "width=600, height=150");
		}
	} 
	
/////////////닉네임 중복 확인 검증 end ////////////////////////////////////




////////주소입력은 DAUM우편번호 API 사용/////////////////////////////////
	function zipcodeFind(){     
	    new daum.Postcode({
	        oncomplete: function(data) {
	            //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력.
	            console.log(data.zonecode);
	            console.log(data.address);
	            console.log(data.sido);
	            console.log(data.sigungu);
	            //가입폼에 적용하기 이런방법도있음~ 참고하세요
// 				document.getElementById('zip1').value = data.postcode1;
// 				document.getElementById('zip1').value = data.postcode2;
// 				document.getElementById('addr1').value = data.address;
// 				document.getElementById('addr2').value = data.postcode2;
				      
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


</script>


</head>
<body>
	<div>
		<div class="content">
		<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
			<div class="row">
				<div style="margin: 50px 0 0 80px;">
					<h5 style="margin-left: 5px;">Join membership</h5>
					<h2>회원가입</h2>
				</div>
			</div>
		</div>
		<br />
		<hr color="gray">
			<!-- 왼쪽 컨텐츠 -->
			
				<div class="left-content">
					<!-- <table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em"> -->
						<form name="registFrm" onsubmit="return isValidate(this);" method="post" enctype="multipart/form-data" 
						action="${pageContext.request.contextPath}/member/membershipAction.do">
				<s:csrfInput />
					<!-- 아이디 -->
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<label>아이디</label>
							<input type="text" class="form-control" id="id"
								name="id"  min="4" maxlength="12" placeholder="아이디를 입력해주세요.">
							<br />
						</div>
						<div class="input-field col-md-6 pl-md-1"
							style="margin-top: 32px;">
							<input type="button" class="btn btn-warning"
								 onclick="id_check_person()" name="idcheck" value="중복확인">
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<label>닉네임</label>
							<input type="text" class="form-control" 
							name="nickname" id="nickname" min="4" maxlength="12" placeholder="닉네임을 입력해주세요."> <br />
						</div>
						<div class="input-field col-md-6 pl-md-1"
							style="margin-top: 32px;">
							<input type="button" class="btn btn-warning"
								id="nickname1" onclick="nick_check_person()" name="nicknamecheck" value="중복확인">
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<label>비밀번호</label>
							<input type="password" class="form-control" id="pw"
								name="pw" min="4" maxlength="20" placeholder="비밀번호를 입력해주세요.">
							<font id="chkNotice" size="2"></font>							
						</div>
						<div class="input-field col-md-6 pl-md-1">
							<label>비밀번호 확인</label>
							<input type="password" class="form-control" id="pw2"
								name="pw2" min="4" maxlength="20" placeholder="비밀번호를 확인하세요"> <br /><br />
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-4 pr-md-1">
							<label>이메일</label>
							<input type="text" name="email_1" id="email_1"
								class="form-control" placeholder="이메일 입력" value="">
							<br />
						</div>
						<div style="margin-top: 36px;">
							&nbsp;@ <br />
						</div>
						<div class="input-field col-md-4 px-md-1"
							style="margin-top: 32px;">
							<input type="text" class="form-control" name="email_2"
								id="email_2" readonly>
							<br />
						</div>
						<div class="input-field col-md-3 pl-md-1"
							style="margin-bottom: 30px; height: 25px;">
							<select name="select_email" id="select_email"
								class="form-control"
								style="margin-top: 32px; background-color: white;"
								onchange="email(this.value);">
								<option value="no">선택해주세요</option>
								<option value="직접입력">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="hanmail.net">hanmail.net</option>
							</select> <br />
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<label>휴대폰 번호</label>
							<input type="text" class="form-control" id="phone"
								name="phone" maxlength="11" placeholder="'-' 없이 번호만 입력해주세요"> <br />
						</div>
						<div class="input-field col-md-6 pl-md-1 ">
							<label>프로필 이미지</label> <input type="file"
								class="form-control" name="img" id="img" value="${dto.img }"
								 accept=".jpeg,.jpg,.png">
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-4 pr-md-1">
							<label>주소</label>
							<input type="text" name="address" id="address"
								class="form-control" placeholder=""> <br />
						</div>
						<div class="input-field col-md-4 pl-md-1"
							style="margin-top: 32px;">
							<input type="button" value="우편번호검색" class="btn btn-warning" onclick="zipcodeFind()" onkeypress=""  />
<!-- 							<a href="javascript:;" title="새 창으로 열림" -->
<!-- 								onclick="zipcodeFind()" onkeypress="">[우편번호검색]</a> <br /> -->
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<input type="text" name="addr1" id="addr1" value=""
								class="form-control" />
						</div>
						<div class="input-field col-md-6 pl-md-1">
							<input type="text" name="addr2" id="addr2" value=""
								class="form-control" />
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12">
							<div class="form-group" style="padding-top: 20px;">
								<label>자기소개</label>
								<textarea rows="4" cols="80" class="form-control"
									maxlength="50" placeholder="내용을 적어주세요." name="intro"></textarea>
							</div>
						</div>
					</div>
					&nbsp;
					<div class="button" align="center">
						<button type="submit" class="btn btn-outline-warning" style="width: 45em">회원가입</button>
					
					</div>
					&nbsp;
					<div>
						<button type="reset" class="btn btn-outline-warning" style="width: 45em">RESET</button>
					</div>
				</form>
						
						
						
						
						
						
						
						
					<!-- </table> -->
				</div>
			</div>
			
			<!-- 오른쪽 컨텐츠종료 -->
		</div>
		<!-- 본문종료 -->
	

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 