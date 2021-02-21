<%@page import="java.security.Principal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="m" items="${notis}">
<c:if test="${m.read eq 0}">
<a style="font-size: 14px" class="dropdown-item" id="noti" onclick="read('${m.n_idx}','${m.audio_idx}')" href="#">
${m.s_id}의 채택메세지 : ${m.msg}</a>
</c:if>
</c:forEach>
