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
		</div>
		<div>
		<%
		System.out.println();
		%>
		
		<form method="post" action="bookupdate" id="form_value">
			<p>ISBN<input type="text" name="ISBN" id="ISBN" value="${mm.get(0).getISBN()}"></p>
			<p>등록번호<input type="text" name="bookID" id="bookID" value="${mm.get(0).getBookID()}"></p>
			<p>책이름<input type="text" name="bookName" id="bookName" value="${mm.get(0).getBookName()}" ></p>
			<p>저자<input type="text" name="author" id="author"  value="${mm.get(0).getAuthor()}"></p>
			<p>출판사<input type="text" name="publisher" id="publisher"  value="${mm.get(0).getPublisher()}"></p>
			<p>대출상태<input type="text" name="checkOutState" id="checkOutState" value="${mm.get(0).getCheckOutState()}" ></p>
			<p>예약상태<input type="text" name="reservationState" id="reservationState"  value="${mm.get(0).getReservationState()}"></p>
			<p>등록일자<input type="text"  name="registDate" id="registDate" value="${mm.get(0).getRegistDate()}" ></p>
			<p>등록자<input type="text" name="register" id="register"  value="${mm.get(0).getRegister()}"></p>
			<p>비고<input type="text"  name="detail" id="detail"  value="${mm.get(0).getDetail()}"></p>			
		<input type="submit" value="등록">
		<input type="button" value="수정">
		</form>
		</div>
</section>
	
<jsp:include page="../../footer.jsp" />

</body>
</html>
