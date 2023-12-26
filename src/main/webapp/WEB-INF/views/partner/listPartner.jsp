<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	var result = '${msg}';
	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}
	
	//파트너 글쓰기 버튼
	$(document).ready(function() {
		
		$(".pInsert-btn").on("click", function() {
			location.href = "/ex/partner/insertPartner"
		});
		
		//기술스택 버튼
		$('#showStackButton').on('click', function() {
            // div 요소의 표시 상태를 토글
            var stackDiv = $('.languages');
            $('.position, .pProgress').hide();
            stackDiv.toggle();
            
         // 해당 기술 스택에 맞는 데이터 필터링
//             filterData('stack');
        });
		
		//포지션 버튼
		$('#showPositonButton').on('click', function() {
            // div 요소의 표시 상태를 토글
            var positionDiv = $('.position');
            $('.languages, .pProgress').hide();
            positionDiv.toggle();
            
            // 해당 포지션에 맞는 데이터 필터링
            filterData('pPosition');
        });
		
		//진행 방식 버튼
		$('#showProgressButton').on('click', function() {
            // div 요소의 표시 상태를 토글
            var ProgressDiv = $('.pProgress');
            $('.languages, .position').hide();
            ProgressDiv.toggle();
            
         // 해당 진행 방식에 맞는 데이터 필터링
            filterData('pProgress');
        });
	});
	
	function redirectToReadPartnerPage(pId) {
        // pId 값을 이용하여 페이지 이동 또는 다른 로직 수행
        window.location.href = '/ex/partner/readPartner?pId=' + pId;
    }
	
	//버튼 애니메이션
	$(document).ready(function() {
	    $('.languages li').click(function() {
	        // 모든 li 요소에서 active 클래스 제거
	        $('.languages li').removeClass('active');

	        // 클릭한 li 요소에 active 클래스 추가
	        $(this).addClass('active');
	     
	    });
	    
	    
	    $('.position li').click(function() {
	        // 모든 li 요소에서 active 클래스 제거
	        $('.position li').removeClass('active2');
	        
	        // 클릭한 li 요소에 active 클래스 추가
	        $(this).addClass('active2');
	    });
	    
	    $('.pProgress li').click(function() {
	        // 모든 li 요소에서 active 클래스 제거
	        $('.pProgress li').removeClass('active3');
	        
	        // 클릭한 li 요소에 active 클래스 추가
	        $(this).addClass('active3');
	    });
	});
	
	//stack별 카테고리 분류
	$(document).ready(function() {
	    $('.languages li').click(function() {
	        // 선택한 언어의 ID 값을 가져옵니다.
	        var selectedLanguageId = $(this).attr('id');

	        // 프로젝트를 숨기고 선택한 언어에 해당하는 것만 보이도록 처리합니다.
	        $('.col-md-4').each(function() {
	            var projectStack = $(this).find('.partner-image').attr('id').split('-')[2];
	            
	            if (projectStack === selectedLanguageId) {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });
	    // 전체 버튼을 클릭할 때
	    $('#allStack').click(function() {
	        // 모든 프로젝트를 보이도록 처리합니다.
	        $('.col-md-4').show();
	    });
	    
	 // position 분류
	    $('.position li').click(function () {
	        // 선택한 언어의 ID 값을 가져옵니다.
	        var selectedPositionId = $(this).attr('id').toLowerCase();

	        // 프로젝트를 숨기고 선택한 언어에 해당하는 것만 보이도록 처리합니다.
	        $('.col-md-4').each(function () {
	            var projectPosition = $(this).find('#hihi').text().toLowerCase();

	            if (projectPosition === selectedPositionId || selectedPositionId === 'allposition') {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });

	    // 전체 버튼을 클릭할 때
	    $('#allPosition').click(function () {
	        // 모든 프로젝트를 보이도록 처리합니다.
	        $('.col-md-4').show();
	    });

	    
	 // progress 분류
	    $('.pProgress li').click(function () {
	        // 선택한 언어의 ID 값을 가져옵니다.
	        var selectedProgressId = $(this).attr('id').toLowerCase();

	        // 프로젝트를 숨기고 선택한 언어에 해당하는 것만 보이도록 처리합니다.
	        $('.col-md-4').each(function () {
	            var projectProgress = $(this).find('#header2').text().toLowerCase();

	            if (projectProgress === selectedProgressId || selectedProgressId === 'allprogress') {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });

	    // 전체 버튼을 클릭할 때
	    $('#allProgress').click(function () {
	        // 모든 프로젝트를 보이도록 처리합니다.
	        $('.col-md-4').show();
	    });
	});
</script>

	<div id="pWrite"><img src="/ex/resources/img/write.png"><a href="/ex/partner/insertPartner">새 글 쓰기</a></div><br>

<!-- 기술 스택 버튼 -->
	<button id="showStackButton">기술 스택 <img src="/ex/resources/img/partnerImg/languages/down.png"></button>
<!-- 포지션 버튼-->
	<button id="showPositonButton">포지션<img src="/ex/resources/img/partnerImg/languages/down.png"></button>
<!-- 진행 방식 버튼-->
	<button id="showProgressButton">진행 방식<img src="/ex/resources/img/partnerImg/languages/down.png"></button>
	<div class="languages" >
		<ul>
			<li id="allStack">
				<img src="/ex/resources/img/partnerImg/allmenu.svg">
    			<span>전체</span>
			</li>	
			<li id="react">
				<img src="/ex/resources/img/partnerImg/languages/react.svg">	
				<span >React</span>
			</li>
			<li id="ts">
				<img src="/ex/resources/img/partnerImg/languages/ts.svg">
				<span >TypeScript</span>
			</li>
			<li id="js">
				<img src="/ex/resources/img/partnerImg/languages/js.svg">
				<span>JavaScript</span>
			</li>
			<li id="vue">
				<img src="/ex/resources/img/partnerImg/languages/vue.svg">
				<span>Vue</span>
			</li>
			<li id="nextjs">
				<img src="/ex/resources/img/partnerImg/languages/nextjs.svg">
				<span>Nextjs</span>
			</li>
			<li id="nodejs">
				<img src="/ex/resources/img/partnerImg/languages/nodejs.svg">
				<span>Nodejs</span>
			</li>
			<li id="java">
				<img src="/ex/resources/img/partnerImg/languages/java.svg">
				<span>Java</span>
			</li>
			<li id="spring">
				<img src="/ex/resources/img/partnerImg/languages/spring.svg">
				<span>Spring</span>
			</li>
			<li id="kotlin">
				<img src="/ex/resources/img/partnerImg/languages/kotlin.svg">
				<span>Kotlin</span>
			</li>
			<li id="nestjs">
				<img src="/ex/resources/img/partnerImg/languages/nestjs.svg">
				<span>Nestjs</span>
			</li>
			<li id="swift">
				<img src="/ex/resources/img/partnerImg/languages/swift.svg">
				<span>Swift</span>
			</li>
			<li id="flutter">
				<img src="/ex/resources/img/partnerImg/languages/flutter.svg">
				<span>Flutter</span>
			</li>
			<li id="figma">
				<img src="/ex/resources/img/partnerImg/languages/figma.svg">
				<span>Figma</span>
			</li>
					
		</ul>
	</div>
	
	<!-- 포지션 옵션-->
	<div class="position"  >
		<ul>
			<li id="allPosition" >	
				<span >전체</span>
			</li>
			<li id="frontend">
				<span >frontend</span>
			</li>
			<li id="backend">
				<span >backend</span>
			</li>
			<li id="designer">
				<span >designer</span>
			</li>
			<li id="ios">
				<span >ios</span>
			</li>
			<li id="android">
				<span >android</span>
			</li>
			<li id="devOps">
				<span >devOps</span>
			</li>
			<li id="pm">
				<span >pm</span>
			</li>
			<li id="planner">
				<span >planner</span>
			</li>			
		</ul>
	</div>
	
	<!-- 진행 방식 옵션 -->
	<div class ="pProgress" >
		<ul>
			<li id="allProgress">	
				<span>전체</span>
			</li>
			<li id="online">
				<span >online</span>
			</li>
			<li id="offline">
				<span >offline</span>
			</li>
			<li id="on/offline">
				<span >on/offline</span>
			</li>			
		</ul>
	</div>
	
	<div id="partnermain" class="container">		
	    <c:forEach items="${partnerDto}" var="dto">
	        <div id="partnermain2" class="col-md-4" onclick="redirectToReadPartnerPage(${dto.pId})">
	            <input type="hidden" value="${dto.pId}">
	            <div id="p-div">
	                <p id="header1">프로젝트</p><p id="header2">${dto.progress}</p>
	                <p id="endDateH">마감일 | <fmt:formatDate pattern="yyyy-MM-dd" value="${dto.startDate}" /></p>
	                <p id="p-title">${dto.pTitle}</p>
	                <p id="hihi">${dto.pPosition}</p><br>
	                <img style="width:50px;" class="partner-image" id="partner-image-${dto.stack}" src="/ex/resources/img/partnerImg/languages/${dto.stack}.svg">
	                <hr id="p-hr">
	                <p id="p-username">${dto.username}</p>
	                <span><img style="width:25px;" src="/ex/resources/img/partnerImg/hit.png"> ${dto.pHit}</span>
	            </div>
	        </div>	  
	    </c:forEach>
	</div>