<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>


<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
	PxItemsInfo pxiteminfo = (PxItemsInfo) request.getAttribute("pxiteminfo");
	
%>

<script type="text/javascript">

	var num = 0;

	//상품 검색
	
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
			if(response=='0')
			{
				// 정상 구매 by 바코드
				num++;
				semi_List(num);
				
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
				alert("code1 : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function semi_List(num){
		var param = "num" + "=" + num; 
		$.ajax({
		url : "/Secsm/api_current_buyList",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			var arr = JSON.parse(response);
			insertBuyListTable(arr);
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code2 : " + request.status + "\r\nmessage : "
						+ request.reponseText + "\r\nerror : " + error);
			}
		}
		});
	}
	
	function insertBuyListTable(jsonArr){
		
		document.getElementById('pxCurrentbuyTbody').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
		
		for(var index = 0;index < jsonArr.length;index++){
			var data = jsonArr[index];
			var tableRef = document.getElementById('currentbuyTable').getElementsByTagName('tbody')[0];

			// Insert a row in the table at the last row
			var newRow   = tableRef.insertRow(tableRef.rows.length);
	
			// Insert a cell in the row at index 0
			var newCell1  = newRow.insertCell(0);
			var newCell2  = newRow.insertCell(1);
			var newCell3  = newRow.insertCell(2);
			var newCell4  = newRow.insertCell(3);

			// Append a text node to the cell
			var newText  = document.createTextNode('New row')
			newCell1.appendChild(document.createTextNode(data.regDate));
			newCell2.appendChild(document.createTextNode(data.name));
			newCell3.appendChild(document.createTextNode(data.price));
			
			var button = document.createElement('input');
			button.setAttribute('type','button');
			button.setAttribute('class','btn btn-default');
			button.setAttribute('value','환불');
			button.setAttribute('OnClick','refund(' +data.id + ',1);getPxAmount();');
			newCell4.appendChild(button);
		}
	}
	
	function end(){
		num=0;
	}
	
	function auto_list(){
		
		$.ajax({
			url : "/Secsm/api_px_Autocomplete",
			type : "POST",
			data : "",
			cache : false,
			async : false,
			dataType : "text",

			success : function(response) {
				var arr=JSON.parse(response);
				complete(arr)
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code3 : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
			
			});
		
	}
	
	function complete(jsonArr){
		
		var arr1 = new Array();
		for(var index = 0;index < jsonArr.length;index++){
			var data = jsonArr[index];
			arr1.push(data.name);
		}
		
		$( "#etItemCode" ).autocomplete({
	          source: arr1
	  });


	}
	
	function inputreset(){
		document.getElementById("buy_form").reset();
	}

	
</script>

<!-- 상품 구매 모달 -->
<div class="modal fade" id="pxBuyItemsModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="SignInModalLabel">상품 구매</h4>
				</div>
				<div class="modal-body" >
					<div class="row-fluid" style="">
		  			<div class="col-md-6"></div> 
		
						<div class="table table-hover">
							<th>분류</th>
				   	     	<th>상품명</th>
				   	     	<th>내 잔액 :</th> 
				   	     	<label id = "amount"></label>  
						</div>
	
					</div>
					
					<form id= "buy_form" onsubmit="buyItem();getPxAmount();inputreset();return false">
					<div  class="row-fluid" style="margin: 20px">
						<div class="col-md-3">
							<select id="slItemType" name="slItemType" style="width: 100%; margin: 5px;">
								<option value="0"> 바코드 </option>
								<option value="1"> 상품 명 </option>
							</select>
						</div>
						<div id = "box2" class="col-md-4">
							<input id="etItemCode" name="etItemCode" type="text" onkeypress = "auto_list();" style="width: 100%">
						</div>
						
						<div class="col-md-5">
							<input type="submit" class="btn btn-default" value = "구입">
						</div>
					</div>
				</form>
					
					<div style="height: 40px;"></div>
				</div>
				
				<div>
					<table class="table table-hover" id = "currentbuyTable" style = "margin-left : 50px">
				 	   <thead>
				   	   <tr>
				   	     <th style = "width:216px">날짜</th>
				   	     <th>상품명</th>
				   	     <th>금액</th>
				   	     <th>  </th>
				   	   </tr>
				  	  </thead>
				   		 <tbody id = "pxCurrentbuyTbody">
		
				    	</tbody>
				 	 </table>
				</div>
				
				<div class="modal-footer">
					<button onclick= "end()" type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
					
				</div>
		</div>
	</div>
</div>