<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	@import
	url('https://fonts.googleapis.com/css?family=Jua:400');
</style>
<body>
<jsp:include page="../../header.jsp" />
<div class="change_page">

	<h2 style="margin-bottom: 20px;">변경할 비밀번호</h2>
	<form method="POST" action="changepwgo?userID=${idd}">
		<input type="password" name="userPW" placeholder="password" style="margin-top: 20px; " class="change_text">
		<input type="submit" value="변경" class="change_btn">
	</form><br/>
	</div>
	<jsp:include page="../../footer.jsp" />
</body>
</html>