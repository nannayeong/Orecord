<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
        		<c:forEach var="b" items="${audiolist}">
					<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="feed">
						<tr>
							<td rowspan="5" style="width:7em;padding-left:1em;padding-right:1em;padding-top:1.5em;vertical-align:top">
								<img src="${b.imagename }" alt="" style="width:6em;height:6em"/>
							</td>
								<td style="padding-left:1em">
								<div style="font-size:14px;cursor:pointer" onclick="location.href='./${b.id }/record'">
									${nicknames[b.id] }
								</div>
								<div style="font-size:18px">
									<a href="./board/view.do?audio_idx=${b.audio_idx}">${b.audiotitle}</a>
									- <a href="${pageContext.request.contextPath}/search.do?searchWord=${b.artistname}">${b.artistname}</a>
								</div>
							</td>
							<td style="text-align:right; color:#423e3e; font-size:14px; padding-right:2em">
								<div>${b.regidate }</div>
								<div>${b.category }</div>
							</td>	
							<td colspan="2" style="padding-right:0.5em">
								<div>
									<div class="dropdown">
									  <span data-toggle="dropdown" style="cursor:pointer">
									    <i class="fas fa-bars"></i>
									  </span>
									  <div class="dropdown-menu">
									  <c:if test="${pageContext.request.userPrincipal.name eq b.id }">
									    <a class="dropdown-item" href="javascript:recordDeleteFunc(${b.audio_idx });">삭제하기</a>
									    <a class="dropdown-item" href="#">수정하기</a>
									    <c:if test="${b.party eq 1}">
									    <a class="dropdown-item" href="#">협업신청리스트</a>
									    </c:if>
									  </c:if>
									  <c:if test="${not empty pageContext.request.userPrincipal.name}">
									  	<a class="dropdown-item" href="${pageContext.request.contextPath}/report/reportlist.do">신고하기</a>
									  </c:if>
									  </div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<audio controls style="width:97%" id="${b.albumName }" >
									<source src="${b.audiofilename }" type="audio/mp4">
								</audio>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								${b.contents}
							</td>
						</tr>
						<tr>
							<td>
							<c:set var="likeB" value="false"/>
								<c:forEach var="l" items="${likes }">
        		<c:if test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
					<c:choose>
               			<c:when test="${likeB}">
                      		<button type="button" class="btn btn-warning btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">
                      		좋아요 &nbsp
                      		${b.like_count }
                      		</button> 
                 		</c:when>
                 <c:otherwise>
                      <button type="button" class="btn btn-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')"  name="minibtn">
                      좋아요 &nbsp
                      ${b.like_count }
                      </button> 
                 </c:otherwise>
               		</c:choose>
						<button type="button" class="btn btn-secondary btn-sm" id="addplaylist" onclick="logincheck(this);" data-toggle="modal" data-target="#play${b.audio_idx}">
							플레이리스트
						</button>
						<!-- The Modal -->
						<c:if test="${not empty pageContext.request.userPrincipal.name}">
				<div class="modal" id="play${b.audio_idx}">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <h4 class="modal-title">플레이리스트 추가하기</h4>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      <!-- Modal body -->
				      <form action="${pageContext.request.contextPath}/addPlayList.do?${_csrf.parameterName}=${_csrf.token}" method="post">
				      <input type="hidden" name="audio_idx" value="${b.audio_idx }" />
				      <div class="modal-body" style="text-align:center">
				      	<div><img src="${b.imagename }" alt="" style="width:25px"/> 
							${b.audiotitle } - ${b.artistname }
						</div><br />
						<div style="margin-bottom:0.3em">저장할 플레이리스트 폴더 선택</div>
				      	<select name="plname" class="custom-select" style="width:12em;text-align:center">
				      		<c:forEach items="${plList}" var="pl" varStatus="status">
				      		<option value="${pl.plname}">${pl.plname }</option>
				      		</c:forEach>
				      	</select>
				      	&nbsp&nbsp<span onclick="addplname();"><i class="fas fa-plus fa-lg"></i></span><br />
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
						<button type="button" class="btn btn-secondary btn-sm" onclick="openmusicbox(${b.audio_idx})">
							재생목록+
						</button>
						<c:if test="${pageContext.request.userPrincipal.name ne b.id && b.party eq 1}">
						<button type="button" class="btn btn-secondary btn-sm" onclick="partyFunc(${b.audio_idx})">참여</button>
						</c:if>
							</td>
							<td style="text-align:right;padding-right:1.5em;color:#423e3e;font-size:14px" colspan="2">
								재생 : ${b.play_count} &nbsp&nbsp
								댓글수 : ${b.commentCount }
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
						</tr>
					</table>
           </c:forEach>