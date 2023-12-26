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
			location.href = "/ex/board/register"
		});
	});

	$(document).ready(function() {
		$(".register-btn").on("click", function() {
			location.href = "/ex/board/register";
		});

		  function countRowsAndColumns() {
              var table = document.getElementById('customers');
              var rowCount = ${pageMaker.totalCount}
              

              // 행과 열 개수를 <p> 태그에 추가
              $("#pp").html(rowCount  + "개의 글");
          }
		

		// 함수 호출
		countRowsAndColumns();
	});

	$(document).ready(
			function() {
				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "listAll"
									+ '${pageMaker.makePage(1)}'
									+ '&searchType='
									+ $("select[name='searchType']").val()
									+ "&keyword=" + $('#keywordInput').val();

						})
			});
</script>
<style>

</style>
<!-- 카테고리 -->
<div class="row">
  <div class="side">
   <a href="/ex/board/listAll" class="right">전체글보기</a><br><hr>
   <a href="/ex/board/register" class="right">글쓰기</a><br><hr>
 
   <c:forEach items="${category}" var="item">
    <c:if test="${item eq '공지사항'}">
      <img src='/ex/resources/img/noties.png'><a href="/ex/board/listAll?bGroupKind=${item}">${item}</a><br>
   </c:if>
   </c:forEach>
   <c:forEach items="${category}" var="item">
   <c:if test="${item ne '공지사항'}">
      <img src='/ex/resources/img/read.png'><a href="/ex/board/listAll?bGroupKind=${item}">${item}</a><br>
   </c:if>
    </c:forEach>
     <hr>
  </div>
  
<div class="main" id="loading-main">


	<h2>
		<c:if test="${empty param.bGroupKind}">
               전체글보기
           </c:if>
		<c:if test="${not empty param.bGroupKind}">
            ${param.bGroupKind} 
           </c:if>
	</h2>
	<div id='pp' style="font-size: 20px;">개의 글</div>
	
	<select name="searchType">
		<option value="null"
			<c:out value="${pageMaker.searchType==null?'selected':'' }"/>>----</option>
		<option value="게시판"
			<c:out value="${pageMaker.searchType eq '게시판'?'selected':'' }"/>>게시판</option>
		<option value="제목"
			<c:out value="${pageMaker.searchType eq '제목'?'selected':'' }"/>>제목</option>
		<option value="내용"
			<c:out value="${pageMaker.searchType eq '내용'?'selected':'' }"/>>내용</option>
		<option value="작성자"
			<c:out value="${pageMaker.searchType eq '작성자'?'selected':'' }"/>>작성자</option>
		<option value="제목+내용"
			<c:out value="${pageMaker.searchType eq '제목+내용'?'selected':'' }"/>>제목+내용</option>
		<option value="내용+작성자"
			<c:out value="${pageMaker.searchType eq '내용+작성자'?'selected':'' }"/>>내용+작성자</option>
		<option value="제목+내용+작성자"
			<c:out value="${pageMaker.searchType eq '제목+내용+작성자'?'selected':'' }"/>>제목+내용+작성자</option>
	</select> <input type="text" name="keyword" id="keywordInput"
		value="${pageMaker.keyword}">
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
		<c:forEach items="${list}" var="boardDto">
			<tr>
				<input type="hidden" value="${boardDto.bId} ">
				<td style="width: 80px;">${boardDto.bGroupKind}</td>
				<!-- bId를 data-bid 속성에 저장 -->
				<td style="width: 250px; text-align: left;"><c:forEach
						begin="1" end="${boardDto.bIndent }">&nbsp;&nbsp;&nbsp;</c:forEach>
					<c:if test="${boardDto.bIndent!=0 }">
						<img src="/ex/resources/img/arrow.png">
					</c:if> <a href="/ex/board/read${pageMaker.makeSearch()}&bId=${boardDto.bId}">${boardDto.bTitle}</a></td>
				<td style="width: 80px;">${boardDto.bName}</td>
				<td style="width: 100px;"><fmt:formatDate
						pattern="yyyy-MM-dd HH:mm" value="${boardDto.bWriteTime}" /></td>
				<td style="width: 50px;">${boardDto.bHit }</td>
				<td style="width: 50px;">${boardDto.bLike }</td>

			</tr>
		</c:forEach>

	</table>
	<div class="pagination">


		<c:if test="${pageMaker.page !=1}">
			<a href='listAll${pageMaker.makeSearch(1)}'>&laquo;</a>
		</c:if>
		<c:if test="${pageMaker.prev }">
			<a href='listAll${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
		</c:if>

		<c:forEach begin="${pageMaker.startPage }" end="${ pageMaker.endPage}"
			var="idx">
			<a href='listAll${pageMaker.makeSearch(idx)}'
				<c:out value="${pageMaker.page==idx?' class=active ':'' }"/>>
				${idx}</a>
		</c:forEach>

		<c:if test="${pageMaker.next }">
			<a href='listAll${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>

		</c:if>


		<c:if test="${pageMaker.page != pageMaker.totalEndPage}">
			<a href='listAll${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
		</c:if>

	</div>
</div>
</div>

<%@include file="../include/footer.jsp"%>