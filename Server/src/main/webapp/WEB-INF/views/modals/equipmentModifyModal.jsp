<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

	
	function deleteEquipment(){
		var check = confirm("해당 장비의 로그도 모두 삭제됩니다. 진행하시겠습니까?");
		if(!check) return;
		var param = {modifyId:$("#modifyId").val()};
		
		$.ajax({
			url : "/Secsm/api_deleteEquipment",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response=='200')
				{
					alert('삭제 되었습니다.');
					location.reload();
				}
				else if(response=='401')
				{
					alert('로그인을 하세요.');
					location.reload();
				}
				else if(response=='402')
				{
					alert('권한이 없습니다.');
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
	
	function modifyReq(){

		var param = {modifyId:$("#modifyId").val(),
					modifyCode:$("#modifyCode").val(),
					modifyTitle: $("#modifyTitle").val(),
					modifyType: $("#modifyType").val(),
					modifyManufacturer: $("#modifyManufacturer").val(),
					modifyCount: $("#modifyCount").val()};
		
		if($("#modifyTitle").val()==""){
			alert("장비명을 입력하세요.");
			return;
		}
		else if($("#modifyManufacturer").val()==""){
			alert("제조사를 입력하세요.");
			return;
		}
		else if($("#modifyCount").val()==""){
			alert("수량을 입력하세요.");
			return;
		}
		else if(0>=$("#modifyCount").val() || $("#modifyCount").val()>100){
			alert("수량 범위를 초과하였습니다.");
			return;
		}
		
		
		$.ajax({
		url : "/Secsm/api_modifyEquipment",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				alert('변경 되었습니다.');
				location.reload();
			}
			else if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else if(response=='402')
			{
				alert('해당장비를 모두 반납처리 한 후 시도하세요.');
				location.reload();
			}
			else if(response=='403')
			{
				alert('해당장비가 존재하지 않습니다.');
				location.reload();
			}
			else if(response=='404')
			{
				alert('분류가 존재하지 않습니다.');
				location.reload();
			}
			else if(response=='405')
			{
				alert('수량을 확인해주세요.');	
			}
			else if(response=='406')
			{
				alert('같은 코드의 장비가 존재합니다.');	
			}
			else if(response=='407')
			{
				alert('권한이 없습니다.');	
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

<!-- 장비 수정 모달-->
<div class="modal fade" id="equipmentModifyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="equipmentModify" id="equipmentModify">
				<div class="modal-header">
					<h4 class="modal-title">장비수정</h4>
				</div>
				<div class="modal-body" >
					<input type="hidden" name="modifyId" id="modifyId" value=""/>
					<div class="form-group">
						<label for="modifyType" >분류</label> 
						<select class="form-control" name="modifyType" id="modifyType">
              				<%	
              					for (EquipmentCategoryInfo info : equipmentCategory){
              						out.println("<option value=\"" + info.getId() + "\">" + info.getName() + "</option>");
              					}
              				%>
         			 	</select>
         			 	
					</div>
						<div class="form-group">
						<label for="modifyCode" >코드</label> 
						<input name="modifyCode" id="modifyCode" type="text" class="form-control" maxlength="25"/>
					</div>
					
					<div class="form-group">
						<label for="modifyTitle" >장비명</label> 
						<input name="modifyTitle" id="modifyTitle" type="text" class="form-control" maxlength="50"/>
					</div>
					
					<div class="form-group">
						<label for="modifyManufacturer" >제조사</label> 
						<input name="modifyManufacturer" id="modifyManufacturer" type="text" class="form-control" maxlength="25"/>
					</div>
					
					<div class="form-group">
						<label for="modifyCount" >수량</label> 
						<input name="modifyCount" id="modifyCount" type="number" class="form-control"/>
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="deleteEquipment();">삭제</button>
					<button type="button" class="btn btn-info" data-toggle="modal" data-target="#equipmentImageModifyModal">이미지 수정</button>
					<button type="button" class="btn btn-default" onclick="modifyReq();">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>