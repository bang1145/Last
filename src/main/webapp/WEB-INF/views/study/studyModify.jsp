<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../include/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/study.css" />


  <div class="mainregister" id="loading-main">
  
<form role="form" method="post">

	<div class="box-body">
		<div class="box-header">
		<img src="/ex/resources/img/logo02.png" alt="로고 이미지" class="logoImage" style='width:50px;'>
					<h2 class="box-title">${studyDto.sGroupKind} 답글쓰기</h2>
	</div><br>

		<input type="hidden" name='sId' style="width:100%" value="${studyDto.sId}"	readonly="readonly">
	

<!-- 		<h2> -->
<!-- 		제목 -->
<%-- 		<input type="text" name='sTitle'  style="width:100%" value="${studyDto.sTitle}"></h2> --%>
		<h3><input type="text" id="title"
				name='sTitle' value="${studyDto.sTitle}" style="width:100%"></h3>
			<br>
	
<!-- 		<h2> -->
<!-- 		글 내용 </h2> -->
<%-- 		<textarea  style="width:100%" name="sContent" rows="3" >${studyDto.sContent}</textarea> --%>
	<h4> 
			<textarea name="sContent" rows="8" style="width:100%">${studyDto.sContent}</textarea></h4>
		<h3>
		<img src="/ex/resources/img/writer.png" style="width: 45px; height: 45px;">
		<input type="hidden" name="sName" style="width:100%" value="${studyDto.sName}">${studyDto.sName}
		</h3>
		<div class='fileDrop'>업로드할 파일을 드래그 해주세요 !</div>

	<div class='uploadedList'></div>
		
		<script>
	
	
	function uploadListAll(){
		var formData = new FormData();
		formData.append("sId","${studyDto.sId}")
	
		/* $(".uploadedList").on("click", "small", function(event){
			
			 var that = $(this);
		 */
		   $.ajax({
			   url:"/ex/allFile",
			   type:"post",
			   data: {"sId":"${studyDto.sId}"},
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
			var file = files[0];

			console.log(file);
			var formData = new FormData();
			
			formData.append("file", file);
			formData.append("sId","${studyDto.sId}")
			
			$.ajax({
				  url: '/ex/uploadAjax',
				  data: formData,
				  dataType:'text',
				  processData: false,
				  contentType: false,
				  type: 'POST',
				  success: function(data){
					  
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
	</div>
	
	<!-- /.box-body -->

<div class="buttonContainer">
	<button type="submit" class="btn btn-primary">수정</button>&nbsp;&nbsp;
	<button type="submit" class="btn btn-warning">목록</button>
</div>
</form>
<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);
		$(".btn-warning").on("click", function() {
			self.location = "/ex/study/studyListAll";
		});
		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
	});
</script>


</div>
		
<%@include file="../include/footer.jsp"%>