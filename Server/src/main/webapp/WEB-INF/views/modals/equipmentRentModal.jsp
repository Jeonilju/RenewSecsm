<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript">
	
	$(function() 
		{
			$("#rentEndDate").datepicker();
		}
	);
	
	function rentEquipment(){

		var param = "rentId" + "=" + $("#rentId").val() + "&" + 
					"rentEndDate" + "=" + $("#rentEndDate").val();
		
		if($("#rentEndDate").val()==""){
			alert("반납일을 입력하세요.");
			return;
		}
		
		$.ajax({
		url : "/Secsm/api_rentEquipment",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				alert('대여완료');
				location.reload();
			}
			else if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else if(response=='402')
			{
				alert('해당하는 장비정보가 없습니다.');
				location.reload();
			}
			else if(response=='403')
			{
				alert('수량을 확인하세요.');
				location.reload();
			}
			else if(response=='404')
			{
				alert('반납일이 대여일보다 빠릅니다.');
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

<!-- 장비 대여 모달-->
<div class="modal fade" id="equipmentRentModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="equipmentRent" id="equipmentRent">
				<div class="modal-header">
					<h4 class="modal-title">장비대여</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
					 	<input type="hidden" name="rentId" id="rentId" value=""/>
						<label for="rentEndDate" >반납일</label> 
						<input name="rentEndDate" id="rentEndDate" type="text" class="form-control"/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="rentEquipment();">대여</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>