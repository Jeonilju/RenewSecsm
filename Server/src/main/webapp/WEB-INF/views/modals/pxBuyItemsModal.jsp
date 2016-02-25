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
<style>
	.ui-autocomplete{
		z-index:30 !important;
	}
</style>

<script type="text/javascript">

	var num = 0;
	var together_member = new Array();
	
	
	function unique(tmparray) {
		
		var result = [];
		$.each(tmparray, function(index, element) {          
			if ($.inArray(element, result) == -1) {  
				result.push(element);                     
			}
		});
		return result;
	}
	
	function together_list(idx){
		if(idx==0){ 
			tmp = document.getElementsByName("together");
		
			for(var i = 0 ; i < tmp.length ; i++){
				if(tmp[i].checked){
					for(var j=0; j < together_member.length;j++){
						
					}
					together_member.push(tmp[i].value);
				}
			}
			alert("정상 추가되었습니다.");
		}
	}
	
	// 아이템 구매
	function buyItem(){
		
		var templist = unique(together_member);
		
		var param = "type" + "=" + $("#slItemType").val() + "&" + 
					"code" + "=" + $("#etItemCode").val() + "&" + 
					"cnt" + "=" + $("#item_cnt").val() + "&" +
					"templist" + "=" + templist + "&" +
					"templen" + "=" + templist.length + "&" +
					"isForcibly" + "="+ "0";
		
		var form = document.buy_form;
		

		if(form.etItemCode.value == ""){
			alert("삼풍명 혹은 바코드를 입력하지 않앗습니다.");	
		}
		else if(form.item_cnt.value == ""){
			alert("수량을 입력하지 않앗습니다.");	
		}
		else if(form.etItemCode.value.length >=100){
			alert("삼풍명 혹은 바코드의 길이는 100자를 넘을 수 없습니다.");	
		}
		else if(form.item_cnt.value.length >= 1000000){
			alert("입력할 수 있는 수량이 초과되었습니다.");
		}
		else{
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
					view_buylist();
					semi_List(num);
					var len = templist.length;
					for(var i = 0; i< len ; i++){templist.pop();}
					
					len = together_member.length;
					for(var i = 0; i< len ; i++){together_member.pop();}
					
						
				}
				else if(response == '1')
				{
					// 해당 상품 없음
					alert('해당 상품이 존재하지 않습니다.');
				}
				else if(response == '2'){
					alert('수량이 부족합니다. 상품신청을 해주세요.');
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
			var newCell5  = newRow.insertCell(4);
			var newCell6  = newRow.insertCell(5);
			
			// Append a text node to the cell
			var newText  = document.createTextNode('New row')
			newCell1.appendChild(document.createTextNode(data.regDate));
			newCell2.appendChild(document.createTextNode(data.name));
			newCell3.appendChild(document.createTextNode(data.price));
			newCell4.appendChild(document.createTextNode(data.count));
			newCell5.appendChild(document.createTextNode(data.with_buy));
			
			var button = document.createElement('input');
			button.setAttribute('type','button');
			button.setAttribute('class','btn btn-default btn-sm');
			button.setAttribute('value','환불');
			button.setAttribute('OnClick','refund(' +data.id + ',1);getPxAmount();');
			newCell6.appendChild(button);
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
	
	function inputreset(temp1)
	{
		if(temp1==0){
			document.getElementById("buy_form").reset();
		}
		else if(temp1==1){
			document.getElementById("charge_form").reset();
			
		}
		else if(temp1==2){
			document.getElementById("add_form").reset();
		}
		else if(temp1==3){
			document.getElementById("apply_form").reset();
		}
		else if(temp1==4){
			document.getElementById("apply2_form").reset();
		}
		else if(temp1==5){
			document.getElementById("accountSignUpForm").reset();
		}
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
					<div class="row-fluid">
		  	
					
	
					</div>
					
					
					
					<div style="height: 40px;"></div>
				</div>
				
				
				
				
		</div>
	</div>
</div>