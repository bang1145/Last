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
        
 ul#replies{
    list-style:none;
 }
 
 button{
 	background-color:#d2e8ff;
 	border: 1px solid #d2e8ff;
 	 border-radius:10px;
 	 margin: 3px;
 }
 
 .mingu{
 	float:left;
 	
 }
 

 textarea {
    resize: none;
}
 
 
 
 
</style>
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script>
   var bId = "${boardDto.bId}";
   var rGroup = "${parentDto.rGroup}";
   var page = 1;
   
   $(document).ready(function() {

      var formObj = $("form[role='form']");

      console.log(formObj);

      $(".btn-warning").on("click", function() {
         formObj.attr("action", "/ex/board/modify");
         formObj.attr("method", "get");
         formObj.submit();
      });

      $(".btn-danger").on("click", function() {
         formObj.attr("action", "/ex/board/remove");
         formObj.submit();
      });

      $(".btn-primary").on("click", function() {
         self.location = "/ex/board/listAll";
      });
      $(".btn-bLike").on("click", function() {
         formObj.attr("action", "/ex/board/bLike");
         formObj.attr("method", "get");
         formObj.submit();
      });
      $(".btn-reply").on("click", function() {
         formObj.attr("action", "/ex/board/reply");
         formObj.attr("method", "get");
         formObj.submit();
      });

      getPageList(page);
      /*댓글 등록 버튼*/
      
      $("#replyAddBtn").on("click", function() {
         var replyer = $("#newReplyeWriter").val();
         var replytext = $("#newReplyText").val();

         $.ajax({
            type : 'post',
            url : '/ex/replies',
            headers : {
               "Content-Type" : "application/json"
            },
            dataType : 'text',
            data : JSON.stringify({
               bId : bId,
               replyer : replyer,
               replytext : replytext,
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
       $("#replies").on("click", ".rereplyAddBtn", function() {
//       $(".rereplyAddBtn").on("click", function() {
         var rId = $(".modal-title").html(); // 대댓글을 등록할 댓글의 rId 가져오기
         var replyer = $("#rereplyer").val();
         var replytext = $("#rereplytext").val();
//          var rGroup = $("#rerGroup").val();

         $.ajax({
            type : 'post',
            url : '/ex/replies',
            headers : {
               "Content-Type" : "application/json"
            },
            dataType : 'text',
            data : JSON.stringify({
               bId : bId,
               rId : rId,
//                rGroup : rGroup, 추가함
               replyer : replyer,
               replytext : replytext,
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
      $("#replies").on("click", ".replyModBtn", function() {
//       $(".replyModBtn").on("click", function() {

         var rId = $(".modal-title").html();
         var replytext = $("#replytext").val();

         $.ajax({
            type : 'put',
            url : '/ex/replies/' + rId,
            headers : {
               "Content-Type" : "application/json"
            },
            data : JSON.stringify({
               replytext : replytext
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
       $("#replies").on("click", ".replyDelBtn", function() {
//       $(".replyDelBtn").on("click", function() {
         var rId = $(".modal-title").html();
         $.ajax({
            type : 'delete',
            url : '/ex/replies/' + rId,
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
       $("#replies").on("click", ".modCloseBtn", function() {
          //alert('a');
            $(".modDiv").hide("fast");
             //       $("#comDiv").hide("fast");
          })
   /*    $(".modCloseBtn").on("click", function() {
        // $(this).parent().parent().hide("fast");
         $("#modDiv").hide("fast");
         //       $("#comDiv").hide("fast");
      }) */
      $("#replies").on("click", ".comCloseBtn", function() {
//       $("#comCloseBtn").on("click", function() {
         $(".comDiv").hide("fast");
      })

      //    /*댓글 mod 수정/삭제 버튼 .on(click 이벤트시 replyLi button만 실행시켜라)*/ 이거 순정임
      //    $("#replies").on("click",".replyLi button",function(){
      //       var rId=$(this).parent().attr("data-rId");
      //       var replytext=$(this).parent().text();
      //       $(".modal-title").html(rId);
      //       $("#replytext").val("");
      //       $("#modDiv").show("slow");
      //    })

      /*댓글 mod 수정/삭제 버튼 .on(click 이벤트시 replyLi button만 실행시켜라)*/
      $("#replies").on("click", ".replyLi button", function() {
         var rId = $(this).parent().attr("data-rId");
         var replytext = $(this).parent().text();

         $(".modal-title").html(rId); // 밑에 body 안에 보면 div가 비어져잇음 그래서 .rId 해서 아이디값 넣게 해준거임
         $("#replytext").val("");
         
         $(".modDiv").hide("fast");
         
         $(this).parent().parent().find(".modDiv").show("fast");
      })

      /*대댓글등록 버튼 .on(click 이벤트시 commentLi button만 실행시켜라)*/
      //       replies 의 정확한 뜻을 잘 몰겠다 ;;
      $("#replies").on("click", ".commentLi button", function() {
         var rId = $(this).parent().attr("data-rId");

         $(".modal-title").html(rId);

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
      
     

   });


   /*댓글 등록 완료 후 실행*/
   function getPageList(page) {
      var str = "";
//       4294/1

      $
            .getJSON(
                  "/ex/replies/" + bId + "/" + page,
                  function(data) {
                     console.log(data);
                     $(data.list)
                           .each(
                                 function() {
                                    
                                    var regdate = new Date(
                                          this.regdate); // 문자열을 Date 객체로 변환

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
                                    str += "<div data-rId='" + this.rId + "' class='replyLi' style=' width: calc(100% - " 
                                    + (this.rIndent * 30) + "px); margin-left: " + (this.rIndent * 30) + "px;'>";

                              // rIndent가 0 이상인 경우에만 이미지를 삽입
                              if (this.rIndent > 0) {
                                  str += "<img src='/ex/resources/img/arrow.png'><br>";
                              }

                              str += this.replyer 
                                    + " <br> "
                                    + this.replytext
                                    + "<br> "
                                    + formattedDate
                                    + " <br><button class='mingu'>수정/삭제</button></div>"
                                    + "<div data-rId='" + this.rId + "' class='commentLi'>"
                                    + " <button class='mingu'>답글등록</button></div>"
                                    + "<div style='clear:both;'></div>"
                                    + "<hr>"
                                    
                                    
                                    +"<div class='modDiv' style='display: none'>" +
                                    "<div class='modal-title'></div>" +
                                    "<div>" +
                                    "<input type='text' id='replytext'>" +
                                    "</div>" +
                                    "<div>" +
                                    "<button type='button' class='replyModBtn'>수정</button>" +
                                    "<button type='button' class='replyDelBtn'>삭제</button>" +
                                    "<button type='button' class='modCloseBtn'>창 닫기</button>" +
                                    "<hr>" +
                                    "</div>" +
                                    "</div>" 
                                    
                                    + "<div class='comDiv' style='display: none'>" +
                                    "<div class='modal-title'></div>" +
                                    "<div>" +
                                    "<input type='text' id='rereplyer' placeholder='작성자'style='width: 100px;'><br><br>" +
                                    "<textarea id='rereplytext' placeholder='내용' style='width: 1000px; height: 120px;'></textarea>" +
                                    
                                    
                                    "</div>" +
                                    "<div>" +
                                    "<button type='button' class='rereplyAddBtn'>등록</button>" +
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
                     $("#replies").html(str);
                     str = "";
                     
                     if (data.pageMaker.prev) {
                        str += "<a href='"
                              + (data.pageMaker.startPage - 1)
                              + "'> << </a>";
                     }

                     for (var i = data.pageMaker.startPage; i <= data.pageMaker.endPage; i++) {
                        var strClass = data.pageMaker.page == i ? 'class=active'
                              : '';

                        str += "<a "+strClass+" href='"+i+"'>" + i
                              + "</a>";
                     }
                     if (data.pageMaker.next) {
                        str += "<a href='"
                              + (data.pageMaker.endPage + 1)
                              + "'> << </a>";
                     }
                     //alert(str);
                     $(".pagination").html(str);

                  })
   }
</script>




<!-- 카테고리 -->
<div class="row">
  <div class="side">
   <a href="/ex/board/listAll" class="right">전체글보기</a><br><hr>
   <a href="/ex/board/register" class="right">글쓰기</a><br><hr>
 
   <c:forEach items="${category}" var="item">
    <c:if test="${item eq '공지사항'}">
      <img src='/ex/resources/img/noties.png'><a href="/ex/board/listAll?bGroupKind=${item}">${item}</a><br>
   </c:if>
   </c:forEach>
   <c:forEach items="${category}" var="item">
   <c:if test="${item ne '공지사항'}">
      <img src='/ex/resources/img/read.png'><a href="/ex/board/listAll?bGroupKind=${item}">${item}</a><br>
   </c:if>
    </c:forEach>
     <hr>
  </div>
 
<div class="main" style="border: 1px solid #ddd; border-radius: 10px;">

   <form role="form" method="post">
      <input type='hidden' name='bId' value="${boardDto.bId}"> <input
         type='hidden' name='page' value="${pageMaker.page}"> <input
         type='hidden' name='perPageNum' value="${pageMaker.perPageNum}">
      <input type='hidden' name='searchType' value="${pageMaker.searchType}">
      <input type='hidden' name='keyword' value="${pageMaker.keyword}">
   </form>

   <!--    controller에 read 부분을 보면 service.read 로 인해서 id 만 hidden으로 가져오면 -->
   <!--    굳이 나머지 content writer 같은거를 hidden으로 안가져와도 됨  controller 에서 read 보면 알 수 있음-->

   <!-- id 는 위에 input 에서 id hidden 으로 가져옴 -->

   <h5 style="color: green;">> ${boardDto.bGroupKind}</h5>

   <h1>${boardDto.bTitle}</h1>
   <div>
      <img src="/ex/resources/img/person_icon.png" width=40px>
      ${boardDto.bName}<br>
      <fmt:formatDate pattern="yyyy-MM-dd HH:mm"
         value="${boardDto.bWriteTime}" />
   </div>
   <hr>
   <div>${boardDto.bContent}</div>


   <!-- /.box-body -->
   <div class="box-footer">
      <button type="submit" class="btn btn-bLike"
         style="background-color: white;">♡ 좋아요 ${boardDto.bLike }</button>
      <hr>
      <button type="submit" class="btn btn-reply"
         style="background-color: lightblue;">답글</button>
      <button type="submit" class="btn btn-warning"
         style="background-color: lightblue;">글 수정</button>
      <button type="submit" class="btn btn-danger"
         style="background-color: lightblue;">글 삭제</button>

   </div>
   <hr>

<div class='fileDrop'>
   <p style="color:gray; width:900px;">업로드 파일을 드래그 하시오.</p>
   <div class='uploadedList'></div></div>
   <hr>
   
   
   <ul id="replies"></ul>




   






<!--댓글 작성창 -->
   <div
      style="height: 400px; border: 1px solid #ddd; border-radius: 5px; padding: 10px; position: relative;">
      <div>
         <input type="text" name="replyer" id="newReplyeWriter"
            placeholder="작성자" style="width: 80px;" />
      </div>
      <br>
      <div>
         <textarea name="replytext" id="newReplyText" placeholder="댓글을 남겨보세요."
            style="width: 1000px; height: 120px;"></textarea>
      </div>
      <br>
      
         
   
      <button id="replyAddBtn"
         style="position: absolute; bottom: 20px; right: 20px;">댓글 등록</button>
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
   cursor:pointer;
}

.thumbnail {
	max-width: 100px;
  	max-height: 100px;
}


</style>


<!-- 파일업로드 -->
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
   <script>
 
	   
   function uploadListAll(){
      var formData = new FormData();
      formData.append("bId","${boardDto.bId}")
   
      /* $(".uploadedList").on("click", "small", function(event){
         
          var that = $(this);
       */
       
         $.ajax({
            url:"/ex/allFile",
            type:"post",
            data: {"bId":"${boardDto.bId}"},
            dataType:"text", 
            success:function(result){
               //alert(typeof result)
               result=eval(result);
               
               
               for(var i=0;i<result.length;i++){
                  var data=result[i];
                  var str ="";
                    
                  
                  if(checkImageType(data)){
                      str ="<div><a href='/ex/displayFile?fileName="+getImageLink(data)+"''>"
                            +"<img src='/ex/displayFile?fileName="+data+"'/>"
                            +"</a><small data-src='"+data+"'>X</small></div>";
                   }else{
                      str = "<div><a href='/ex/displayFile?fileName="+data+"'>" 
                            + getOriginalName(data)+"</a>"
                            +"<small data-src='"+data+"'>X</small></div></div>";
                   }
                   
                   $(".uploadedList").append(str);

                  
                  
              

               } 
            }
         });
      /* }); */
   }   


   
      $(".fileDrop").on("dragenter dragover", function(event) {
         event.preventDefault();
      });

      $(".fileDrop").on("drop", function(event){
         event.preventDefault();
         
         var files = event.originalEvent.dataTransfer.files;
         console.log(files);
         
        

         var formData = new FormData();
         
         for(var a=0;a<files.length;a++){
				console.log(files[a]);
				formData.append("file", files[a]);
			};
         
         
         formData.append("bId","${boardDto.bId}")
         
         $.ajax({
              url: '/ex/uploadAjax',
              data: formData,
              dataType:'text',
              processData: false,
              contentType: false,
              type: 'POST',
              success: function(data){
            	  
            	  
            	 var fileNames = data.split(',');
	             for(var i=0; i<fileNames.length; i++) {
	                    var fileName = fileNames[i];
                 
                 var str ="";
                 
                 if(checkImageType(fileName)){
                    str ="<div></a><small data-src='"+fileName+"'>X</small><a href='/ex/displayFile?fileName="+getImageLink(fileName)+"''>"
                          +"<img src='/ex/displayFile?fileName="+fileName+"'class='thumbnail'/>"
                          +"</div>";
                 }else{
                    str = "<div><small data-src='"+fileName+"'>X&nbsp</small><a href='/ex/displayFile?fileName="+fileName+"'>" 
                          + getOriginalName(fileName)+"</a>"
                          +"</div></div>";
                 }
                 
                 $(".uploadedList").append(str);
              }
              }
            });   
      });


      $(".uploadedList").on("click", "small", function(event){
         
             var that = $(this);
         
            $.ajax({
               url:"/ex/deleteFile",
               type:"post",
               data: {fileName:$(this).attr("data-src")},
               dataType:"text",
               success:function(result){
                  if(result == 'deleted'){
                     that.parent("div").remove();
                  }
               }
            });
      });
      

      function getOriginalName(fileName){   

         if(checkImageType(fileName)){
            return;
         }
         
         var idx = fileName.indexOf("_") + 1 ;
         return fileName.substr(idx);
         
      }


      function getImageLink(fileName){
         
         if(!checkImageType(fileName)){
            return;
         }

         
         return fileName.replace("s_","");
         
      }
      function checkImageType(fileName){
         
         var pattern = /jpg|gif|png|jpeg/i;
         
         return fileName.match(pattern);
         
      }
       
         
      </script>
      







<%@include file="../include/footer.jsp"%>