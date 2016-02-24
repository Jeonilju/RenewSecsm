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
			if(response==-1)
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
	
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		{
			return;
		}
		else
		{
			return false;
		}
	}
	
</script>

<!-- 금액 충전 모달 -->
<div class="modal fade" id="pxChargemoneyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="SignInModalLabel">금액 충전</h4>
				</div>
				<div class="modal-body" >
					<div class="row-fluid" style="">
						<div class="col-md-8">
						</div>
						<div class="col-md-2" style="padding-left: 10px;">
							내 잔액 : 
						</div>
						<div>    
								<label id = "amounts"></label>  	
						</div>
					</div>
					
					<form id= "charge_form" onsubmit="charge_Money();getPxAmount();inputreset(1);return false">
					<div class="row-fluid" style="margin: 10px">
						<div class="col-md-3" style=" padding-right: 0px; padding-left: 50px;">
							<h5>충전금액</h5>
						</div>
						<div class = "col-md-6">
						<input id="charge_money" onkeydown="return showKeyCode(event)" name="charge_money" class = "form-control" type="text" style="width: 100%">
						</div>
						<div class="col-md-3">
							<input type="submit" class="btn btn-default" value = "충전">
						</div>
					</div>
					</form>
					<div style="height: 40px;"></div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
		</div>
	</div>
</div>