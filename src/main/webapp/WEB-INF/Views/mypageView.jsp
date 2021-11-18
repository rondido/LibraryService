<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">

</head>
<body>

<!-- header -->
<jsp:include page="../../header.jsp" />

<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
	<section>
		<div class="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="current_menu">마이페이지</div>
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
			<div class="main_wrap">
				<!-- 마이페이지 -->
				<div class="border">
						 <div style=" margin-bottom: 20px;">이름 : ${userOne.getUserName()}</div>
						 <div>전화번호 : ${userOne.getPhone()}</div>
				</div>
				<!-- 대출현황 -->
				<div class="border" onclick=location.href='checkout?userID=${sessionScope.SessionID}'>
						<div class="test"> 대출한 책 : ${checkCount}</div> 
				</div>
				<!-- 예약현황 -->
				<div class="border" onclick=location.href='reservation?userID=${sessionScope.SessionID}'>
						<div> 예약한 책 : ${reservationCount}</div> 
				</div>
				
				<!-- 찜 목록 -->
				<div class="border" onclick=location.href='like?userID==${sessionScope.SessionID}'>
						<div> 찜한 책 : ${likeCount}</div> 
				</div>
			</div>
		</div>
	</section>
	
	<!-- footer -->
<jsp:include page="../../footer.jsp" />
	
<script>
	$(".checkout").on("click",function(){
		location.href="checkout?userID=${sessionScope.SessionID}";
	})
	$(".reservation").on("click",function(){
		location.href="reservation?userID=${sessionScope.SessionID}";
	})
	$(".like").on("click",function(){
		location.href="like?userID=${sessionScope.SessionID}";
	})
</script>


</body>
</html>