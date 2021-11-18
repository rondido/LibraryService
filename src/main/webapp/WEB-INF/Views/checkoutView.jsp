<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<!-- header -->
<jsp:include page="../../header.jsp" />

	<section>
		<div class="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="current_menu">대출현황</div>
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
			<div class="notice_main">
				<div><h2>대출현황</h2></div>
				<div>
					<div class="book_subject">
						<div>No.</div>
						<div>책 제목</div>
						<div>저자</div>
						<div>출판사</div>
						<div>대출일자</div>
						<div>반납일자</div>
						<div>연장</div>
					</div>
					<div class="line"></div>
					<c:if test= "${checkCount ne 0}"> 
							
						<c:forEach var = "list" items="${checkList}">
							<div class="book_subject">
								<div class="book">${list.bookBean.bookID}</div>
								<input type="hidden" value="${list.bookBean.ISBN}">
								<div>${list.bookBean.bookName }</div>
								<div>${list.bookBean.author }</div>
								<div>${list.bookBean.publisher }</div>
								<div>${list.checkOutDate}</div>
								<div>${list.checkInDate}</div>
								<div>
									<input type="button" value="연장하기" onClick="delayCheck('${list.bookBean.reservationState}','${list.checkNum}')">
									<input type="hidden" value="${list.bookBean.reservationState}" class="reserState">
									<input type="hidden" value="${list.checkNum}" class="checkNum">
								</div> 
							</div>
						</c:forEach>	 
									
					</c:if> 
					<c:if test = "${checkCount eq 0 }"> 
						<div class="nolist">목록이 없습니다.</div>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
	<!-- footer -->
<jsp:include page="../../footer.jsp" />

<script>
$(".book").on("click",function(){
	var ISBN = $(this).next().val();
	location.href="bookDetail?ISBN="+ISBN;
})
function delayCheck(reservationState,checkNum) {

	if(reservationState == "X"){
		alert("연장 할 수 없습니다.");
	}else{
		$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/delay",
			data : {
				checkNum : checkNum
			},
			success:function(data){
				if(data != 0){
					alert("연장 성공하였습니다.");
					location.reload();
				}else{
					alert("연장 실패하였습니다.")
				}
			}, error:function(data){
				alert("에러가 발생했습니다.")
				return false;
			}
		});
	}
}

</script>
</body>
</html>