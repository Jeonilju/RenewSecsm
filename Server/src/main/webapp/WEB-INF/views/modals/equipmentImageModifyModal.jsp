<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

function modifyImageEquipment(){
	var formData = new FormData();
  	formData.append("modifyId", $("input[name=modifyId]").val());
  	formData.append("modifyImageURL", $("input[name=modifyImageURL]")[0].files[0]);
	
    if($("#modifyImageURL").val() == ''){
    	alert('이미지를 입력하세요.');
    	return;
    }
  	
	$.ajax({
	url : "/Secsm/api_modifyImage",
	type : "POST",
	data : formData,
	processData: false,
	contentType: false,
	    
	success : function(response) {	
		if(response=='200')
		{
			alert('변경 되었습니다.');
			$("#modifyImageURLRap").html('<label for="modifyImageURL" cond="">이미지</label>' 
					+ '<input name="modifyImageURL" id="modifyImageURL" type="file" class="form-control"/>');
			location.reload();
		}
		else if(response=='401')
		{
			alert('로그인을 하세요.');
			location.reload();
		}
		else if(response=='402')
		{
			alert('해당장비가 존재하지 않습니다.');
			location.reload();
		}
		else if(response=='403')
		{
			alert('파일업로드 에러');
			location.reload();
		}
		else{}
	},
	error : function(request, status, error) {
		if (request.status != '0') {
			alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
		}
	}
	
	});
}

</script>

<style>
	#equipmentImageModifyModal{
		z-index:999999;
	}
</style>

<!-- 자동당직생성 모달-->
<div class="modal fade" id="equipmentImageModifyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="equipmentImageModifyModal" id="equipmentImageModifyModal" enctype="multipart/form-data">
				<div class="modal-header">
					<h4 class="modal-title">이미지 수정</h4>
				</div>
				<div class="modal-body">
					<div class="form-group" id="modifyImageURLRap">
						<label for="modifyImageURL" cond="">이미지</label> 
						<input name="modifyImageURL" id="modifyImageURL" type="file" class="form-control"/>
					</div>
					
				</div>

				<div class="modal-footer"> 
					<button type="button" class="btn btn-default" onclick="modifyImageEquipment();">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>