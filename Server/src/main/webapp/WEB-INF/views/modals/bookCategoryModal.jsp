<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
		
	function addCategory(){
		var param = {addCategoryName: $("#addCategoryName").val()};
		
		if($("#addCategoryName").val()==""){
			alert('추가할 카테고리명을 입력하세요.');
			return;
		}
		
		$.ajax({
		url : "/Secsm/api_bookAddCategory",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else if(response=='402')
			{
				alert('동일한 명칭의 카테고리가 존재합니다.');
				location.reload();
			}
			else if(response=='403')
			{
				alert('권한이 없습니다.');
			}
			else
			{
				alert('추가 되었습니다.');
				location.reload();
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function deleteCategory(){
		var param = "categoryOption" + "=" + $("#categoryOption option:selected").val();
		if(confirm("해당 카테고리를 삭제하면 카테고리의 관련 도서들이 모두 삭제됩니다.\n삭제하시겠습니까?"))
		
		$.ajax({
		url : "/Secsm/api_bookDeleteCategory",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else if(response=='402')
			{
				alert('해당 카테고리는 삭제할 수 없습니다.');
			}
			else if(response=='403')
			{
				alert('해당 카테고리를 찾을 수 없습니다.');
				location.reload();
			}
			else if(response=='404')
			{
				alert('해당 카테고리의 도서들을 다른 카테고리로 변경한 후 시도하세요.');
			}
			else if(response=='405')
			{
				alert('권한이 없습니다.');
			}
			else
			{
				alert('삭제 되었습니다.');
				location.reload();
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

<!-- 도서 카테고리 모달-->
<div class="modal fade" id="bookCategoryModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="bookCategory" id="bookCategory">
				<div class="modal-header">
					<h4 class="modal-title">분류</h4>
				</div>
				<div class="modal-body form-inline" >
					<select class="form-control" name="categoryOption" id="categoryOption" style="width:10em;  margin-left:15px;">
              			<%
              				for (BookCategoryInfo info : bookCategory){
              					out.println("<option>" + info.getName() + "</option>");
              				}
              			%>
         			 </select>
         			 <button type="button" class="btn btn-danger" onclick="deleteCategory();">삭제</button>			
				</div>

				<div class="modal-footer form-inline">
					<input name="addCategoryName" id="addCategoryName" type="text" class="form-control" style="width: 40%" maxlength="25"/>
					<button type="button" class="btn btn-default" onclick="addCategory();">추가</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>