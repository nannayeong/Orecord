<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table.recFollow{
}
</style>
</head>
<body>
			<c:if test="${recFollow.size() ne 0}">
					<h5>친구가 팔로우중인 아티스트</h5>
					</c:if>
				<c:forEach var="r" items="${recFollow}">
				<table height="50"
				style="width: 100%; margin: auto;"
				class="recFollow"">
				<tr>
					<td rowspan="4"
						style="width: 7em; padding-left: 1em; padding-right: 1em">
						<img src="${r.img }" alt="" style="width: 5em" />
					</td>
					<td colspan="2"><h5 style="padding-top: 1em;"><a href="./${r.id }/record">${r.nickname}</a></h5></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td style="padding-top: 0.5em; padding-bottom: 0.5em; text-align: left;">
				<c:set var="followB" value="false"/>
        		<c:forEach var="f" items="${follows }">
        		<c:if test="${r.id eq f.following_id}">
        		<c:set var="followB" value="true"/>
        		</c:if>
        		</c:forEach>
        		     <c:choose>
               <c:when test="${followB}">
               <button type="button" class="btn btn-outline-secondary btn-sm follow ${r.id}" onclick="fBtn('${r.id}')" >팔로우</button>
                 </c:when>
                 <c:otherwise>
                   <button type="button" class="btn btn-secondary btn-sm follow ${r.id}" onclick="fBtn('${r.id}')" >팔로우</button>
                 </c:otherwise>
               </c:choose>	</td>
					<td style="text-align: center; padding-right: 5px;">
						<h6 class="pCount ${r.id }">팔로워 : ${recMemberMap[r.id].follower}</h6>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					</td>
				</tr>
				</table>
				
				<hr />
				</c:forEach>
				<div style="margin-top:1.7em ">
			<h6> (153-759) 서울시 금천구 가산동 426-5 월드메르디앙 2차 413호</h6>
			<br>
			<h6>팀장 남아영 / 010-9346-1822</h6>
			<br>
			<h6>swkosmo@daum.net</h6>
			<br>
			<h6> <a style="color: orange;" href="">[오시는길]</a></h6>
			</div>
</body>
</html> 