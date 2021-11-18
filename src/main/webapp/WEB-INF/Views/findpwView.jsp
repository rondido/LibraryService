<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- header -->
<jsp:include page="../../header.jsp" />

<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<div class="pwdcheck_form">
		<form method="POST" action="findpwcheck" onsubmit="return check();">
			<h2>비밀번호 찾기</h2>

			<!-- 비밀번호 찾기 -->
			<input type="text" name="userID" placeholder="id" class="pwdcheck_text"><br/>
			<input type="text" name="userName" placeholder="name" style="margin-top: 20px;" class="pwdcheck_text"><br/>
			<input type="text" id="phone" name="phone" placeholder="phone" style="margin-top: 20px;  margin-left: 155px;" class="pwdcheck_text">
			<input type="button" onClick="cer()" value="인증" class="change_btn"><br/>
			<input type="text" id="code" name="code" placeholder="인증번호" class="pwdcheck_text" style="margin-left: 155px;" >
			<input type="button" onClick="cerCheck()" value="인증번호확인" class="change_btn"><br/><br/>
			<span id = "certi"></span><br/>

			<input type="submit" value="확인" class="pw_check_btn">
		</form><br/>
	</div>
<!-- footer -->
<jsp:include page="../../footer.jsp" />

<script>
	var localresp;
	var localcc;
	function cer(){
		let phone = $("#phone").val();
		let sendData = {"phone":phone};
		$.ajax({
			method : 'POST',
			url : 'send',
			data : sendData,
			success : function(resp){
				localresp=resp
				alert('인증번호를 문자로 보냈습니다.');
			}
		});
	}

	function check(){
		if(localresp==local){
			return true;
		}return false;
	}

	function cerCheck(){
		var cc = $('#code').val();
		local=cc;
		if(cc == localresp){
			$('#certi').css('color','blue');
			$('#certi').html("인증되었습니다.");
		}else{
			$('#certi').css('color','red');
			$('#certi').html("인증되지 않았습니다.");
		}
	}

</script>

</body>
</html>