<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 네번째 박스 -->
<table>
<c:forEach items="${audioList}" var="a">
<tr onclick="playAudio('${a.imagename}','${a.audiofilename}','${a.audiotitle }','${a.artistname }')" style="cursor:pointer">
	<td colspan="2"><img src="${pageContext.request.contextPath}/resources/upload/${a.imagename}" alt="" style="width:35px;height:35px;" /></td>
	<td>${a.audiotitle }</td>
	<td> - ${a.id }</td>
</tr>
</c:forEach>
</table>

