<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>Page Title</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel="stylesheet" href="css/bestBook.css">

</head>
<body>

	<!-- header -->
	<jsp:include page="../../header.jsp" />
	<div class="mar">
		<MARQUEE class="mar">
			<div class="sub">BEST</div>
			<div class="mar_img">
				<img src="https://ifh.cc/g/MH5GWh.png" alt="erro">
				<img src="https://ifh.cc/g/9lezDp.jpg" alt="erro">
				<img src="https://ifh.cc/g/F141u9.jpg" alt="erro">
				<img src="https://ifh.cc/g/o74ErH.jpg" alt="erro">
				<img src="https://ifh.cc/g/91Nhyd.jpg" alt="erro">
				<img src="https://ifh.cc/g/3FzACw.jpg" alt="erro">
				<img src="https://ifh.cc/g/XoS5xC.jpg" alt="erro">
				<img src="https://ifh.cc/g/UErQmx.jpg" alt="erro">
			</div>
		</MARQUEE>
	</div>

	<div id="best" style="margin-bottom: 200px;">
		
		<!-- <div id="best_list" style="width: 600px; height: 600px;"> -->
		<div class="best_list">
		<div id="best_header">
			<h3>이달의 베스트 도서 정보</h3>
		</div>
						<div class="best_class">
							<a href="bookDetail?ISBN=20000">
								<div class="best_img">
									<img src="https://ifh.cc/g/MH5GWh.png" alt="erro"> 
								</div>
							</a>
						</div>

						<div class="best_class">
							<a href="bookDetail?ISBN=80000">
								<div class="best_img">
									<img src="https://ifh.cc/g/9lezDp.jpg" alt="erro">
								</div>
							</a>
						</div>
	
						<div class="best_class">
							<a href="bookDetail?ISBN=40000">
								<div class="best_img">
									<img src="https://ifh.cc/g/F141u9.jpg" alt="erro"> 
								</div>
							</a>
						</div>
	
						<div class="best_class">
							<a href="bookDetail?ISBN=10000">
								<div class="best_img">
									<img src="https://ifh.cc/g/o74ErH.jpg" alt="erro">
								</div>
							</a>
						</div>

						<div class="best_class">
							<a href="bookDetail?ISBN=60000">
								<div class="best_img">
									<img src="https://ifh.cc/g/91Nhyd.jpg" alt="erro"> 
								</div>
							</a>
						</div>

						<div class="best_class">
							<a href="bookDetail?ISBN=40000">
								<div class="best_img">
									<img src="https://ifh.cc/g/3FzACw.jpg" alt="erro">
								</div>
							</a>
						</div>

						<div class="best_class">
							<a href="bookDetail?ISBN=70000">
								<div class="best_img">
									<img src="https://ifh.cc/g/XoS5xC.jpg" alt="erro">
								</div>
							</a>
						</div> 

						<div class="best_class">
							<a href="bookDetail?ISBN=50000">
								<div class="best_img"> 
									<img src="https://ifh.cc/g/UErQmx.jpg" alt="erro">
							</div>
							
							</a>
						</div> 
		</div>
	</div>

	<!-- footer -->
	<jsp:include page="../../footer.jsp" />
</body>
</html>