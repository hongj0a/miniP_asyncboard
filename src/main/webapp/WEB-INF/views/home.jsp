<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<link href="/resources/css/board.css" rel="stylesheet">
	<title>Home</title>
</head>
	
	<body>
		<center>
			<h1>
				Hello!  
			</h1>
			<span class="hov-anim-box">
			  <img src="/resources/img/flower.gif" alt="" class="static">
			</span>
			
			<P> <a href="board"> >> 자유게시판</a> </P>
			<P> <a href="listPage"> >> 페이징게시판</a> </P>
			<p> <a href="ajaxPage" > >> 비동기게시판</button> </p>
		</center>
	</body>
	
</html>
