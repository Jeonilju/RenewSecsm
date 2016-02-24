<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

	function requestEquipment(){

		var param = {reqTypeKr: $("#reqTypeKr").val(), 
					reqTypeEn: $("#reqTypeEn").val(),
					reqTitleKr: $("#reqTitleKr").val(),
					reqTitleEn: $("#reqTitleEn").val(),
					reqBrand: $("#reqBrand").val(),
					reqLink: $("#reqLink").val(),
					reqContent: $("#reqContent").val(),
					reqPay: $("#reqPay").val(),
					reqCount: $("#reqCount").val()};
		
		if($("#reqTypeKr").val()==""){
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

<!-- 자동당직생성 모달-->
<div class="modal fade" id="equipmentRequestModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="equipmentRequest" id="equipmentRequest">
				<div class="modal-header">
					<h4 class="modal-title">장비신청</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="reqType" cond="">분류(한글/영어)</label>
						<input name="reqType" id="reqTypeKr" type="text" class="form-control"/>
						<input name="reqType" id="reqTypeEn" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqTitle" cond="">장비명(한글/영어)</label>
						<input name="reqTitle" id="reqTitleKr" type="text" class="form-control"/>
						<input name="reqTitle" id="reqTitleEn" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqBrand" cond="">브랜드</label> 
						<input name="reqBrand" id="reqBrand" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqLink" cond="">참고링크</label> 
						<input name="reqLink" id="reqLink" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqContent" cond="">사유내역</label> 
						<input name="reqContent" id="reqContent" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqPay" cond="">단가</label> 
						<input name="reqPay" id="reqPay" type="number" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqCount" cond="">수량</label> 
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