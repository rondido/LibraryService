<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
    <style>
    @import
			url('https://fonts.googleapis.com/css?family=Jua:400');
	</style>
</head>
<header>
	<div class="header_section">
						<div class="container">
							<div class="row">							
						 <div class="col-sm-6">
						 	<nav class="navbar navbar-expand-lg navbar-light bg-light">
								<c:if test="${sessionScope.SessionID eq null }">
									<input type="button" value="로그인"  class="navbar-toggler"onclick="location.href='login'" />
									<input type="button" value="회원가입"  class="navbar-toggler" onclick="location.href='join'" />								
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
								<a href="index.jsp"><img src="images/KakaoTalk_20211016_171439822.jpg" class="logo"></a>									
										<a  class="nav-item nav-link" href="search">자료검색</a>
								
										<a  class="nav-item nav-link" href="bestBook">베스트 셀러</a>
								
										<c:if test="${sessionScope.flag eq 'U'}">
											<a  class="nav-item nav-link" href="mypage?userID=${sessionScope.SessionID}">마이페이지</a>
										</c:if>
										<c:if test="${sessionScope.flag eq 'A'}">
											<a  class="nav-item nav-link" href="adminPage">관리자페이지</a>
										</c:if>
										<c:if test="${sessionScope.flag eq null}">
											<a  class="nav-item nav-link" href="login">마이페이지</a>
										</c:if>								
										<a  class="nav-item nav-link" href="notice">공지사항</a>								
										<a  class="nav-item nav-link" href="load">오시는 길</a>
									</div>
               					</div>
									
									</nav>
								</div>
							</div>
						</div>
						</div>
		</header>