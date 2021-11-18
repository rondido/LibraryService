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
		<div class ="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="current_menu">FAQ</div>
					<div class="line"></div>
					<a href="notice"><div class="side_detail">공지사항</div></a>
					<hr>
					<a href="help"><div class="side_detail">문의하기</div></a>
					<hr>
					<a href="faq"><div class="side_detail">FAQ</div></a>
				</div>
				<hr>
			</div>
			<div class="notice_main">
				<div><h2>자주묻는질문</h2></div>
				<div class="qna_wrap">
					<div class="qna_menu1">예약 취소는 어떻게 하나요?</div>
	        			<div class="qna_menu1-1">
	        			<br>
	        			1. MyPage > 예약 현황 > 취소 버튼 누르면 취소  처리가 됩니다.
	        		
	        			</div>
	        			<hr>
	        		<div class="qna_menu2">비밀번호를 까먹었어요 !</div>
	        			<div class="qna_menu1-2">
	        			<br>
	        			1. Login 페이지에서 아이디/비밀번호 찾기를 이용해주세요
	        		
	        			</div>
	        			<hr>
				</div>
			</div>		
		
		</div>
	</section>
	
	
<!-- footer -->
<jsp:include page="../../footer.jsp" />

<script>
$(".qna_menu1").on("click", function () {
	
	if($('.qna_menu1-1').css("display") == 'none'){
		$('.qna_menu1-1').css("display",'block');
		$('.qna_menu1-1').animate({height : "300px"},500);
	} else{
		$('.qna_menu1-1').animate({height : "0px"},500, function () {
			$('.qna_menu1-1').css("display",'none');
		})
	}
})
$(".qna_menu2").on("click", function () {
		
		if($('.qna_menu1-2').css("display") == 'none'){
			$('.qna_menu1-2').css("display",'block');
			$('.qna_menu1-2').animate({height : "300px"},500);
		} else{
			$('.qna_menu1-2').animate({height : "0px"},500, function () {
				$('.qna_menu1-2').css("display",'none');
			})
		}
	})


</script>

</body>
</html>