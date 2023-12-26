<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function searchNews() {
    var selectedCategory = $("#newsCategory").val();
    
    // 검색어를 선택한 카테고리로 설정하여 searchNews 함수 호출
    window.location.href = "/ex/board/searchNews?query=" + selectedCategory;
}
	
</script>
</head>
<body>
<div  id="loading-main">
	<div>
		<br><h2>magazine</h2><br>
		<select name="title" id="newsCategory">
			<option id="IT" value="IT">IT</option>
			<option id="geabal" value="개발">개발</option>
			<option id="computer" value="컴퓨터">컴퓨터</option>
			<option id="hacking" value="해킹">해킹</option>
		</select>
		<button id="newsBtn" onclick="searchNews()">검색</button>
	</div><hr>
	<c:set var="newsResult" value="${newsResult}" />
	<c:set var="imageUrl" value="${imageUrl}" />
	
	<c:if test="${not empty newsResult}">
    	<c:forEach var="newsItem" items="${newsResult.items}">
        	<div>
            	- <a href="${newsItem.link}" target="_blank">${newsItem.title}</a><hr>
        	</div>
    	</c:forEach>
	</c:if>
</div>
</body>
</html>