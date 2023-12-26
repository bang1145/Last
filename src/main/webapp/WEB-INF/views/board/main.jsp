<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HProject</title>
<script>
    // JavaScript 함수를 통해 로그아웃 알림을 표시
    function showLogoutAlert() {
        alert("로그아웃 하였습니다.");
    }
</script>
<!-- main -->
<div style='height: 500px; background-color: #d2e8ff; display: none;'
	id="main-content">
	<p id='mainTitle'>
		세상의 모든 팀빌딩을,<br>
		<b>H-Project에서..</b>
	</p>
	<p id='sub'>공모전, 단기 프로젝트, 사이드잡, 채용, 공동창업 등 다양한 팀빌딩을 이용해보세요</p>
</div>
</body>
</html>