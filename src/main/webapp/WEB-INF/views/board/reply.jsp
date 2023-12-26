<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>

<script>
function validateForm() {
    // 필수 입력 필드 값을 가져옵니다.
    var title = document.getElementsByName("bTitle")[0].value;
    var content = document.getElementsByName("bContent")[0].value;
    var writer = document.getElementsByName("bName")[0].value;

    // 각 필드가 비어있는지 확인합니다.
    if (title === "" || content === "" || writer === "") {
        // 경고창을 표시합니다.
        alert("제목, 내용, 작성자 중 하나라도 입력되지 않았습니다. 모든 항목을 입력해주세요.");
        return false; // 폼 전송을 막습니다.
    }

    // 유효성 검사가 통과한 경우 true를 반환하여 폼이 전송되도록 합니다.
    return true;
}
</script>


<div class="mainregister">

	<div class="box-header">
		<h3 class="box-title">답글쓰기</h3>
	</div><br>
	<!-- /.box-header -->
	<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->


	<form role="form" action="/ex/board/reply" method="post" onsubmit="return validateForm();">
		<input type='hidden' name='bId' value="${boardDto.bId}"> 
		
			<div>[${boardDto.bGroupKind}]</div>
		<h2> 제목  
			<input type="text" name='bTitle' placeholder="제목을 입력해 주세요" style="width:100%">
		</h2> 
		<h2> 내용 
			<textarea name="bContent" rows="8" style="width:100%" placeholder="내용을 50자 이상 입력해 주세요."></textarea>
		</h2>
		<h2> 작성자 
			<input type="text" name="bName"  placeholder="작성자"  style="width:100%">
		</h2> 
		<!-- /.box-body -->
		<button type="submit" class="btn">답글등록</button>
	</form>

</div>

<%@include file="../include/footer.jsp"%>