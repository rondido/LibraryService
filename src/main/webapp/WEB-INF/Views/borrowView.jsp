<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- get:데이터를 가져오는 용도, post:데이터를 등록하는 용도 -->
<title>borrow</title>
	<script>
		function checkoutRegister(){
			let userID = $("#userID").val();
			let bookID = $("#bookID").val();
			let sendData = {"userID":userID, "bookID":bookID};
			$.ajax({
		        method : 'POST',
		        url : 'checkOutRegister',
		        data : sendData,
		        success : function(resp){
		            if(resp=='fail'){
		                alert('대출할 수 없는 책입니다.책 번호를 확인해주세요');
		                $("#userID").val('');
		    			$("#bookID").val('');
		            }else{
					    tableCreate();
		                alert('등록되었습니다.');
		                location.reload();
		            }}
		    })
		}
		
		/* function tableCreate(){
			let html = '';
			
			$('#dynamicTable').empty();
			html += '<tr> <td>사용자 아이디</td> <td>ISBN</td> <td>책 아이디</td> <td>대출일</td> <td>반납일</td> <td>반납 상태</td> <td>예약 상태</td> </tr>'
			html += '<c:forEach items="${checkresult}" var="checkresult">'
			html += '<tr> <td>${checkresult.userID}</td> <td>${checkresult.ISBN}</td> <td>${checkresult.bookID}</td> <td>${checkresult.checkOutDate}</td> <td>${checkresult.checkInDate}</td> <td>${checkresult.checkState}</td> <td>${checkresult.reservationState}</td> </tr><br/> </c:forEach>' 
			
			$('#dynamicTable').append(html);
			
			$("#userID").val('');
			$("#bookID").val('');
		}
		
		window.onload = function() {
			tableCreate();
		} */
	</script>
</head>
<body>
	<jsp:include page="../../header.jsp" />


	
	<!-- <table border= 1px soild id="dynamicTable">
		<tr>
			<td>사용자 아이디</td>
			<td>ISBN</td>
			<td>책 아이디</td>
			<td>대출일</td>
			<td>반납일</td>
			<td>반납 상태</td>
			<td>예약 상태</td>
		</tr>
		 <tbody id="dynamicTbody">
	
		 </tbody>
	</table> -->
	<fieldset class="field">
		<legend>대출</legend>
	사용자 아이디<input type="text" id="userID"> <br>
	책 번호<input type="text" id="bookID"> 
	<button onclick="checkoutRegister()" class="btn">대출 승인</button>
	
	</fieldset>
	<br/>
	
	<fieldset class="field"> <legend>반납</legend>
		<form action="banap" method="post">
			책 번호<input type="text" name="bookID2">
		<input type="submit" value="반납" class="btn">
		</form>
	</fieldset>
	<!-- footer -->
	<jsp:include page="../../footer.jsp" />
</body>
</html>