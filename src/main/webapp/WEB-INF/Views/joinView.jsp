<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Pack01.UserDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">

</head>
<body>

<!-- header -->
<jsp:include page="../../header.jsp" />
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<h2>회원가입</h2>
	<form name="login" action="joinPro" method="post" onsubmit="return check()">
 	 	<div width='300px' cellpadding='3' cellspacing='1' align='center'>
 			<div> <input type="text" name="userName" placeholder="NAME"   class="join_text" required id="userName"></div>
 			
 			<!-- 아이디 중복 확인 -->
 	 		
 	 		<div> <input type="text" class="join_text" name="userID" id="userID" required autoComplete='off' placeholder="ID"></div>
 	 		<div><span id = "idcheck"></span></div>
 	 		<div> <input type="password" name="userPW" class="join_text" placeholder="PASSWORD"  id="userPW" required ></div>
 	 		<div>  <input type="password" name="PWCheck" class="join_text" placeholder="PASSWORD 확인"  id="PWCheck" required > </div>
 			<div> <input type="text" name="phone" class="join_text" placeholder="010-****-****"  id="phone" required ></div>
 			<div> <input type="email" name="email" class="join_text" placeholder="이메일 입력"  id="email" required ></div>
 			<div style="width:82%">
 				<input class="join_text" type="text" id="sample6_address" class="address" name="address" placeholder="주소" required >
                <input type="button" class="adress_btn" onclick="sample6_execDaumPostcode()"  value="찾기"> 			
 			</div>
 			<div>
 				<input type="text" class="join_text" id="sample6_postcode" class="postcode" name="postNum" placeholder="우편번호" required >
 			</div>
 			<div>
 				<input type="text" id="sample6_detailAddress" class="detailadd join_text" name="detailadd" placeholder="상세주소" required >
                
 			</div>
 			<div>
 			<input type="text" id="sample6_extraAddress" class="join_text" id="extraadd" name="extraadd" placeholder="참고항목">
 			</div>
 			
 			<div> <input type="text" class="join_text" name="birthday" placeholder="생년월일 ( 8 자리 )" id="birthday"   required ></div>
			
			
 			<div>
				<button id="completeButton"class="join_btn" type="submit">가입완료</button>
			</div>
 	 	</div>
 	 </form>

<!-- footer -->
<jsp:include page="../../footer.jsp" />

<script>
	$(function(){
		$("#userID").on('keyup', idcheck);
	})
</script>

<script>
	var localresp;
	function idcheck(){
	    let userid = $("#userID").val();
	    let sendData = {"userID":userid};
	    $.ajax({
	        method : 'POST',
	        url : 'idcheck',
	        data : sendData,
	        success : function(resp){
	        	localresp=resp
	            if(resp=='fail'){
	                $('#idcheck').css('color','red')
	                $('#idcheck').html("사용할 수 없는 아이디입니다.")
	            }else{
	                $('#idcheck').css('color','blue')
	                $('#idcheck').html("사용할 수 있는 아이디입니다.")
	            }}
	    })	
	}
	

</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script>
function check(){
    alert(localresp);
	if(localresp=="fail"){
		return false;
	}else{
		var	userID = $("#userID").val();
		var userPW = $("#userPW").val();
		var PWCheck = $("#PWCheck").val();
		var userName = $("#userName").val();
		var phone = $("#phone").val();
		var email = $("#email").val();
		var postcode = $(".postcode").val();
		var address = $(".address").val();
		var detailadd = $(".detailadd").val();
		var birthday = $("#birthday").val();
		// 정규표현식
		//비밀번호
	    var reg2 = /^[A-za-z0-9]{5,15}$/; // 5~10자리
	    //이름
	    var reg3 = /^[가-힣]{2,5}$/;
	    //전화번호
	    var reg4 = /^01(?:0|1|[6-9])[-]?(\d{3}|\d{4})[-]?(\d{4})$/; // 010-(3자리 또는 4자리 0부터 9까지)-(4자리 0부터 9까지)
	    
	    //우편번호
	    var reg5 = /^[가-힣a-zA-Z0-9~!@#$%^&*()_+-]{2,40}$/; // 상세주소
	    
	   	//아이디
	    var idReg = /^[A-za-z0-9]{5,15}/g; //영문대소문자,숫자로 시작 5~15자 끝은 상관없음
	    
	    
	    //
	    var birthReg = /^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;

	    
	    // 아이디 확인
	    var resultID = idReg.test(userID);
	    if(resultID != true){
	    	alert("아이디는 영문,숫자 조합 5~15자 입력 가능합니다.");
	    	return false;
	    }
	    
	    // 비밀번호 확인
	   	var resultPW = reg2.test(userPW);
	    if(userPW != PWCheck){
	    	alert("비밀번호를 확인해주세요");
	    	return false;
	    }else if(resultPW != true){
	    	alert("비밀번호를 정확하게 입력해주세요. (5~10자로 입력해주세요.)"+resultBirth);
	    	return false;
	    }
	    
	    //이름확인
	    var resultName = reg3.test(userName);
	    if(resultName != true){
	    	alert("이름을 정확하게 입력해주세요");
	    	return false;
	    }
	    
	    // 전화번호 확인
	    var resultPhone = reg4.test(phone);
	    if(resultPhone != true){
	    	alert("전화번호를 정확하게 입력해주세요");
	    	return false;
	    }
	    
	    // 주소확인
	    var resultPost = reg5.test(detailadd);
	    
	    if(resultPost != true){
	    	alert("상세주소를 정확하게 입력하세요");
	    	return false;
	    }
	    
	    var resultBirth = birthReg.test(birthday);
	    //생년월일 확인
	    if(resultBirth != true){
	    	alert("생년월일을 정확하게 입력하세요 ( ex) 19970501"); 
	    	return false;
	    }
	    
		return true;	
	}
	
}
</script>
</body>
</html>