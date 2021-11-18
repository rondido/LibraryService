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
					<div class="current_menu">찜 목록</div>
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
				<div><h2>찜 목록</h2></div>
				<div>
					<div class="book_subject">
						<div>No.</div>
						<div>책 제목</div>
						<div>저자</div>
						<div>출판사</div>
						<div>찜</div>
					</div>
					<div class="line"></div>
					
					<c:if test= "${likeCount ne 0}"> 
						<c:forEach var = "list" items="${likeBook}">
							<div class="book_subject">
								<div class="book">${list.bookBean.bookID}</div>
								<input type="hidden" value="${list.bookBean.ISBN }">
								<div>${list.bookBean.bookName}</div>
								<div>${list.bookBean.author}</div>
								<div>${list.bookBean.publisher}</div>
								<div class="like_image"> 
			                 	 	<img class="like" src="images/heart_full.png" style="height: 40px; width:40px;">
			                   		<input type="hidden" value="${list.bookBean.ISBN}" class="ISBN">
			                 	</div>
							</div>
						</c:forEach>	 
									
					</c:if> 
					<c:if test = "${likeCount eq 0 }"> 
						<div class="nolist">목록이 없습니다.</div>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
	<!-- footer -->
<jsp:include page="../../footer.jsp" />
<script>
$(".like").on("click",function(){
	var image = $(this).attr("src");
	var ISBN = $(this).next().val();
	var likeOn = "images/heart_full.png";
	var likeOff ="images/heart_empty.png";
	if('${sessionScope.SessionID}' != null){
		if(image == likeOff){
			$(this).attr("src",likeOn)
		 	$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/likeOn",
				data : {ISBN : ISBN},
				dataType :"text",
				async:true,
				success:function(data,status){
					if(data == "success"){
						alert("찜등록 완료 !");
					}else{
						alert("찜등록 실패"+data);
					}
				},error: function(data,status){
					alert("에러 발생했습니다."+data);
				}
				
			}); 
		}else if(image == likeOn){
			$(this).attr("src",likeOff)
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/likeOff",
				data : {ISBN : ISBN},
				dataType : "text",
				async : true,
				success : function(data,status){
					if(data == "success"){
						alert("찜등록 취소");
						location.href="like?userID=${sessionScope.SessionID}";
					}else{
						alert("실패"+data);
					}
				},
				error : function(data,status){
					alert("에러가 발생했습니다."+data);
				}
			});
			
			} 
	}else{
		alert("로그인 후 눌러주세요.");
	}
	
});
function like(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/isLike",
		data : {ISBN : ISBN},
		async : false,
		dataType : "text",
		success : function(data,status){
		console.log("data" + data);
			if(data == "success"){
				cla.children(".like").attr("src","${pageContext.request.contextPath}/images/heart_full.png");
				console.log(cla.children(".like").attr("src"))
			}
		},
		error: function(data,status){
			alert("에러가 발생했습니다.");
		}
	});
	}
</script>
<script>
$(".book").on("click",function(){
	var ISBN = $(this).children().first().val();
	location.href="bookDetail?ISBN="+ISBN;
	
})
</script>
</body>
</html>