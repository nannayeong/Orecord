<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#list tr:hover{
background-color: #f2f2f2;cursor:pointer
}
#list tr{
border:1px solid #f2f2f2;
}
</style>
 
<!-- 앨범 -->
<table style="width:80%;margin:auto;">
<c:choose>
<c:when test="${empty plSet and nowPage eq '1'}">
	<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
		<div>등록된 플레이리스트가 없습니다.</div><br />
		<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
		<div><button type="button" onclick="location.href='../main.do'" class="btn btn-outline-dark">음악찾으러가기</button></div>
		</c:if>
	</td>
</c:when>
<c:otherwise>
<c:forEach items="${plSet }" var="plName">
	<tr>
		<td style="padding-top:1em"> 
			<table style="width:100%">
				<tr>
					<td><span style="font-size:30px">${plName}</span></td>
					<td style="padding-right:1em;text-align:right">
						<div>
							<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
							<button type="button" class="btn btn-outline-dark btn-sm" onclick="">삭제</button>
							</c:if>
						</div>
					</td>
				</tr>
			</table>
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
                   				
								
                   				<!-- 삭제 -->
                   				<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
                   				<span id="heart" class="iconPoint" onclick="likeFunc(${audio.audio_idx});">
                   					<i id="likeIcon${audio.audio_idx}" class="fas fa-heart ${audio.like eq 'true' ? 'on' : '' }"></i>
                   				</span>
                   				</c:if>	
                   				<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
                   				<span>
								  <a href="javascript:plAudioDeleteFunc(${audio.idx}, ${audio.audio_idx });">
								  	<i class="fas fa-trash-alt"></i>
								  </a>
								</span>
								</c:if>
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