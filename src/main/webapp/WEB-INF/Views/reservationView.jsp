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
					<div class="current_menu">예약현황</div>
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
				<div><h2>예약현황</h2></div>
				<div>
					<div class="book_subject">
						<div>No.</div>
						<div>책 제목</div>
						<div>저자</div>
						<div>출판사</div>
						<div>예약 신청일</div>
						<div>픽업 일자</div>
						<div>픽업 가능 여부</div>
						<div>취소</div>
					</div>
					<div class="line"></div>
					<c:if test= "${reservationCount ne 0}">
						<c:forEach var = "list" items="${reserList}">
							<div class="book_subject book">
								<input type="hidden" value="${list.bookBean.ISBN }">
								<div>${list.bookBean.bookID}</div>
								<div>${list.bookBean.bookName}</div>
								<div>${list.bookBean.author}</div>
								<div>${list.bookBean.publisher}</div>
								<div>${list.reservationApply}</div>
								<div>${list.pickDate}</div>
								<div>${list.pickCheck}</div>
								<div><a href="deleteReser?reserNum=${list.reserNum}&&bookID=${list.bookBean.bookID}">취소${list.reserNum}</a></div>
							</div>
						</c:forEach>					
					</c:if>
					<c:if test = "${reservationCount eq 0}"> <!-- 공지사항 리스트 만들면 0으로 바꾸기 -->
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
	var ISBN = $(this).children().first().val();
	location.href="bookDetail?ISBN="+ISBN;
	
})
</script>
</body>
</html>