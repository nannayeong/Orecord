<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>admin - member</title>

<!-- Custom fonts for this template-->
<link href="${pageContext.request.contextPath}/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link href="${pageContext.request.contextPath}/resources/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${pageContext.request.contextPath}/resources/admin/css/sb-admin.css" rel="stylesheet">

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

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
	
	 // 다른 확장자 업로드 시 경고창 
    if($("#img").val != ""){
    	var ext = $('#img').val().split('.').pop().toLowerCase();
    	if($.inArray(ext, ['jpeg','jpg','png'])==-1){
    		alert("지정된 확장자의 파일만 업로드 가능합니다.");
    		$("#img").val("");
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
</script>
</head>

<body id="page-top">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="${pageContext.request.contextPath}/admin/main">Orecord</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <button class="btn btn-primary" type="button">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>

    <!-- Navbar -->
    <ul class="navbar-nav ml-auto ml-md-0">
      <li class="nav-item dropdown no-arrow mx-1">
        <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-bell fa-fw"></i>
          <span class="badge badge-danger">9+</span>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown no-arrow mx-1">
        <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-envelope fa-fw"></i>
          <span class="badge badge-danger">7</span>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown no-arrow">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-user-circle fa-fw"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
          <a class="dropdown-item" href="#">Settings</a>
          <a class="dropdown-item" href="#">Activity Log</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
        </div>
      </li>
    </ul>

  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/main">
          <span>회원관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/adaudioboardList.do">
          <span>게시물관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/adalbumList.do">
          <span>앨범관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/sponsorshipList.do">
          <span>후원관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/chargeList.do">
          <span>결제/충전관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/exchangeList.do">
          <span>환전관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/mCommentList.do">
          <span>댓글관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/partyList.do">
          <span>협업관리</span>
        </a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/reportList.do">
          <span>신고관리</span>
        </a>
      </li>
    </ul>

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="../admin/main">Orecord</a>
          </li>
          <li class="breadcrumb-item active">memberEdit</li>
        </ol>
        
        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>회원수정</div>
          <div class="card-body">
            <div class="table-responsive">
              <form name="registFrm" onsubmit="return isValidate(this);" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/admemberEditAction.do">
				<s:csrfInput />
					<input type="hidden" name="id" value="${dto.id }"/>
					<!-- 아이디 -->
					<div class="row">
						<div class="col-md-6 pr-md-1">
							<label>아이디</label>
							${dto.id }
						</div>
						<div class="col-md-6 pl-md-1">
							<label>닉네임</label>
							${dto.nickname }
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<label>비밀번호</label>
							<input type="text" class="form-control" id="pw" value="${dto.pw }"
								name="pw" min="4" maxlength="20" placeholder="비밀번호를 입력해주세요.">
							<font id="chkNotice" size="2"></font>	
							<br />						
						</div>
						<div class="input-field col-md-6 pl-md-1">
							<label>비밀번호 확인</label>
							<input type="password" class="form-control" id="pw2" value="${dto.pw }"
								name="pw2" min="4" maxlength="20" placeholder="비밀번호를 확인하세요">
						</div>
					</div>
					
					<div class="row">
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
						<div class="input-field col-md-6 pr-md-1">
							<label>휴대폰 번호</label>
							<input type="text" class="form-control" id="phone" name="phone" maxlength="11" placeholder="'-' 없이 번호만 입력해주세요" value="${dto.phone }"> <br />
						</div>
						<div class="input-field col-md-6 pl-md-1 ">
							<label>프로필 이미지</label> <input type="file" class="form-control" name="img" id="img" value="${dto.img }" accept=".jpeg,.jpg,.png">
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-4 pr-md-1">
							<label>주소</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind()" onkeypress="">[우편번호검색]</a>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4 pr-md-1" >
							<input type="text" name="address" id="address" class="form-control" value="${addArr[0] }">
						<br />
						</div>
					</div>
					
					<div class="row">
						<div class="input-field col-md-6 pr-md-1">
							<input type="text" name="addr1" id="addr1" value="${addArr[1] }" class="form-control" />
						</div>
						<div class="input-field col-md-6 pl-md-1">
							<input type="text" name="addr2" id="addr2" value="${addArr[2] }" class="form-control" />
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12">
							<div class="form-group" style="padding-top: 20px;">
								<label>자기소개</label>
								<textarea rows="4" cols="80" class="form-control" maxlength="50" placeholder="내용을 적어주세요." name="intro" >${dto.intro }</textarea>
							</div>
						</div>
					</div>
					
					<div align="center">
						<input type="submit" class="btn btn-fill btn-primary" value="수정하기"> &nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset" class="btn btn-fill btn-primary">RESET</button>
					</div>
				</form>
               </tbody>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © Your Website 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/chart.js/Chart.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>
  <script src="js/demo/chart-area-demo.js"></script>

</body>
</html>
