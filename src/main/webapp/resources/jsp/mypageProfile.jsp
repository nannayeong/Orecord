<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="profile" style="background: linear-gradient(to right, #91888A, #5A5B82);">
	<table style="">
		<tr>
			<td rowspan="2" style="padding-top:2em;padding-left:2em">
				<img src="${memberDTO.img }" alt="" style="width:200px;border-radius:50%"/>
			</td>
			<td> 
				${memberDTO.id }
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
</div>