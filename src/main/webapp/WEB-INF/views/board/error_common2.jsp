<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>

<html>
hi COMMON2
${exception}
${exception.getMessage()}
<c:forEach items="${exception.getStackTrace() }" var="stack">
<h1>${stack.toString() }</h1>
</c:forEach>
</html>

