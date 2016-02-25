
<%@page import="com.secsm.info.AccountInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<script type="text/javascript">

	function member_info(){
		var id = "";
		var index = "";
	}
	
	function member_select(){
		
		var param = "";
		$.ajax({
			url : "/Secsm/api_togetherList",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {
				
				if(response == "400"){
					alert("마지막 페이지 입니다.");
					pagenum = pagenum - 10;
				}
				else if(response == "300"){
					alert("첫페이지 입니다.");
					pagenum = 0;
				}
				else{
					var arr = JSON.parse(response);
					MemberListTable(arr);
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}
	
	function MemberListTable(jsonArr){
			
			document.getElementById('pxTogetherBody').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
			
			for(var index = 0;index < jsonArr.length;index++){
				var data = jsonArr[index];
				var tableRef = document.getElementById('pxTogetherTable').getElementsByTagName('tbody')[0];
	
				// Insert a row in the table at the last row
				var newRow   = tableRef.insertRow(tableRef.rows.length);
	
				// Insert a cell in the row at index 0
				var newCell1  = newRow.insertCell(0);
				var newCell2  = newRow.insertCell(1);
	
				// Append a text node to the cell
				var newText  = document.createTextNode('New row')
				newCell1.appendChild(document.createTextNode(data.name));
				
				var chkbox = document.createElement('input');
				chkbox.setAttribute('type','checkbox');
				chkbox.setAttribute('name','together');
				chkbox.setAttribute('value',data.id);
				newCell2.appendChild(chkbox);
			}
			
	//		var newCell3  = newRow.insertCell(0);
	//		var button = document.createElement('input');
	//		button.setAttribute('type','button');
	//		button.setAttribute('class','btn btn-default');
	//		button.setAttribute('value','확인');
	//		button.setAttribute('OnClick','together_list(0)');
	//		newCell3.appendChild(button);
			
		}
</script>

<!-- 함께 구매할 회원 선택 모달 -->
<div class="modal fade" id="pxItem_buy_together" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="SignInModalLabel">함께 구매할 회원 선택</h4>
				</div>
				<div class="modal-body"  style = "overflow : scroll; height : 500px;" >
				
					<table class="table table-hover" id = "pxTogetherTable">
						<thead>
							<tr>
							<th style=" width: 166px;">이름</th>
							<th>확인</th>
							</tr>
						</thead>
							<tbody id = "pxTogetherBody">
							
							</tbody>
						
					</table>
					<div style="height: 40px;"></div>
				</div>
				
				<div class="modal-footer">
				<input type = "button" class = "btn btn-default" value = "확인" Onclick = "together_list(0)" data-dismiss="modal"/>
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
				
		</div>
	
	</div>
</div>