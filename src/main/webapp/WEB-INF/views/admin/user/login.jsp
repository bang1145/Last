<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<style>

</style>
<meta charset="UTF-8" />
<title>로그인 페이지</title>
</head>

<body>
	<div style="text-align: center; margin-top: 100px;">
		<c:if test="${param.error != null}">
			<p>아이디와 비밀번호가 잘못되었습니다.</p>
		</c:if>
		<img src="/ex/resources/img/logo03.png" style="width:350px;">
		<div class="h-login">
		<div style="border: 1px solid #ddd; border-radius: 25px; width:500px;">
		<h3 style="margin-top:20px;">Login</h3>
		<br>
		<c:url value="/login" var="loginUrl" />
		<form name="frmLogin" action="${loginUrl}" method="POST">
			<!-- csrf가 있어야 된다. -->
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }" />
			<p>
				<label for="id">아이디</label> <input type="text" id="id" name="id" style="margin-left:15px;"/>
			</p>
			<p>
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password" />
			</p>
			<button type="submit" class="btn" style="margin-bottom:20px; border: 2px solid black;">로그인</button>
			<button style="margin-bottom:20px; border: 2px solid black;"><a href="/ex/board/main">HOME</a></button>
		</form>
		</div>
		</div>
	</div>
</body>
</html>
