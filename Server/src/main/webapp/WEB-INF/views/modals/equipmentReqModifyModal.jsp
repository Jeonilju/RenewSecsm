<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	function reqSearchEquipment(id){
		var param = {reqModifyId: id};
		$('#reqModifyId').val(id);
		
		$.ajax({
			url : "/Secsm/api_reqSearchEquipment",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response=='401')
				{
					alert("로그인을 하세요.");
					location.reload();
				}
				else if(response=='402')
				{
					alert("해당 장비신청이 존재하지 않습니다.");
					location.reload();
				}
				else
				{
					var obj = JSON.parse(response);
					
					$("#reqModifyProject").val(obj[0].projectId);
					$("#reqModifyTypeKr").val(obj[0].typeKr);
					$("#reqModifyTypeEn").val(obj[0].typeEn);
					$("#reqModifyTitleKr").val(obj[0].titleKr);
					$("#reqModifyTitleEn").val(obj[0].titleEn);
					$("#reqModifyBrand").val(obj[0].brand);
					$("#reqModifyLink").val(obj[0].link);
					$("#reqModifyContent").val(obj[0].content);
					$("#reqModifyPay").val(obj[0].pay);
					$("#reqModifyCount").val(obj[0].count);
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
			
		});
	}	
	
	function requestDelete(){	
		var param = {reqModifyId: $("#reqModifyId").val()}; 
		
		$.ajax({
			url : "/Secsm/api_reqEquipmentCancel",
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
				else
				{
					alert('철회 되었습니다.');
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

	
	function requestModify(){

		var param = {
					reqModifyId: $("#reqModifyId").val(),
					reqModifyProject: $("#reqModifyProject").val(),
					reqModifyTypeKr: $("#reqModifyTypeKr").val(), 
					reqModifyTypeEn: $("#reqModifyTypeEn").val(),
					reqModifyTitleKr: $("#reqModifyTitleKr").val(),
					reqModifyTitleEn: $("#reqModifyTitleEn").val(),
					reqModifyBrand: $("#reqModifyBrand").val(),
					reqModifyLink: $("#reqModifyLink").val(),
					reqModifyContent: $("#reqModifyContent").val(),
					reqModifyPay: $("#reqModifyPay").val(),
					reqModifyCount: $("#reqModifyCount").val()};
		
		if($("#reqModifyProject").val()==""){
			alert("프로젝트 번호를 입력하세요.");
			return;
		}
		else if(0>=$("#reqModifyProject").val() || $("#reqModifyProject").val()>10000){
			alert("프로젝트 번호 범위를 초과하였습니다.");
			return;
		}
		else if($("#reqModifyTypeKr").val()==""){
			alert("분류(한글)를 입력하세요.");
			return;
		}
		else if($("#reqModifyTypeEn").val()==""){
			alert("분류(영어)를 입력하세요.");
			return;
		}
		else if($("#reqModifyTitleKr").val()==""){
			alert("장비명(한글)를 입력하세요.");
			return;
		}
		else if($("#reqModifyTitleEn").val()==""){
			alert("장비명(영어)를 입력하세요.");
			return;
		}
		else if($("#reqModifyBrand").val()==""){
			alert("브랜드를 입력하세요.");
			return;
		}
		else if($("#reqModifyLink").val()==""){
			alert("참고링크를 입력하세요.");
			return;
		}
		else if($("#reqModifyContent").val()==""){
			alert("사유내역을 입력하세요.");
			return;
		}
		else if($("#reqModifyPay").val()==""){
			alert("단가를 입력하세요.");
			return;
		}
		else if($("#reqModifyCount").val()==""){
			alert("수량을 입력하세요.");
			return;
		}
		else if(0>=$("#reqModifyPay").val() || $("#reqModifyPay").val()>1000000){
			alert("단가 범위르 초과하였습니다.");
			return;
		}
		else if(0>=$("#reqModifyCount").val() || $("#reqModifyCount").val()>100){
			alert("수량 범위를 초과하였습니다.");
			return;
		}
		else{}
		
		$.ajax({
		url : "/Secsm/api_reqModifyEquipment",
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

			if(response=='402')
			{
				alert('수량을 확인해주세요.');
			}
			else if(response=='403')
			{
				alert("해당 프로젝트는 존재하지 않습니다.");
			}
			else
			{
				alert('수정이 완료되었습니다.');
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

<style>
	#equipmentReqModifyModal{
		z-index:999999;
	}
</style>

<!-- 장비 신청 수정 모달-->
<div class="modal fade" id="equipmentReqModifyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="equipmentReqModify" id="equipmentReqModify">
				<div class="modal-header">
					<h4 class="modal-title">장비신청 수정</h4>
				</div>
				<input type="hidden" name="reqModifyId" id="reqModifyId" value=""/>
				<div class="modal-body" >
					<div class="form-group">
						<label for="reqModifyProject" >프로젝트 번호</label> 
						<input name="reqModifyProject" id="reqModifyProject" type="number" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqModifyType" >분류(한글/영어)</label>
						<input name="reqModifyType" id="reqModifyTypeKr" type="text" class="form-control" maxlength="25"/>
						<input name="reqModifyType" id="reqModifyTypeEn" type="text" class="form-control" maxlength="50"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyTitle" >장비명(한글/영어)</label>
						<input name="reqModifyTitle" id="reqModifyTitleKr" type="text" class="form-control" maxlength="50"/>
						<input name="reqModifyTitle" id="reqModifyTitleEn" type="text" class="form-control" maxlength="100"/>
					</div>
					<div class="form-group">
						<label for="reqModifyBrand" >브랜드</label> 
						<input name="reqModifyBrand" id="reqModifyBrand" type="text" class="form-control" maxlength="25"/>
					</div>
					<div class="form-group">
						<label for="reqModifyLink" >참고링크</label> 
						<input name="reqModifyLink" id="reqModifyLink" type="text" class="form-control" maxlength="100"/>
					</div>
					<div class="form-group">
						<label for="reqModifyContent" >사유내역</label> 
						<input name="reqModifyContent" id="reqModifyContent" type="text" class="form-control" maxlength="75"/>
					</div>
					<div class="form-group">
						<label for="reqModifyPay" >단가</label> 
						<input name="reqModifyPay" id="reqModifyPay" type="number" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqModifyCount">수량</label> 
						<input name="reqModifyCount" id="reqModifyCount" type="number" class="form-control"/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="requestDelete();">철회</button>
					<button type="button" class="btn btn-default" onclick="requestModify();">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>