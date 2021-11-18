<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

        <script>
           function registerISBN(){
           let ISBN="";
           ISBN=document.getElementById("ISBN").value;
            $.ajax({
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book?target=isbn",
                    data: {query: ISBN},
                    headers: {Authorization: "KakaoAK fa5ae319f527c74f77894c25ec1c9412"}, 
                })
                .done(function (msg) {
                   
                   var ISBN2=document.getElementById("ISBN").value;
                   console.log(msg.documents[0].title);   // 책 제목 뽑기
                   console.log(msg.documents[0].contents); // 책 내용 뽑기
                   console.log(msg.documents[0].authors[0]); // 책 저자 뽑기
                   console.log(msg.documents[0].publisher); // 책 출판사 뽑기
                   console.log(msg.documents[0].thumbnail); // 책 표지 뽑기 
                   
                   
                   let bookName = msg.documents[0].title;
                   let detail= msg.documents[0].contents;
                   let author= msg.documents[0].authors;
                   let publisher= msg.documents[0].publisher;
                   let img= msg.documents[0].thumbnail; 
                   let purl = "apiMain?bookName="+bookName+"&detail="+detail+"&author="+author+"&publisher="+publisher+"&img="+img+"&ISBN="+ISBN2; 
                   let purl2 = "apiMain?bookName="+encodeURI(encodeURIComponent(bookName))+"&detail="+encodeURI(encodeURIComponent(detail))+"&author="+encodeURI(encodeURIComponent(author))+"&publisher="+encodeURI(encodeURIComponent(publisher))+"&img="+encodeURI(encodeURIComponent(img))+"&ISBN="+encodeURI(encodeURIComponent(ISBN));
                   location.href = purl;  
                });
               }
</script>
<script type="text/javascript">
   var request = new XMLHttpRequest();
   function searchFunction() {
	  var searchItem = document.getElementById("searchItem").value;
	  var searchText = document.getElementById("searchText").value;
      var url = "./adminbooksearch?searchItem="+searchItem+"&searchText="+searchText;
      request.open("POST",url, true);
      request.onreadystatechange = searchProcess;
      request.send(null);
   }
   function searchProcess() {
      var table = document.getElementById("ajaxTable");
      table.innerHTML = "";
      if(request.readyState == 4 && request.status == 200){
         var object = eval('(' + request.responseText + ')');
         var result = object.result;
         for(var i = 0 ; i < result.length; i++){
            var row = table.insertRow(0);
            for(var j = 0; j < result[i].length; j++){
            	var a = result[i][j].value;
            	var b = result[i][1].value;
               var cell = row.insertCell(j);
               cell.innerHTML = a;
            }
         }
      }
   }
   
   function goCheck(){
	   location.href = "goCheck"; 
} 
   window.onload = function() {
	   searchFunction();
	}
</script>
<jsp:include page="../../header.jsp" />
<section>
		<div class="wrap">
			<div class="notice_side">
				<div class="side_detail">
					<div class="side_detail">
						<b>관리자 페이지</b>
					</div>	
					<div class="side_detail">
						 <div onClick="goCheck()">대출 및 반납 </div>
					</div>
									
				</div>			
		</div>
	</div>
		<div class="page_search">
		<select name="searchItem" id="searchItem" onclick="searchFunction()">
                  <option value="BookName">책제목</option>
                  <option value="Author">저자</option>
                  <option value="Publisher">출판사</option>                  
            </select>
            <div class='col-xs-8'>
            <input type="text" id="searchText" onkeyup="searchFunction()" size="20" placeholder="검색어를 입력해주세요" style="PADDING: 15px;">
         </div>
         <div class="col-xs-2">
            <button type="button" class="btn-primary" onclick="searchFunction();">검색</button>
         </div>
		</div>
		
		<table class="table"
         style="text-align: center; border: 1px solid;">
         <thead>
            <tr>
               <th style="background-color: #fafafa; text-align: center;">ISBN</th>
               <th style="background-color: #fafafa; text-align: center;">등록번호</th>               
               <th style="background-color: #fafafa; text-align: center;">책 이름</th>
               <th style="background-color: #fafafa; text-align: center;">저자</th>
               <th style="background-color: #fafafa; text-align: center;">출판사</th>
               <th style="background-color: #fafafa; text-align: center;">대출상태</th>
               <th style="background-color: #fafafa; text-align: center;">예약상태</th>
               <th style="background-color: #fafafa; text-align: center;">등록일자</th>
               <th style="background-color: #fafafa; text-align: center;">등록자</th>
            </tr>
         </thead>
         <tbody id="ajaxTable">
        	
         </tbody>
      </table>
        <div class="isbn_btn">
	<input type="text" id="ISBN" placeholder="등록할 도서의 ISBN을 입력해주세요" class="isbn_text">
	<button type="button" class="adminpage_submit" onclick="registerISBN();" >도서 등록</button>
    </div>
	</section>

	

</body>
</html>