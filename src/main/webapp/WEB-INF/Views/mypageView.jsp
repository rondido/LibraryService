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
					<div class="current_menu">����������</div>
					<div class="line"></div>
					
					<a href="mypage?userID=${sessionScope.SessionID}"><div class="side_detail">����������</div></a>
					<hr>
					<a href="checkout?userID=${sessionScope.SessionID}"><div class="side_detail">������Ȳ</div></a>
					<hr>
					<a href="reservation?userID=${sessionScope.SessionID}"><div class="side_detail">������Ȳ</div></a>
					<hr>
					<a href="like?userID=${sessionScope.SessionID}"><div class="side_detail">�� ���</div></a>
					<hr>
					<a href="infoCheck"><div class="side_detail">Ż���ϱ�</div></a>
					
				</div>
			</div>
			<div class="main_wrap">
				<!-- ���������� -->
				<div class="border">
						 <div style=" margin-bottom: 20px;">�̸� : ${userOne.getUserName()}</div>
						 <div>��ȭ��ȣ : ${userOne.getPhone()}</div>
				</div>
				<!-- ������Ȳ -->
				<div class="border" onclick=location.href='checkout?userID=${sessionScope.SessionID}'>
						<div class="test"> ������ å : ${checkCount}</div> 
				</div>
				<!-- ������Ȳ -->
				<div class="border" onclick=location.href='reservation?userID=${sessionScope.SessionID}'>
						<div> ������ å : ${reservationCount}</div> 
				</div>
				
				<!-- �� ��� -->
				<div class="border" onclick=location.href='like?userID==${sessionScope.SessionID}'>
						<div> ���� å : ${likeCount}</div> 
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