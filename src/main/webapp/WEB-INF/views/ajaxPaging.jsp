<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>

	<title>LIST</title>
	<link rel="stylesheet"
	  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link href="/resources/css/board.css" rel="stylesheet">
</head>
	
	
<body>


	<div class="container" style="text-align: center; background: #FFFFFF; padding:30px 50px; min-height: 800px">
	<button class="btn board-form-btn pull-right" onclick="location.href='ajaxPage'">처음목록</button>
    	<H3 class="pull-left" style="margin-bottom: 40px">ajax 구현 게시판</H3>
    	
    		<table class="table table-hover table table-striped" id="ptList">
		       
		        <tr>
		            <th style="text-align: center; width:7%;">번호</th>
		            <th style="text-align: center; width:40%;">제목</th>
		            <th style="text-align: center; width:10%;">작성자</th>
		            <th style="text-align: center; width:15%;">조회수</th>
		            <th style="text-align: center; width:15%;">작성날짜</th>
		        </tr>
		        
		       <c:forEach items="${list}" var="list">  
		        	<tr>
			            <td style="text-align: center; width:7%; font-size: small">${list.seq}</td>
			            <td style="text-align: left; width:40%;">
			                <a href='inside&seq=${list.seq}' style="color:black">${list.title}
			                </a>
			            </td>
			            <td>${list.user}</td>
			            <td>${list.readnum}</td>
			            <td>${list.regdate}</td>
			        </tr>
		        </c:forEach>
		        
    		</table>

  			<button class="btn board-form-btn pull-right" onclick="location.href='write'">글쓰기</button>
  			
  				

<!-- autocomplete from jQuery Ui -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type ="text/javascript">
	
</script>
		</div>
	
</body>
</html>
