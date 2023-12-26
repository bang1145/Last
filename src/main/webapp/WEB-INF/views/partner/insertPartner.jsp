<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<script>
function pValidateForm() {
    // 필수 입력 필드 값을 가져옵니다.
    var pTitle = document.getElementsByName("pTitle")[0].value;
    var pContent = document.getElementsByName("pContent")[0].value;
    var pProgress = document.getElementsByName("progress")[0].value;
    var pPosition = document.getElementsByName("pPosition")[0].value;
    var pStack = document.getElementsByName("stack")[0].value;
    var pPersonnel = document.getElementsByName("personnel")[0].value;
    var pStartDate = document.getElementsByName("startDate")[0].value;
    var pExpectDate = document.getElementsByName("expectDate")[0].value;
    var pContact = document.getElementsByName("pContact")[0].value;
    var pUsername = document.getElementsByName("username")[0].value;
    
    // 각 필드가 비어있는지 확인합니다.
    if (pTitle === "" || pContent === "" || pProgress === "" || pPosition === "" || stack === ""
    		|| pPersonnel === "" || pStartDate === "" || pExpectDate === "" || pContact === "" || pUsername === "") {
    	
        // 경고창을 표시합니다.
        alert("제목, 내용, 작성자 중 하나라도 입력되지 않았습니다. 모든 항목을 입력해주세요.");
        return false; // 폼 전송을 막습니다.
    }
    // 유효성 검사가 통과한 경우 true를 반환하여 폼이 전송되도록 합니다.
    return true;
}

$('#pPosition').change(function() {
    var selectedValue = $(this).val();
    if (selectedValue !== null) {
        // 선택된 값이 있을 경우 해당 값을 표시
        console.log(selectedValue);
    }
});

$(document).ready(function() {
	var formObj = $("form[role='form']");
	console.log(formObj);
	$(".btn-cancle").on("click", function() {
		self.location = "/ex/partner/listPartner";
	});
	$(".btn-submit").on("click", function() {
		formObj.submit();
	});
});
</script>

<div id="pInsert">
<div style="margin-bottom:80px;">
<h2>1. 프로젝트 기본 정보를 입력해주세요.</h2>
<hr>
	<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
	<form role="form" method="post" onsubmit="return pValidateForm();">
	<table id="infoInput">
    <tr>
        <th>진행 방식</th>
        <td>
            <select name="progress" id="progress">
                <option id="online" value="online">online</option>
                <option id="offline" value="offline">offline</option>
                <option id="on/offline" value="on/offline">on/offline</option>
            </select>
        </td>
        <th>모집 포지션</th>
        <td>
            <select name="pPosition" id="pPosition" >
                <option id="frontend" value="frontend">frontend</option>
                <option id="backend" value="backend">backend</option>
                <option id="designer" value="designer">designer</option>
                <option id="ios" value="ios">ios</option>
                <option id="android" value="android">android</option>
                <option id="devOps" value="devOps">devOps</option>
                <option id="pm" value="pm">pm</option>
                <option id="planner" value="planner">planner</option>
            </select>
        </td>
    </tr>
    <tr>
        <th>모집 스택</th>
        <td>
            <select name="stack" id="stack" >
            	<option id="react" value="react">React</option>
            	<option id="ts" value="ts">ts</option>
                <option id="js" value="js">js</option>
                <option id="vue" value="vue">Vue</option>
                <option id="nextjs" value="nextjs">Nextjs</option>
                <option id="nodejs" value="nodejs">Nodejs</option>
                <option id="java" value="java">Java</option>
                <option id="spring" value="spring">spring</option>
                <option id="kotlin" value="kotlin">kotlin</option>
                <option id="nestjs" value="nestjs">nestjs</option>
                <option id="swift" value="swift">swift</option>
                <option id="flutter" value="flutter">flutter</option>
                <option id="figma" value="figma">figma</option>
            </select>
        </td>
        <th>모집인원</th>
        <td><input type="text" name="personnel" style="width:50px; margin-left:10px;">명</td>
    </tr>
    <tr>
        <th>모집 마감</th>
        <td><input type="date" name="startDate" style=" margin-left:10px;"></td>
        <th>진행 기간</th>
        <td><input type="text" name="expectDate" style="width:50px; margin-left:10px;">개월</td>
    </tr>
    <tr >
    	<th><img src="/ex/resources/img/partnerImg/talk.jpg"> 오픈톡</th>
        <td><input type="text" name="pContact" style="width:400px; text-align:left; margin-left:10px;"></td>
    </tr>
</table>

	</div>
	<div>
	<h2>2. 프로젝트에 대해 소개해주세요.</h2><hr>
		<p> <input type="text" name='pTitle' placeholder="제목을 입력하세요." style="width:100%; border: 1px solid #ddd;"></p> 		
		
		<p> <textarea name="pContent" rows="8" style="width:100%; border: 1px solid #ddd; resize: none;" placeholder="내용을 입력해주세요."></textarea></p>
		
		<p> <input type="text" name="username"  placeholder="닉네임"  style="width:200px; border: 1px solid #ddd;"></p>
		<div style="display: flex; float: left; ">		
		<button type="submit" class="btn-submit" style="margin-left:900px; margin-right:10px;">등록</button>
		<button type="submit" class="btn-cancle">취소</button>
	
	</div>	
	</form>
</div>