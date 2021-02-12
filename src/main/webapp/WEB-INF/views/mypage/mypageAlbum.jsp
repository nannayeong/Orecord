<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#list tr:hover{
background-color: #f2f2f2;cursor:pointer
}
#list tr{
border:1px solid #f2f2f2
}
</style>
<!-- 앨범 -->
<table style="width:95%;margin:auto;">
<c:choose>
<c:when test="${empty albumList and nowPage eq 1}">
	<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
		<div>등록된 앨범이 없습니다.</div><br />
		<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
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
			<div>
				<span style="font-size:30px">${album.albumName }</span>
				<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
				<button type="button" data-toggle="modal" data-target="#albumEdit${album.album_idx }">앨범수정</button>
				<!-- 수정 모달 -->
				<div class="modal" id="albumEdit${album.album_idx }">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <h4 class="modal-title">앨범 수정</h4>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      <!-- Modal body -->
				      <form action="../albumModify.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" >
				      <div class="modal-body" style="text-align:center">
				      	<label>이미지</label>
		                <input type="file" id="imgFile" accept=".jpeg,.jpg,.png" name="imagename" class="form-control"/>
		                <img id="img_preview" class="inline-block"/>
		                <span>앨범이름 : </span> <input type="text" name="albumName" value="${album.albumName }" />
		                <input type="hidden" name="album_idx" value="${album.album_idx }" />
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="submit" class="btn btn-warning btn-sm">수정하기</button>
				      </div>
					</form>
				    </div>
				  </div>
				</div>
				<button type="button" onclick="deleteAlbumFunc(${album.album_idx})">앨범삭제</button>
				</c:if>
			</div>
			<audio controls style="background-color:white;width:495px;height:40px" id="${album.albumName }">
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
							<td onclick="location.href='../board/view.do?audio_idx=${audio.audio_idx}'" style="padding-left:0.7em">
								<img src="${audio.imagename }" alt="" style="width:25px;"/> 
								${status.count }. ${audio.audiotitle } - ${audio.artistname }
							</td>
							<td style="padding-right:0.7em;text-align:right">
								<!-- 플레이버튼 -->
								<span id="play" onclick="clickAudio('${audio.audiofilename}','${album.albumName }');" class="iconPoint"> 
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
                   				<c:if test="${pageContext.request.userPrincipal.name ne user_id}">
                   				<span id="heart" class="iconPoint" onclick="likeFunc(${audio.audio_idx});">
                   					<i id="likeIcon${audio.audio_idx}" class="fas fa-heart ${audio.like eq 'true' ? 'on' : '' }"></i>
                   				</span>
                   				</c:if>	
                   				<c:if test="${pageContext.request.userPrincipal.name eq user_id}">
                   				<span class="dropdown">
								  <span data-toggle="dropdown" style="cursor:pointer">
								    <i class="fas fa-ellipsis-h fa-lg"></i>
								  </span>
								  <div class="dropdown-menu">
								  	
								    <a class="dropdown-item" href="javascript:recordDeleteFunc(${audio.audio_idx });">삭제하기</a>
								    <a class="dropdown-item" href="#">수정하기</a>
								  </div>
								</span>
								</c:if>
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