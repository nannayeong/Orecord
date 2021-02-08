<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
</head>
<style>
#list tr:hover{
background-color: #f2f2f2;cursor:pointer
}
#list tr{
border:1px solid #f2f2f2
}
</style>
<body>
<!-- 앨범 -->
<table style="width:95%;margin:auto;margin-bottom:1em">
<c:choose>
<c:when test="${empty albumList }">
	<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
		<div>등록된 앨범이 없습니다.</div><br />
		<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
		<div><button type="button" onclick="location.href='../upload.do'" class="btn btn-outline-dark">업로드하기</button></div>
		</c:if>
	</td>
</c:when>
<c:otherwise>
<c:forEach items="${albumList }" var="album">
	<tr>
		<td rowspan="2" style="width:7em;padding-left:1em;padding-right:1em;vertical-align:top;padding-top:1em">
			<img src="${album.albumJacket }" alt="" style="width:6em"/>
		</td>
		<td style="padding-top:1em">
			<div><h4>${album.albumName }</h4></div>
			<audio controls style="background-color:white;width:420px;height:40px" id="${album.albumName }">
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
 			<div id="accordion">
				<div id="col${album.albumName }" class="collapse show" data-parent="#accordion">
					<table style="width:95%;font-size:15px" id="list">
						<c:forEach items="${audioList }" var="audio" varStatus="status">
						<c:if test="${audio.albumName eq album.albumName }">	
						<tr>		
							<td onclick="location.href='../board/view.do?audio_idx=${audio.audio_idx}'">
								<img src="${audio.imagename }" alt="" style="width:25px"/> 
								${status.count }. ${audio.audiotitle } - ${audio.artistname }
							</td>
							<td>
								<span id="play" onclick="clickAudio('${audio.audiofilename}','${album.albumName }');" class="iconPoint"> 
                   					<i class="fas fa-play"></i>
                   				</span>&nbsp&nbsp 
                   				<span id="addplaylist" class="iconPoint"
                   					onclick="loginCheckPlay('${pageContext.request.userPrincipal.name}',${audio.audio_idx })">
                   					
                   				</span>&nbsp&nbsp
                   				
                   				<span id="" class="iconPoint"
                   					onclick="loginCheckaddLike('${pageContext.request.userPrincipal.name}',${audio.audio_idx })">
                   					
                   				</span>
							</td>
						</tr>
						</c:if>
						</c:forEach>
					</table>
				</div>

			    <div style="cursor:pointer;background-color:#f2f2f2;font-size:15px;text-align:center;margin-bottom:1em;width:95%">
			    	<a class="card-link" data-toggle="collapse" href="#col${album.albumName }">
			    		트랙 리스트
			    	</a>
			    </div>
			</div>			
		</td>
	</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</table>

</body>
</html>