<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>

	<title>COTENT</title>
		<style>
				@font-face { font-family: 'BMJUA';
					src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
					font-weight: normal;
					font-style: normal;
				}
		</style>
		
			<link rel="stylesheet"
			  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
			  <link href="/resources/css/board.css" rel="stylesheet">
</head>
	
	
<body>
	<div class="container" style="text-align: center; background: #FFFFFF; padding:30px 50px; min-height: 800px">
	
	    <div class="bsubject">
	        <h3 style="margin: 0 0 20px 0; text-align: left;">${board.title}</h3>
		        <div class="subject-info-form" style="margin-bottom: 20px">
		    	    <span class="subject-info">글번호 <b>${board.seq}</b></span>
			        <span class="subject-info">조회수<b>${board.readnum}</b></span>
		            <span class="subject-info">작성자 <b>${board.user}</b></span>
		            <span class="subject-info">날짜<b>${board.regdate}</b></span>
		        </div>
		        
       		 	 <div>
		        	<div style="min-height:300px">
		            
			            <img src="" style="max-width: 300px; display: block; margin: 0 auto">
			           
			            <span>
			              ${board.content}
			            </span>	
			            </div>
			            
	                   <div style="text-align: right">
	                   
	                  	   <a style="margin-right: 10px; color:black; " href="ajaxPage">목록</a>
	                   
	                       <a style="margin-right: 10px; color:black; " href='innerInside?seq=${board.seq}'>수정</a>
	                       <a href="remove?seq=${board.seq}" style="color:black">삭제</a>
                  	 </div>
               </div>
           </div>
       </div>

</body>
</html>
