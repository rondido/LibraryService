<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/searchView.css">

</head>
<body>
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>


<!-- header -->
<jsp:include page="../../header.jsp" />
<section>
	<div class="bookView">
		<div class="bookImg"><img src="${detailBook[0].img}"></div>
		<div class="bookSub">
				<c:if test = "${sessionScope.flag eq 'U'}">
					<div class="like_image">
					     <img class="like" src="images/heart_empty.png" style="height: 40px; width:40px;">
					    <input type="hidden" value="${detailBook[0].ISBN}" class="ISBN">
					</div>
				</c:if>
			<div class="navbar-nav caca">
				<div>책 제목 : ${detailBook[0].bookName }</div><br>
				<div> 책 저자 : ${detailBook[0].author}</div> <br>
				<div> 책 출판사 : ${detailBook[0].publisher}</div> <br>
				<div> 상세 내용 : ${detailBook[0].detail}</div><br>
			</div>
		</div>
	</div>
	<div class="line"></div>
	<div class="allBookList">
		<div>전체 책 목록 (대출 가능한 책 : ${count} 권)</div>
		<div class="bookListSub">
			<div>책번호</div>
			<div>ISBN</div>
			<div>상태</div>
			<div>반납 일자</div>
			<div>예약</div>
		</div>
		<c:forEach var="list" items="${detailBook}">
		<div class="bookList bookListSub">
			<div>${list.bookID}</div>
			<div>${list.ISBN}</div>
					
			<c:choose>
				<c:when test="${list.checkOutState eq 'X'}">
					<div>대출 가능</div>
					<div>-</div>
					<div><input type="button" value="예약불가능" disabled></div>
				</c:when>
				<c:when test="${list.checkOutState eq 'O'}">
					<div>대출중</div>
					<div>${list.checkOutBean.checkInDate}</div>
					
						<c:choose>
							<c:when test="${count eq 0}">
								<c:if test="${list.reservationState eq 'X'}">
									<div>
										<input type="button" value="예약하기" onClick="reserA('${list.bookID}','${list.ISBN}','${list.checkOutBean.checkInDate}','${sessionScope.SessionID}')">
									</div>
								</c:if>
								<c:if test="${list.reservationState eq 'O'}">
									<div><input type="button" value="예약불가능" disabled></div>
								</c:if>
							</c:when>
							
							<c:when test="${count ne 0}">
									<div><input type="button" value="예약불가능" disabled></div>
							</c:when>
						</c:choose>
				</c:when>
				<c:when test="${list.checkOutState eq 'D' }">
					<div>연체중</div>
					<div id="checkInDate">${list.checkOutBean.checkInDate}</div>
					<input type="hidden" value="${list.checkOutBean.checkInDate}" class="checkInDateC">
					<div><input type="button" value="예약불가능" disabled></div>
				</c:when>
			</c:choose>
			</div>
		</c:forEach>
		
	</div>
</section>

<script>
	var check = $(".checkInDateC").val();
	var inDate = new Date(check);
	var date = new Date();
	console.log(inDate);
	console.log(date);
	
	console.log(inDate < date)
	if(inDate < date){
		$("#checkInDate").css("color","red");
}
</script>
<script type="text/javascript">
function reserA(bookID,ISBN,checkInDate,userID){
	
	console.log(bookID);
	if(userID == null || userID==""){
		alert("로그인 후 이용해주세요");
	}else{
		$.ajax({
			type : "post",
			url:"${pageContext.request.contextPath}/reserAdd",
			data : {
				bookID : bookID,
				ISBN : ISBN,
				checkInDate : checkInDate,
				userID : userID
			},
			success:function(data){
				if(data != 0){
					alert("예약 완료 되었습니다.");
					location.reload();
				}else{
					alert("예약 실패하셨습니다.");
					
				}
			}, error:function(data){
				alert("에러가 발생했습니다."+data)
				return false;
			}
			
		});
	}
}
</script>
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


for(var i = 0; i<"${fn:length(detailBook)}"; i++){
     
	var cla = $(".like_image").eq(i);
	var ISBN = cla.children(".ISBN").val();
	console.log(ISBN);
		
	like();
}
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
				cla.children(".like").attr("src","images/heart_full.png");
				console.log(cla.children(".like").attr("src"))
			}
		},
		error: function(data,status){
			alert("에러가 발생했습니다."+data);
		}
	});
}

</script>
<!-- footer -->
<jsp:include page="../../footer.jsp" />
</body>
</html>