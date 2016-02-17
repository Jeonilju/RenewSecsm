<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	// 아이템 구매
	
	function addBook(){

		var param = {addCode:$("#addCode").val(),
					addTitle: $("#addTitle").val(),
					addType: $("#addType").val(),
					addPublisher: $("#addPublisher").val(),
					addAuthor: $("#addAuthor").val(),
					addImageURL: $("#addImageURL").val(),
					addCount: $("#addCount").val()};
		
		if($("#addCode").val()==""){
			alert("코드명을 입력하세요.");
			return;
		}
		else if($("#addTitle").val()==""){
			alert("도서명을 입력하세요.");
			return;
		}
		else if($("#addPublisher").val()==""){
			alert("출판사를 입력하세요.");
			return;
		}
		else if($("#addCount").val()==""){
			alert("수량을 입력하세요.");
			return;
		}
		
		$.ajax({
		url : "/Secsm/api_addBook",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				alert('추가 되었습니다.');
				location.reload();
			}
			else if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else if(response=='402')
			{
				alert('분류가 존재하지 않습니다.');
				location.reload();
			}
			else
			{
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	

</script>

<%
	ArrayList<BookCategoryInfo> bookCategory = (ArrayList<BookCategoryInfo>) request.getAttribute("bookCategory");
%>

<!-- 자동당직생성 모달-->
<div class="modal fade" id="bookAddModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="bookAdd" id="bookAdd">
				<div class="modal-header">
					<h4 class="modal-title">도서등록</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="addType" cond="">분류</label> 
						<select class="form-control" name="addType" id="addType">
              				<%
              					for (BookCategoryInfo info : bookCategory){
              						out.println("<option>" + info.getName() + "</option>");
              					}
              				%>
         			 	</select>
         			 	
					</div>
						<div class="form-group">
						<label for="addCode" cond="">코드</label> 
						<input name="addCode" id="addCode" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addTitle" cond="">도서명</label> 
						<input name="addTitle" id="addTitle" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addPublisher" cond="">출판사</label> 
						<input name="addPublisher" id="addPublisher" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addAuthor" cond="">저자</label> 
						<input name="addAuthor" id="addAuthor" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addImageURL" cond="">이미지 URL</label> 
						<input name="addImageURL" id="addImageURL" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addCount" cond="">수량</label> 
						<input name="addCount" id="addCount" type="number" class="form-control"/>
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addBook();">추가</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>