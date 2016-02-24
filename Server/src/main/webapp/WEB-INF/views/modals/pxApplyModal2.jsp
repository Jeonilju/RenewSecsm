<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8" %>

<%
	List<PxReqInfo> pxReqList = (List<PxReqInfo>)request.getAttribute("pxReqList");
%>

<script type="text/javascript">
	var pagenum = 10;
	
	function pxApplyReq2(){
		var param = "pxApplyTitle" + "=" + $("#pxApplyTitle2").val() + "&" + 
				"pxApplyContent" + "="+ $("#pxApplyContent2").val();
		
		var form = document.apply2_form;
		
		if(form.pxApplyTitle2.value == ""){
			alert("상품명을 입력해주세요.");
		}
		else if(form.pxApplyTitle2.value.length>50){
			alert("상품명이 은 50자를 넘을 수 없습니다.");
		}
		else if(form.pxApplyContent2.value.length>200){
			alert("설명은 200자를 넘을 수 없습니다.");
		}
		else{
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
					refreshReqTable2(0);
				}
			
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code___ : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
		
			});
		}
	}
	function refreshReqTable2(opt){
		
		if(opt==0){
			pagenum = 0;
		}
		else if(opt==1){
			pagenum = pagenum - 10;
		}
		else if(opt==2){
			pagenum = pagenum + 10;
		}
		
		var param = "pagenum" + "=" + pagenum;
		
		$.ajax({
		url : "/Secsm/api_applyReqList",
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
				insertReqTable2(arr);
			}
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
			
			
			if(data.status == 0 ){
				button.setAttribute('class','btn btn-info');
				button.setAttribute('value','승인');
				button.setAttribute('OnClick','accept123(' +data.id + ');');
			}
			else{
				button.setAttribute('class','btn btn-danger');
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
					        <th>상품명</th>
					        <th>내용</th>
					        <th>상태</th>
					      </tr>
					    </thead>
					    <tbody id="pxReqTbody2">
							<%
							
							%>
						</tbody>
					</table>
				<button type="button" class="btn btn-sm" onclick="refreshReqTable2(1);" style="margin: 5px;">이전</button>
				<button type="button" class="btn btn-sm" onclick="refreshReqTable2(2);" style="margin: 5px; margin-left:0px;">다음</button>
				
				</div>
				
				<!-- 상품 요청 form -->
			<form id= "apply2_form" name= "apply2_form" onsubmit="pxApplyReq2();inputreset(4);return false">
				<div id="pxReqDivForm2" name="pxReqDivForm2" style="display: none;">
					상품명
					<input type="text" id="pxApplyTitle2" class = "form-control" name="pxApplyTitle2" autofocus >
					
					내용
					<input type="text" id="pxApplyContent2" class = "form-control" name="pxApplyContent2">
				</div>
			</div>
			
			<div class="modal-footer">
				<input id="pxReqBtn2" name="pxReqBtn2" type="submit" value="요청" class="btn btn-default" style="display: none;">
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick = "end_apply2();">닫기</button>
			</div>
			</form>
		</div>
		
		<!-- /.modal-content -->
	</div>
</div>
<!-- 신청 -->