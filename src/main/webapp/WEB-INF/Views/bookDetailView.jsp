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
				<div>å ���� : ${detailBook[0].bookName }</div><br>
				<div> å ���� : ${detailBook[0].author}</div> <br>
				<div> å ���ǻ� : ${detailBook[0].publisher}</div> <br>
				<div> �� ���� : ${detailBook[0].detail}</div><br>
			</div>
		</div>
	</div>
	<div class="line"></div>
	<div class="allBookList">
		<div>��ü å ��� (���� ������ å : ${count} ��)</div>
		<div class="bookListSub">
			<div>å��ȣ</div>
			<div>ISBN</div>
			<div>����</div>
			<div>�ݳ� ����</div>
			<div>����</div>
		</div>
		<c:forEach var="list" items="${detailBook}">
		<div class="bookList bookListSub">
			<div>${list.bookID}</div>
			<div>${list.ISBN}</div>
					
			<c:choose>
				<c:when test="${list.checkOutState eq 'X'}">
					<div>���� ����</div>
					<div>-</div>
					<div><input type="button" value="����Ұ���" disabled></div>
				</c:when>
				<c:when test="${list.checkOutState eq 'O'}">
					<div>������</div>
					<div>${list.checkOutBean.checkInDate}</div>
					
						<c:choose>
							<c:when test="${count eq 0}">
								<c:if test="${list.reservationState eq 'X'}">
									<div>
										<input type="button" value="�����ϱ�" onClick="reserA('${list.bookID}','${list.ISBN}','${list.checkOutBean.checkInDate}','${sessionScope.SessionID}')">
									</div>
								</c:if>
								<c:if test="${list.reservationState eq 'O'}">
									<div><input type="button" value="����Ұ���" disabled></div>
								</c:if>
							</c:when>
							
							<c:when test="${count ne 0}">
									<div><input type="button" value="����Ұ���" disabled></div>
							</c:when>
						</c:choose>
				</c:when>
				<c:when test="${list.checkOutState eq 'D' }">
					<div>��ü��</div>
					<div id="checkInDate">${list.checkOutBean.checkInDate}</div>
					<input type="hidden" value="${list.checkOutBean.checkInDate}" class="checkInDateC">
					<div><input type="button" value="����Ұ���" disabled></div>
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
		alert("�α��� �� �̿����ּ���");
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
					alert("���� �Ϸ� �Ǿ����ϴ�.");
					location.reload();
				}else{
					alert("���� �����ϼ̽��ϴ�.");
					
				}
			}, error:function(data){
				alert("������ �߻��߽��ϴ�."+data)
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
			alert("������ �߻��߽��ϴ�."+data);
		}
	});
}

</script>
<!-- footer -->
<jsp:include page="../../footer.jsp" />
</body>
</html>