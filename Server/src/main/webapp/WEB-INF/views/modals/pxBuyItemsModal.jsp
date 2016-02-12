<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"> </script>
 <script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"> </script>
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
 
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/autoComplete.js"></script>


<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
%>

<script type="text/javascript">
	
	// 아이템 구매
	function buyItem(){
		var param = "type" + "=" + $("#slItemType").val() + "&" + 
					"code" + "=" + $("#etItemCode").val() + "&" + 
					"isForcibly" + "="+ "0";

		$.ajax({
		url : "/Secsm/api_pxBuyItem",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			alert(response);
			if(response=='0')
			{
				// 정상 구매
				alert('정상 구매되었습니다.');
				window.location.reload(true);
			}
			else if(response == '1')
			{
				// 해당 상품 없음
				alert('해당 상품이 존재하지 않습니다.');
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
		//		alert(response);
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
	
	$("#etItemCode").keyup(function(event){
	    if(event.keyCode == 13){
	    	buyItem();
	    }
	});
	
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
		//	alert(response);
			if(response==0)
			{
				alert('실패');
				
			}
			else{
			//	alert(response);
				var amount = document.getElementById("amount");
				amount.innerHTML = response + "원";
			}

		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	//환불
	function RefundItem(){
		
	}
</script>

<!-- 상품 구매 모달 -->
<div class="modal fade" id="pxBuyItemsModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="createProjectForm" id="createProjectForm" action="/api_createProject">
				<div class="modal-header">
					<h4 class="modal-title" id="SignInModalLabel">상품 구매</h4>
				</div>
				<div class="modal-body" >
					<div class="row-fluid" style="">
						<div class="col-md-6">
						</div>
						<div class="col-md-3">
							내 잔액 : 
						</div>
						<div class="col-md-3">    
				<!--  		<label><%=accountInfo.getPxAmount() %> 원</label>  -->	
					<!--			<script>getPxAmount()</script>-->
								<label id = "amount"></label>  
						
						</div>
						
						<div class="col-md-6">
							<input id="charge_money" name="charge_money" type="text" style="width: 30%">
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-default" onclick="charge_Money();getPxAmount();"> 충전 </button>
						</div>
					</div>
					
					<div class="row-fluid" style="margin: 20px">
						<div class="col-md-3">
							<select id="slItemType" name="slItemType" style="width: 100%; margin: 5px;">
								<option value="0"> 바코드 </option>
								<option value="1"> 상품 명 </option>
							</select>
						</div>
						<div id = "box2" class="col-md-6">
							<input id="etItemCode" name="etItemCode" type="text" style="width: 100%">
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-default" onclick="buyItem();getPxAmount();"> 승인 </button>
						</div>
					</div>
					
					<div style="height: 40px;"></div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>