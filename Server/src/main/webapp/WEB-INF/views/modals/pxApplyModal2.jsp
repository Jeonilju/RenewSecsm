<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<%
	List<PxReqInfo> pxReqList = (List<PxReqInfo>)request.getAttribute("pxReqList");
%>

<script type="text/javascript">
	
	function pxApplyReq2(){
		var param = "pxApplyTitle" + "=" + $("#pxApplyTitle2").val() + "&" + 
				"pxApplyContent" + "="+ $("#pxApplyContent2").val();
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
				document.getElementById("pxApplyTitle2").value = "";
				document.getElementById("pxApplyContent2").value = "";
				refreshReqTable2()
			}
			
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code___ : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function refreshReqTable2(){
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
			insertReqTable2(arr);
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	
	function insertReqTable2(jsonArr){
		
		document.getElementById('pxReqTbody2').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
		
		for(var index = 0;index < jsonArr.length;index++){
			var data = jsonArr[index];
			var tableRef = document.getElementById('pxReqTable2').getElementsByTagName('tbody')[0];

			// Insert a row in the table at the last row
			var newRow   = tableRef.insertRow(tableRef.rows.length);

			// Insert a cell in the row at index 0
			var newCell1  = newRow.insertCell(0);
			var newCell2  = newRow.insertCell(1);
			var newCell3  = newRow.insertCell(2);
			var newCell4  = newRow.insertCell(3);

			// Append a text node to the cell
			var newText  = document.createTextNode('New row')
			newCell1.appendChild(document.createTextNode(data.id));
			newCell2.appendChild(document.createTextNode(data.title));
			newCell3.appendChild(document.createTextNode(data.context));
			
			var button = document.createElement('input');
			button.setAttribute('type','button');
			button.setAttribute('class','btn btn-default');
			
			if(data.status == 0 ){
				button.setAttribute('value','승인');
				button.setAttribute('OnClick','accept123(' +data.id + ');');
			}
			else{
				button.setAttribute('value','삭제');
				button.setAttribute('OnClick','DeleteReqlist('+ data.id+ ',0)');
			}
			
			newCell4.appendChild(button);
		}
	}
	
	function pxReqSwapBtn2(){
		
		var pxReqDivList2 = document.getElementById("pxReqDivList2");
		var pxReqDivForm2 = document.getElementById("pxReqDivForm2");
		var swapBtn2 = document.getElementById("swapBtn2");
		var pxReqBtn2 = document.getElementById("pxReqBtn2");
		
		var j = swapBtn2.childNodes[0];
		if(pxReqDivList2.style.display == ""){
			// Form으로 변경
			j.innerText = '상품 요청';
			swapBtn2.value = "신청 리스트";
			pxReqBtn2.style.display = "";
		}
		else{
			// list로 변경
			j.innerText = '상품 리스트';
			swapBtn2.value = "상품 요청";
			pxReqBtn2.style.display = "none";
			refreshReqTable2();
		}
		
		var temp = pxReqDivList2.style.display;
		pxReqDivList2.style.display = pxReqDivForm2.style.display;
		pxReqDivForm2.style.display = temp;
	}
	
	function end_apply2(){
		
		var pxReqDivList2 = document.getElementById("pxReqDivList2");
		var pxReqDivForm2 = document.getElementById("pxReqDivForm2");
		var swapBtn2 = document.getElementById("swapBtn2");
		var pxReqBtn2 = document.getElementById("pxReqBtn2");
		
		var j = swapBtn2.childNodes[0];
		
		if(pxReqDivForm2.style.display == ""){
			// list로 변경
			j.innerText = '상품 리스트';
			swapBtn2.value = "상품 요청";
			pxReqBtn2.style.display = "none";
			refreshReqTable2();
			
			var temp = pxReqDivList2.style.display;
			pxReqDivList2.style.display = pxReqDivForm2.style.display;
			pxReqDivForm2.style.display = temp;
		}
		

	}
	
	
	function accept123(idx){
	
		var param = "idx" + "=" + idx;
		
		$.ajax({
		url : "/Secsm/api_Accept",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
		
			if(response=='200')
			{
				alert("승인되었습니다.");
				
				refreshReqTable2()
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		});
	}
	
	function apply2_reset(){
		
		document.getElementById("pxReqDivForm2").reset();
	}
	function DeleteReqlist(idx,check){
		
		var param = "idx" + "=" + idx;
		
		$.ajax({
		url : "/Secsm/api_Delete_req_list",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
		
			if(response=='200')
			{
				alert("삭제 되었습니다.");
				if(check == 0){
					refreshReqTable2();
				}
				else if(check==1){
					refreshReqTable();
				}
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

<div class="modal fade" id="pxApplyModal2" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel2">상품 요청</h4>
			</div>
			
			<div class="modal-body">
			
				<button id="swapBtn2" name="swapBtn2" type="button" class="btn" style="margin: 5px;" onclick="pxReqSwapBtn2();">상품 리스트</button>
			
				<!-- 상품 요청 리스트-->
				<div id="pxReqDivList2" name="pxReqDivList2" style="display: ;">
					<table class="table table-hover" id="pxReqTable2">
					    <thead>
					      <tr>
					        <th>No.</th>
					        <th>제목</th>
					        <th>내용</th>
					        <th>상태</th>
					      </tr>
					    </thead>
					    <tbody id="pxReqTbody2">
							<%
							
							%>
						</tbody>
					</table>
				
				</div>
				
				<!-- 상품 요청 form -->
				<div id="pxReqDivForm2" name="pxReqDivForm2" style="display: none;">
					제목
					<input type="text" id="pxApplyTitle2" class = "form-control" name="pxApplyTitle2">
					
					내용
					<input type="text" id="pxApplyContent2" class = "form-control" name="pxApplyContent2">
				</div>
			</div>
			
			<div class="modal-footer">
				<button id="pxReqBtn2" name="pxReqBtn2" type="button" class="btn btn-default" onclick="pxApplyReq2();" style="display: none;">요청</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick = "end_apply2();">닫기</button>
			</div>
		</div>
		
		<!-- /.modal-content -->
	</div>
</div>
<!-- 신청 -->