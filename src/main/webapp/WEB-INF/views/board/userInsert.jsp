<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>데이터 입력</h4>
<form action="/ex/board/selectAll" method="post">
	유저명:<input type="text" name="username"><br>
	비밀번호:<input type="text" name="password"><br>
	권한:<input type="text" name="enabled"><br>
	<input type="submit" value="등록"><br>
</form>
</body>
</html>