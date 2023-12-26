<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	var result = '${msg}';
	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}

	$(document).ready(function() {
		$(".register-btn").on("click", function() {
			location.href = "/ex/uboard/register"
		});
	});

	$(document).ready(function() {
		$(".register-btn").on("click", function() {
			location.href = "/ex/uboard/register";
		});

	function countRowsAndColumns() {
    	var table = document.getElementById('customers');
        var rowCount = ${UPageMaker.totalCount}
              
        // 행과 열 개수를 <p> 태그에 추가
        $("#pp").html(rowCount  + "개의 글");
    }
		
		// 함수 호출
		countRowsAndColumns();
	});

	$(document).ready(
			function() {
				$('#searchBtn').on("click",function(event) {
					self.location = "listAll" 
									+ '${UPageMaker.makePage(1)}'
									+ '&searchType='
									+ $("select[name='searchType']").val()
									+ "&keyword=" + $('#keywordInput').val();
			});
	});
</script>

<!-- 카테고리 -->
<div class="row">
	<div class="side">
   		<a href="/ex/uboard/listAll" class="right">전체글보기</a><br><hr>
   		<a href="/ex/uboard/register" class="right">글쓰기</a><br><hr>
 
		<c:forEach items="${category}" var="item">
    		<c:if test="${item eq '공지사항'}">
      			<img src='/ex/resources/img/noties.png'><a href="/ex/uboard/listAll?uGroupKind=${item}">${item}</a><br>
   			</c:if>
		</c:forEach>
	
		<c:forEach items="${category}" var="item">
			<c:if test="${item ne '공지사항'}">
      			<img src='/ex/resources/img/read.png'><a href="/ex/uboard/listAll?uGroupKind=${item}">${item}</a><br>
   			</c:if>
    	</c:forEach>
    	<hr>
	</div>
  
	<div class="main" id="loading-main">
		<h2>
		<c:if test="${empty param.uGroupKind}">전체글보기</c:if>
		<c:if test="${not empty param.uGroupKind}">${param.uGroupKind}</c:if>
		</h2>
	
		<div id='pp' style="font-size: 20px;">개의 글</div>
	
		<select name="searchType">
			<option value="null"
				<c:out value="${UPageMaker.searchType==null?'selected':'' }"/>>----</option>			
			<option value="제목"
				<c:out value="${UPageMaker.searchType eq '제목'?'selected':'' }"/>>제목</option>
			<option value="내용"
				<c:out value="${UPageMaker.searchType eq '내용'?'selected':'' }"/>>내용</option>
			<option value="작성자"
				<c:out value="${UPageMaker.searchType eq '작성자'?'selected':'' }"/>>작성자</option>
			<option value="제목+내용"
				<c:out value="${UPageMaker.searchType eq '제목+내용'?'selected':'' }"/>>제목+내용</option>
			<option value="내용+작성자"
				<c:out value="${UPageMaker.searchType eq '내용+작성자'?'selected':'' }"/>>내용+작성자</option>
			<option value="전체"
				<c:out value="${UPageMaker.searchType eq '제목+내용+작성자'?'selected':'' }"/>>전체</option>
		</select>
	
		<input type="text" name="keyword" id="keywordInput" value="${UPageMaker.keyword}">
		<button id="searchBtn">검색</button>
		<hr>
	
		<table id='customers' width=100%>
			<tr>
				<th colspan=2 style="text-align: center;">제목</th>
				<th style="width: 80px;">작성자</th>
				<th style="width: 100px;">작성일</th>
				<th style="width: 50px;">조회</th>
				<th style="width: 50px;">좋아요</th>
			</tr>
		
			<c:forEach items="${list}" var="uBoardDto">
				<tr>
					<input type="hidden" value="${uBoardDto.id} ">
					<td style="width: 80px;">${uBoardDto.uGroupKind}</td>
					<!-- id를 data-id 속성에 저장 -->
					<td style="width: 250px; text-align: left;">
						<c:forEach begin="1" end="${uBoardDto.uIndent }">&nbsp;&nbsp;&nbsp;</c:forEach>
						<c:if test="${uBoardDto.uIndent!=0 }">
							<img src="/ex/resources/img/arrow.png">
						</c:if> 
						<a href="/ex/uboard/read${UPageMaker.makeSearch()}&id=${uBoardDto.id}">${uBoardDto.uTitle}</a>
					</td>
					<td style="width: 80px;">${uBoardDto.uName}</td>
					<td style="width: 100px;">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${uBoardDto.uWriteTime}" /></td>
					<td style="width: 50px;">${uBoardDto.uHit }</td>
					<td style="width: 50px;">${uBoardDto.uLike }</td>
				</tr>
			</c:forEach>
		</table>
	
		<div class="pagination">

			<c:if test="${UPageMaker.page !=1}">
				<a href='listAll${UPageMaker.makeSearch(1)}'>&laquo;</a>
			</c:if>
	
			<c:if test="${UPageMaker.prev }">
				<a href='listAll${UPageMaker.makeSearch(UPageMaker.startPage-1)}'>&lt;</a>
			</c:if>

			<c:forEach begin="${UPageMaker.startPage }" end="${UPageMaker.endPage}"
         var="idx">
         <a href='listAll${UPageMaker.makeSearch(idx)}'
            <c:out value="${UPageMaker.page==idx?' class=active ':'' }"/>>
            ${idx}</a>
      </c:forEach>

			<c:if test="${UPageMaker.next }">
				<a href='listAll${UPageMaker.makeSearch(UPageMaker.endPage+1)}'>&gt;</a>
			</c:if>

			<c:if test="${UPageMaker.page != UPageMaker.totalEndPage}">
				<a href='listAll${UPageMaker.makeSearch(UPageMaker.totalEndPage)}'>&raquo;</a>
			</c:if>
		</div>
	</div>
</div>

<%@include file="../include/footer.jsp"%>