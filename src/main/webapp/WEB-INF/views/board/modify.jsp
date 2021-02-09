<%@page import="impl.ViewImpl"%>
<%@page import="model.AudioBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지 수정</title>
<!-- Jquery, BootStrap -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css"
	rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script>
var modiValidate = function(f){
	
	if(f.artistname.value==""){
		alert("아티스트명을 입력하세요");
		f.artistname.focus();
		return false;
	}
	if(f.audiotitle.value==""){
		alert("곡 명을 입력하세요");
		f.audiotitle.focus();
		return false;
	}
	if(f.audiofilename.value==""){
        alert('음원파일을 첨부하세요.');
        f.audiofilename.focus();
        return false;
    }if(f.country.selectedIndex == 0){
        alert("나라를 선택하세요.");
        f.country.focus();
        return false;
    }
    if(f.genre.selectedIndex == 0){
        alert("장르를 선택하세요.");
        f.genre.focus();
        return false;
    }
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus();
		return false;
	}
	
	// 다른 확장자 업로드시 경고창
	if($("#imagename").val != ""){
    	var ext = $('#imagename').val().split('.').pop().toLowerCase();
    	if($.inArray(ext, ['jpeg','jpg','png'])==-1){
    		alert("지정된 확장자의 파일만 업로드 가능합니다.");
    		$("#imagename").val("");
    		return false;
    	}
    }
    
    if($("#audiofilename").val != ""){
    	var ext = $('#audiofilename').val().split('.').pop().toLowerCase();
    	if($.inArray(ext, ['mp4','mp3','wav'])==-1){
    		alert("지정된 확장자의 파일만 업로드 가능합니다.");
    		$("#audiofilename").val("");
    		return false;
    	}
    }
}
</script>
</head>
<body>
<script> 
$.fn.setPreview = function(opt){
	"use strict" 
	var defaultOpt = { 
			inputFile: $(this), 
			img: $('#img_preview'), 
			w: 300, 
			h: 250 
	}; 
	$.extend(defaultOpt, opt); 
	
	var previewImage = function(){ 
		if (!defaultOpt.inputFile || !defaultOpt.img) return; 
		
		var inputFile = defaultOpt.inputFile.get(0); 
		var img = defaultOpt.img.get(0); 
		
		// FileReader 
		if (window.FileReader) { 
			// image 파일만 
			if (!inputFile.files[0].type.match(/image\//)) return; 
			
			// preview 
			try { 
				var reader = new FileReader(); 
				reader.onload = function(e){ 
					img.src = e.target.result; 
					img.style.width = defaultOpt.w+'px'; 
					img.style.height = defaultOpt.h+'px'; 
					img.style.display = ''; 
				} 
				reader.readAsDataURL(inputFile.files[0]);
			} catch (e) { 
				// exception... 
			} 
		// img.filters (MSIE) 
		}else if (img.filters) { 
			inputFile.select(); 
			inputFile.blur(); 
			var imgSrc = document.selection.createRange().text;
			
			img.style.width = defaultOpt.w+'px'; 
			img.style.height = defaultOpt.h+'px'; 
			img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")"; 
			img.style.display = ''; 
			
		// no support 
		} else { 
			// Safari5, ... 
		} 
	}; 
	
	// onchange 
	$(this).change(function(){ 
		previewImage(); 
	}); 
}; 
		
$(document).ready(function(){ 
	var opt = { 
		img: $('#img_preview'), 
		w: 260, 
		h: 260 
	}; 
	$('#input_file').setPreview(opt); 
}); 

function colChoice(){
	var fn = document.regiform;
	
	if(fn.party.checked==true){
		fn.party.value = "Y";
	}
	else{
		fn.party.value = "N";
	}
}
</script>
<div>
	<div class="content">
		<!-- 왼쪽 컨텐츠 -->
		<form method="post" enctype="multipart/form-data" name="modiform"
			onsubmit="return modiValidate(this);"
			action="<c:url value="/board/modifyAction.do" />">
			<s:csrfInput />
			<input type="hidden" name="audio_idx" value="${modify.audio_idx}">
			<input type="hidden" name="id" value="${pageContext.request.userPrincipal.name}" />
			<div
				style="background: linear-gradient(to right, #91888A, #5A5B82);"
				class="jumbotron">
				<div class="row">
					<div class="col-8"
						style="padding-left: 40px; font-size: 20px;">
						<div class="row">
							<!-- 가수명, 곡 이름 -->
							<div class="col-6">
								<div style="padding: 8px 0 5px 0;">
									<label>아티스트 명</label>
									<input type="text" class="form-control"
										name="artistname" value="${modify.artistname }">
								</div>
								<div style="margin-top: 5px;">
									<label>곡 이름</label> <input type="text" class="form-control"
										name="audiotitle" value="${modify.audiotitle }">
								</div>
							</div>
							<!-- 작성일, 카테고리 -->
							<div class="col-4 " style="padding-top: 8px;">
								<label>작성일</label>
								<input type="text" class="form-control" name="regidate" value="${modify.regidate }">
								<!-- 국가별 카테고리 -->
								<div class="form-group">
									<label style="margin-top: 10px;">카테고리</label> <select
										name="country" id="country" class="form-control">
										<option style="color: black;" value="noValue">나라</option>
										<option style="color: black;" value="Ghana">가나</option>
										<option style="color: black;" value="Korea">대한민국</option>
										<option style="color: black;" value="Germany">독일</option>
										<option style="color: black;" value="US">미국</option>
										<option style="color: black;" value="Brazil">브라질</option>
										<option style="color: black;" value="Sweden">스웨덴</option>
										<option style="color: black;" value="Singapore">싱가포르</option>
										<option style="color: black;" value="Argentina">아르헨티나</option>
										<option style="color: black;" value="UK">영국</option>
										<option style="color: black;" value="Japan">일본</option>
									</select>
								</div>
								<!-- 장르별 카테고리 -->
								<div class="form-group">
									<select name="genre" id="genre" class="form-control">
										<option style="color: black;" value="noValue">장르</option>
										<option style="color: black;" value="Dance">Dance</option>
										<option style="color: black;" value="Rock">Rock</option>
										<option style="color: black;" value="Jazz">Jazz</option>
										<option style="color: black;" value="Classic">Classic</option>
										<option style="color: black;" value="Ballad">Ballad</option>
										<option style="color: black;" value="Hip-pop">Hip-pop</option>
										<option style="color: black;" value="Pop">Pop</option>
										<option style="color: black;" value="Trot">Trot</option>
										<option style="color: black;" value="Reggae">Reggae</option>
										<option style="color: black;" value="Blues">Blues</option>
									</select>
								</div>
							</div>
						</div>
						
						<!-- 음원파일 -->
						<div style="padding: 5px 80px 5px 0;">
							<label>음원파일</label>
							<input type="file" class="form-control"
								name="audiofilename" id="audiofilename" accept=".mp4,.mp3,.wav">
						</div>
					</div>

					<!-- 앨범사진 -->
					<div class="col-4" style="padding: 0 30px 20px 20px;">
						<label>앨범사진</label>
						<input type="file" id="input_file" accept=".jpeg,.jpg,.png"
							name="imagename" class="form-control"/>
						<img id="img_preview" class="inline-block"/>
					</div>
				</div>
			</div>
			<br>
			<!-- 곡 설명 -->
			<div style="padding-left: 50px;">
				<textarea name="contents" id="" cols="120" rows="10"
					placeholder="내용을 입력해주세요."></textarea>
			</div>
			<hr width="90%" align="center" color="gray" size="10px">
			<!-- 수정, 삭제 버튼 -->
			<div class="d-flex flex-row-reverse" style="margin-top: 15px;">
				<div style="margin-right: 60px;">
					<button type="submit" class="btn btn-outline-info">수정</button>
				</div>
				<div style="margin-right: 10px;">
					<button type="button" class="btn btn-outline-info"
					onclick="location.href='view.do?audio_idx=${modify.audio_idx}'">
						취소
					</button>
				</div>
			</div>
			<br> <br>
		</form>
		<!-- 왼쪽 컨텐츠 종료 -->
	</div>
	<!-- 본문종료 -->
</div>


	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp"%>
	</header>

</body>
</html>