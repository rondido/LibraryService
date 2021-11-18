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

<!-- header -->
<jsp:include page="../../header.jsp" />

	<section>
		<div class ="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="current_menu">공지사항</div>
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
				<div><h2>공지사항</h2></div>
				<div>
					<div class="subject">
						<div>No.</div>
						<div>제목</div>
						<div>작성자</div>
						<div>날짜</div>
					</div>
					<c:if test= "${count != 0} }">
						<c:forEach var = "list" items="${requestScope.list} ">

						</c:forEach>					
					</c:if>
					<c:if test = "${count eq null }"> <!-- 공지사항 리스트 만들면 0으로 바꾸기 -->
						<div class="nolist">목록이 없습니다.</div>
					</c:if>
			
			
			
			
				</div>
			</div>


		
		</div>
	</section>
	
<!-- footer -->
<jsp:include page="../../footer.jsp" />

</body>
</html>