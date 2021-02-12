<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<table style="margin:auto;width:240px">
	<tr>
		<td style="border-right:2px solid #f2f2f2;width:40px;">
			<div style="font-size:0.8em">Followers</div>
			<div id="followers">0</div>
		</td>
		<td style="border-right:2px solid #f2f2f2;width:40px;padding-left:15px">
			<div style="font-size:0.8em">Following</div>
			<div id="following" onclick="location.href='./myFollowers'" style="cursor:pointer">0</div>
		</td>
		<td style="width:40px;padding-left:15px">
			<div style="font-size:0.8em;" >Tracks</div>
			<div id="track" onclick="location.href='./myFollowing'" style="cursor:pointer">0</div>
		</td>
	</tr>
</table>