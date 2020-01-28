<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false"%>
<%@ page import="hong.jy.domain.PageMaker" %>

<%
	PageMaker data = (PageMaker) request.getAttribute("pageMaker");
	System.out.println(data);
	int totalCount = data.getTotalDataCount();
%>
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
		            <th id="seq" style="text-align: center; width:7%;">번호</th>
		            <th id="subject" style="text-align: center; width:40%;">제목</th>
		            <th id="user" style="text-align: center; width:10%;">작성자</th>
		            <th id="readnum" style="text-align: center; width:15%;">조회수</th>
		            <th id="regdate" style="text-align: center; width:15%;">작성날짜</th>
		        </tr>
		       <c:forEach items="${list}" var="list">  
		        	<tr>
			            <td style="text-align: center; width:7%; font-size: small">${list.seq}</td>
			            <td style="text-align: left; width:40%; cursor:pointer"  onclick="subjectClick(${list.seq})">${list.title}
			            </td>
			            <td>${list.user}</td>
			            <td>${list.readnum}</td>
			            <td>${list.regdate}</td>
			        </tr>
		        </c:forEach>
    		</table>
  			<button id="firstWrite" class="btn board-form-btn pull-right" onclick="writeForm()">글쓰기</button>
  				<div>
	  				<div class="form-inline" style="float:left;" id="listSelect">
		  					<select id="searchTypeSel" name="searchType" style="height:36px; float: left;" >
		  						<option value="" >검색조건</option>
		  						<option value="t" >제목</option>
		  						<option value="c">내용</option>
		  						<option value="w" >작성자</option>
		  						<option value="tc">제목+내용</option>
		  						<option value="all">제목+내용+작성자</option>
		  					</select>
  						<input class="form-control" type="text" id="keyword" name="keyword" style="float:left" value="${pageMaker.cri.keyword }"  placeholder="검색어를 입력하세요" />
	  					<span id="" style="background-color:lightgray;" class="btn board-form-btn pull-left" onclick="search()">검색</span>
	  				</div>
  				</div>
 		<div class="text-center" id="pagination">
			<nav aria-label="pagination">
				<ul class="pagination">
			<!-- prev 버튼 -->
					<li id="page-prev">
						<a href="ajaxPage${pageMaker.makeQuery(pageMaker.startPage-1)}" aria-label="Prev">
							<span aria-hidden="true">«</span>
						</a>
					</li>

			<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
			<%-- <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li id="page${idx}" onclick="pageAjax(${idx})">
				   <a href="ajaxPage${pageMaker.makeQuery(idx)}">
				    	<!-- 시각 장애인을 위한 추가 -->
				      	<span>${idx}<span class="sr-only">(current)</span></span>
				  <!--   </a> -->
			    </li>
			</c:forEach> --%>

			<!-- next 버튼 -->
			<li id="page-next">
			    <a href="ajaxPage${pageMaker.makeQuery(pageMaker.endPage + 1)}" aria-label="Next" >
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

	var title;
	var user;
	var content;
	var readnum;
	var regdate;
	var seq;
	var searchKeyword;
	var keywordType;
	var pageNumber;
	
	function makePage(count) {
		var totalCount = 0;

		if (count != 0) {
			totalCount = count;
		} else {
			totalCount = <%= totalCount %>;
		}
		
		var html = "";
		
		
		pageNumber = (totalCount/10) + 1;
		
		console.log("토탈카운트인가요? : "+totalCount);
		console.log("페이지 넘버이죠?: " +pageNumber);
		
		
			for (var i = 1; i < pageNumber; i++) {
				console.log("i는모에요?:"+i);
				if( i <= 10 ){
					console.log("i는 10까지 있어요:"+i);
					html += "<li id="+i+" onclick=pageAjax("+i+")>";
					html += "   <span>"+i+"<span class=\"sr-only\">(current)</span></span>";
			    	html += "</li>";
				} else{
					break;
				}
			}
			$('#page-prev').after(html);
		}
	function pageAjax(i){
			var page = i;
			$.ajax({
			url: "/ajaxPaging",
			type: "GET",
			data: {
				"page": i,
				"keyword": searchKeyword,
				"searchType": keywordType
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				if(data == null){
					alert("데이터가 없습니다.");
				}
				
				if(data != null){
					
					$('#ptList').html("<tr><th style=\"text-align: center; width:7%;\">"+"번호" + 
					"</th><th style=\"text-align: center; width:40%;\">" +"제목" + 
					"</th><th style=\"text-align: center; width:10%;\">"+ "작성자" + 
					"</th><th style=\"text-align: center; width:15%;\">"+ "조회수" + 
					"</th><th style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");
					
					$.each(data, function(keyword){
						$('#ptList').append("<tr><td>" + this.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=subjectClick("+this.seq+")>" + this["title"]
						+ "</td><td>" + this["user"] + "</td><td>" + this["readnum"]+ 
						"</td><td>" + this["regdate"] + "</td></tr>");
					});
				}
			},error: function(request,status,responseText,error){
				console.log("NONONO")
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}) 

		//현재 페이지 파란색으로 활성화
		$('#page'+page).addClass('active')
			.siblings().removeClass('active');
	}

	var $searchTypeSel = $('#searchTypeSel');
	var $keyword = $('#keyword');
	$searchTypeSel.val('${pageMaker.cri.searchType}').prop("selected",true);

	function showList(list) {
		$('#ptList').html("<tr><th style=\"text-align: center; width:7%;\">"+"번호" + 
		"</th><th style=\"text-align: center; width:40%;\">" +"제목" + 
		"</th><th style=\"text-align: center; width:10%;\">"+ "작성자" + 
		"</th><th style=\"text-align: center; width:15%;\">"+ "조회수" + 
		"</th><th style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");

		for (var data of list) {
			$('#ptList').append("<tr><td>" + data.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=subjectClick("+data.seq+")>" + this["title"]
			+ "</td><td>" + this["user"] + "</td><td>" + this["readnum"]+ 
			"</td><td>" + this["regdate"] + "</td></tr>");
		}
	}

	//검색 버튼이 눌리면
	function search(){
		var searchTypeVal = $searchTypeSel.val();
		var keywordVal = $keyword.val();
		var totalCount = 0;
		searchKeyword = keywordVal;
		keywordType = searchTypeVal;
		
		//검색 조건 입력 안했으면 경고창 
		if(!searchTypeVal){
			alert("검색 조건을 선택하세요!");
			$searchTypeSel.focus();
			return;
		//검색어 입력 안했으면 경고창
		}else if(!keywordVal){
			alert("검색어를 입력하세요!");
			$('#keyword').focus();
			return;
		}
		console.log("searchType: "+ searchTypeVal);
		console.log("keyword:" +keywordVal);
		
		$.ajax({
			url: "/ajaxSearch",
			type: "GET",
			data: {
				"searchType": searchTypeVal,
				"keyword": keywordVal,
				"totalCount": totalCount
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("here~~~")
				if(data == null){
					alert("데이터없음");
				}
				if(data != null){
					
					makePage(data[0].totalcount);
					
					$('#ptList').empty();
					$('#ptList').append("<tr><th id=\"h\"style=\"text-align: center; width:7%;\">"+"번호" + 
					"</th><th id=\"hh\" style=\"text-align: center; width:40%;\">" +"제목" + 
					"</th><th id=\"hhh\" style=\"text-align: center; width:10%;\">"+ "작성자" + 
					"</th><th id=\"hhhh\" style=\"text-align: center; width:15%;\">"+ "조회수" + 
					"</th><th id=\"hhhhh\" style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");
					$.each(data, function(){
						$('#ptList').append("<tr><td>" + this.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=subjectClick("+this.seq+")>" + this["title"]
						+ "</td><td>" + this["user"] + "</td><td>" + this["readnum"]+ 
						"</td><td>" + this["regdate"] + "</td></tr>");
					});
					console.log("seqeseqesedqeseqseqseqseq"+this.title);
				}
			},error: function(request,status,responseText,error){
				console.log("noknoknoknoknoknokno")
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	}

	$(function(){
		//perPageNum select 박스 설정
		setPerPageNumSelect();
		//searchType select 박스 설정
		//setSearchTypeSelect();
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
		makePage(0);
	})
	
		function setPerPageNumSelect(){
		var perPageNum = '${pageMaker.cri.perPageNum}';
		var $perPageSel = $('#perPageSel');
		var thisPage = '${pageMaker.cri.page}';

		$perPageSel.val(perPageNum).prop("selected",true);
		$perPageSel.on('change',function(){
			window.location.href = "ajaxPage?page="+thisPage+"&perPageNum="+$perPageSel.val();
		})

	}
	
	function writeForm(){
	
		$('#firstWrite').hide();
		$('#listSelect').hide();
		$('#pagination').hide();
		$('#ptList').empty();
		$('#ptList').append("<tr id=\"gg\"><th>"+"게시글 작성"+"</th></tr>");
		$('#ptList').append("<tr id=\"ggg\"><td><input type='text' class='form-control' placeholder='글제목' name='title' id='title' maxlength='50'/>"+"</td></tr>");
		$('#ptList').append("<tr id=\"gggg\"><td style=\"background-color:white;\"><input type=\"text\" class=\"form-control\" placeholder=\"작성자\" name=\"user\" id=\"user\" maxlength=\"50\">"+"</td></tr>");
		$('#ptList').append("<tr id=\"ggggg\"><td><textarea name=\"content\" id=\"content\" rows=\"10\" cols=\"100\" style=\"width:633px; height:490px;\">"+"</textarea></td></tr>");
		$('#ptList').append("<tr id=\"gggggg\"><td><input type=\"button\" class=\"btn btn-default pull-left\" value=\"목록\" onclick=\"location.href='ajaxPage'\">"+
				"<input type=\"button\" class=\"btn btn-default pull-right\" value=\"글쓰기\" id=\"save\" onclick=\"realWrite(title, user, content)\">"+"</td></tr>");

	}

	function realWrite(title, user, content){
	
		title=$('#title').val();
		user=$('#user').val();
		content=$('#content').val();

		console.log("===========================");
		console.log("title: "+title);
		console.log("user: "+user);
		console.log("content: "+content);

		var titleVal = title
		var userVal = user
		var contentVal = content

		console.log("title.val():" +titleVal);
		console.log("user.val(): " +userVal);
		console.log("content.val():" +contentVal);

		$.ajax({
			url: "/realWrite",
			type: "GET",
			data: {
				"title": titleVal,
				"user" : userVal,
				"content": contentVal
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("성고옹~: " + contentVal);
				$('#gg').hide();
				$('#ggg').hide();
				$('#gggg').hide();
				$('#ggggg').hide();
				$('#gggggg').hide();
 
				console.log("writeFormData:"+ userVal);
				listForm(titleVal, userVal, contentVal);
				console.log("????");
			},error: function(response){
				if(response.status == 200){
					console.log("성공?");
				}
			}
		})
	}

	function listForm(titleVal, userVal, contentVal){
		var title = titleVal;
		var user = userVal;
		var content = contentVal;

		console.log(title);
		console.log(user);
		console.log(content);

		$.ajax({
			url: "/realList",
			type: "GET",
			data: {
				"title" : titleVal,
				"user" : userVal,
				"content": contentVal
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				$('#ptList').append("<tr><th id=\"h\"style=\"text-align: center; width:7%;\">"+"번호" + 
						"</th><th id=\"hh\" style=\"text-align: center; width:40%;\">" +"제목" + 
						"</th><th id=\"hhh\" style=\"text-align: center; width:10%;\">"+ "작성자" + 
						"</th><th id=\"hhhh\" style=\"text-align: center; width:15%;\">"+ "조회수" + 
						"</th><th id=\"hhhhh\" style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");
				$.each (data, function(){
					$('#ptList').append("<tr><td>" + this.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=\"subjectClick()\">" + this["title"]
					+ "</td><td>" + this["user"] + "</td><td>" + this["readnum"]+ 
					"</td><td>" + this["regdate"] + "</td></tr>");
				});
				$('#firstWrite').show();
				$('#listSelect').show();
				$('#pagination').show();
			},error : function(request,status,responseText,error,data){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				console.log("data: "+ data);
				console.log("seq:" + seq);
			}
		})
	}

	function subjectClick(seq){

		$('#ptList').empty();
		console.log("come here?")
		console.log("=============================================="+seq);
		$.ajax({
			url: "/realContent",
			type: "GET",
			data: {
				"seq": seq
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("data????????????????????????????????????:"+ data);
				console.log("여기서도 먹혀라 "+seq);
				$('#ptList').append("<h3 id=\"a\" style=\"margin: 0 0 20px 0; text-align: left;\">" + data.title + "</h3>");
				$('#ptList').append("<div id=\"aa\" class=\"subject-info-form\" style=\"margin-bottom: 20px\"><span class=\"subject-info\" style=\"font-bold\" id=\"delete\">"+"글번호"+"<b>"+data.seq+"</b></span>");
				$('#ptList').append("<span id=\"aaa\" class=\"subject-info\">"+"조회수"+"<b>"+data.readnum+"</b></span>");
				$('#ptList').append("<span id=\"aaaa\" class=\"subject-info\">"+"작성자"+"<b>"+data.user+"</b></span>");
				$('#ptList').append("<span id=\"aaaaa\" class=\"subject-info\">"+"날짜"+"<b>"+data.regdate+"</b></span></div>");
				$('#ptList').append("<span id=\"aaaaaa\" style=\"max-width: 300px; min-height:300px; display: block; margin: 0 auto\">"+data.content+"</span>");
				$('#ptList').append("<tr id=\"aaaaaaa\"><td style=\"background: white;\"><input type=\"button\" class=\"btn btn-default pull-left\" value=\"수정\" onclick=realDetail(" +seq+")>"+
						"<input type='button' class='btn btn-default pull-right' value='삭제' id='del' onclick=realDelete(" +seq+")>"+"</td></tr>");
			},error: function(request,status,responseText,error,data){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				console.log("data: "+ data);
				console.log("seq:" + seq);
			}
		})
	}

	function realDelete(seq){
		console.log("seq----------------"+ seq);

		$.ajax({
			url: "/realDel",
			type: "GET",
			data: {
				"seq": seq
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("data  ::: "+data);
				console.log("data.seq"+ data.seq);
				$('#a').hide();
				$('#aa').hide();
				$('#aaa').hide();
				$('#aaaa').hide();
				$('#aaaaa').hide();
				$('#aaaaaa').hide();
				$('#aaaaaaa').hide();

				$('#ptList').append("<tr><th id=\"h\"style=\"text-align: center; width:7%;\">"+"번호" + 
						"</th><th id=\"hh\" style=\"text-align: center; width:40%;\">" +"제목" + 
						"</th><th id=\"hhh\" style=\"text-align: center; width:10%;\">"+ "작성자" + 
						"</th><th id=\"hhhh\" style=\"text-align: center; width:15%;\">"+ "조회수" + 
						"</th><th id=\"hhhhh\" style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");

				for (var listData of data) {
					$('#ptList').append("<tr><td>" + listData.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=\"subjectClick()\">" + listData.title
							+ "</td><td>" + listData.user + "</td><td>" + listData.readnum + 
							"</td><td>" + listData.regdate + "</td></tr>");
				}
				$('#firstWrite').show();
				$('#listSelect').show();
				$('#pagination').show(); 
			},error: function (request,status,responseText,error,data) {
				error
			}
		})
	}

	function realDetail(seq){
		console.log("seq:::::::::::::::::::::::"+seq);

		$.ajax({
			url: "/realDetail",
			type: "GET",
			data: {
				"seq": seq
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("이곳의 data는?????????????"+data);
				console.log("이곳의 seq는????????????"+ seq);

				$('#a').hide();
				$('#aa').hide();
				$('#aaa').hide();
				$('#aaaa').hide();
				$('#aaaaa').hide();
				$('#aaaaaa').hide();
				$('#aaaaaaa').hide();

				$('#ptList').append("<tr><th id=\"number\">"+"글번호"+seq+"</tr></th>");
				$('#ptList').append("<tr><td id=\"td1\"><input type=\"text\" class=\"form-control\" value="+data.title+" name=\"title\" id=\"title\" maxlength=\"50\">"+"</td></tr>");
				$('#ptList').append("<tr><td id=\"td2\"><input type=\"text\" class=\"form-control\" value="+data.user+" name=\"user\" id=\"user\" maxlength=\"50\">"+"</td></tr>");
				$('#ptList').append("<tr><td id=\"td3\"><textarea name=\"content\" id=\"content\" rows=\"10\" cols=\"100\" style=\"width:578px; height:490px;\">"+data.content+"</textarea></td></tr>");
				$('#ptList').append("<td style=\"width: 600px; text-align: center;\" id =\"td4\"><input type=\"button\" class=\"btn btn-default pull-left\" value=\"취소\" onclick=\"history.go()\">"+
				"<input type=\"button\" class=\"btn btn-default pull-right\" value=\"수정\" id=\"save\"  onclick=realUpdate(" + seq+")>"+"</td></tr>");
			},error: function(request,status,responseText,error,data){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				console.log("data: "+ data);
				console.log("seq:" + seq);
			}
		})
	}

  function realUpdate(seq){
		console.log("업데이트 무사도착 ~~~seq????:"+ seq);

		title=$('#title').val();
		user=$('#user').val();
		content=$('#content').val();
		
		console.log("title::::::::::::::::::::::"+title);
		console.log("user::::::::::::::::::::::"+user);
		$.ajax({
			url: "/realUpdate",
			type: "GET",
			data: {
				"seq": seq,
				"title": title,
				"user": user,
				"content": content
			},
			dataType: 'JSON',
			contentType:"application/json; charset=UTF-8",
			success: function(data){
				console.log("이곳의 data는?????????????"+data);
				$('#number').hide();
				$('#td1').hide();
				$('#td2').hide();
				$('#td3').hide();
				$('#td4').hide();
				$('#firstWrite').hide();
				$('#listSelect').hide();
				$('#pagination').hide();
				
				$('#ptList').append("<tr><th id=\"h\"style=\"text-align: center; width:7%;\">"+"번호" + 
						"</th><th id=\"hh\" style=\"text-align: center; width:40%;\">" +"제목" + 
						"</th><th id=\"hhh\" style=\"text-align: center; width:10%;\">"+ "작성자" + 
						"</th><th id=\"hhhh\" style=\"text-align: center; width:15%;\">"+ "조회수" + 
						"</th><th id=\"hhhhh\" style=\"text-align: center; width:15%;\">" +"작성날짜"+ "</th></tr>");
				for (var listData of data) {
					$('#ptList').append("<tr><td>" + listData.seq + "</td><td style=\"text-align: left; cursor:pointer;\" onclick=subjectClick("+listData.seq+")>" + listData.title
							+ "</td><td>" + listData.user + "</td><td>" + listData.readnum + 
							"</td><td>" + listData.regdate + "</td></tr>");
				}
				$('#firstWrite').show();
				$('#listSelect').show();
				$('#pagination').show();
			},error: function (request,status,responseText,error,data) {
				error
			}
		})
	}

	</script>

</div>

</body>
</html>