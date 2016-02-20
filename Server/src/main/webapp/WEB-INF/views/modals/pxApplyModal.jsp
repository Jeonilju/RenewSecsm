<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<%
	List<PxReqInfo> pxReqList = (List<PxReqInfo>)request.getAttribute("pxReqList");
%>

<script type="text/javascript">
	
	function pxApplyReq(){
		var param = "pxApplyTitle" + "=" + $("#pxApplyTitle").val() + "&" + 
				"pxApplyContent" + "="+ $("#pxApplyContent").val();
		$.ajax({
		url : "/Secsm/api_applyReq",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
		
			if(response=='200')
			{
				alert("요청되었습니다.");
				document.getElementById("pxApplyTitle").value = "";
				document.getElementById("pxApplyContent").value = "";
				refreshReqTable()
			}
			
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function refreshReqTable(){
		var param = "";
		
		$.ajax({
		url : "/Secsm/api_applyReqList",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			var arr = JSON.parse(response);
			insertReqTable(arr);
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function insertReqTable(jsonArr){
		
		document.getElementById('pxReqTbody').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
		
		for(var index = 0;index < jsonArr.length;index++){
			var data = jsonArr[index];
			var tableRef = document.getElementById('pxReqTable').getElementsByTagName('tbody')[0];

			// Insert a row in the table at the last row
			var newRow   = tableRef.insertRow(tableRef.rows.length);
			 
			// Insert a cell in the row at index 0
			var newCell1  = newRow.insertCell(0);
			var newCell2  = newRow.insertCell(1);
			var newCell3  = newRow.insertCell(2);
			var newCell4  = newRow.insertCell(3);
			var newCell5  = newRow.insertCell(4);
			
			// Append a text node to the cell
			var newText  = document.createTextNode('New row')
			newCell1.appendChild(document.createTextNode(data.id));
			newCell2.appendChild(document.createTextNode(data.title));
			newCell3.appendChild(document.createTextNode(data.context));
			
			if(data.status == 0 ){
				newCell4.appendChild(document.createTextNode('승인 중'));
				
			}
			else{
				newCell4.appendChild(document.createTextNode('승인완료'));
				var button = document.createElement('input');
				button.setAttribute('type','button');
				button.setAttribute('class','btn btn-default');
				button.setAttribute('value','삭제');
				button.setAttribute('OnClick','DeleteReqlist('+ data.id+ ',1)');
				newCell5.appendChild(button);
			}
		}
	}
	
	function pxReqSwapBtn(){
		
		var pxReqDivList = document.getElementById("pxReqDivList");
		var pxReqDivForm = document.getElementById("pxReqDivForm");
		var swapBtn = document.getElementById("swapBtn");
		var pxReqBtn = document.getElementById("pxReqBtn");
		
		var j = swapBtn.childNodes[0];
		if(pxReqDivList.style.display == ""){
			// Form으로 변경
			j.innerText = '상품 요청';
			swapBtn.value = "신청 리스트";
			pxReqBtn.style.display = "";
		}
		else{
			// list로 변경
			j.innerText = '상품 리스트';
			swapBtn.value = "상품 요청";
			pxReqBtn.style.display = "none";
			refreshReqTable();
		}
		
		var temp = pxReqDivList.style.display;
		pxReqDivList.style.display = pxReqDivForm.style.display;
		pxReqDivForm.style.display = temp;
	}
	
	function end_apply(){
		
		var pxReqDivList = document.getElementById("pxReqDivList");
		var pxReqDivForm = document.getElementById("pxReqDivForm");
		var swapBtn = document.getElementById("swapBtn");
		var pxReqBtn = document.getElementById("pxReqBtn");
		
		var j = swapBtn.childNodes[0];
		if(pxReqDivList.style.display == ""){
			// Form으로 변경
			j.innerText = '상품 요청';
			swapBtn.value = "신청 리스트";
			pxReqBtn.style.display = "";

			var temp = pxReqDivList.style.display;
			pxReqDivList.style.display = pxReqDivForm.style.display;
			pxReqDivForm.style.display = temp;
		}
		
	}
		
	
	function apply_reset(){
		
		document.getElementById("pxReqDivForm").reset();
	}
</script>

<div class="modal fade" id="pxApplyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel">상품 요청</h4>
			</div>
			
			<div class="modal-body">
			
			
			<button id="swapBtn" name="swapBtn" type="button" class="btn" style="margin: 5px;" onclick="pxReqSwapBtn();"><span>상품요청</span></button>
		
			
				<!-- 상품 요청 리스트-->
				<div id="pxReqDivList" name="pxReqDivList" style="display: none;">
					<table class="table table-hover" id="pxReqTable">
					    <thead>
					      <tr>
					        <th>No.</th>
					        <th>제목</th>
					        <th>내용</th>
					        <th>상태</th>
					      </tr>
					    </thead>
					    <tbody id="pxReqTbody">
							<%
							
							%>
						</tbody>
					</table>
				
				</div>
				
				<!-- 상품 요청 form -->
				<div id="pxReqDivForm" name="pxReqDivForm" style="display: ;">
					제목
					<input type="text" id="pxApplyTitle" class = "form-control" name="pxApplyTitle">
					
					내용
					<input type="text" id="pxApplyContent" class = "form-control" name="pxApplyContent">
				</div>
			</div>
			
			<div class="modal-footer">
				<button id="pxReqBtn" name="pxReqBtn" type="button" class="btn btn-default" onclick="pxApplyReq();" style="display: ;">요청</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick = "end_apply();">닫기</button>
			</div>
		</div>		
		<!-- /.modal-content -->
	</div>
</div>
<!-- 신청 -->