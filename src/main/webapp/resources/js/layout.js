$(function(){
	if($('.right-content').height()>$('.left-content').height()){
		$('.right-content-back').css("border-left","3px #f2f2f2 solid");
	}
	else{
		$('.left-content-back').css("border-right","3px #f2f2f2 solid");
	}
});

var count_setting = 0;
function settingFunc(){
	count_setting = count_setting+1;
	if(count_setting%2==1){
		$('.setting-down').css('visibility','');
		$('.setting-down').css('visibility','visibility');
	}
	else{
		$('.setting-down').css('visibility','');
		$('.setting-down').css('visibility','hidden');
	}
}
var count_noti = 0;
function notiFunc(){
	count_noti = count_noti+1;
	if(count_noti%2==1){
		$('.noti-down').css('visibility','');
		$('.noti-down').css('visibility','visibility');
	}
	else{
		$('.noti-down').css('visibility','');
		$('.noti-down').css('visibility','hidden');
	}
}

var count_user = 0;
function userFunc(){
	count_user = count_user+1;
	if(count_user%2==1){
		$('.user-down').css('visibility','');
		$('.user-down').css('visibility','visibility');
	}
	else{
		$('.user-down').css('visibility','');
		$('.user-down').css('visibility','hidden');
	}
}

function addplname(){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="/orecord/member/login.do"
	}
	else{
		var a = prompt('추가하실 이름을 입력해주세요');
		$('select[name=plname]').prepend('<option value='+a+' selected>'+a+"</option>");
	}
}
function partyFunc(aidx){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="/orecord/member/login.do"
	}
	else{
		location.href='/orecord/board/partyWrite.do?audio_idx='+aidx;
	}
}
function recordDeleteFunc(aidx){
	if("${pageContext.request.userPrincipal.name}"==""){
		alert('로그인 후 이용해주세요');
		location.href="/orecord/member/login.do"
	}
	else{
		if(confirm('삭제하시겠습니까?')){
			$.ajax({
			     url : "/orecord/recordDelete.do",
			     type : "get",
			     contentType : "text/html;charset:utf-8",
			     data : {audio_idx:aidx},
			     dataType : "json",
			     success : function sucFunc(resData) {
			    	 if(resData.result==1){
							alert("정상적으로 삭제되었습니다");
							location.href="./record";
					 }
			     }    
			});
		}
	}
}

var pop;
function openmusicbox(audio_idx){
	pop = window.open("/orecord/musicbox?audio_idx="+audio_idx, "musicbox", "width=400,height=550,toolbars=no,status=no");
}
function openmusicboxnull(){
	pop = window.open("/orecord/musicbox", "musicbox", "width=400,height=550,toolbars=no,status=no");
}