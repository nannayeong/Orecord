<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<style>
body {
	background-color: #f2f2f2;
}

a {
	color: #333333;
}

.content {
	background-color: white;
	margin: auto;
	width: 960px;
	margin-top: 3em;
}

.left-content-back {
	background-color: white;
	width: 70%;
	float: left;
	display: inline-block;
}

.left-content {
	background-color: white;
	width: 95%;
	max-width: 800px;
	margin: auto;
	padding-top: 1em;
	content-align: center;
	padding-bottom: 1em;
}

.right-content-back{
	background-color:white;
	max-width:288px;
	height : 100%;
	width:30%;
	display:inline-block;
	position: fixed;
	top: 0px;
	float: left;
}
.right-content{
	background-color:white;
	width:100%;
	height : 960px!;
	margin:auto;
	padding-top:3em;
	padding-bottom:1em;
	text-align: center;
}

.fix {
	position: fixed;
	right: 0;
}

header {
	background-color: #333333;
	height: 3em;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
}

.menu-back {
	width: 960px;
	margin: auto;
}

.logo {
	color: white;
	background-color: orange;
	height: 3em;
	width: 6em;
	float: left;
	vertical-align: middle;
	padding-top: 0.5em;
	text-align: center;
}

.menu {
	color: white;
	background-color: #333333;
	height: 3em;
	width: 6em;
	float: left;
	vertical-align: middle;
	padding-top: 0.5em;
	text-align: center;
}

.menu-r {
	color: white;
	background-color: #333333;
	height: 3em;
	width: 6em;
	float: right;
	vertical-align: middle;
	padding-top: 0.5em;
	text-align: center;
}

.search {
	color: white;
	background-color: #333333;
	height: 3em;
	float: left;
	padding-top: 0.5em;
	padding-left: 7px;
	text-align: center;
}

.noti {
	color: white;
	background-color: #333333;
	height: 3em;
	width: 4em;
	float: right;
	vertical-align: middle;
	padding-top: 0.6em;
	text-align: center;
}

.menu-unlogin {
	color: white;
	background-color: #333333;
	height: 3em;
	float: right;
	vertical-align: middle;
	padding-top: 0.6em;
	text-align: center;
	padding-right: 1em;
}

.sidebar {
	width: 100%;
}

h6 {
	display: inline;
}

li {
	list-style: none;
	color: black;
	background-color: white;
	width: 8em;
	border: 2px #f2f2f2 solid;
}
</style>
<script>
function checknull(form) {
	if (form.searchWord.value == null || form.searchWord.value == "") {
		alert("검색어를 입력하세요");
		return false;
	}
}
$(window).on("scroll", function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();		
	var loadedSize = $('.feed').length;
	$("#scrollHeight").text(scrollHeight);
	$("#scrollPosition").text(scrollPosition);
	$("#bottom").text(scrollHeight - scrollPosition);
	if (scrollPosition > scrollHeight -1) {	
		if('${searchType}'=='title'){
			 $.ajax({
			      url : "./searchAudioLoad.do",
			      type : "get",
		            contentType : "text/html;charset:utf-8",
			      data : { loadlength :loadedSize,searchWord:'${searchWord}',searchType:'audiotitle'}, 
			      dataType : "html",
			      success : function(resData) {
			    	  $('.feed').last().after(resData);
			    	  checktotalLoad('audiotitle');
			      },
			      error : function(e) {
				}
			      
			 }); 
			
		}else if('${searchType}'=='byartist'){
			$.ajax({
			      url : "./searchAudioByArtistLoad.do",
			      type : "get",
		            contentType : "text/html;charset:utf-8",
			      data : { loadlength :loadedSize,searchWord:'${searchWord}',searchType:'artistname'}, 
			      dataType : "html",
			      success : function(resData) {
			    	  $('.feed').last().after(resData);
			    	  checktotalLoad('artistname');
			      },
			      error : function(e) {
				}
			      
			 }); 
		}else if('${searchType}'=='artist'){
			$.ajax({
			      url : "./searchArtistLoad.do",
			      type : "get",
		            contentType : "text/html;charset:utf-8",
			      data : { loadlength :loadedSize,searchWord:'${searchWord}'}, 
			      dataType : "html",
			      success : function(resData) {
			    	  $('.feed').last().after(resData);
			    	  checktotalLoad('nickname');
			      },
			      error : function(e) {
				}
			      
			 }); 
		}else if('${searchType}'=='contents'){
			$.ajax({
			      url : "./searchContentsLoad.do",
			      type : "get",
		            contentType : "text/html;charset:utf-8",
			      data : { loadlength :loadedSize,searchWord:'${searchWord}',searchType:'contents'}, 
			      dataType : "html",
			      success : function(resData) {
			    	  $('.feed').last().after(resData);
			    	  checktotalLoad('contents');
			      },
			      error : function(e) {
				}
			      
			 }); 
		}
	}
	
});
function checktotalLoad(type) {
	var loadedSize = $('.feed').length;
	var end = $('.end').val();
	 $.ajax({
	      url : "./loadsearchCount.do",
	      type : "get",
           contentType : "text/html;charset:utf-8",
	      data : { loadlength :loadedSize,searchWord:'${searchWord}',searchType:type}, 
	      dataType : "json",
	      success : function(resData) {
	    	  
	    	  if(resData.nomoreFeed!=null&&resData.nomoreFeed!=""){
	    	  if(end==undefined){
	    		  $('.feed').last().after("<h3 class='end'>"+resData.nomoreFeed+"</h3>");
	    	  }}
	    	  
	      },
	      error : function(e) {
		}
	      
	 });
}
</script>
<script type="text/javascript">
	function heartbtn(audioIdx) {
		var a = audioIdx;
		var clas = document
				.getElementsByClassName("btn btn-outline-secondary btn-sm heart "
						+ a);
		if ("${pageContext.request.userPrincipal.name}" == ""
				|| "${pageContext.request.userPrincipal.name}" == null) {
			alert("로그인후 이용하세요");
			location.href = "${pageContext.request.contextPath}/member/login.do";
		} else {
			if (clas.length == 0) {
				like(a);
			} else {
				nolike(a);
			}
		}
	}
	function like(audioIdx) {
		var a = audioIdx;
		var count;
		$
				.ajax({
					url : "./like.do",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						audio_idx : a,
						like_id : "${pageContext.request.userPrincipal.name}"
					},
					dataType : "json",
					success : function sucFunc(resData) {
						var section1s = document
								.getElementsByClassName("btn btn-secondary btn-sm heart "
										+ a);
						for (var i = section1s.length - 1; i >= 0; i--) {
							var sec1 = section1s.item(0);
							sec1.className = "btn btn-outline-secondary btn-sm heart "
									+ a;
							count = resData.likecount;
					          $(sec1).html("좋아요&nbsp;&nbsp;&nbsp;"
					                  +count);
						}
					}
				});
	}
	function nolike(audioIdx) {
		var a = audioIdx;
		var count;
		$
				.ajax({
					url : "./nolike.do",
					type : "get",
					contentType : "text/html;charset:utf-8",
					data : {
						audio_idx : a,
						like_id : "${pageContext.request.userPrincipal.name}"
					},
					dataType : "json",
					success : function sucFunc(resData) {
						var section1s = document
								.getElementsByClassName("btn btn-outline-secondary btn-sm heart "
										+ a);
						for (var i = section1s.length - 1; i >= 0; i--) {
							var sec1 = section1s.item(0);
							sec1.className = "btn btn-secondary btn-sm heart "
									+ a;
							count = resData.likecount;
					          $(sec1).html("좋아요&nbsp;&nbsp;&nbsp;"
					                  +count);
						}
					}
				});
	}
</script>
<script type="text/javascript">
	/* 버튼눌렀을때 팔로잉중인경우 언팔로우, 팔로우 안하는중이면 팔로우 함수로 이동 */
	function fBtn(follow) {
		var f = follow;
		var clas = document.getElementsByClassName("btn btn-outline-secondary btn-sm follow " + f);
		if ("${pageContext.request.userPrincipal.name}" == ""
				|| "${pageContext.request.userPrincipal.name}" == null) {
			alert("로그인후 이용하세요");
			location.href = "${pageContext.request.contextPath}/member/login.do";
		} else {
			if (clas.length == 0) {
				followbtn(f);
			} else {
				unfollowbtn(f);
			}
		}
	}
	function followbtn(follow) {
		var f = follow;

		$.ajax({
			url : "./addFollower.do",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : {
				followId : "${pageContext.request.userPrincipal.name}",
				followerId : f
			},
			dataType : "json",
			success : function sucFunc(resData) {
				var section1s = document
						.getElementsByClassName("btn btn-secondary btn-sm follow " + f);
				for (var i = section1s.length - 1; i >= 0; i--) {
					var sec1 = section1s.item(i);
					sec1.className = "btn btn-outline-secondary btn-sm follow " + f;
				}
				count = resData.followcount;
				$('.pCount.' + f).html('팔로워 : ' + count);
			}

		});
	}
	function unfollowbtn(follow) {
		var f = follow;
		$.ajax({
			url : "./unFollow.do",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : {
				followId : "${pageContext.request.userPrincipal.name}",
				followerId : f
			},
			dataType : "json",
			success : function sucFunc(resData) {
				var section1s = document
						.getElementsByClassName("btn btn-outline-secondary btn-sm follow " + f);
				for (var i = section1s.length - 1; i >= 0; i--) {
					var sec1 = section1s.item(i);
					sec1.className = "btn btn-secondary btn-sm follow " + f;
				}
				count = resData.followcount;
				$('.pCount.' + f).html('팔로워 : ' + count);
			}
		});
	}
	function commentNcheck(c) {
		if ("${pageContext.request.userPrincipal.name}" == ""
				|| "${pageContext.request.userPrincipal.name}" == null) {
			alert("로그인후 이용하세요");
			location.href = '${pageContext.request.contextPath}/member/login.do';
			return false
		} else if (c.cInput.value == "" || c.cInput.value == null) {
			alert("내용을 입력하세요")
			c.focus();
			return false;
		}

	}
</script>
<script>
	$(function() {
		if ($('.right-content').height() > $('.left-content').height()) {
			$('.right-content-back').css("border-left", "3px #f2f2f2 solid");
		} else {
			$('.left-content-back').css("border-right", "3px #f2f2f2 solid");
		}
	});

	var count_setting = 0;
	function settingFunc() {
		count_setting = count_setting + 1;
		if (count_setting % 2 == 1) {
			$('.setting-down').css('visibility', '');
			$('.setting-down').css('visibility', 'visibility');
		} else {
			$('.setting-down').css('visibility', '');
			$('.setting-down').css('visibility', 'hidden');
		}
	}
	var count_noti = 0;
	function notiFunc() {
		count_noti = count_noti + 1;
		if (count_noti % 2 == 1) {
			$('.noti-down').css('visibility', '');
			$('.noti-down').css('visibility', 'visibility');
		} else {
			$('.noti-down').css('visibility', '');
			$('.noti-down').css('visibility', 'hidden');
		}
	}

	var count_user = 0;
	function userFunc() {
		count_user = count_user + 1;
		if (count_user % 2 == 1) {
			$('.user-down').css('visibility', '');
			$('.user-down').css('visibility', 'visibility');
		} else {
			$('.user-down').css('visibility', '');
			$('.user-down').css('visibility', 'hidden');
		}
	}
</script>

</head>
<body>
<div>
<div class="content">
<div class="left-content-back">
	<div class="left-content">
	 <c:if test="${searchType eq 'title'}"> 
		<h2>제목으로 검색결과</h2>
		<c:if test="${audioList.size() eq 0}">
		<h4>검색 결과가 없습니다.</h4>
		</c:if>
		<c:forEach var="b" items="${audioList }">
	
				<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="feed">
						<tr>
							<td rowspan="5" style="width:7em;padding-left:1em;padding-right:1em;padding-top:1.5em;vertical-align:top">
								<img src="${b.imagename }" alt="" style="width:6em"/>
							</td>
							<td style="padding-left:1em">
								<div style="font-size:14px;cursor:pointer" onclick="location.href='./${b.id }/record'">
									${b.id }
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
									  </div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<audio controls style="width:97%" id="${b.albumName }">
									<source src="${b.audiofilename }" type="audio/mp4">
								</audio>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								${fn:length(audio.contents)>20 ? substring(audio.contents,0,20) : audio.contents}
							</td>
						</tr>
						<tr>
							<td>
							<c:set var="likeB" value="false"/>
								<c:forEach var="l" items="${likes1 }">
        		<c:if test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
					<c:choose>
               			<c:when test="${likeB}">
                      		<button type="button" class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">
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
						      <form action="../addPlayList.do?${_csrf.parameterName}=${_csrf.token}" method="post">
						      <input type="hidden" name="audio_idx" value="${audio.audio_idx }" />
						      <div class="modal-body" style="text-align:center">
						      	<div><img src="${b.imagename }" alt="" style="width:25px"/> 
									${b.audiotitle } - ${b.artistname }
								</div><br />
						      	<span>저장할 플레이리스트 폴더 선택</span><br />
						      	<select name="plname" id="" style="width:8em;text-align:center">
						      		<c:forEach items="${plList}" var="pl" varStatus="status">
						      		<option value="${pl.plname}">${pl.plname }</option>
						      		</c:forEach>
						      	</select>
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
						<c:if test="${pageContext.request.userPrincipal.name eq b.id and b.party eq 1}">
						<button type="button" class="btn btn-secondary btn-sm" onclick="coOp('${b.audio_idx}')">참여</button>
						</c:if>
							</td>
							<td style="text-align:right;padding-right:1.5em;color:#423e3e;font-size:14px" colspan="2">
								재생 : ${b.play_count} &nbsp&nbsp
								댓글수 : ${b.commentCount }
							</td>
						</tr>
						<tr>
							<td colspan="3">
							<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</form>
							</td>
						</tr>
					</table>
		</c:forEach>
		</c:if>
		 <c:if test="${searchType eq 'byartist'}"> 
		<h3>아티스트명으로 곡 검색결과</h3>
					<c:if test="${audioByNameList.size() eq 0}">
			<h4>검색 결과가 없습니다.</h4>
			</c:if>
		<c:forEach var="b" items="${audioByNameList }">
		<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="feed">
						<tr>
							<td rowspan="5" style="width:7em;padding-left:1em;padding-right:1em;padding-top:1.5em;vertical-align:top">
								<img src="${b.imagename }" alt="" style="width:6em"/>
							</td>
							<td style="padding-left:1em">
								<div style="font-size:14px;cursor:pointer" onclick="location.href='./${b.id }/record'">
									${b.id }
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
									  </div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<audio controls style="width:97%" id="${b.albumName }">
									<source src="${b.audiofilename }" type="audio/mp4">
								</audio>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								${fn:length(audio.contents)>20 ? substring(audio.contents,0,20) : audio.contents}
							</td>
						</tr>
						<tr>
							<td>
							<c:set var="likeB" value="false"/>
								<c:forEach var="l" items="${likes2 }">
							
        		<c:if test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
					<c:choose>
               			<c:when test="${likeB}">
                      		<button type="button" class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">
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
						      <form action="../addPlayList.do?${_csrf.parameterName}=${_csrf.token}" method="post">
						      <input type="hidden" name="audio_idx" value="${audio.audio_idx }" />
						      <div class="modal-body" style="text-align:center">
						      	<div><img src="${b.imagename }" alt="" style="width:25px"/> 
									${b.audiotitle } - ${b.artistname }
								</div><br />
						      	<span>저장할 플레이리스트 폴더 선택</span><br />
						      	<select name="plname" id="" style="width:8em;text-align:center">
						      		<c:forEach items="${plList}" var="pl" varStatus="status">
						      		<option value="${pl.plname}">${pl.plname }</option>
						      		</c:forEach>
						      	</select>
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
						<c:if test="${pageContext.request.userPrincipal.name eq b.id and b.party eq 1}">
						<button type="button" class="btn btn-secondary btn-sm" onclick="coOp('${b.audio_idx}')">참여</button>
						</c:if>
							</td>
							<td style="text-align:right;padding-right:1.5em;color:#423e3e;font-size:14px" colspan="2">
								재생 : ${b.play_count} &nbsp&nbsp
								댓글수 : ${b.commentCount }
							</td>
						</tr>
						<tr>
							<td colspan="3">
							<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</form>
							</td>
						</tr>
					</table>
				</c:forEach>
				</c:if>
		<c:if test="${searchType eq 'artist'}">
		<h3>아티스트 검색결과</h3>
			<c:if test="${ artists.size() eq 0}">
		<h4>검색 결과가 없습니다.</h4>
		</c:if>
		<c:forEach var="a" items="${artists}">
			<table
				style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
				class="feed">
				<tr>
					<td rowspan="4"
						style="width: 7em; padding-left: 1em; padding-right: 1em">
						<img src="./resources/default.jpg" alt="" style="width: 6em" />
					</td>
					<td><h3 style="padding-top: 1em;"><a href="./${a.id }/record">${a.nickname}</a></h3></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td style="padding-top: 1em; padding-bottom: 1em;">
				<c:set var="followB" value="false"/>
        		<c:forEach var="f" items="${follows }">
        		<c:if test="${a.id eq f.following_id}">
        		<c:set var="followB" value="true"/>
        		</c:if>
        		</c:forEach>

        		     <c:choose>
               <c:when test="${followB}">
               <button type="button" class="btn btn-outline-secondary btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로우</button>
                 </c:when>
                 <c:otherwise>
                   <button type="button" class="btn btn-secondary btn-sm follow ${a.id}" onclick="fBtn('${a.id}')" >팔로우</button>
                 </c:otherwise>
               </c:choose>
					<td style="text-align: center">
						<h6 class="pCount ${a.id }">팔로워 : ${memberMap[a]}</h6>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					</td>
				</tr>
			</table>
		</c:forEach>
		</c:if>
		<c:if test="${searchType eq 'contents'}">
		<h3>내용으로 검색결과</h3>
		<c:if test="${popMap3.size() eq 0}">
		<h4>검색 결과가 없습니다.</h4>
		</c:if>
			<c:forEach var="b" items="${popMap3}">
				<table style="width:100%;border:2px #f2f2f2 solid;margin:auto;margin-bottom:1em" class="feed">
						<tr>
							<td rowspan="5" style="width:7em;padding-left:1em;padding-right:1em;padding-top:1.5em;vertical-align:top">
								<img src="${b.imagename }" alt="" style="width:6em"/>
							</td>
							<td style="padding-left:1em">
								<div style="font-size:14px;cursor:pointer" onclick="location.href='./${b.id }/record'">
									${b.id }
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
									  </div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<audio controls style="width:97%" id="${b.albumName }">
									<source src="${b.audiofilename }" type="audio/mp4">
								</audio>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								${fn:length(audio.contents)>20 ? substring(audio.contents,0,20) : audio.contents}
							</td>
						</tr>
						<tr>
							<td>
							<c:set var="likeB" value="false"/>
								<c:forEach var="l" items="${likes3 }">
        		<c:if test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
        		<c:set var="likeB" value="true"/>
        		</c:if>
        		</c:forEach>
					<c:choose>
               			<c:when test="${likeB}">
                      		<button type="button" class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}" title="좋아요" onclick="heartbtn('${b.audio_idx}')" name="minibtn">
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
						      <form action="../addPlayList.do?${_csrf.parameterName}=${_csrf.token}" method="post">
						      <input type="hidden" name="audio_idx" value="${audio.audio_idx }" />
						      <div class="modal-body" style="text-align:center">
						      	<div><img src="${b.imagename }" alt="" style="width:25px"/> 
									${b.audiotitle } - ${b.artistname }
								</div><br />
						      	<span>저장할 플레이리스트 폴더 선택</span><br />
						      	<select name="plname" id="" style="width:8em;text-align:center">
						      		<c:forEach items="${plList}" var="pl" varStatus="status">
						      		<option value="${pl.plname}">${pl.plname }</option>
						      		</c:forEach>
						      	</select>
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
						<c:if test="${pageContext.request.userPrincipal.name eq b.id and b.party eq 1}">
						<button type="button" class="btn btn-secondary btn-sm" onclick="coOp('${b.audio_idx}')">참여</button>
						</c:if>
							</td>
							<td style="text-align:right;padding-right:1.5em;color:#423e3e;font-size:14px" colspan="2">
								재생 : ${b.play_count} &nbsp&nbsp
								댓글수 : ${b.commentCount }
							</td>
						</tr>
						<tr>
							<td colspan="3">
							<form action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}" method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width:80%;"/>&nbsp&nbsp<input type="submit" value="댓글달기" class="btn btn-secondary btn-sm" style="margin-bottom:5px"/>
							</form>
							</td>
						</tr>
					</table>
		</c:forEach>
		</c:if>
	</div>
</div>
	<div class="right-content-back">
		<div class="right-content">
			<div class="sidebar recF">
				<c:forEach var="rf" items="recommendF">
					<div class=""></div>
				</c:forEach>
			</div>
			<div class="sidebar myF"></div>
			<ul>
			<li><a href="./search.do?searchWord=${searchWord }">전체 검색</a></li>
			<li><a href="./searchAudio.do?searchWord=${searchWord }">제목으로 검색</a></li>
			<li><a href="./searchAudioByArtist.do?searchWord=${searchWord }">아티스트명으로 검색</a></li>
			<li><a href="./searchArtist.do?searchWord=${searchWord }">아티스트 검색</a></li>
			<li><a href="./searchContents.do?searchWord=${searchWord }">내용으로 검색</a></li>
			</ul>
					<c:forEach var="r" items="${recFollow}">
				<table
				style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
				class="feed">
				<tr>
					<td rowspan="4"
						style="width: 7em; padding-left: 1em; padding-right: 1em">
						<img src="${r.img }" alt="" style="width: 6em" />
					</td>
					<td><h4 style="padding-top: 1em;"><a href="./${r.id }/record">${r.nickname}</a></h4></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td style="padding-top: 1em; padding-bottom: 1em;">
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
					<td style="text-align: center">
						<h6 class="pCount ${r.id }">팔로워 : ${recMemberMap[r]}</h6>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					</td>
				</tr>
			</table>
		</c:forEach>
		</div>
	</div>
</div>
</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp"%>
	</header>


</body>
</html>