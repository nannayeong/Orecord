<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="profile" style="background: linear-gradient(to right, #91888A, #5A5B82);">
	<table>
		<tr>
			<td rowspan="2">
				<img src="${memberDTO.img }" alt="" style="width:200px;border-radius:50%;margin:1.5em 0 2em 2em"/>
			</td>
			<td> 
				<div style="margin-left:2em;"> 
					<div style="background-color: #15181b; color: white; padding: 5px; border-radius: 20px; margin-bottom:1em"><h3>${memberDTO.nickname }(${memberDTO.id })</h3></div>
					<c:if test="${not empty memberDTO.intro }">
					<span style="background-color: #15181b; color: white; padding: 5px; border-radius: 20px;">${memberDTO.intro }</span>
					</c:if> 
				</div>
				
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
</div>