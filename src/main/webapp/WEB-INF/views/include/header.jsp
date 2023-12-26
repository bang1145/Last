<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Page Title</title>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
   </script>

<script>
// JavaScript 함수를 통해 로그아웃 알림을 표시
function showLogoutAlert() {
    alert("로그아웃 하였습니다.");
}

//로딩
document.addEventListener("DOMContentLoaded", function () {
    var loadingContainer = document.querySelector(".loading-container");
    var navbar = document.querySelector(".custom-navbar");
    var mainContent = document.querySelector("#main-content");

    loadingContainer.style.display = "flex";

    setTimeout(function () {
        loadingContainer.style.display = "none";
        navbar.style.display = "flex";
        mainContent.style.display = "block";
    }, 1500);
});


function showAlert() {
    Swal.fire({
        title: "준비 중인 서비스 입니다.",
        imageUrl: "/ex/resources/img/logo02.png", // 이미지 경로로 수정
        imageWidth: 80,
        imageHeight: 80,
        imageAlt: "Custom image",
        showCancelButton: true,
        cancelButtonColor: '#D2E8FF',  // 여기에 원하는 색상을 지정하세요
        cancelButtonText:'<span style="color: black;">확인</span>',
        showConfirmButton: false
    });
}
function searchTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("customers");
    tr = table.getElementsByTagName("tr");

    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[2]; // 여기서 [3]은 '이름' 열을 가리킵니다.
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

</script>
</head>

<body>

	<!-- 로딩 -->
	<div class="loading-container">
		<div class="loading"></div>
		<div id="loading-text">loading</div>
	</div>

	<!-- header -->
	<nav class="navbar navbar-expand-sm custom-navbar"
		style="display: none;">

		<div class="container-fluid mx-x1">
			<!-- Links -->
			<a href='/ex/board/main'><img src='/ex/resources/img/logo01.png'
				style='width: 200px; height: 50px;'></a> <b>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="/ex/board/searchNews?query=코딩">매거진</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/ex/board/listAll">게시판</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/ex/partner/listPartner">H-파트너</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/ex/hire/listAllHire">H-채용</a></li>
					<li class="nav-item"><a class="nav-link" href="/ex/study/studyListAll">스터디 </a></li>
					<li class="nav-item"><a class="nav-link" href="/ex/uboard/listAll">익명방</a></li>
					<li class="nav-item"><a class="nav-link" onclick="showAlert()">H-Talk</a>
					</li>
				</ul>
			</b>
			<!-- 로그인 및 회원가입 링크 -->
			<div>
				<sec:authorize access="!isAuthenticated()">
					<a href="/ex/admin/user/login">
						<button class="btn btn-outline-primary mx-2">로그인</button>
					</a>
					<a href="/ex/admin/user/insert">
						<button class="btn btn-outline-primary">회원가입</button>
					</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form:form action="${pageContext.request.contextPath}/admin/user/logout" method="POST"
					onsubmit="showLogoutAlert()">
						 <button class="btn btn-outline-primary mx-2" 
						 type="submit">로그아웃</button>
					</form:form>
					
				</sec:authorize>
				</a>
			</div>
		</div>
	</nav>

</body>
</html>