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
		<c:forEach var="a" items="${ artists}">
			<table
				style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
				class="feed">
				<tr>
					<td
						style="width: 7em; padding-left: 1em; padding-right: 1em">
						<img src="${a.img}" alt="" style="width: 5em" />
					</td>
					<td><h3 style="padding-top: 1em; padding-bottom: 1em;"><a href="./${a.id }/record">${a.nickname}</a></h3></td>
					<td style="padding-top: 1em; padding-bottom: 1em; width: 160px;">
				<c:set var="followB" value="false"/>
        		<c:forEach var="f" items="${followMap }">
        		<c:forEach var="follower" items="${f.value }">
        		<c:if test="${pageContext.request.userPrincipal.name eq follower and a.id eq f.key}">
        		<c:set var="followB" value="true"/>
        		</c:if>
        		</c:forEach>
        		</c:forEach>
        		
        		<h6 class="pCount ${a.id }">팔로워 : ${a.follower}&nbsp;&nbsp;</h6>
        		<c:if test="${pageContext.request.userPrincipal.name ne a.id}">
        		
        		<c:choose>    
               <c:when test="${followB}">
               <button type="button" class="btn btn-warning btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로우</button>
                 </c:when>
                 <c:otherwise>
                   <button type="button" class="btn btn-secondary btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로우</button>
                 </c:otherwise>
               </c:choose>
               </c:if>
					</td>
				</tr>
			</table>
		</c:forEach>
</body>
</html>