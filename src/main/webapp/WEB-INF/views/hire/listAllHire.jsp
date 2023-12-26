<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
   var result = '${msg}';
   if (result == 'success') {
      alert("처리가 완료되었습니다.");
   }

   function redirectToReadPage(hId) {
       // pId 값을 이용하여 페이지 이동 또는 다른 로직 수행
       window.location.href = '/ex/hire/readHire?hId=' + hId;
   }

   function toggleStar(element) {
         if (element.classList.contains('active')) {
           element.classList.remove('active');
           alert("스크랩이 취소되었습니다.");
       } else {
           element.classList.add('active');
           alert("스크랩되었습니다.");
       }
   }
   
    </script>


<h2 style="margin:30px 20px;"><strong>채용 정보</strong></h2>

<div id="partnermain" style="border: none; border-radius: 10px;" >
   <c:forEach items="${hireDto}" var="hireDto">
      <div class="hiremain" class="col-md-4" >
         <input type="hidden" value="${hireDto.hId}">
         <div class="h-div" onclick="redirectToReadPage(${hireDto.hId})">
            <img class="hire-image" id="hire-image-아이콘${hireDto.hId}" src="/ex/resources/img/hire/아이콘${hireDto.hId}.jpg">
            <p class="h-title"><strong>${hireDto.hTitle}</strong></p>
            <p class="h-Name">${hireDto.hName}</p>
            <p class="h-info"><img src="/ex/resources/img/hire/map1.png" style="height:20px;">
            ${hireDto.location} | ${hireDto.career} | ${hireDto.education}</p>
            <p class="h-info">${hireDto.salary}</p>
   
         </div>
         <div style="margin:2px 0px;">
           <span style="display: flex; justify-content: space-between; align-items: center;">
                <span style="display: flex; align-items: center;" >
            <span class="star" onclick="toggleStar(this)">☆</span>
                <span style="text-align: left;">관심등록</span>
                </span>
                <span class="h-endDate">~<fmt:formatDate pattern="yyyy-MM-dd" value="${hireDto.endDate}" /></span>
            </span>
         </div>
      </div>
   </c:forEach>
</div>