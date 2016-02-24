<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

	function requestEquipment(){

		var param = {reqProject: $("#reqProject").val(),
					reqTypeKr: $("#reqTypeKr").val(), 
					reqTypeKr: $("#reqTypeKr").val(), 
					reqTypeEn: $("#reqTypeEn").val(),
					reqTitleKr: $("#reqTitleKr").val(),
					reqTitleEn: $("#reqTitleEn").val(),
					reqBrand: $("#reqBrand").val(),
					reqLink: $("#reqLink").val(),
					reqContent: $("#reqContent").val(),
					reqPay: $("#reqPay").val(),
					reqCount: $("#reqCount").val()};
		
		if($("#reqProject").val()==""){
			alert("프로젝트 입력하세요.");
			return;
		}
		else if(0>=$("#reqProject").val() || $("#reqProject").val()>10000){
			alert("프로젝트 번호 범위를 초과하였습니다.");
			return;
		}
		else if($("#reqTypeKr").val()==""){
			alert("분류(한글)를 입력하세요.");
			return;
		}
		else if($("#reqTypeEn").val()==""){
			alert("분류(영어)를 입력하세요.");
			return;
		}
		else if($("#reqTitleKr").val()==""){
			alert("장비명(한글)를 입력하세요.");
			return;
		}
		else if($("#reqTitleEn").val()==""){
			alert("장비명(영어)를 입력하세요.");
			return;
		}
		else if($("#reqBrand").val()==""){
			alert("브랜드를 입력하세요.");
			return;
		}
		else if($("#reqLink").val()==""){
			alert("참고링크를 입력하세요.");
			return;
		}
		else if($("#reqContent").val()==""){
			alert("사유내역을 입력하세요.");
			return;
		}
		else if($("#reqPay").val()==""){
			alert("단가를 입력하세요.");
			return;
		}
		else if($("#reqCount").val()==""){
			alert("수량을 입력하세요.");
			return;
		}
		else if(0>=$("#reqPay").val() || $("#reqPay").val()>1000000){
			alert("단가 범위를 초과하였습니다.");
			return;
		}
		else if(0>=$("#reqCount").val() || $("#reqCount").val()>100){
			alert("수량 범위를 초과하였습니다.");
			return;
		}
		else{}
		
		$.ajax({
		url : "/Secsm/api_reqEquipment",
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
				alert('수량을 확인해주세요.');	
			}
			else if(response=='403')
			{
				alert('해당 프로젝트는 존재하지 않습니다.');
			}
			else
			{
				alert('신청이 완료되었습니다.');
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

<!-- 장비 신청 모달-->
<div class="modal fade" id="equipmentRequestModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="equipmentRequest" id="equipmentRequest">
				<div class="modal-header">
					<h4 class="modal-title">장비신청</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="reqProject" >프로젝트 번호</label> 
						<input name="reqProject" id="reqProject" type="number" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqType" >분류(한글/영어)</label>
						<input name="reqType" id="reqTypeKr" type="text" class="form-control" maxlength="25"/>
						<input name="reqType" id="reqTypeEn" type="text" class="form-control" maxlength="50"/>
					</div>
					
					<div class="form-group">
						<label for="reqTitle" >장비명(한글/영어)</label>
						<input name="reqTitle" id="reqTitleKr" type="text" class="form-control" maxlength="50"/>
						<input name="reqTitle" id="reqTitleEn" type="text" class="form-control" maxlength="100"/>
					</div>
					<div class="form-group">
						<label for="reqBrand" >브랜드</label> 
						<input name="reqBrand" id="reqBrand" type="text" class="form-control" maxlength="25"/>
					</div>
					<div class="form-group">
						<label for="reqLink" >참고링크</label> 
						<input name="reqLink" id="reqLink" type="text" class="form-control" maxlength="100"/>
					</div>
					<div class="form-group">
						<label for="reqContent" >사유내역</label> 
						<input name="reqContent" id="reqContent" type="text" class="form-control" maxlength="75"/>
					</div>
					<div class="form-group">
						<label for="reqPay" >단가</label> 
						<input name="reqPay" id="reqPay" type="number" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqCount" >수량</label> 
						<input name="reqCount" id="reqCount" type="number" class="form-control"/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="requestEquipment();">신청</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>