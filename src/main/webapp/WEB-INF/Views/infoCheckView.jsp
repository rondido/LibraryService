<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">

</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<script>
		function pwdCheck() {
			var form = $("#infoForm").serialize();
			var userPW = $("#userPW").val().trim();

			if (userPW == "") {
				alert("비밀번호를 입력해주세요.");
			} else {
				$.ajax('userCheck', {
					type : "post",
					data : form,
					success : function(data) {
						if (data == "success") {
							alert("회원 탈퇴 성공했습니다.");
							location.href = "logout";
						} else if (data == "fail") {
							alert("비밀번호가 틀렸습니다.");
						}
					},
					error : function(data) {
						alert("에러가 발생했습니다." + data);
					}

				});
			}
		}
	</script>
	<jsp:include page="../../header.jsp" />
	<section>
		<div class="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="current_menu">탈퇴하기</div>
					<div class="line"></div>

					<a href="mypage?userID=${sessionScope.SessionID}"><div class="side_detail">마이페이지</div></a>
					<hr>
					<a href="checkout?userID=${sessionScope.SessionID}"><div class="side_detail">대출현황</div></a>
					<hr>
					<a href="reservation?userID=${sessionScope.SessionID}"><div class="side_detail">예약현황</div></a>
					<hr>
					<a href="like?userID=${sessionScope.SessionID}"><div class="side_detail">찜 목록</div></a>
					<hr>
					<a href="infoCheck"><div class="side_detail">탈퇴하기</div></a>
					
				</div>
			</div>
			<div class="notice_main pwdCheck">
				<div>비밀번호 확인</div>
				<div>
					<form method="post" id="infoForm">
						<div>
							<input type="text" name="userID" value="${sessionScope.SessionID}" disabled>
						</div>
						<div>
							<input type="password" name="userPW" class="pwdCheck" id="userPW"
								placeholder="PASSWORD">
						</div>
						<div>
							<input type="button" value="확인" onclick="pwdCheck()" class="pwdBtn">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- footer -->
	<jsp:include page="../../footer.jsp" />
</body>
</html>