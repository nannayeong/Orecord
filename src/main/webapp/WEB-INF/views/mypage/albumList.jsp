<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 앨범 -->
<c:forEach items="${albumList }" var="album">
<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em">
	<tr>
		<td rowspan="2" style="width:7em;padding-left:1em;padding-right:1em;vertical-align:top;padding-top:1em">
			<img src="../resources/img/default.jpg" alt="" style="width:6em"/>
		</td>
		<td style="padding-top:1em">
			<div><h4>${album.albumName }</h4></div>
			<audio controls style="background-color:white;width:420px;height:40px" id="">
				<c:forEach items="${audioList }" var="audio">
				<c:if test="${audio.albumName eq album.albumName }">
    			<source src="${audio.audiofilename }" type="audio/mp4"/>
    			</c:if>
    			</c:forEach>
    		</audio>
		</td>
	</tr>
	<tr>
		<td>
			<!-- 앨범 수록 음원 -->
			<div class="accordion" id="acc">
				<div id="col${album.albumName }" class="collapse show" aria-labelledby="headingOne" data-parent="#acc">
					<div>
						<table style="width:95%;font-size:15px">
							<c:forEach items="${audioList }" var="audio" varStatus="status">
							<c:if test="${audio.albumName eq album.albumName }">	
							<tr>		
								<td style="border:1px solid #f2f2f2"><img src="" alt="" /> ${status.count }. ${audio.audiotitle } - ${audio.artistname }</td>
							</tr>
							</c:if>
							</c:forEach>
						</table>
					</div>
			    </div>
			    <div data-toggle="collapse" data-target="#col${album.albumName }" aria-expanded="false" aria-controls="col${album.albumName }" 
			    style="cursor:pointer;background-color:#f2f2f2;font-size:15px;text-align:center;margin-bottom:1em;width:95%">
			        트랙리스트
			    </div>
			</div>
		</td>
	</tr>
</table>
</c:forEach>
</html>