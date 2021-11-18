<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
</head>
<body>

<!-- header -->
<jsp:include page="../../header.jsp" />
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div class="form_login">
	<form method="POST" action="loginPro">
		<h2>로그인</h2>
		<!-- 라디오 버튼 -->
		<input type="radio" id="ra"  name="chk_info" value="admin" onchange="setDisplay()">관리자
		<input type="radio" id="ru" name="chk_info" value="user" onchange="setDisplay()" checked style="margin-left:20px;">사용자<br/><br/>
			
			<!-- 관리자버전/사용자 버전 아이디 및 비밀번호 입력칸 -->
			<div id="idd">
				 <input type="text" class="login_text" name="userID" placeholder="ID"><br/>
				<input type="password" class="login_text" name="userPW" placeholder="PASSWORD" style="margin-top: 20px;"><br/><br/>
			</div>
			<div id="numm">
				<input type="text" class="login_text" name="adminID" placeholder="ADMIN_ID"><br/>
				<input type="password" class="login_text" name="adminPW" placeholder="PASSWORD" style="margin-top: 20px;" ><br/><br/>
			</div>

		<input type="submit" value="로그인" class="login_btn">
	</form><br/>
	
	<a href="findid" class="login_a">아이디 찾기</a>
	<a href="findpw" class="login_a">비밀번호 찾기</a>
	<a href="join" class="login_a">회원가입</a>
</div>
	
<!-- footer -->
<jsp:include page="../../footer.jsp" />

<!-- 라디어 버튼 체크에 따른 텍스트 출력 유무 -->
<script>
	$('#numm').hide();
	function setDisplay(){
		if($('input:radio[id=ra]').is(':checked')){
			$('#idd').hide();
			$('#numm').show();
		}else{
			$('#idd').show();
			$('#numm').hide();
		}
	}
</script>

<!-- 로그인 실패 시, 알려주는 문구 -->
<script>
	if(${loginSuccess} == false){
	  alert( '로그인 실패' );
	}
</script>


</body>
</html>