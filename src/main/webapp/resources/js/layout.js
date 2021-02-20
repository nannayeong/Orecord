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

var webSocket;
var chat_id;
window.onload = function(){
	chat_id = document.getElementById("chat_id").value;
	
	webSocket = new WebSocket("ws://localhost:8080/orecord/EchoServer.do");
	webSocket.onopen = function(event){
		wsOpen(event);
	};
	webSocket.onmessage = function(event){
		wsMessage(event);
	};
	webSocket.onclose = function(event){
		wsClose(event);
	};
	webSocket.onerror = function(event){
		wsError(event);
	};
}
function wsOpen(event){
	writeResponse("연결성공");
}
function wsMessage(event){
	var message = event.data.split("|");
	var sender = message[0];//닉네임
	var content = "temp";
	content = message[1];//메세지
	
	writeResponse(event.data);
	
	if(content == ""){
		//날라온 내용이 없으므로 아무것도 하지 않는다.
	}
	else{
		//내용에 / 가 있다면 귓속말
		if(content.match("/")){
			//귓속말
			if(content.match(("/"+ chat_id))){
				console.log("notify()");
				//노티 함수 호출
				notify(content);
			}
		}
		else{}
	}
}
function wsClose(event){
	writeResponse("대화 종료");
}
function wsError(event){
	writeResponse("에러 발생");
	writeResponse(event.data);
}
function enterkey(){
	if(window.event.keyCode==13){
		sendMessage();
	}
}
function writeResponse(text){
	console.log(text);
}
function notify(notiMsg) {
	
	if (Notification.permission !== 'granted') {
		alert('notification is disabled');
	}
	else {
		var notification = new Notification(
			notiMsg,
			{
				icon : 'https://t4.ftcdn.net/jpg/00/78/87/93/500_F_78879336_2f2Ivwq2jN2EFMSJSi72OevDAQob2JJv.jpg',
				body : '채택되셨습니다.',
			});
		//Noti에 핸들러를 사용한다.
		notification.onclick = function() {
			alert('채택된 글이 있습니다. 확인해주세요.');
		};
	}
	
	//토스트로 표시
	$('.toast-body').html(notiMsg);
	$('.toast').toast({
		delay : 5000
	}).toast('show');
}
function addpl(){
	var pln = $("select[name=plname]").val();
	var aidx = $("input[name=audio_idx]").val();
	$.ajax({
	     url : "/orecord/addpl.do",
	     type : "get",
	     contentType : "text/html;charset:utf-8",
	     data : {plname:pln,audio_idx:aidx},
	     dataType : "json",
	     success : function sucFunc(resData) {
	    	 if(resData.result==1){
					alert("플레이리스트에 등록되었습니다");
					window.open("/orecord/musicbox?state=playlist&pl="+pln, "musicbox", "width=400,height=550,toolbars=no,status=no");
			 }
	     }    
	});
}
