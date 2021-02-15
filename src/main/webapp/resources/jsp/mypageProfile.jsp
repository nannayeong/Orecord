<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="profile" style="background: linear-gradient(to right, #91888A, #5A5B82);">
	<table style="">
		<tr>
			<td rowspan="2" style="padding-top:2em;padding-left:2em">
				<img src="${memberDTO.img }" alt="" style="width:200px;border-radius:50%"/>
			</td>
			<td> 
				<div style="margin-left:1em"> 
					<div><h3>${memberDTO.nickname }(${memberDTO.id })</h3></div>
					<c:if test="${not empty memberDTO.intro }">
					<div>${memberDTO.intro }</div>
					</c:if>
				</div>
				
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
</div>