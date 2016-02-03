<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

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
	
	$("#etItemCode").keyup(function(event){
	    if(event.keyCode == 13){
	    	buyItem();
	    }
	});

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
							<label><%=accountInfo.getPxAmount() %> 원</label>
						</div>
					</div>
					
					<div class="row-fluid" style="margin: 20px">
						<div class="col-md-3">
							<select id="slItemType" name="slItemType" style="width: 100%; margin: 5px;">
								<option value="0"> 바코드 </option>
								<option value="1"> 상품 명 </option>
							</select>
						</div>
						<div class="col-md-6">
							<input id="etItemCode" name="etItemCode" type="text" style="width: 100%">
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-default" onclick="buyItem();"> 승인 </button>
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