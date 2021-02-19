<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<script>

function playstop(){
	if($('#playstop').hasClass('fa-play')){
		$('#playstop').removeClass('fa-play');
		$('#playstop').addClass('fa-pause')
	}
	else if($('#playstop').hasClass('fa-pause')){
		$('#playstop').removeClass('fa-pause');
		$('#playstop').addClass('fa-play')
	}
}

function playright(){
	
}

function playleft(){
	
}
</script>
<style>
.audiobar{margin:auto;margin-top:1.5em;}
.audiobar td{color:black;text-align:center}
</style>
</head>
<body>
<div class="row">
	<div class="col-12" style="background-color:red;height:100%">
		<div style="height:2.5em">
			<span>O!record</span>
		</div>
		<div style="text-align:center">
			<img src="${pageContext.request.contextPath}/resources/img/1.jpg" alt="" style="width:15em;height:15em"/>
		</div>
		<div>
			<table class="audiobar">
				<tr>
					<td><i class="fas fa-fast-backward" style="width:2.5em;height:2.5em;margin:0 1em 0 1em" onclick="playleft();"></i>
					<i id="playstop" class="fas fa-play" style="width:2.5em;height:2.5em;margin:0 1em 0 1em" onclick="playstop();"></i>
					<i class="fas fa-fast-forward" style="width:2.5em;height:2.5em;margin:0 1em 0 1em" onclick="playright();"></i></td>
				</tr>
				<tr>
					<td colspan="3">
						<div class="progress" style="width:345px;height:6px;margin-top:1em">
						   <div class="progress-bar bg-warning" style="width:40%;height:6px"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div class="btn-group btn-group-sm">
						  <button type="button" class="btn btn-primary">Apple</button>
						  <button type="button" class="btn btn-primary">Samsung</button>
						  <button type="button" class="btn btn-primary">Sony</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div></div>
	</div>
</div>
</body>
</html>