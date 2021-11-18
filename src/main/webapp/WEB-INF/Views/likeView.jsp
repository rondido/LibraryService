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
					<div class="current_menu">�� ���</div>
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
			<div class="notice_main">
				<div><h2>�� ���</h2></div>
				<div>
					<div class="book_subject">
						<div>No.</div>
						<div>å ����</div>
						<div>����</div>
						<div>���ǻ�</div>
						<div>��</div>
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
						<div class="nolist">����� �����ϴ�.</div>
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
						alert("���� �Ϸ� !");
					}else{
						alert("���� ����"+data);
					}
				},error: function(data,status){
					alert("���� �߻��߽��ϴ�."+data);
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
						alert("���� ���");
						location.href="like?userID=${sessionScope.SessionID}";
					}else{
						alert("����"+data);
					}
				},
				error : function(data,status){
					alert("������ �߻��߽��ϴ�."+data);
				}
			});
			
			} 
	}else{
		alert("�α��� �� �����ּ���.");
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
			alert("������ �߻��߽��ϴ�.");
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