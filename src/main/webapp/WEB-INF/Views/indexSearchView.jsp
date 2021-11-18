<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewprot" content="width=device-with, inital-scale=1">
<link rel="stylesheet" href="css/searchView.css">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
   var request = new XMLHttpRequest();
   function searchFunction() {
	  var searchItem = document.getElementById("searchItem").value;
	  var searchText = document.getElementById("searchText").value;
      var url = "./bookSearch?searchItem="+searchItem+"&searchText="+searchText;

      
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
            row.setAttribute("class","book");
            
            for(var j = 0; j < result[i].length; j++){
            	var a = result[i][j].value;
            	var isbn = result[i][j].value;
                var cell = row.insertCell(j);
               
           	   if(j == 1){
            	   cell.innerHTML ='<img alt="오류데쓰!" src="'+a+'">';
               }else if(j == result[i].length-1){
            	    console.log(isbn);
            		row.setAttribute("onclick","bookClick("+isbn+");");
            	   cell.innerHTML='<input type="hidden" class="isbn" value="'+result[i][j].value+'">';
               }else{
               cell.innerHTML = result[i][j].value;
               } 
           	   
            }
         }
      }
   }
   window.onload = function() {
	   searchFunction();
	}
	
   function bookClick(ISBN){
	  
	   location.href="bookDetail?ISBN="+ISBN;
	   
   }

   
</script>
</head>
<body>
<!-- header -->
<jsp:include page="../../header.jsp" />
   <br>
   <div class="container">
      <div class="form-group row pull-right">
         <div class='col-xs-8'>
            <select  name="searchItem" id="searchItem" onclick="searchFunction()" style="padding: 12.5px; border: 1px solid rgb(23, 28, 94); border-radius: 5px px 5px 5px;">
                  <option value="BookName">책제목</option>
                  <option  value="Author">저자</option>
                  <option value="Publisher">출판사</option>
            </select>
         </div>
         <div class='col-xs-8'>
			<input class="form-control" type="text" id="searchText" value="${searchText}" onkeyup="searchFunction()" size="20" placeholder="검색어를 입력해주세요" style="padding: 11px; border: 1px solid rgb(23, 28, 94); border-radius: 5px px 5px 5px;">         </div>
         <div class="col-xs-2">
            <button type="button" class="btn btn-primary" onclick="searchFunction();" style="padding: 11px; color:white; border-radius: 5px px 5px 5px; background-color:rgb(23, 28, 94); ">검색</button>
         </div>
      </div>
      <table class="table" style="text-align: center; border: 1px solid #dddddd;">
         <thead>
            <tr>
               <th style="background-color: #fafafa; text-align: center; width:150px">등록 번호</th>
               <th style="background-color: #fafafa; text-align: center; width:200px;">표지</th>
               <th style="background-color: #fafafa; text-align: center; width:200px;">책 이름</th>
               <th style="background-color: #fafafa; text-align: center; width:10%;">저자</th>
               <th style="background-color: #fafafa; text-align: center; width:15%;">출판사</th>
               <th style="background-color: #fafafa; text-align: center;">요약</th>
            </tr>
         </thead>
         <tbody id="ajaxTable">
         
         </tbody>
      </table>
   </div>
      <!-- footer -->
<jsp:include page="../../footer.jsp" />

<script>
	

</script>
</body>