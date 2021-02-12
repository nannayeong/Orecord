<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</script>
<script type="text/javascript">
$(window).on("scroll", function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();		
	var loadedSize = $('table').length;
	var feedEnd = $(".feedEnd").val();
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
					alert("실패"+e);
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
					alert("실패"+e);
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
					alert("실패"+e);
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
					alert("실패"+e);
				}
			      
			 }); 
		}
	}
	
});
function checktotalLoad(type) {
	var loadedSize = $('table').length;
	var end = $('.end').val();
	 $.ajax({
	      url : "./loadsearchCount.do",
	      type : "get",
           contentType : "text/html;charset:utf-8",
	      data : { loadlength :loadedSize,searchWord:'${searchWord}',searchType:type}, 
	      dataType : "json",
	      success : function(resData) {
	    	  if(resData.nomoreFeed!=null){
	    	  if(end==undefined){
	    		  $('.feed').last().after("<h3 class='end'>"+resData.nomoreFeed+"</h3>");
	    	  }}
	    	  
	      },
	      error : function(e) {
			alert("checktotalLoad 실패"+e);
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
							$('.lCount.' + a).html('좋아요 : ' + count);
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
							$('.lCount.' + a).html('좋아요 : ' + count);
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
		<c:forEach var="a" items="${audioList }">
	
				<table
					style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
					class="feed">
					<tr>
						<td rowspan="4"
							style="width: 7em; padding-left: 1em; padding-right: 1em">
							<img src="./resources/default.jpg" alt="" style="width: 6em" />
						</td>
						<td><a
							href="./board/view.do?audio_idx=${a.audio_idx }">${ a.audiotitle}</a>
							- <a href="./${a.id }/record">${a.artistname}</a></td>
					</tr>
					<tr>
						<td colspan="2"><audio src="" controls style="width: 95%">
								<source src="">
							</audio></td>
					</tr>
					<tr>
						<td><c:set var="likeB" value="false" /> <c:forEach var="l"
								items="${likes1 }">
								<c:if
									test="${a.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
									<c:set var="likeB" value="true" />
								</c:if>
							</c:forEach> <c:choose>
								<c:when test="${likeB}">
									<button type="button"
										class="btn btn-outline-secondary btn-sm heart ${a.audio_idx}"
										title="좋아요" onclick="heartbtn('${a.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:when>
								<c:otherwise>
									<button type="button"
										class="btn btn-secondary btn-sm heart ${a.audio_idx}"
										title="좋아요" onclick="heartbtn('${a.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
							<button type="button" class="btn btn-secondary btn-sm"
								onclick="coOp('${a.audio_idx}')">참여</button></td>
						<td style="text-align: center">
							<h6 class="pCount ${a.audio_idx }">재생 : ${a.play_count}</h6>
							<h6 class="lCount ${a.audio_idx }">좋아요 : ${a.like_count }</h6>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<form
								action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${a.audio_idx}"
								method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width: 80%;" />&nbsp&nbsp<input
									type="submit" value="댓글달기" class="btn btn-secondary btn-sm"
									style="margin-bottom: 5px" />

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
		<c:forEach var="a" items="${audioByNameList }">
				<table
					style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
					class=feed>
					<tr>
						<td rowspan="4"
							style="width: 7em; padding-left: 1em; padding-right: 1em">
							<img src="./resources/default.jpg" alt="" style="width: 6em" />
						</td>
						<td><a href="./board/view.do?audio_idx=${a.audio_idx }">${ a.audiotitle}</a>
							- <a href="./${a.id }/record">${a.artistname}</a></td>
					</tr>
					<tr>
						<td colspan="2"><audio src="" controls style="width: 95%">
								<source src="">
							</audio></td>
					</tr>
					<tr>
						<td><c:set var="likeB" value="false" /> <c:forEach var="l"
								items="${likes2 }">
								<c:if
									test="${a.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
									<c:set var="likeB" value="true" />
								</c:if>
							</c:forEach> <c:choose>
								<c:when test="${likeB}">
									<button type="button"
										class="btn btn-outline-secondary btn-sm heart ${a.audio_idx}"
										title="좋아요" onclick="heartbtn('${a.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:when>
								<c:otherwise>
									<button type="button"
										class="btn btn-secondary btn-sm heart ${a.audio_idx}"
										title="좋아요" onclick="heartbtn('${a.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
							<button type="button" class="btn btn-secondary btn-sm"
								onclick="coOp('${a.audio_idx}')">참여</button></td>
						<td style="text-align: center">
							<h6 class="pCount ${a.audio_idx }">재생 : ${a.play_count}</h6>
							<h6 class="lCount ${a.audio_idx }">좋아요 : ${a.like_count }</h6>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<form
								action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${a.audio_idx}"
								method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width: 80%;" />&nbsp&nbsp<input
									type="submit" value="댓글달기" class="btn btn-secondary btn-sm"
									style="margin-bottom: 5px" />

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
				<table
					style="width: 100%; border: 2px #f2f2f2 solid; margin: auto; margin-bottom: 1em"
					class="feed">
					<tr>
						<td rowspan="4"
							style="width: 7em; padding-left: 1em; padding-right: 1em">
							<img src="./resources/default.jpg" alt="" style="width: 6em" />
						</td>
						<td><a href="./board/view.do?audio_idx=${b.audio_idx }">${ b.audiotitle}</a>
							- <a href="./${b.id }/record">${b.artistname}</a></td>
					</tr>
					<tr>
						<td colspan="2"><audio src="" controls style="width: 95%">
								<source src="">
							</audio></td>
					</tr>
					<tr>
						<td><c:set var="likeB" value="false" /> <c:forEach var="l"
								items="${likes3 }">
								<c:if
									test="${b.audio_idx eq l.audio_idx and pageContext.request.userPrincipal.name eq l.like_id}">
									<c:set var="likeB" value="true" />
								</c:if>
							</c:forEach> 
							<c:choose>
								<c:when test="${likeB}">
									<button type="button"
										class="btn btn-outline-secondary btn-sm heart ${b.audio_idx}"
										title="좋아요" onclick="heartbtn('${b.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:when>
								<c:otherwise>
									<button type="button"
										class="btn btn-secondary btn-sm heart ${b.audio_idx}"
										title="좋아요" onclick="heartbtn('${b.audio_idx}')"
										name="minibtn">좋아요</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-secondary btn-sm">플레이리스트</button>
							<button type="button" class="btn btn-secondary btn-sm"
								onclick="coOp('${b.audio_idx}')">참여</button></td>
						<td style="text-align: center">
							<h6 class="pCount ${b.audio_idx }">재생 : ${b.play_count}</h6>
							<h6 class="lCount ${b.audio_idx }">좋아요 : ${b.like_count }</h6>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<form
								action="${pageContext.request.contextPath}/board/commentAction.do?audio_idx=${b.audio_idx}"
								method="post" onsubmit="return commentNcheck(this)">
								<input type="text" name="contents" style="width: 80%;" />&nbsp&nbsp<input
									type="submit" value="댓글달기" class="btn btn-secondary btn-sm"
									style="margin-bottom: 5px" />

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