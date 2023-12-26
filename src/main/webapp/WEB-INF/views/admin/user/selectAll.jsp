<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
h3{
	color:#04AA6D;
	margin-left:5px;

}
</style>
<script>
var result = '${msg}';

if (result == 'success') {
	alert("처리가 완료되었습니다.");
}
</script>
<title>select</title>
</head>
<body>
<h3>모든 데이터 보기</h3>
<table id='customers' width=100% border="1">
<tr>
	<th style="width:10px">username</th>
	<th style="width:100px">password</th>
	<th style="width:200px">enabled</th>
</tr>
	<c:forEach items="${list }" var="dto">
		<tr>
			<td>${dto.username }</td>
			<td>${dto.password}</td>
			<td>${dto.enabled }</td>
		</tr>
	
	</c:forEach>
</table>
<a href="/ex/admin/user/insert">입력</a>
</body>
</html>