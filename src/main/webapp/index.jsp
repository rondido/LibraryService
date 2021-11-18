<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="style.css">
<style>
			@import
			url('https://fonts.googleapis.com/css?family=Jua:400')
</style>
</head>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function search(){
	var searchItem = document.getElementById("searchItem").value;
	var searchText = document.getElementById("searchText").value;
	console.log(searchItem);
	location.href='bookSearch2?searchItem='+searchItem+'&searchText='+searchText;
}
</script>
<body>
	<header>
		<div class="header_section">
			<div class="container">
				<div class="row">

					<div class="col-sm-6">
						<nav class="navbar navbar-expand-lg navbar-light bg-light">
							<c:if test="${sessionScope.SessionID eq null }">
								<input type="button" value="로그인" class="navbar-toggler"
									onclick="location.href='login'" />
								<input type="button" value="회원가입" class="navbar-toggler"
									onclick="location.href='join'" />
							</c:if>
							<c:if test="${sessionScope.SessionID ne null }">
								<div class="navar_login">	
									<div class="navar_login1">
										<div>${sessionScope.SessionID}님이 로그인 하셨습니다.</div>
										<div><input type="button" value="로그아웃" onclick="location.href='logout'" class="navbar-toggler1"/></div>
									</div>
								</div>
							</c:if>
							<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
								<div class="navbar-nav">
									<a href="index.jsp"><img
										src="images/KakaoTalk_20211016_171439822.jpg" class="logo"></a> 
										<a class="nav-item nav-link" href="search">자료검색</a> 
										<a class="nav-item nav-link" href="bestBook">베스트 셀러</a>

									<c:if test="${sessionScope.flag eq 'U'}">
										<a class="nav-item nav-link"
											href="mypage?userID=${sessionScope.SessionID}">마이페이지</a>
									</c:if>
									<c:if test="${sessionScope.flag eq 'A'}">
										<a class="nav-item nav-link" href="adminPage">관리자페이지</a>
									</c:if>
									<c:if test="${sessionScope.flag eq null}">
										<a class="nav-item nav-link" href="login">마이페이지</a>
									</c:if>
									<a class="nav-item nav-link" href="notice">공지사항</a> <a
										class="nav-item nav-link" href="load">오시는 길</a>
								</div>
							</div>

						</nav>
					</div>
				</div>
			</div>
		</div>
	</header>
	<!-- banner section start -->
	<div class="layout_padding banner_section">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<h1 class="banner_taital">All You Need Is Here & Classified</h1>
					<p class="browse_text">Browse from more than 100 book while new
						ones come on daily bassis</p>

				</div>
			</div>
		</div>
	</div>
	<!-- banner section end -->
	<!-- search box start -->
	<div class="container">
		<div class="search_box">
			<div class="row search_row" style="display: flex;">
				<div class="form-combo">
					<select name="searchItem" id="searchItem" 
						style="padding: 12.5px; border: 1px solid rgb(23, 28, 94); border-radius: 5px px 5px 5px;">

						<option value="BookName">책제목</option>
	                  
					</select>
				</div>
				<div class="form-text">
					
				<input class="form-control email_boton" type="text" id="searchText"  placeholder="검색어를 입력해주세요"  style="width: 650px;">
						
						
				</div>
				<div class="form-group">
					<button class="search_bt"
						style="padding: 8.5px; margin-top: -1px; width: 100px; font-family: 'jua';" onClick="search();">검색</button>
				</div>
			</div>
		</div>


	</div>
	<!-- search box end -->
	<footer>
		<div class="layout_padding footer_section">
			<div class="container footer_container">
				<div class="row">
					<!-- <div class="img"><img src="https://ifh.cc/g/u5RzbN.png" style="float: left; width:15%; height:15%; "></div>							 					
						<div class="img"><img src="https://ifh.cc/g/p66ysh.png" style="float: left; width:15%; height:15%; margin-top:2%;"></div> -->
					<div class="p">
						<div class="dolor_text">부산광역시 해운대구 센텀중앙로 55 지번우동 1465</div>
						<br>
						<div class="dolor_text">TEL)051-731-6660 FAX)051-731-6664</div>
						<br>
						<div class="dolor_text">COPYRIGHTⓒ 부산정보산업진흥원 ALL RIGHTS
							RESERVED.</div>
						<br>
					</div>
				</div>
					<div class="copyright">
		<p class="copyright_text">2021 All Rights Reserved. Busan library</p>
	</div>
				
			</div>
		</div>
	</footer>

</body>
</html>
