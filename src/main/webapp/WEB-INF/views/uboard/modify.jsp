<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />

<style>
textarea {
	resize: none;
}

 input {
    border: 1px solid #ddd; 
    margin:10px;
  }


  textarea {
    border: 1px solid #ddd; 
    margin:10px;
  }
</style>

<!-- 카테고리 -->
<div class="row">
	<div class="side">
		<a href="/ex/uboard/listAll" class="right">전체글보기</a><br>
		<hr>
		<a href="/ex/uboard/register" class="right">글쓰기</a><br>
		<hr>

		<c:forEach items="${category}" var="item">
			<c:if test="${item eq '공지사항'}">
				<img src='/ex/resources/img/noties.png'>
				<a href="/ex/uboard/listAll?uGroupKind=${item}">${item}</a>
				<br>
			</c:if>
		</c:forEach>
		<c:forEach items="${category}" var="item">
			<c:if test="${item ne '공지사항'}">
				<img src='/ex/resources/img/read.png'>
				<a href="/ex/uboard/listAll?uGroupKind=${item}">${item}</a>
				<br>
			</c:if>
		</c:forEach>
		<hr>
	</div>

  	<div class="mainregister" id="loading-main" style="border: 1px solid #ddd; border-radius: 10px; ">
  
		<form role="form" method="post">

		<h3 class="box-title">글 수정</h3><hr>
	
		<select name="uGroupKind" id="category" style="margin:10px; width:250px; height:35px;">
			<option value="board" disabled selected hidden>게시판을 선택해주세요.</option>
         	<option id="free" value="자유게시판">자유게시판</option>
          	<option id="hot" value="인기게시판">인기게시판</option>
          	<option id="humor" value="유머게시판">유머게시판</option>
          	<option id="advice" value="고민게시판">고민게시판</option>
     	</select>

		<div class="box-body">
			<h5>
			<input type="hidden" name='id' value="${uDto.id}" readonly="readonly">

			<input type="text" name='uTitle'  style="width:500px; height:35px; margin:10px;" value="${uBoardDto.uTitle}">
		
			<textarea  style="width:800px; height:300px; margin:10px;" name="uContent">${uBoardDto.uContent}</textarea>
			</h5><br>	
		</div>
	</form>
		
	<!-- /.box-body -->
		<div class="box-footer">
			<button type="submit" class="btn btn-save" style="background-color: lightblue;">등록</button>
			<button type="button" class="btn btn-list" style="background-color: lightblue;">취소</button>
		</div>
	
		<script>
			$(document).ready(function() {
				var formObj = $("form[role='form']");
				console.log(formObj);
				 $(".btn-list").on("click", function() {

				        var urlParams = new URLSearchParams(window.location.search);
				        var currentUGroup = urlParams.get('uGroup');
				        var currentUStep = urlParams.get('uStep');
				        var currentId = urlParams.get('id');
				        
				        if (currentBGroup !== null && currentBStep !== null) {
				            self.location = "/ex/uboard/read?uGroup=" + currentUGroup + "&uStep=" + (parseInt(currentUStep) - 1) + "&id=" + currentId;
				        } 
				        else {
				            self.location = "/ex/uboard/read?id=" + currentId;
				        }
				    });
			
				$(".btn-save").on("click", function() {
					formObj.submit();
				});
			});
		</script>
	</div>
</div>
		
<%@include file="../include/footer.jsp"%>