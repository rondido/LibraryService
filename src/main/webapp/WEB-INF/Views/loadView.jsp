<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- header -->
<jsp:include page="../../header.jsp" />

	<center>
		<h2>오시는 길</h2>
		<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1634035261425" class="root_daum_roughmap root_daum_roughmap_landing"></div>
		
		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
		
		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1634035261425",
				"key" : "27nje",
				"mapWidth" : "640",
				"mapHeight" : "360"
			}).render();
		</script>
		
		<!-- 부가 정보 -->
		<img src="https://ifh.cc/g/i3ardi.png"> 부산 해운대구 센텀중앙로 55
		<img src="https://ifh.cc/g/xxVNXL.png"> TEL 010-0000-0000
		<img src="https://ifh.cc/g/0vpLvY.png"> FAX 02-0000-0000		
		<hr>교통편</br>
		<img src="https://ifh.cc/g/Vug2QB.png"> BUS SK텔레콤	
		<img src="https://ifh.cc/g/ZiEABm.png"> SUBWAY 부산 2호선 센텀시티역 6번 출구 도보 13분
		
	</center>
	
	
	<!-- footer -->
<jsp:include page="../../footer.jsp" />
</body>
</html>