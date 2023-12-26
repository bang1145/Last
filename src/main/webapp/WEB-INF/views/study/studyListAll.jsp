<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/study.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	var result = '${msg}';
	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}

	$(document).ready(function() {
		$(".register-btn").on("click", function() {
			location.href = "/ex/study/studyRegister"
		});
	});

	$(document).ready(function() {
		$(".register-btn").on("click", function() {
			location.href = "/ex/study/studyRegister";
		});

		  function countRowsAndColumns() {
              var table = document.getElementById('customers');
              var rowCount = ${studyPageMaker.totalCount}
              

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

							self.location = "studyListAll"
									+ '${studyPageMaker.makePage(1)}'
									+ '&searchType='
									+ $("select[name='searchType']").val()
									+ "&keyword=" + $('#keywordInput').val();

						})
			});
</script>
<style>


/*   게시글 디자인 */
#studyList ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	flex-wrap: wrap;
}

#studyList li:hover {
	border-color: #D2E8FF;
}

#studyList li {
	border: 2px solid #ccc;
	margin: 10px;
	padding: 10px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-between;
	border-radius: 10px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
	width: calc(33.33% - 20px); /* 3개씩 나오게 설정 */
	height: 200px;
	box-sizing: border-box;
}

#studyList .post-info {
	display: flex;
	justify-content: space-between;
	width: 100%;
	margin-top: 10px;
}

#studyList .post-info>span {
	flex: 1;
	text-align: center;
	font-size: 12px;
}

#studyList .post-info>span:not (:last-child ) {
	margin-right: 5px;
}

#studyList .post-info>span.name {
	flex: 3; /* sname이 나오는 부분이 더 크게 설정 */
}

#studyList .groupKind {
	font-size: 12px;
	text-align: center;
}

#studyList .title {
	font-size: 18px;
	font-weight: bold;
}

#studyList .writeTime {
	color: gray;
	font-size: 12px;
}

#studyList .hit img, #studyList .like img {
	width: 25px;
	height: 17px;
	margin-right: 2px; /* 각 이미지 사이의 간격 조정 */
}

#studyList .name img {
	width: 40px;
	height: 40px;
}

/* 셀렉트박스 */
select[name="searchType"] {
	font-size: 14px;
	border-radius: 5px;
    border: 1px solid #ccc;
}

#keywordInput {
	font-size: 13px;
}

#searchBtn {
	padding: 0 1.25rem; /*필요에 따라 패딩 조정 */
	font-weight: 700;
	font-size: 1rem; /* 필요에 따라 글꼴 크기 조정 */
	background-color: #262626; /* 회색 배경색 지정 */
	color: white; /* 흰색 텍스트 색상 지정 */
	border: none;
	border-radius: 4px; /* 테두리 둥글기 조정 */
	cursor: pointer;
}

#searchBtn:hover {
	background-color: #D2E8FF;
	color: black;
}

/* 페이지 가운데정렬 */
.pagination {
	text-align: center; /* pagination 클래스를 가운데 정렬합니다. */
	margin: auto;
	width: 0%; /* 원하는 너비로 설정 */
}

.pagination {
	margin: auto;
	width: 0%; /* 원하는 너비로 설정 */
}
</style>
<!-- 카테고리 -->
<div class="row1">
	<div class="side1">
		<a href="/ex/study/studyListAll" class="right">전체글보기</a> <a
			href="/ex/study/studyRegister" class="right">글쓰기</a>

		<c:forEach items="${category}" var="item">
			<c:if test="${item ne '공지사항'}">
				<a href="/ex/study/studyListAll?sGroupKind=${item}">${item}</a>
			</c:if>
		</c:forEach>
		<hr>
	</div>

	<div class="main" id="loading-main">


		<h4>
			<b> <c:if test="${empty param.sGroupKind}">
               전체글보기
           </c:if> <c:if test="${not empty param.sGroupKind}">
            ${param.sGroupKind} 
           </c:if>
			</b>
		</h4>
		<div id='pp' style="font-size: 20px;">개의 글</div>

		<select name="searchType">
			<option value="null"
				<c:out value="${studyPageMaker.searchType==null?'selected':'' }"/>>----</option>
			<option value="게시판"
				<c:out value="${studyPageMaker.searchType eq '게시판'?'selected':'' }"/>>게시판</option>
			<option value="제목"
				<c:out value="${studyPageMaker.searchType eq '제목'?'selected':'' }"/>>제목</option>
			<option value="내용"
				<c:out value="${studyPageMaker.searchType eq '내용'?'selected':'' }"/>>내용</option>
			<option value="작성자"
				<c:out value="${studyPageMaker.searchType eq '작성자'?'selected':'' }"/>>작성자</option>
			<option value="제목+내용"
				<c:out value="${studyPageMaker.searchType eq '제목+내용'?'selected':'' }"/>>제목+내용</option>
			<option value="내용+작성자"
				<c:out value="${studyPageMaker.searchType eq '내용+작성자'?'selected':'' }"/>>내용+작성자</option>
			<option value="제목+내용+작성자"
				<c:out value="${studyPageMaker.searchType eq '제목+내용+작성자'?'selected':'' }"/>>제목+내용+작성자</option>
		</select> <input type="text" name="keyword" id="keywordInput"
			value="${studyPageMaker.keyword}">
		<button id="searchBtn">검색</button>

		<hr>
		<!-- 	<table id='customers' width=100%> -->
		<!-- 		<tr> -->
		<!-- 			<th colspan=2 style="text-align: center;">제목</th> -->
		<!-- 			<th style="width: 80px;">작성자</th> -->
		<!-- 			<th style="width: 100px;">작성일</th> -->
		<!-- 			<th style="width: 50px;">조회</th> -->
		<!-- 			<th style="width: 50px;">좋아요</th> -->

		<!-- 		</tr> -->
		<script>
  $(document).ready(function() {
    // studyList의 li 요소를 클릭했을 때의 이벤트 처리
    $("#studyList li").on("click", function() {
      // li 요소 안에서 a 태그를 찾아 그 링크의 주소를 가져옴
      var link = $(this).find("a").attr("href");
      
      // link가 유효한 경우에만 이동
      if (link) {
        window.location.href = link;
      }
    });
  });
</script>


		<div id="studyList">
			<ul>
				<c:forEach items="${list}" var="studyDto">
					<li><input type="hidden" value="${studyDto.sId}">
						<div class="groupKind" style="width: 80px;">${studyDto.sGroupKind}</div>
						<!-- bId를 data-bid 속성에 저장 -->
						<div class="writeTime" style="width: 100px;">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
								value="${studyDto.sWriteTime}" />
						</div>
						<div class="title">
							<c:forEach begin="1" end="${studyDto.sIndent }">&nbsp;&nbsp;&nbsp;</c:forEach>
							<c:if test="${studyDto.sIndent!=0 }">
								<img src="/ex/resources/img/arrow.png" class="arrow">
							</c:if>
							<a
								href="/ex/study/studyRead${studyPageMaker.makeSearch()}&sId=${studyDto.sId}">${studyDto.sTitle}</a>
						</div> <span class="namehitlike"> <img
							src="/ex/resources/img/writer.png"
							style="width: 40px; height: 40px;">${studyDto.sName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="/ex/resources/img/eye.png"
							style="width: 25px; height: 17px;"> ${studyDto.sHit } <img
							src="/ex/resources/img/like.png"
							style="width: 30px; height: 25px;"> ${studyDto.sLike }
					</span></li>
				</c:forEach>
			</ul>
		</div>

		<div class="pagination">


			<c:if test="${studyPageMaker.page !=1}">
				<a href='studyListAll${studyPageMaker.makeSearch(1)}'>&laquo;</a>
			</c:if>
			<c:if test="${studyPageMaker.prev }">
				<a
					href='studyListAll${studyPageMaker.makeSearch(studyPageMaker.startPage-1)}'>&lt;</a>
			</c:if>

			<c:forEach begin="${studyPageMaker.startPage }"
				end="${studyPageMaker.endPage}" var="idx">
				<a href='studyListAll${studyPageMaker.makeSearch(idx)}'
					<c:out value="${studyPageMaker.page==idx?' class=active ':'' }"/>>
					${idx}</a>
			</c:forEach>

			<c:if test="${studyPageMaker.next }">
				<a
					href='studyListAll${studyPageMaker.makeSearch(studyPageMaker.endPage+1)}'>&gt;</a>

			</c:if>


			<c:if test="${studyPageMaker.page !=studyPageMaker.totalEndPage}">
				<a
					href='studyListAll${studyPageMaker.makeSearch(studyPageMaker.totalEndPage)}'>&raquo;</a>
			</c:if>

		</div>
	</div>

</div>



<%@include file="../include/footer.jsp"%>