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
	<button class="btn board-form-btn pull-right" onclick="location.href='listPage'">처음목록</button>
    	<H3 class="pull-left" style="margin-bottom: 40px">페이징 & 검색게시판</H3>
    	
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
			                <a href='content${pageMaker.makeQuery(pageMaker.cri.page)}&seq=${list.seq}' style="color:black">${list.title}
			                </a>
			            </td>
			            <td>${list.user}</td>
			            <td>${list.readnum}</td>
			            <td>${list.regdate}</td>
			        </tr>
		        </c:forEach>
		        
    		</table>

  			<button class="btn board-form-btn pull-right" onclick="location.href='input'">글쓰기</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			
  				<div>
	  				<div class="form-inline" style="float:left;">
		  					<select id="searchTypeSel" name="searchType" style="height:36px; float: left;">
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


    		<div class="text-center">
	<nav aria-label="pagination">
		<ul class="pagination">
		
			<!-- prev 버튼 -->
			<li id="page-prev">
				<a href="listPage${pageMaker.makeQuery(pageMaker.startPage-1)}" aria-label="Prev">
					<span aria-hidden="true">«</span>
				</a>
			</li>
			
			<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li id="page${idx}">
				    <a href="listPage${pageMaker.makeQuery(idx)}">
				    	<!-- 시각 장애인을 위한 추가 -->
				      	<span>${idx}<span class="sr-only">(current)</span></span>
				    </a>
			    </li>
			</c:forEach>
			
			<!-- next 버튼 -->
			<li id="page-next">
			    <a href="listPage${pageMaker.makeQuery(pageMaker.endPage + 1)}" aria-label="Next">
			    	<span aria-hidden="true">»</span>
			    </a>
			</li>
			
		</ul>
	</nav>
</div>

<!-- autocomplete from jQuery Ui -->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type ="text/javascript">
	$(function(){
		//perPageNum select 박스 설정
		setPerPageNumSelect();
		//searchType select 박스 설정
		setSearchTypeSelect();
		
		//등록, 삭제 후 문구 처리
		var result = '${result}';
		$(function(){
			if(result === 'registerOK'){
				$('#registerOK').removeClass('hidden');
				$('#registerOK').fadeOut(2000);
			}
			if(result === 'removeOK'){
				$('#removeOK').removeClass('hidden');
				$('#removeOK').fadeOut(2000);
			}
		})
		
		//prev 버튼 활성화, 비활성화 처리
		var canPrev = '${pageMaker.prev}';
		if(canPrev !== 'true'){
			$('#page-prev').addClass('disabled');
		}
		
		//next 버튼 활성화, 비활성화 처리
		var canNext = '${pageMaker.next}';
		if(canNext !== 'true'){
			$('#page-next').addClass('disabled');
		}
		
		//현재 페이지 파란색으로 활성화
		var thisPage = '${pageMaker.cri.page}';
		//매번 refresh 되므로 다른 페이지 removeClass 할 필요는 없음->Ajax 이용시엔 해야함
		$('#page'+thisPage).addClass('active');
	})
	
	function setPerPageNumSelect(){
		var perPageNum = '${pageMaker.cri.perPageNum}';
		var $perPageSel = $('#perPageSel');
		var thisPage = '${pageMaker.cri.page}';
		
		$perPageSel.val(perPageNum).prop("selected",true);
		$perPageSel.on('change',function(){
			window.location.href = "listPage?page="+thisPage+"&perPageNum="+$perPageSel.val();
		})
	}
	function setSearchTypeSelect(){
		var $searchTypeSel = $('#searchTypeSel');
		var $keyword = $('#keyword');
		
		$searchTypeSel.val('${pageMaker.cri.searchType}').prop("selected",true);
		//검색 버튼이 눌리면
		$('#searchBtn').on('click',function(){
			var searchTypeVal = $searchTypeSel.val();
			var keywordVal = $keyword.val();
			//검색 조건 입력 안했으면 경고창 
			if(!searchTypeVal){
				alert("검색 조건을 선택하세요!");
				$searchTypeSel.focus();
				return;
			//검색어 입력 안했으면 검색창
			}else if(!keywordVal){
				alert("검색어를 입력하세요!");
				$('#keyword').focus();
				return;
			}
			var url = "listPage?page=1"
				+ "&perPageNum=" + "${pageMaker.cri.perPageNum}"
				+ "&searchType=" + searchTypeVal
				+ "&keyword=" + encodeURIComponent(keywordVal);
			window.location.href = url;
		})
	}
</script>
		
	</div>
</body>
</html>
