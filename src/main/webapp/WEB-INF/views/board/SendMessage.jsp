<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 메세지 보내기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<script type="text/javascript">
var messageWindow;
var inputMessage;
var chat_id;
var webSocket;
var logWindow;

window.onload = function(){
	messageWindow = document.getElementById("messageWindow");
	inputMessage = document.getElementById("msg");
	chat_id = document.getElementById("chat_id").value;
	logWindow = document.getElementById("logWindow");
	
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
function sendMessage(){
	receive_id = $("#r_id").val();
	inputMessage = '/'+ receive_id+ ' '+ $("#msg").val();
	var send_message = chat_id+ '|'+ inputMessage;
	console.log('send_message:'+ send_message);
	webSocket.send(send_message);
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
				body : '쪽지가 왔습니다.',
			});
		//Noti에 핸들러를 사용한다.
		notification.onclick = function() {
			alert('링크를 이용해서 해당페이지로 이동할 수 있다.');
		};
	}
	
	//토스트로 표시
	$('.toast-body').html(notiMsg);
	$('.toast').toast({
		delay : 5000
	}).toast('show');
}
</script>
<div class="container">
	<input type="hid den" name="r_id" id="r_id" value="${r_id }" />
	<input type="hid den" value="${sessionScope.chat_id }" />
	<input type="hid den" name="chat_id" id="chat_id" value="${pageContext.request.userPrincipal.name}" />
	<table class="table table-bordered">
		<tr>
			<td>닉네임:</td>
			<td><input type="text" id="chat_id" class="form=control"
				value="${pageContext.request.userPrincipal.name}" readonly/></td>
		</tr>
		<tr>
			<td>받는사람 아이디:</td>
			<td><input type="text" id="r_id" class="form-control"
				value="${r_id }" readonly/></td>
		</tr>
		<tr>
			<td>쪽지내용:</td>
			<td>
				<input type="text" name="msg" id="msg" class="form-control float-left mr-1"
					style="width:70%" onkeyup="enterkey();" />
				<input type="button" value="쪽지전송" onclick="sendMessage();"
					class="btn btn-info float-left"/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>