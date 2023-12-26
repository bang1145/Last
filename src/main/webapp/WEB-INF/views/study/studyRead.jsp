<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css"
   href="/ex/resources/css/template.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/hh.css" />
<link rel="stylesheet" type="text/css" href="/ex/resources/css/study.css" />
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script>
   var sId = "${studyDto.sId}";
   var sGroup = "${parentDto.sGroup}";
   var page = 1;
   
   $(document).ready(function() {

      var formObj = $("form[role='form']");

      console.log(formObj);

      $(".btn-warning").on("click", function() {
         formObj.attr("action", "/ex/study/studyModify");
         formObj.attr("method", "get");
         formObj.submit();
      });

      $(".btn-danger").on("click", function() {
         formObj.attr("action", "/ex/study/studyRemove");
         formObj.submit();
      });

      $(".btn-primary").on("click", function() {
         self.location = "/ex/study/studyListAll";
      });
      $(".btn-bLike").on("click", function() {
         formObj.attr("action", "/ex/study/sLike");
         formObj.attr("method", "get");
         formObj.submit();
      });
      $(".btn-reply").on("click", function() {
         formObj.attr("action", "/ex/study/studyReply");
         formObj.attr("method", "get");
         formObj.submit();
      });

      getPageList(page);
      /*댓글 등록 버튼*/
      
      $("#replyAddBtn").on("click", function() {
         var sReplyer = $("#newReplyeWriter").val();
         var sReplytext = $("#newReplyText").val();

         $.ajax({
            type : 'post',
            url : '/ex/studyreplies',
            headers : {
               "Content-Type" : "application/json"
            },
            dataType : 'text',
            data : JSON.stringify({
               sId : sId,
               sReplyer : sReplyer,
               sReplytext : sReplytext,
               commentType : "COMMENT"
            }),
            success : function(result) {
               if (result == 'SUCCESS') {
                  alert("댓글이 등록됐습니다.");
                  //화면에 찍는 작업
                  getPageList(page);

                  $("#newReplyeWriter").val("");
                  $("#newReplyText").val("");
               }
            }
         })
      })
 
      /*대대댓글 등록 버튼*/
       $("#studyreplies").on("click", ".rereplyAddBtn", function() {
//       $(".rereplyAddBtn").on("click", function() {
         var sRId = $(".modal-title").html(); // 대댓글을 등록할 댓글의 sRId 가져오기
         var sReplyer = $("#rereplyer").val();
         var sReplytext = $("#rereplytext").val();
//          var rGroup = $("#rerGroup").val();

         $.ajax({
            type : 'post',
            url : '/ex/studyreplies',
            headers : {
               "Content-Type" : "application/json"
            },
            dataType : 'text',
            data : JSON.stringify({
               sId : sId,
               sRId : sRId,
//                rGroup : rGroup, 추가함
               sReplyer : sReplyer,
               sReplytext : sReplytext,
               commentType : "REPLY"
            }),
            success : function(result) {
               if (result == 'SUCCESS') {
                  alert("댓글이 등록됐습니다.");
                  //화면에 찍는 작업
                  getPageList(page);

                  $("#rereplyer").val("");
                  $("#rereplytext").val("");
               }
            }
         })
      })


      /*댓글 수정 버튼*/
      $("#studyreplies").on("click", ".replyModBtn", function() {
//       $(".replyModBtn").on("click", function() {

         var sRId = $(".modal-title").html();
         var sReplytext = $("#replytext").val();

         $.ajax({
            type : 'put',
            url : '/ex/studyreplies/' + sRId,
            headers : {
               "Content-Type" : "application/json"
            },
            data : JSON.stringify({
               sReplytext : sReplytext
            }),
            dataType : 'text',
            success : function(result) {
               if (result == 'SUCCESS') {
                  alert("수정 되었습니다.");
                  $(".modDiv").hide("slow");

                  getPageList(page);
               }
            }
         })
      })

      /*댓글 삭제 버튼*/
       $("#studyreplies").on("click", ".replyDelBtn", function() {
//       $(".replyDelBtn").on("click", function() {
         var sRId = $(".modal-title").html();
         $.ajax({
            type : 'delete',
            url : '/ex/studyreplies/' + sRId,
            headers : {
               "Content-Type" : "application/json"
            },
            dataType : 'text',
            success : function(result) {
               if (result == 'SUCCESS') {
                  alert("삭제 되었습니다.");
                  $(".modDiv").hide("slow");
                  getPageList(page);
               }
            }
         })
      })
      /*댓글 창닫기 버튼*/
       $("#studyreplies").on("click", ".modCloseBtn", function() {
          //alert('a');
            $(".modDiv").hide("fast");
             //       $("#comDiv").hide("fast");
          })
   /*    $(".modCloseBtn").on("click", function() {
        // $(this).parent().parent().hide("fast");
         $("#modDiv").hide("fast");
         //       $("#comDiv").hide("fast");
      }) */
      $("#studyreplies").on("click", ".comCloseBtn", function() {
//       $("#comCloseBtn").on("click", function() {
         $(".comDiv").hide("fast");
      })


      $("#studyreplies").on("click", ".replyLi button", function() {
         var sRId = $(this).parent().attr("data-sRId");
         var sReplytext = $(this).parent().text();

         $(".modal-title").html(sRId); // 밑에 body 안에 보면 div가 비어져잇음 그래서 .sRId 해서 아이디값 넣게 해준거임
         $("#replytext").val("");
         
         $(".modDiv").hide("fast");
         
         $(this).parent().parent().find(".modDiv").show("fast");
      })


  
      /*대댓글등록 버튼 .on(click 이벤트시 commentLi button만 실행시켜라)*/
      $("#studyreplies").on("click", ".commentLi button", function() {
         var sRId = $(this).parent().attr("data-sRId");

         $(".modal-title").html(sRId);

//          $(".comDiv").show("fast");
         $(".comDiv").hide("fast");
         $(this).parent().parent().find(".comDiv").show("fast");
      })

      var fObject = $(".form");
      $(".pagination").on("click", "a", function(event) {
         event.preventDefault();
         page = $(this).attr("href");
         getPageList(page);

      })
      uploadListAll();
   });   


   /*댓글 등록 완료 후 실행*/
   function getPageList(page) {
      var str = "";
      $
            .getJSON(
                  "/ex/studyreplies/" + sId + "/" + page,
                  function(data) {
                     console.log(data);
                     $(data.list)
                           .each(
                                 function() {
                                    
                                    var sRegdate = new Date(
                                          this.sRegdate); // 문자열을 Date 객체로 변환

                                    // 원하는 날짜 형식으로 포맷팅
                                    var formattedDate = sRegdate
                                          .getFullYear()
                                          + "-"
                                          + padZero(sRegdate
                                                .getMonth() + 1)
                                          + "-"
                                          + padZero(sRegdate
                                                .getDate())
                                          + " "
                                          + padZero(sRegdate
                                                .getHours())
                                          + ":"
                                          + padZero(sRegdate
                                                .getMinutes())
                                          + ":"
                                          + padZero(sRegdate
                                                .getSeconds());

                                    
                                    // 기존의 str에 댓글 부분 추가
                                    str+="<li>"
                                    str += "<div data-sRId='" + this.sRId + "' class='replyLi' style=' width: calc(100% - " 
                                    + (this.sIndent * 30) + "px); margin-left: " + (this.sIndent * 30) + "px;'>";

                              // rIndent가 0 이상인 경우에만 이미지를 삽입
                              if (this.sIndent > 0) {
                                  str += "<img src='/ex/resources/img/arrow.png'><br>";
                              }

                              str += this.sReplyer 
                              + " <br> "
                              + this.sReplytext
                              + "<br> "
                              + formattedDate
                              + " <br><button class='mingu'>수정/삭제</button></div>"
                              + "<div data-sRId='" + this.sRId + "' class='commentLi'>"
                              + " <button class='mingu'>답글등록</button></div>"
                              + "<div style='clear:both;'></div>"
                              + "<hr>"
                                    
                                    
                                    +"<div class='modDiv' style='display: none'>" +
                                    "<div class='modal-title'></div>" +
                                    "<div>" +
                                    "<input type='text' id='replytext'><br><br>" +
                                    "</div>" +
                                    "<div>" +
                                    "<button type='button' class='replyModBtn'>수정</button>&nbsp;" +
                                    "<button type='button' class='replyDelBtn'>삭제</button>&nbsp;" +
                                    "<button type='button' class='modCloseBtn'>창 닫기</button>" +
                                    "<hr>" +
                                    "</div>" +
                                    "</div>" 
                                    
                                    + "<div class='comDiv' style='display: none'>" +
                                    "<div class='modal-title'></div>" +
                                    "<div>" +
                                    "<input type='text' id='rereplyer' placeholder='작성자'style='width: 80px;'><br><br>" +
                                    "<textarea id='rereplytext' placeholder='내용' style='width: 800px; height: 120px;'></textarea>" +
                                    
                                    
                                    "</div>" +
                                    "<div>" +
                                    "<button type='button' class='rereplyAddBtn'>등록</button>&nbsp;" +
                                    "<button type='button' class='comCloseBtn'>창 닫기</button>" +
                                    
                                    "<hr>" +
                                    "</div>" +
                                    "</div>";
                                    str+="</li>";
                                      
                                          
                                    

                                 });

                   

                     function padZero(num) {
                        return num < 10 ? "0" + num : num;
                     }
                   
                     /*위에 str에서 문자열로 만든 후 아래 str""에서 출력해 준다.*/
                     $("#studyreplies").html(str);
                     str = "";
                     
                     if (data.studyPageMaker.prev) {
                        str += "<a href='"
                              + (data.studyPageMaker.startPage - 1)
                              + "'> << </a>";
                     }

                     for (var i = data.studyPageMaker.startPage; i <= data.studyPageMaker.endPage; i++) {
                        var strClass = data.studyPageMaker.page == i ? 'class=active'
                              : '';

                        str += "<a "+strClass+" href='"+i+"'>" + i
                              + "</a>";
                     }
                     if (data.studyPageMaker.next) {
                        str += "<a href='"
                              + (data.studyPageMaker.endPage + 1)
                              + "'> << </a>";
                     }
                     //alert(str);
                     $(".pagination").html(str);

                  })
   }
</script>




<!-- 카테고리 -->
<div class="row">
   <div class="side1">
      <a href="/ex/study/studyListAll" class="right">전체글보기</a><br>
      <hr>
      <a href="/ex/study/studyRegister" class="right">글쓰기</a><br>
      <hr>
      <c:forEach items="${category}" var="item">
         <c:if test="${item ne '공지사항'}">
            <a href="/ex/study/studyListAll?sGroupKind=${item}">${item}</a>
            <br>
         </c:if>
      </c:forEach>
      <hr>
   </div>
<style>
.main1 {
    width: 900px;
    margin: 0 auto;
  }
</style>
   <div class="main1">

      <form role="form" method="post">
         <input type='hidden' name='sId' value="${studyDto.sId}"> <input
            type='hidden' name='page' value="${studyPageMaker.page}"> <input
            type='hidden' name='perPageNum' value="${studyPageMaker.perPageNum}">
         <input type='hidden' name='searchType'
            value="${studyPageMaker.searchType}"> <input type='hidden'
            name='keyword' value="${studyPageMaker.keyword}">
      </form>

      <!--    controller에 read 부분을 보면 service.read 로 인해서 id 만 hidden으로 가져오면 -->
      <!--    굳이 나머지 content writer 같은거를 hidden으로 안가져와도 됨  controller 에서 read 보면 알 수 있음-->

      <!-- id 는 위에 input 에서 id hidden 으로 가져옴 -->

      <span style="color: gray; font-size: 14px;">> ${studyDto.sGroupKind}</span>

      <h1 style="font-weight:bold;">${studyDto.sTitle}</h1><br>
      <div>
      <img src="/ex/resources/img/writer.png" style="width: 40px; height: 40px;">
         <span style="font-size: 18px; font-weight: bold;">${studyDto.sName}</span>
    <span style="font-size: 12px;">
        <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${studyDto.sWriteTime}" />
    </span>
         
<%--          ${studyDto.sName} --%>
<%--          <fmt:formatDate pattern="yyyy-MM-dd HH:mm" --%>
<%--             value="${studyDto.sWriteTime}" /> --%>
      </div><br><br>
      
      <div style="font-size:20px;">${studyDto.sContent}</div><br><br>


      <!-- /.box-body -->
      <div class="box-footer" style="text-align: right;">
         <button type="submit" class="btn btn-bLike"
            style="background-color: white;"><img src="/ex/resources/img/like.png"
                     style="width: 30px; height: 25px;">좋아요 ${studyDto.sLike }</button>
                     <img src="/ex/resources/img/eye.png"
                     style="width: 30px; height: 20px;">  조회수 ${studyDto.sHit }
         <hr>
         <div class="buttonContainer">
         <button type="submit" class="btn btn-reply">답글</button>&nbsp;&nbsp;
         <button type="submit" class="btn btn-warning">수정</button>&nbsp;&nbsp;
         <button type="submit" class="btn btn-danger">삭제</button></div>

      </div>
      <hr>
<div class='fileDrop'>업로드할 파일을 드래그 해주세요 !</div>

   <div class='uploadedList'></div>
      <hr>

      <ul id="studyreplies"></ul>
<style>

#studyreplies {
    list-style: none;
}
/* 대댓글버튼스타일 */
.replyModBtn,
.replyDelBtn,
.modCloseBtn,
.rereplyAddBtn,
.comCloseBtn {
  padding: 0 1.25rem;
  font-weight: 700;
  font-size: 1rem;
  background-color: #262626;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.replyModBtn:hover,
.replyDelBtn:hover,
.modCloseBtn:hover,
.rereplyAddBtn:hover,
.comCloseBtn:hover {
  background-color: #D2E8FF;
  color: black;
}
.mingu
 {
  padding: 0 1.25rem;
  font-weight: 700;
  font-size: 1rem;
  background-color: #262626;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: left;
  margin: 2.5px;
}

.mingu:hover {
  background-color: #D2E8FF;
  color: black;
}      
</style>

      <!--댓글 작성창 -->
      <div
         style="height: 350px; border: 1px solid #ddd; border-radius: 5px; padding: 10px; position: relative;">
         <div><img src="/ex/resources/img/writer.png" style="width: 40px; height: 40px;">
            <input type="text" name="replyer" id="newReplyeWriter"
               placeholder="작성자" style="width: 80px;" />
         </div>
         <br>
         <div>
            <textarea name="replytext" id="newReplyText"
               placeholder="댓글을 남겨보세요." style="width: 800px; height: 120px;">
               </textarea>
         </div>
         <div class="buttonContainer">
                  <button id="replyAddBtn">댓글
                     등록</button></div>
               </div>
               <div class="pagination" style="text-align: center; margin-top: 10px;"></div>
      </div>
   </div>

   <!-- upload start-->
   <style>

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
   formData.append("sId", "${studyDto.sId}")


   $.ajax({
      url : "/ex/StudyallFile",
      type : "post",
      data : {
         "sId" : "${studyDto.sId}"
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
         
         formData.append("sId", "${studyDto.sId}")
         
         $.ajax({
            url : '/ex/StudyUploadAjax',
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
      url : "/ex/StudydeleteFile",
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
      return ;
   }
      return fileName.replace("s_", "");
}
   
function checkImageType(fileName) {
   var pattern = /jpg|gif|png|jpeg/i;
   
   return fileName.match(pattern);
}
</script>

   <%@include file="../include/footer.jsp"%>