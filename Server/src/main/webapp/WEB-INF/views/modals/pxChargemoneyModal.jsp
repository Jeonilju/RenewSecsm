<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"> </script>
 <script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"> </script>
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
 

<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
%>

<script type="text/javascript">
		
	function charge_Money(){
		var param = "money" + "=" + $("#charge_money").val();
		
		$.ajax({
			url : "/Secsm/api_Charge_Money",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response=='0')
				{
					// 충전완료
					alert('충전되었습니다.');
				}
				else if(response == '1')
				{
					// 해당 상품 없음
					alert('실패하였습니다.');
				}	
				else{
					alert('알수없음');
				}
				
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
			
		});
		
		
	}
	
	//금액확인
	function getPxAmount(){
		
		$.ajax({
		url : "/Secsm/api_GetPxAmount",
		type : "POST",
		data : false,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response==0)
			{
				alert('실패');
				
			}
			else{
				var amount = document.getElementById("amount");
				amount.innerHTML = response + "원";
				
				var amount = document.getElementById("amounts");
				amounts.innerHTML = response + "원";
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

<!-- 금액 충전 모달 -->
<div class="modal fade" id="pxChargemoneyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="createProjectForm" id="createProjectForm" action="/api_createProject">
				<div class="modal-header">
					<h4 class="modal-title" id="SignInModalLabel">금액 충전</h4>
				</div>
				<div class="modal-body" >
					<div class="row-fluid" style="">
						<div class="col-md-6">
						</div>
						<div class="col-md-3">
							내 잔액 : 
						</div>
						<div class="col-md-3">    
								<label id = "amounts"></label>  	
						</div>
					</div>
					
					<div class="row-fluid" style="margin: 20px">
						<div class="col-md-3">
							충전금액
						</div>
						<div class = "col-md-6">
						<input id="charge_money" name="charge_money" type="text" style="width: 100%">
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-default" onclick="charge_Money();getPxAmount();"> 충전 </button>
						</div>
					</div>
					
					<div style="height: 40px;"></div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>