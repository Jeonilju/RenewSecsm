<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<script>

	function not_paid_list(){
	
		var param = "";
	
		$.ajax({
		url : "/Secsm/api_not_paid_list",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {

			var arr = JSON.parse(response);
			not_list_Table(arr);
		
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
		
	function not_list_Table(jsonArr){
			
			document.getElementById('Not_Paid_list_body').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
			var num = 1;
			for(var index = 0;index < jsonArr.length;index++){
				var data = jsonArr[index];
				var tableRef = document.getElementById('Not_Paid_table').getElementsByTagName('tbody')[0];
	
				// Insert a row in the table at the last row
				var newRow   = tableRef.insertRow(tableRef.rows.length);
				 
				// Insert a cell in the row at index 0
				var newCell1  = newRow.insertCell(0);
				var newCell2  = newRow.insertCell(1);
				var newCell3  = newRow.insertCell(2);
				
				// Append a text node to the cell
				var newText  = document.createTextNode('New row')
				if(data.pxAmount < 0){
					newCell1.appendChild(document.createTextNode(num));
					newCell2.appendChild(document.createTextNode(data.name));
					newCell3.appendChild(document.createTextNode(data.pxAmount));
					num++;
				}
			}
	}
</script>

<div class="modal fade" id="view_Not_paidList" tabindex="-1" role="dialog" aria-hidden="true">

	<div class="modal-dialog">
		
		<div class="modal-content">
			
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel">PX 미정산자 명단</h4>
			</div>
			
			<div class="modal-body">
			
				<div id="total_item_list" name="total_item_list" style = "overflow : scroll; height : 500px;">
					<table class="table table-hover" id="Not_Paid_table">
					    <thead>
					      <tr>
					      	<th>No</th>
					        <th>이름</th>
					        <th>금액</th>
					      </tr>
					    </thead>
					    <tbody id="Not_Paid_list_body">
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