<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
.custom-navbar {
	background-color: #d2e8ff;
}

ul#replies {
	list-style: none;
}

button {
	background-color: #d2e8ff;
	border: 1px solid #d2e8ff;
	border-radius: 10px;
	margin: 3px;
}

.mingu {
	float: left;
}

textarea {
	resize: none;
}

.thumbnail {
	max-width: 100px;
	max-height: 100px;
}
</style>

<script>
	var id = "${UBoardDto.id}";
	var rGroup = "${UReplyDto.rGroup}";
	var page = 1;

	$(document).ready(function() {

		var formObj = $("form[role='form']");
		console.log(formObj);

		$(".btn-modify").on("click", function() {
			formObj.attr("action", "/ex/uboard/modify");
			formObj.attr("method", "get");
			formObj.submit();
		});

		$(".btn-delete").on("click", function() {
			formObj.attr("action", "/ex/uboard/remove");
			formObj.submit();
		});

		$(".btn-list").on("click", function() {
			self.location = "/ex/uboard/listAll";
		});
		$(".btn-uLike").on("click", function() {
			formObj.attr("action", "/ex/uboard/uLike");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btn-reply").on("click", function() {
			formObj.attr("action", "/ex/uboard/reply");
			formObj.attr("method", "get");
			formObj.submit();
		});
		

		getPageList(page);
		/*댓글 등록 버튼*/

		$("#replyAddBtn").on("click", function() {
			var replyer = $("#newReplyeWriter").val();
			var rPw = $("#newrPw").val();
			var replytext = $("#newReplyText").val();
			
			console.log("replyer:", replyer);
			console.log("rPw:", rPw);
			console.log("replytext:", replytext);

			$.ajax({
				type : 'post',
				url : '/ex/ureplies',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : 'text',
				data : JSON.stringify({
					id : id,
					replyer : replyer,
					rPw : rPw,
					replytext : replytext,
					commentType : "COMMENT"
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("댓글이 등록됐습니다.");
						//화면에 찍는 작업
						getPageList(page);

						$("#newReplyeWriter").val("");
						$("#newrPw").val("");
						$("#newReplyText").val("");
					}
				},
				error: function (xhr, status, error) {
					console.error(xhr.responseText); // 에러 메시지 출력
				}
			})
		})

		/*대대댓글 등록 버튼*/
		$("#replies").on("click", ".rereplyAddBtn", function() {			
			var urId = $(".modal-title").html(); // 대댓글을 등록할 댓글의 urId 가져오기
			var replyer = $("#rereplyer").val();
			var rPw = $("#rerPw").val();
			var replytext = $("#rereplytext").val();

			$.ajax({
				type : 'post',
				url : '/ex/ureplies',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : 'text',
				data : JSON.stringify({
					id : id,
					urId : urId,
					replyer : replyer,
					rPw : rPw,
					replytext : replytext,
					commentType : "REPLY"
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("댓글이 등록됐습니다.");
						//화면에 찍는 작업
						getPageList(page);

						$("#rereplyer").val("");
						$("#rerPw").val("");
						$("#rereplytext").val("");
					}
				}
			});
		});

		/*댓글 수정 버튼*/
		$("#replies").on("click", ".replyModBtn", function() {

			var urId = $(this).closest('.modDiv').find(".modal-title").html();
			var rPw = $(this).closest('.modDiv').find("#rPw").val();
			var replytext = $(this).closest('.modDiv').find("#replytext").val();
			
			var a = '/ex/ureplies/' + urId;
			console.log("수정 주소",a);
			console.log("수정 rPw: ",rPw);	
			
			$.ajax({
				type : 'put',
				url : a,
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					rPw : rPw,
					replytext : replytext
				}),
				dataType : 'text',
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("비밀번호가 일치 하지 않습니다.");
						$(".modDiv").hide("slow");
						getPageList(page);
					}
					else {
						alert("비밀번호가 일치 하지 않습니다.");
						$(".modDiv").hide("slow");
						getPageList(page);
					}					
				}
			});
		});

		/*댓글 삭제 버튼*/
		$("#replies").on("click", ".replyDelBtn", function() {
			var urId = $(this).closest('.modDiv').find(".modal-title").html();
			var rPw = $(this).closest('.modDiv').find("#rPw").val();
			var a = '/ex/ureplies/' + urId;
			console.log("삭제 rPw: ",rPw);			
			
			$.ajax({
				type : 'delete',
				url : a,
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					rPw : rPw
				}),
				dataType : 'text',
				success : function(result) {
					if (result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						$(".modDiv").hide("slow");
						getPageList(page);
					}
					else{
						alert("비밀번호가 일치 하지 않습니다.");
						$(".modDiv").hide("slow");
						getPageList(page);
					}
				}
			});
		});
			
		/*댓글 창닫기 버튼*/
		$("#replies").on("click", ".modCloseBtn", function() {
			$(".modDiv").hide("fast");	
		});
		
		$("#replies").on("click", ".comCloseBtn", function() {	
			$(".comDiv").hide("fast");
		});


		/*댓글 mod 수정/삭제 버튼 .on(click 이벤트시 replyLi button만 실행시켜라)*/
		$("#replies").on("click", ".replyLi button", function() {
			var urId = $(this).parent().attr("data-urId");
			var rPw = $(this).parent().text();
			var replytext = $(this).parent().text();

			$(".modal-title").html(urId); // 밑에 body 안에 보면 div가 비어져잇음 그래서 .urId 해서 아이디값 넣게 해준거임
			$("#rPw").val("");
			$("#replytext").val("");

			$(".modDiv").hide("fast");

			$(this).parent().parent().find(".modDiv").show("fast");
		});

		
		/*대댓글등록 버튼 .on(click 이벤트시 commentLi button만 실행시켜라)*/
		$("#replies").on("click", ".commentLi button", function() {
			var urId = $(this).parent().attr("data-urId");
			$(".modal-title").html(urId);
			$(".comDiv").hide("fast");
			$(this).parent().parent().find(".comDiv").show("fast");
		})

		var fObject = $(".form");
		$(".pagination").on("click", "a", function(event) {
			event.preventDefault();
			page = $(this).attr("href");
			getPageList(page);
		})
		uploadListAll(); // 나갔다 들어와도 업로드한 파일 그대로 불러오는 함수 호출
	});

	/*댓글 등록 완료 후 실행*/
	function getPageList(page) {
		var str = "";

		$.getJSON("/ex/ureplies/" + id + "/" + page, function(data) {
					console.log(data);
					$(data.list).each(
							function() {
								var regdate = new Date(this.regdate); // 문자열을 Date 객체로 변환
							// 원하는 날짜 형식으로 포맷팅
							 var formattedDate = regdate
                                          .getFullYear()
                                          + "-"
                                          + padZero(regdate
                                                .getMonth() + 1)
                                          + "-"
                                          + padZero(regdate
                                                .getDate())
                                          + " "
                                          + padZero(regdate
                                                .getHours())
                                          + ":"
                                          + padZero(regdate
                                                .getMinutes())
                                          + ":"
                                          + padZero(regdate
                                                .getSeconds());

							// 기존의 str에 댓글 부분 추가
							str+="<li>"
                                    str += "<div data-urId='" + this.urId + "' class='replyLi' style=' width: calc(100% - " 
                                    + (this.rIndent * 30) + "px); margin-left: " + (this.rIndent * 30) + "px;'>";

								// rIndent가 0 이상인 경우에만 이미지를 삽입
								if (this.rIndent > 0) {
									str += "<img src='/ex/resources/img/arrow.png'><br>";
								}

								str += this.replyer+ " <br> "									
									+ this.replytext+ "<br> "
									+ formattedDate
									+ " <br><button class='mingu'>수정/삭제</button></div>"
									+ "<div data-urId='" + this.urId + "' class='commentLi'>"									
									+ " <button class='mingu'>답글등록</button></div>"
									+ "<div style='clear:both;'></div>"
									+ "<hr>"
									
									+ "<div class='modDiv' style='display: none'>"
									+ "<div class='modal-title'></div>"
									+ "<div>"
									+ "<input type='password' id='rPw' placeholder='비밀번호'style='width: 80px; height: 30px;'>"
									+ "</div>"
									+ "<div>"						
									+ "<textarea id='replytext' placeholder='수정 할 내용'style='width: 500px; height: 90px;'></textarea>"
									+ "</div>"
									+ "<div>"
									+ "<button type='button' class='replyModBtn'>수정</button>"
									+ "<button type='button' class='replyDelBtn'>삭제</button>"
									+ "<button type='button' class='modCloseBtn'>창 닫기</button>"
									+ "<hr></div></div>"		
									
									+ "<div class='comDiv' style='display: none'>"
									+ "<div class='modal-title'></div>"									
									+ "<div>"
									+ "<input type='text' id='rereplyer' placeholder='작성자'style='width: 100px;'>"
									+ "<input type='password' id='rPw' placeholder='비밀번호'style='width: 100px;'><br><br>"
									+ "<textarea id='rereplytext' placeholder='내용' style='width: 500px; height: 120px;'></textarea>"
									+"</div>"
									+ "<div>"
									+ "<button type='button' class='rereplyAddBtn'>등록</button>"
									+ "<button type='button' class='comCloseBtn'>창 닫기</button>"
									+"<hr></div></div>";	
									
									str += "</li>";
					});
					

					function padZero(num) {
						return num < 10 ? "0" + num : num;
					}

					/*위에 str에서 문자열로 만든 후 아래 str""에서 출력해 준다.*/
					$("#replies").html(str);
					str = "";
                     
                    if (data.uPageMaker.prev) {                                  	
                        str += "<a href='"
                              + (data.uPageMaker.startPage - 1)
                              + "'> << </a>";
                    }

                     for (var i = data.uPageMaker.startPage; i <= data.uPageMaker.endPage; i++) {                                        	 
                         var strClass = data.uPageMaker.page == i ? 'class=active'
                               : '';

                         str += "<a "+strClass+" href='"+i+"'>" + i
                               + "</a>";
                      }
                      if (data.uPageMaker.next) {                    
                         str += "<a href='"
                               + (data.uPageMaker.endPage + 1)
                               + "'> << </a>";
                      }                   
                      $(".pagination").html(str);
		});
	}
	
</script>

<!-- 카테고리 -->
<div class="row">
	<div class="side">
		<a href="/ex/uboard/listAll" class="right">전체글보기${pageValue }</a><br>
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
				<a href="/ex/uboard/listAll?uGroupKind=${item}">${item}</a><br>
			</c:if>
		</c:forEach><hr>
	</div>

	<div class="main" style="border: 1px solid #ddd; border-radius: 10px; ">

		<form role="form" method="post">
			<input type='hidden' name='id' value="${UBoardDto.id}"> 
			<input type='hidden' name='page' value="${UPageMaker.page}"> 
			<input type='hidden' name='perPageNum' value="${UPageMaker.perPageNum}">
			<input type='hidden' name='searchType' value="${UPageMaker.searchType}">
			<input type='hidden' name='keyword' value="${UPageMaker.keyword}">
		</form>

		<!--    controller에 read 부분을 보면 service.read 로 인해서 id 만 hidden으로 가져오면 -->
		<!--    굳이 나머지 content writer 같은거를 hidden으로 안가져와도 됨  controller 에서 read 보면 알 수 있음-->

		<!-- id 는 위에 input 에서 id hidden 으로 가져옴 -->

		<h5 style="color: green;">> ${UBoardDto.uGroupKind}</h5>

		<h1>${UBoardDto.uTitle}</h1>
		<div>
			<img src="/ex/resources/img/person_icon.png" width=40px>${UBoardDto.uName}<br>
			<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${UBoardDto.uWriteTime}" />
		</div>
		<hr>
		<div>${UBoardDto.uContent}</div>


		<!-- /.box-body -->
		<div class="box-footer">
			<button type="submit" class="btn btn-uLike"
				style="background-color: white;">♡ 좋아요 ${UBoardDto.uLike }</button>
			<hr>
			<button type="submit" class="btn btn-reply" style="background-color: lightblue;">답글</button>
				
			<button type="submit" class="btn btn-list" style="background-color: lightblue;">목록</button>
				
			<button type="submit" class="btn btn-modify" style="background-color: lightblue;">글 수정</button>
				
			<button type="submit" class="btn btn-delete" style="background-color: lightblue;">글 삭제</button>
		</div>
		<hr>

		<div class='fileDrop'>
			<p style="color: gray; width: 900px;">업로드 파일을 드래그 하시오.</p>
			<div class='uploadedList'></div>
		</div>
		<hr>

		<ul id="replies"></ul>

		<!--댓글 작성창 -->
		<div style="height: 250px; border: 1px solid #ddd; border-radius: 5px; padding: 10px; position: relative;">
			
			<div>
				<input type="text" name="replyer" id="newReplyeWriter" placeholder="작성자" style="width: 80px;" />
			</div>
			<div>
				<input type="password" name="rPw" id="newrPw" placeholder="비밀번호" style="width: 80px;" />
			</div>
			<br>
			<div>
				<textarea name="replytext" id="newReplyText" placeholder="댓글을 남겨보세요." style="width: 1000px; height: 120px;"></textarea>
			</div><br>

			<button id="replyAddBtn"
				style="position: absolute; bottom: 20px; right: 20px; margin-top:20px">댓글 등록</button>
		</div>
		<div class="pagination" style="text-align: center; margin-top: 10px;"></div>
	</div>
</div>

<!-- upload start-->
<style>
.fileDrop {
	width: 1000px;
	height: 100px;
	border: 1px dotted blue;
	overflow: auto; /* 스크롤이 필요한 경우 자동으로 스크롤이 나타납니다. */
}

small {
	margin-left: 3px;
	font-weight: bold;
	color: gray;
	cursor: pointer;
}

.thumbnail {
	max-width: 100px;
	max-height: 100px;
}
</style>


<!-- 파일업로드 -->
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
function uploadListAll() {
	var formData = new FormData();
	formData.append("id", "${UBoardDto.id}")


	$.ajax({
		url : "/ex/uallFile",
		type : "post",
		data : {
			"id" : "${UBoardDto.id}"
		},
		dataType : "text",
		success : function(result) {
			//alert(typeof result)
			result = eval(result);
				
			for (var i = 0; i < result.length; i++) {
				var data = result[i];
				var str = "";

				if (checkImageType(data)) {
					str = "<div><small data-src='"+data+"'>X&nbsp</small><a href='/ex/displayFile?fileName="
						+ getImageLink(data) + "''>"
						+ "<img src='/ex/displayFile?fileName="
						+ data + "'/>" + "</a></div>";
							
				} else {
					str = "<div><small data-src='"+data+"'>X&nbsp</small><a href='/ex/displayFile?fileName="
						+ data
						+ "'>"
						+ getOriginalName(data)
						+ "</a>" + "</div></div>";
				}
					
				$(".uploadedList").append(str);
			}
		}
	});
}

$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
});

$(".fileDrop").on(
		"drop",
		function(event) {
			event.preventDefault();
		
			var files = event.originalEvent.dataTransfer.files;
			console.log(files);

			var formData = new FormData();

			for (var a = 0; a < files.length; a++) {
				console.log(files[a]);
				formData.append("file", files[a]);
			};
			
			formData.append("id", "${UBoardDto.id}")
			
			$.ajax({
				url : '/ex/uuploadAjax',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					var fileNames = data.split(',');
					
					for (var i = 0; i < fileNames.length; i++) {
						var fileName = fileNames[i];

						var str = "";

						if (checkImageType(fileName)) {
							str = "<div></a><small data-src='"+fileName+"'>X</small><a href='/ex/displayFile?fileName="
								+ getImageLink(fileName)
								+ "''>"
								+ "<img src='/ex/displayFile?fileName="
								+ getImageLink(fileName)
								+ "'class='thumbnail'/>"
								+ "</div>";
						} else {
							str = "<div><small data-src='"+fileName+"'>X&nbsp</small><a href='/ex/displayFile?fileName="
							+ fileName
							+ "'>"
							+ getOriginalName(fileName)
							+ "</a>"
							+ "</div></div>";
						}					
						$(".uploadedList").append(str);
					}
				}
			});
		});

$(".uploadedList").on("click", "small", function(event) {

	var that = $(this);

	$.ajax({
		url : "/ex/udeleteFile",
		type : "post",
		data : {
			fileName : $(this).attr("data-src")
		},
		dataType : "text",
		success : function(result) {
			if (result == 'deleted') {
				that.parent("div").remove();
			}
		}
	});
});

function getOriginalName(fileName) {
	
	if (checkImageType(fileName)) {
		return;
	}
	var idx = fileName.indexOf("_") + 1;
	return fileName.substr(idx);
}

function getImageLink(fileName) {
	if (!checkImageType(fileName)) {
		return;
	}
		return fileName.replace("s_", "");
}
	
function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;
	
	return fileName.match(pattern);
}
</script>

<%@include file="../include/footer.jsp"%>