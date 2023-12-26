<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
   $(document).ready(function() {
      
      var formObj = $("form[role='form']");
      
      //목록
      $(".backList").on("click", function() {
            self.location = "/ex/partner/listPartner";
         });
      
      //삭제
       $(".delPartner").on("click", function() {
            formObj.attr("action", "/ex/partner/deletePartner");
            formObj.submit();
         });
      
      //수정
       $(".upPartner").on("click", function() {
            formObj.attr("action", "/ex/partner/updatePartner");
            formObj.attr("method", "get");
            formObj.submit();
         });
   })
</script>
<div class="sideMain">
<div class="readMain">
   
<div style="display: flex; align-items: center; margin-bottom:50px;">
    <div style="margin-right: 1000px;"><button type="submit" class="backList" ><img src="/ex/resources/img/partnerImg/back.png" ></button></div>
    <div style="margin-right: 10px;"><button type="submit" class="upPartner" ><img src="/ex/resources/img/partnerImg/edit.png" ></button></div>
    <form role="form" method="post">
        <input type='hidden' name='pId' value="${partnerDto.pId}">
        <div style="margin-right: 10px;"><button type="submit" class="delPartner" ><img src="/ex/resources/img/partnerImg/delete.png" ></button></div>
    </form>
</div>
   
   <h1>${partnerDto.pTitle}</h1>
   <p style="float:left;"><strong>${partnerDto.username}</strong></p>
   <p style="color:lightslategray;">&nbsp; | <fmt:formatDate pattern="yyyy-MM-dd" value="${partnerDto.writeDate}" /></p> 
   <hr>
   <table class="partnerTable">
      <tr>
         <td class="rCategory">모집 구분</td><td class="rCategory2">프로젝트</td>
         <td class="gap"></td>
         <td class="rCategory">진행방식</td><td class="rCategory2">${partnerDto.progress }</td>
      </tr>
      <tr>
         <td class="rCategory">모집 인원</td><td class="rCategory2">${partnerDto.personnel} 명</td>
         <td class="gap"></td>
         <td class="rCategory">시작 예정</td><td class="rCategory2"><fmt:formatDate pattern="yyyy-MM-dd" value="${partnerDto.startDate}" /></td>
      </tr>
      <tr>
         <td class="rCategory">연락 방법</td><td class="rCategory2">
            <a href="${partnerDto.pContact }"><img src="/ex/resources/img/partnerImg/talk.jpg"> 오픈톡</a></td>
         <td class="gap"></td>
         <td class="rCategory">예상 기간</td><td class="rCategory2">${partnerDto.expectDate} 개월</td>
      </tr>
      <tr>
         <td class="rCategory">모집 분야</td><td class="rCategory2">${partnerDto.pPosition }</td>
         <td class="gap"></td>
         <td class="rCategory">사용 언어</td><td class="rCategory2"><img style="width:50px;" class="partner-image" id="partner-image-${partnerDto.stack}" src="/ex/resources/img/partnerImg/languages/${partnerDto.stack}.svg"> ${partnerDto.stack}</td>
      </tr>
   </table>
   
   <h1>프로젝트 소개</h1><hr>
   <div class="rContent">${partnerDto.pContent}</div>
   
   <div style="display: flex; float: left; ">
      <button type="submit" class="backList" id="readButton" style="margin-left:850px;">목록</button>
      <button type="submit" class="upPartner" id="readButton" style="margin-left:10px;">수정</button>
      <button type="submit" class="delPartner" id="readButton" style="margin-left:10px;">삭제</button></div>
   
</div>
</div>