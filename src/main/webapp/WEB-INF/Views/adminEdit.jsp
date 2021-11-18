<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	table {
		border: 5px solid red;
	}
	th{
		border: 5px solid blue;
	}
</style>
</head>
<body>
<jsp:include page="../../header.jsp" />
<section>
		<div class="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="side_detail">
					<b>관리자 페이지</b>
					</div>	
					<div class="side_detail">
					책 등록하기
					</div>					
					<div class="side_detail">
					회원 정보
					</div>	
				</div>			
		</div>		
		<div>
		<form method="post" action="bookjoin" id="form_value">
			<p>ISBN<input type="text" name="ISBN" id="ISBN"></p>
			<p>등록번호<input type="text" name="bookID" id="bookID"></p>
			<p>책이름<input type="text" name="bookName" id="bookName"></p>
			<p>저자<input type="text" name="author" id="author"></p>
			<p>출판사<input type="text" name="publisher" id="publisher"></p>
			<p>대출상태<input type="text" name="checkOutState" id="checkOutState"></p>
			<p>예약상태<input type="text" name="reservationState" id="reservationState"></p>
			<p>등록일자<input type="text"  name="registDate" id="registDate"></p>
			<p>등록자<input type="text" name="register" id="register"></p>
			<p>비고<input type="text"  name="detail" id="detail"></p>			
		</div>
		<input type="submit" value="등록">
		<input type="button" value="수정">
		</form>
	</section>
	


	
<jsp:include page="../../footer.jsp" />

</body>
</html>
