<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="text-align: center; margin-top: 100px;">
		<img src="/ex/resources/img/logo03.png" style="width:350px;">
		<div class="h-login">
		<div style="border: 1px solid #ddd; border-radius: 25px; width:500px;">
		<h3 style="margin-top:20px;">Join</h3>
		<br>
		<form action="/ex/admin/user/insert" method="post">	
			<p>
				아이디: <input type="text" name="username" style="margin-left:15px;"/>
			</p>
			<p>
				비밀번호: <input type="password" name="password" />
			</p>
			<p>
				권한: <input type="enabled" name="password" style="margin-left:25px;" placeholder="1을 입력해주세요."/>
			</p>
			<input type="submit" value="등록"><br>
		</form>
		</div>
		</div>
	</div>

</body>
</html>