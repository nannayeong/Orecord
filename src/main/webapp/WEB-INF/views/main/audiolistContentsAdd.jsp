<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="b" items="${audiolist}">
		<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="pcount">
			<tr>
				<td rowspan="4" style="width:7em;padding-left:1em;padding-right:1em">
					<img src="./resources/default.jpg" alt="" style="width:6em"/>
				</td>
				<td><a href="./board/view.do?audio_idx=${b.audio_idx }">${ b.audiotitle}</a> - <a href="./${b.id }/record">${b.artistname}</a></td>
			</tr>
			<tr>
				<td colspan="2">
					<audio src="" controls style="width:95%" >
						<source src="">
					</audio>
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
                   		<button type="button" class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">좋아요</button> 
              		</c:when>
              <c:otherwise>
                   <button type="button" class="btn btn-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')"  name="minibtn">좋아요</button> 
              </c:otherwise>
            		</c:choose>
					<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
					<button type="button" class="btn btn-secondary btn-sm" onclick="coOp('${b.audio_idx}')">참여</button>
				</td>
				<td style="text-align:center">
					<h6 class="pCount ${b.audio_idx }">재생 : ${b.play_count} </h6> <h6 class="lCount ${b.audio_idx }">좋아요 : ${b.like_count }</h6> 
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
					<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
					
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<h8>내용 : ${b.contents }</h8>
				</td>
			</tr>
		</table>

        </c:forEach>
</body>
</html>