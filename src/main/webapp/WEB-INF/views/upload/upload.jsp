<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orecord - upload</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap-theme.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<style>
.col-5{
  margin:15px 0 0 50px;
}
.form-group p {
  margin-top:37px; color:gray;
  font-size:16px;
}
</style>
     <script>   
      var isValidate = function(frm){
         
           if(frm.audiotitle.value==""){
               alert('곡명을 입력하세요.');
               frm.audiotitle.focus();
               return false;
           }
           if(frm.artistname.value==""){
               alert('아티스트명을 입력하세요.');
               frm.artistname.focus();
               return false;
           }
           if(frm.audiofilename.value==""){
               alert('음원파일을 첨부하세요.');
               frm.audiofilename.focus();
               return false;
           }
           if(frm.country.selectedIndex == 0){
                alert("나라를 선택하세요.");
                frm.country.focus();
                return false;
            }
           if(frm.genre.selectedIndex == 0){
                alert("장르를 선택하세요.");
                frm.genre.focus();
                return false;
            }
           
           
           // 다른 확장자 업로드 시 경고창 
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
            w: 380, 
            h: 300 
         }; 
         $('#input_file').setPreview(opt); 
      }); 
   </script>
</head>
<body>

<script> 


function addAlbumFunc(){
   if($('#addAlbumName').val()==''){
      alert('앨범명을 입력해주세요');
   }
   else{
      $.ajax({
           url : "./addAlbum.do",
           type : "get",
           contentType : "text/html;charset:utf-8",
           data : {addAlbumName:$('#addAlbumName').val()},
           dataType : "json",
           success : function sucFunc(resData) {
              if(resData.result==1){
                 $('#albumName').prepend('<option value="'+resData.addAlbumName+'"style="color: black;" selected>'+resData.addAlbumName+'</option>');
                 alert("새 앨범이 추가되었습니다");
                 $('#addalbum').modal('hide');
                }
              else{
                 alert('중복되는 앨범이름입니다.');
              }
           }    
      });
   }
}
</script>
   <div>
      <div class="content">
      <div style="background: linear-gradient(to right, #91888A, #5A5B82);">
         <div class="row">
            <div style="margin: 50px 0 0 80px;">
               <h5 style="margin-left: 5px;">upload</h5>
               <h2>업로드</h2>
            </div>
         </div>
      </div>
      <br>
      <hr color="gray">
         <!-- 왼쪽 컨텐츠 -->
            <form name="regiform" onsubmit="return isValidate(this);" method="post" enctype="multipart/form-data" action="./uploadAction.do?${_csrf.parameterName}=${_csrf.token}">
                
                <div class="row"> 
                   <div class="col-5">
                      <label>이미지</label>
                      <input type="file" id="input_file" accept=".jpeg,.jpg,.png" name="imagename" class="form-control"/>
                  <img id="img_preview" class="inline-block"/>
               </div>
               <div class="col-5">
                         <div class="form-group">
                           <label>곡명</label>
                           <tr><input type="text" class="form-control" name="audiotitle" id="audiotitle" value=""></tr>
                         </div>
                         <div class="form-group">
                           <label>아티스트명</label>
                           <input type="text" class="form-control" name="artistname">
                         </div>
                         <div class="form-group">
                           <label>앨범</label>
                           <button type="button" data-toggle="modal" data-target="#addalbum">앨범추가</button>
                           <!-- The Modal -->
                     <div class="modal" id="addalbum">
                       <div class="modal-dialog">
                         <div class="modal-content">
                           <!-- Modal body -->
                           <div class="modal-body" style="text-align:center">
                              <span>추가할 앨범명을 입력해주세요</span><br />
                              <input type="text" id="addAlbumName" />
                              <div><button type="button" id="aaButton" class="btn btn-warning btn-sm" onclick='addAlbumFunc();'>추가하기</button></div>
                           
                           </div>
                           <br />
                         </div>
                       </div>
                     </div>
                      </div>
                         <div class="form-group">
                           <select name="albumName" id="albumName" class="form-control">
                           <!-- <option value="default" style="color: black;">default</option> -->
                           <c:forEach items="${albumList}" var="album">
                           <option value="${album.albumName}" style="color: black;">${album.albumName}</option>
                           </c:forEach>
                           </select>
                         <label>음원파일</label>
                             <input type="file" class="form-control" name="audiofilename" id="audiofilename" accept=".mp4,.mp3,.wav">
                   </div>
               </div>
            </div>
            <div class="row">
                    <div class="col-5">
                       <div>다른 유저와 협업하기 <input type="checkbox" name="party" value="Y"/></div>
                       <br />
               </div>
               <div class="col-5">
                        <input type="hidden" class="form-control" name="id" value="${pageContext.request.userPrincipal.name}">
                   </div>
            </div>
                <div class="row">
                  <div class="col-5">
                    <div class="form-group">
                         <label>카테고리</label>
                         <select name="country" id="country" class="form-control">
                         <option style="color: black;" value="noValue" >나라</option> 
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
                  </div>
                  <div class="col-5">
                    <div class="form-group">
                       <select name="genre" id="genre" class="form-control" style="margin-top: 30px;">
                         <option style="color: black;" value="noValue" >장르</option> 
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
                  
                  <div class="row">
                    <div class="col-11">
                      <div class="form-group" style="margin: 15px -15px 0 50px;">
                        <label>곡설명</label>
                        <textarea rows="4" class="form-control" placeholder="내용을 적어주세요." name="contents"></textarea>
                      </div>
                      <br />
                      <br />
                    </div>
                  </div>
                     <div class="form-group" align="center">
                      <input type="submit" class="btn btn-fill btn-outline-warning" value="업로드">
                      <input type="reset" class="btn btn-fill btn-outline-warning" value="취소">
                    </div>
                 <br>
         <br>
         <hr color="gray">
            </form>
      </div>
   </div>
      <!-- 본문종료 -->
   <!-- 상단 메뉴바(위치옮기면안됨!) -->
   <header>
      <div class="menu-back">
         <%@include file="/resources/jsp/header.jsp" %>
      </div>
   </header>
</body>
</html>