<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>

	<title>BOARD</title>
	<link rel="stylesheet"
	  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link href="/resources/css/board.css" rel="stylesheet">
</head>
	
	
<body>
	<div class="container" style="text-align: center; background: #FFFFFF; padding:30px 50px; min-height: 800px">
    	<H3 class="pull-left" style="margin-bottom: 40px">자유게시판</H3>
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
			                <a href='content?seq=${list.seq}' style="color:black">${list.title}
			                </a>
			            </td>
			            <td>${list.user}</td>
			            <td>${list.readnum}</td>
			            <td>${list.regdate}</td>
			        </tr>
		        </c:forEach>
		        
    		</table>

  			<button class="btn board-form-btn pull-right" onclick="location.href='input'">글쓰기</button>
  				<div>
	  				<div class="form-inline" style="float:left;">
		  					<select name="searchType" name="searchType" style="height:26px;">
		  						<option value="" >검색조건</option>
		  						<option value="t" >제목</option>
		  						<option value="c">내용</option>
		  						<option value="w" >작성자</option>
		  						<option value="tc">제목+내용</option>
		  						<option value="all">제목+내용+작성자</option>
		  					</select>
  						<input class="form-control" type="text" id="keyword" name="keyword" style="float:left" value="${pageMaker.cri.keyword }"  placeholder="검색어를 입력하세요" />
	  					<button id="searchBtn" class="btn board-form-btn pull-left" >검색</button>
	  				</div>
  				</div>


    		<ul class="btn-group pagination">
			    <c:if test="${pageMaker.prev }">
				    <li>
				        <a href='<c:url value="/board?page=${pageMaker.startPage-1 }"/>'><<<i class="fa fa-chevron-left"></i></a>
				    </li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				    <li>
				        <a href='<c:url value="/board?page=${idx }"/>'><i class="fa">${idx }</i></a>
				    </li>
			    </c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board?page=${pageMaker.endPage+1 }"/>'>>><i class="fa fa-chevron-right"></i></a>
				    </li>
			    </c:if>
			</ul>
		
	</div>
</body>
</html>
