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

<style>
.fileDrop {
	width: 100%;
	height: 100px;
	border: 1px dotted blue;
}
small {
	margin-left: 3px;
	font-weight: bold;
	color: gray;
}
</style>







 
  			<div class="mainregister">
 				<div class="box-header">
					<h2 class="box-title">글쓰기</h2>
				</div>
				<!-- /.box-header -->
	<!-- action에 경로가 없으면 현재 페이지 주소로 이동한다.-->
	<form role="form" method="post" onsubmit="return validateForm();">
	
		
		<select name="bGroupKind" id="category">
            <option id="free" value="자유">자유</option>
            <option id="hot" value="인기">인기</option>
            <option id="humor" value="유머">유머</option>
            <option id="advice" value="고민">고민</option>
        </select> 
	
		<h3> title  <input type="text"
				name='bTitle' placeholder="Enter Title" style="width:100%"></h3> 
			
		
		<h2> content 
			<textarea name="bContent" rows="8" style="width:100%"
				placeholder="Enter ..."></textarea></h2>
		<h2> writer 
			<input type="text"
				name="bName"  placeholder="Enter Writer"  style="width:100%"></h2> 
		
		
		
	<!-- upload start-->

	<h3>Ajax File Upload</h3>
	<div class='fileDrop'></div>

	<div class='uploadedList'></div>
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
			var file = files[0];

			console.log(file);
			var formData = new FormData();
			
			formData.append("file", file);
			formData.append("bId","${boardDto.bId}")
			
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
		
	
	<!-- /.box-body -->


		<button type="submit">등록</button>
		<button><a href="/ex/board/listAll" >목록</a></button>	
	</form>
</div>
		
<%@include file="../include/footer.jsp"%>