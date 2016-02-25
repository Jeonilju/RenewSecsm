<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<script>

	function total_item_list(){
	
		var param = "";
	
		$.ajax({
		url : "/Secsm/api_total_list",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {

			var arr = JSON.parse(response);
			total_item_list_Table(arr);
		
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
		
	function total_item_list_Table(jsonArr){
			
			document.getElementById('total_item_list_body').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
		
			for(var index = 0;index < jsonArr.length;index++){
				var data = jsonArr[index];
				var tableRef = document.getElementById('item_list_table').getElementsByTagName('tbody')[0];
	
				// Insert a row in the table at the last row
				var newRow   = tableRef.insertRow(tableRef.rows.length);
				 
				// Insert a cell in the row at index 0
				var newCell1  = newRow.insertCell(0);
				var newCell2  = newRow.insertCell(1);
				var newCell3  = newRow.insertCell(2);
		
				// Append a text node to the cell
				var newText  = document.createTextNode('New row')
				newCell1.appendChild(document.createTextNode(data.name));
				newCell2.appendChild(document.createTextNode(data.count));
				newCell3.appendChild(document.createTextNode(data.price));
			}
	}
</script>

<div class="modal fade" id="pxItem_list" tabindex="-1" role="dialog" aria-hidden="true">

	<div class="modal-dialog">
		
		<div class="modal-content">
			
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel">전체 상품목록</h4>
			</div>
			
			<div class="modal-body">
			
				<div id="total_item_list" name="total_item_list" style = "overflow : scroll; height : 500px;">
					<table class="table table-hover" id="item_list_table">
					    <thead>
					      <tr>
					        <th>상품명</th>
					        <th>수량</th>
					        <th>가격</th>
					      </tr>
					    </thead>
					    <tbody id="total_item_list_body">
							<%
				
							%>
						</tbody>
					</table>
				
				</div>
			</div>
			
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
		</div>
		
	</div>
	
</div>