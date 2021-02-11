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
<table style="width:80%;margin:auto;margin-bottom:1em">
<c:choose>
<c:when test="${empty plSet }">
	<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
		<div>등록된 플레이리스트가 없습니다.</div><br />
		<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
		<div><button type="button" onclick="location.href='../main.do'" class="btn btn-outline-dark">음악찾으러가기</button></div>
		</c:if>
	</td>
</c:when>
<c:otherwise>
<c:forEach items="${plSet }" var="plName">
	<tr>
		<td style="padding-top:1em"> 
			<div>
				<span style="font-size:30px">${plName}</span>
				<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
				
				<button type="button" onclick="">리스트삭제</button>
				</c:if>
			</div>
			<audio controls style="background-color:white;width:560px;height:40px" id="${plName }">
				<c:forEach items="${plList }" var="pl">
				<c:if test="${plName eq pl.plname }">
    			<source src="${pl.audiofilename }" type="audio/mp4"/> 
    			</c:if>
    			</c:forEach>
    		</audio>
		</td>
	</tr>
	<tr>
		<td>
			<!-- 앨범 수록 음원 -->
 			<div id="accordion">
				<div id="col${plName }" class="collapse show" data-parent="#accordion">
					<table style="width:100%;font-size:15px" id="list">
						<c:forEach items="${plList }" var="audio" varStatus="status">
						<c:if test="${audio.plname eq plName }">	
						<tr>		
							<td onclick="location.href='../board/view.do?audio_idx=${audio.audio_idx}'" style="padding-left:0.7em">
								<img src="${audio.imagename }" alt="" style="width:25px;"/> 
								${status.count }. ${audio.audiotitle } - ${audio.artistname }
							</td>
							<td style="padding-right:0.7em;text-align:right">
								<!-- 플레이버튼 -->
								<span id="play" onclick="clickAudio('${audio.audiofilename}','${plName }');" class="iconPoint"> 
                   					<i class="fas fa-play"></i>
                   				</span>&nbsp&nbsp 
                   				
                   				<!-- 플레이리스트추가 -->
                   				<span id="addplaylist" class="iconPoint" onclick="logincheck(this);" data-toggle="modal" data-target="#play${audio.audio_idx}">
                   					<i class="fas fa-plus fa-lg"></i>
                   				</span>&nbsp&nbsp
                   				<!-- The Modal -->
								<c:if test="${not empty pageContext.request.userPrincipal.name}">
								<div class="modal" id="play${audio.audio_idx}">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <!-- Modal Header -->
								      <div class="modal-header">
								        <h4 class="modal-title">플레이리스트 추가하기</h4>
								        <button type="button" class="close" data-dismiss="modal">&times;</button>
								      </div>
								      <!-- Modal body -->
								      <form action="../addPlayList.do?${_csrf.parameterName}=${_csrf.token}" method="post">
								      <input type="hidden" name="audio_idx" value="${audio.audio_idx }" />
								      <div class="modal-body" style="text-align:center">
								      	<div><img src="${audio.imagename }" alt="" style="width:25px"/> 
											${audio.audiotitle } - ${audio.artistname }
										</div><br />
								      	<span>저장할 플레이리스트 폴더 선택</span><br />
								      	<select name="plname" id="" style="width:8em;text-align:center">
								      		<c:forEach items="${plList}" var="pl" varStatus="status">
								      		<option value="${pl.plname}">${pl.plname }</option>
								      		</c:forEach>
								      	</select>
								      </div>
								      <!-- Modal footer -->
								      <div class="modal-footer">
								        <button type="submit" class="btn btn-warning btn-sm">추가하기</button>
								      </div>
									</form>
								    </div>
								  </div>
								</div>
								</c:if>
								
                   				<!-- like -->
                   				<span id="heart" class="iconPoint" onclick="likeFunc(${audio.audio_idx});">
                   					<i id="likeIcon${audio.audio_idx}" class="fas fa-heart ${audio.like eq 'true' ? 'on' : '' }"></i>
                   				</span>	
<%--                    				<span id="likecount${audio.audio_idx}">${audio.like_count }</span> --%>
							</td>
						</tr>
						</c:if>
						</c:forEach>
					</table>
				</div>

			    <div style="cursor:pointer;background-color:#f2f2f2;font-size:15px;text-align:center;margin-bottom:1em;width:100%">
			    	<a class="card-link" data-toggle="collapse" href="#col${plName }">
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
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

</body>
</html>