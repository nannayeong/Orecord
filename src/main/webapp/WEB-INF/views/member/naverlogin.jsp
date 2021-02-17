<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<%
    String clientId = "WTRSWBdAspUjsSDbYv2u";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8282", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Jquery, BootStrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- layout css -->
<link href="${pageContext.request.contextPath}/resources/css/layout.css" rel="stylesheet" />
<!-- layout js-->
<script src="${pageContext.request.contextPath}/resources/js/layout.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    var userInputId = getCookie("userInputId");
    var setCookieYN = getCookie("setCookieYN");
    
    if(setCookieYN == 'Y') {
        $("#idSaveCheck").prop("checked", true);
    } else {
        $("#idSaveCheck").prop("checked", false);
    }
    
    $("#loginid").val(userInputId); 
    
    //로그인 버튼 클릭
    $('#loginbtn').click(function() {
        if($("#idSaveCheck").is(":checked")){ 
            var userInputId = $("#loginid").val();
            setCookie("userInputId", userInputId, 60); 
            setCookie("setCookieYN", "Y", 60);
        } else {
            deleteCookie("userInputId");
            deleteCookie("setCookieYN");
        }
        
        document.fform.submit();
    });
});

//쿠키값 Set
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
    exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키값 Delete
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
} 

//쿠키값 가져오기
function getCookie(cookie_name) {
    var x, y;
    var val = document.cookie.split(';');
    
    for (var i = 0; i < val.length; i++) {
        x = val[i].substr(0, val[i].indexOf('='));
        y = val[i].substr(val[i].indexOf('=') + 1);
        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
        
        if (x == cookie_name) {
          return unescape(y); // unescape로 디코딩 후 값 리턴
        }
    }
}
</script>







<script type="text/javascript">
		
		
GET /oauth/authorize?client_id={e1dea648a00c2082d1e6c90ec387bf1e}&redirect_uri={http://localhost:8282, http://localhost:8080, http://localhost:9999}&response_type=code HTTP/1.1
Host: kauth.kakao.com

https://kauth.kakao.com/oauth/authorize?response_type=code&client_id={e1dea648a00c2082d1e6c90ec387bf1e}&redirect_uri={http://localhost:8282, http://localhost:8080, http://localhost:9999}
	

	HTTP/1.1 302 Found
	Content-Length: 0
	Location: {REDIRECT_URI}?code={AUTHORIZE_CODE}
	
	HTTP/1.1 302 Found
	Content-Length: 0
	Location: {REDIRECT_URI}?error=consent_required&error_description=user%20consent%20required.
			
	HTTP/1.1 302 Found
	Content-Length: 0
	Location: {REDIRECT_URI}?error=access_denied&error_description=User%20denied%20access
	
		
	HTTP/1.1 200 OK
	Content-Type: application/json;charset=UTF-8
	{
	    "token_type":"bearer",
	    "access_token":"{jhSRkprxWFOarTPRptJD0GpaiE_MX5EWaNQohAo9dJkAAAF3h0uORg}",
	    "expires_in":43199,
	    "refresh_token":"{REFRESH_TOKEN}",
	    "refresh_token_expires_in":25184000,
	    "scope":"account_email profile"
	}
</script>
<script>
<!-- 네이버아이디로로그인 버튼 노출 영역 -->
  <div id="naver_id_login"></div>
  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("YOUR_CLIENT_ID", "YOUR_CALLBACK_URL");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	naver_id_login.setDomain("YOUR_SERVICE_URL");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  </script>
</head>
<body>
	<div>
		<div class="content">
			<div >
			<c:choose>
			<c:when test="${empty pageContext.request.userPrincipal.name }">
			<c:url value="/member/loginAction.do" var="loginUrl" />
			<form:form name="loginFrm" action="${loginUrl }" method="post">
			<c:if test="${param.error != null }">
				<p>아이디와 패스워드가 잘못되었습니다.</p>
			</c:if>
			<c:if test="${param.login != null }">
				<p>로그아웃 하였습니다.</p>
			</c:if>
				<table>
			<div style="background: linear-gradient(to right, #91888A, #5A5B82);">
				<div class="row">
					<div style="margin: 50px 0 0 60px;">
						<h5 style="margin-left: 3px;">Login</h5>
						<h2>로그인</h2>
					</div>
				</div>
			</div>
			<br />
			<hr color="gray">

			<br /><br /><br /><br />  
					<div class="container" align="center">
						<div class="row" style="margin: 50px 100px 0 80px;">   
					         <div class="col-md-3 pr-md-0">
					            <label>아이디</label>
					         </div>
					         <div class="col-md-13  pl-md-0" style="margin:1px">      
					            <input type="text" name="id" class="form-control login_input" style="width: 27em; height: 40px;">     
					         </div>
				        </div> 
			         
						<br /> 
						<div class="row" style="margin: 50px 100px 0 80px;">  
							<div class="col-md-3 pr-md-0" >
					            <label>비밀번호</label>
					        </div>
					        
					        <div> 
						        <div class="col-md-12 pl-md-0" style="1em">	   
						        	<input class="pswrd form-control" name="pw" type="password" style="width: 27em; height: 40px;">               
						        </div>
							</div> 
						</div>
					</div>
					<div class="container" align="center">  
						<div class="button" style="margin: 50px 100px 0 160px">               
 							<div class="inner"></div> 
							<button  type="submit" class="btn btn-outline-warning" style="width: 14em; height: 40px;">로그인</button>       
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							 
							<br /> 
						</div>
					</div> 
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<br /> 
					</div>
					<!-- 
					
					<div class="links">

						<div class="kakaotalk">
							<a id="kakao-login-btn" href="javascript:loginWithKakao()">
							<a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize
							    ?client_id=5de051009d4dd68062be58fd9608a661
							    &redirect_uri=http://localhost:8282/login
							    &response_type=code">
	 								<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222"/></a>
							<script type='text/javascript'>
							   <![CDATA[
							   // 사용할 앱의 JavaScript 키를 설정해 주세요.
							   Kakao.init('	5de051009d4dd68062be58fd9608a661');
							   
							   // 카카오 로그인 버튼을 생성합니다.
							   Kakao.Auth.createLoginButton({
							    	container: '#kakao-login-btn',
							    	success: function(authObj) {
							    	alert(JSON.stringify(authObj));
							    },
						     	fail: function(err) {
						     	alert(JSON.stringify(err));
						     	}
						    });
							    
							  </script>
						</div>
					</div> -->
					
				<div class="container" align="center">
					<div class="container">
						<div class="signup">
							<a href="./membershipsub.do">회원가입</a>
							&nbsp;
						</div>
					</div>
					&nbsp;
					<div class="idpw">
						
						<a href="./id_pwSearch.do">아이디/비밀번호 찾기</a>
						&nbsp;
					</div>
				</div>
				
			
			
					<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
					
				</table>
			</form:form>
			</c:when>
			<c:otherwise>
				${pageContext.request.userPrincipal.name }님, 로그인 되셨습니다.
			</c:otherwise>
			</c:choose>
			</div>
		</div>
		<!-- 본문종료 -->
	</div>

	<!-- 상단 메뉴바(위치옮기면안됨!) -->
	<header>
		<%@include file="/resources/jsp/header.jsp" %>
	</header>

</body>
</html> 