<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#list{
border:2px #f2f2f2 solid
}
#list:hover{
background-color: #f2f2f2;cursor:pointer
}
</style>
</style>
<table style="width:95%;margin:auto;">
<c:choose>
<c:when test="${empty audioList and nowPage eq 1}">
	<tr>
		<td style="text-align:center;border:2px #f2f2f2 solid;height:30em">
			<div>등록된 레코드가 없습니다.</div><br />
		</td>
	</tr>
</c:when>
<c:otherwise>
<c:forEach items="${audioList }" var="audio" varStatus="status">
	<table style="width:95%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em;">
		<tr>
			<td rowspan="5" style="width:7em;padding-left:1em;padding-right:1em;padding-top:1.5em;vertical-align:top">
				<img src="${audio.imagename }" alt="" style="width:6em"/>
			</td>
			<td style="padding-left:1em">
				<div style="font-size:14px;cursor:pointer" onclick="location.href='../${audio.id }/record'">
					${audio.id }
				</div>
				<div style="font-size:18px">
					<a href="../board/view.do?audio_idx=${audio.audio_idx }">${audio.audiotitle}</a>
					- <a href="${pageContext.request.contextPath}/search.do?searchWord=${audio.artistname}">${audio.artistname}</a>
				</div>
			</td>
			<td style="text-align:right; color:#423e3e; font-size:14px; padding-right:2em">
				<div>${audio.regidate }</div>
				<div>${audio.category }</div>
			</td>	
			<td>
				<div class="dropdown">
				  <span data-toggle="dropdown" style="cursor:pointer">
				    <i class="fas fa-bars"></i>
				  </span>
				  <div class="dropdown-menu">
				  <c:if test="${pageContext.request.userPrincipal.name eq audio.id }">
				    <a class="dropdown-item" href="javascript:recordDeleteFunc(${audio.audio_idx });">삭제하기</a>
				    <a class="dropdown-item" href="../board/modify.do?audio_idx=${audio.audio_idx }">수정하기</a>
				    <c:if test="${audio.party eq 1}">
				    <a class="dropdown-item" href="../board/partyList.do?audio_idx=${audio.audio_idx }">협업신청리스트</a>
				    </c:if>
				  </c:if>
				  </div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<audio controls style="width:97%" id="${audio.albumName }">
					<source src="${audio.audiofilename }" type="audio/mp4">
				</audio>
			</td>
		</tr>
		<tr>
			<td>
				${audio.contents}
			</td>
		</tr>
		<tr>
			<td>
				<button type="button" class="btn btn-secondary btn-sm" title="좋아요" onclick="likeFunc('${audio.audio_idx}')">
					<i class="fas fa-heart ${audio.like eq 'true' ? 'on' : '' }" id="likeIcon${audio.audio_idx}"></i> &nbsp 
					<span id="likecount${audio.audio_idx}">${audio.like_count }</span>
				</button> 
				<button type="button" class="btn btn-secondary btn-sm" id="addplaylist" onclick="logincheck(this);" data-toggle="modal" data-target="#play${audio.audio_idx}">
					플레이리스트
				</button>
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
						<div style="margin-bottom:0.3em">저장할 플레이리스트 폴더 선택</div>
				      	<select name="plname" class="custom-select" style="width:12em;text-align:center">
				      		<c:forEach items="${plList}" var="pl" varStatus="status">
				      		<option value="${pl.plname}">${pl.plname }</option>
				      		</c:forEach>
				      	</select>
				      	&nbsp&nbsp<span onclick="addplname();"><i class="fas fa-plus fa-lg"></i></span><br />
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
				<c:if test="${pageContext.request.userPrincipal.name ne audio.id && audio.party eq 1}">
				<button type="button" class="btn btn-secondary btn-sm" onclick="partyFunc(${audio.audio_idx})">참여</button>
				</c:if>
			</td>
			<td style="text-align:right;color:#423e3e;font-size:14px;padding-right:1.5em;" colspan="2">
				재생 : ${audio.play_count} &nbsp&nbsp
				댓글수 : ${audio.commentCount }
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
					<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
				</form>
			</td>
		</tr>
	</table>
</c:forEach>
</c:otherwise> 
</c:choose>
</table>