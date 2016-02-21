<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	function addEquipment(){

		var param = {addCode:$("#addCode").val(),
					addTitle: $("#addTitle").val(),
					addType: $("#addType option:selected").text(),
					addManufacturer: $("#addManufacturer").val(),
					addImageURL: $("#addImageURL").val(),
					addCount: $("#addCount").val()};
		
		if($("#addCode").val()==""){
			alert("코드명을 입력하세요.");
			return;
		}
		else if($("#addTitle").val()==""){
			alert("장비명을 입력하세요.");
			return;
		}
		else if($("#addPublisher").val()==""){
			alert("제조사를 입력하세요.");
			return;
		}
		else if($("#addCount").val()==""){
			alert("수량을 입력하세요.");
			return;
		}
		
		$.ajax({
		url : "/Secsm/api_addEquipment",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				alert('추가 되었습니다.');
				$('select[name=addType]').val(0);
				$("#addCode").val("");
				$("#addTitle").val("");
				$("#addPublisher").val("");
				$("#addAuthor").val("");
				$("#addImageURL").val("");
				$("#addCount").val("");
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
	ArrayList<EquipmentCategoryInfo> equipmentCategory = (ArrayList<EquipmentCategoryInfo>) request.getAttribute("equipmentCategory");
%>

<!-- 자동당직생성 모달-->
<div class="modal fade" id="equipmentAddModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="equipmentAdd" id="equipmentAdd">
				<div class="modal-header">
					<h4 class="modal-title">장비등록</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="addType" cond="">분류</label> 
						<select class="form-control" name="addType" id="addType">
              				<%
              					int i=0;
              					for (EquipmentCategoryInfo info : equipmentCategory){
              						out.println("<option value=\"" + i++ +"\">" + info.getName() + "</option>");
              					}
              				%>
         			 	</select>
         			 	
					</div>
						<div class="form-group">
						<label for="addCode" cond="">코드</label> 
						<input name="addCode" id="addCode" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addTitle" cond="">장비명</label> 
						<input name="addTitle" id="addTitle" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addManufacturer" cond="">제조사</label> 
						<input name="addManufacturer" id="addManufacturer" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addImageURL" cond="">파일 URL</label> 
						<input name="addImageURL" id="addImageURL" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="addCount" cond="">수량</label> 
						<input name="addCount" id="addCount" type="number" class="form-control"/>
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addEquipment();">추가</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>