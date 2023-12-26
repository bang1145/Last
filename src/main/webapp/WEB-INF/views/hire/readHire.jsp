<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<div class="mainHire">
<div class="hire-main"  style="border: 1px solid #ddd; border-radius: 10px; ">
    <form role="form" method="post">
        <c:forEach items="${hireDtoList}" var="hireDto">
            <input type='hidden' name='hId' value="${hireDto.hId}">
        </c:forEach>
    </form>
    
    <img src="/ex/resources/img/hire/arrow.png" id="h-arrow">
    
      
    <h5 style="margin-top:40px; text-align: left;"><c:out value="${hireDtoList[0].hName}"/></h5>
    <h2 style="text-align: left;"><strong><c:out value="${hireDtoList[0].hTitle}"/></strong></h2>
    <br>
    <div >
        <div class="information" >
            <dl>
                <dt>경력</dt>
                <dd style="color:#2d65f2;"><c:out value="${hireDtoList[0].career}"/></dd>
            </dl>
            <dl>
                <dt>학력</dt>
                <dd style="color:#2d65f2;"><c:out value="${hireDtoList[0].education}"/></dd>
            </dl>
            <dl>
                <dt>근무형태</dt>
                <dd style="color:#2d65f2;"><c:out value="${hireDtoList[0].type}"/></dd>
            </dl>
        </div>
        
        <div class="information">
            <dl>
                <dt>급여</dt>
                <dd><c:out value="${hireDtoList[0].salary}"/></dd>
            </dl>
            <dl>
                <dt>근무일시</dt>
                <dd><c:out value="${hireDtoList[0].time}"/></dd>
            </dl>
            <dl>
                <dt>근무지역</dt>
                <dd><c:out value="${hireDtoList[0].location}"/></dd>
            </dl>
        </div>
    </div>
    <div>
        <c:forEach items="${hireDtoList}" var="hireDto">
            <img id="hire-image-정보${hireDto.hId}" src="/ex/resources/img/hire/정보${hireDto.hId}.JPG" style="margin-top:40px;">
        </c:forEach>
    </div>
</div>
</div>

<script>
  $(document).ready(function () {
    $('#h-arrow').on('click', function () {
      window.location.href = '/ex/hire/listAllHire';
    });
  });
</script>