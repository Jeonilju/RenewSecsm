<%@page import="com.secsm.conf.Util"%>
<%@page import="com.secsm.info.PxLogInfo"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>


<%
	List<PxLogInfo> pxLogList = (List<PxLogInfo>)request.getAttribute("pxLogList");
%>

<script type="text/javascript">

					var pagenum = 10;
					
					function refund(idx,chk) {
						var param = "idx" + "=" + idx;
						
						$.ajax({
							url : "/Secsm/Refund_px_items",
							type : "POST",
							data : param,
							cache : false,
							async : false,
							dataType : "text",
							
							success : function(response) {	
		    					if(response=='200')
		    					{
		    						alert("환불되었습니다!");
		    						if(chk==0){
		    							log_detail(0);
		    						}
		    						else if(chk == 1){
		    							num--;
		    							semi_List(num);
		    							if(num ==0){
		    								view_buylist_remove();
		    							}
		    						}
		    					}
		    					else
		    					{
		    						alert("환불할 수 없습니다.");
		    					}
		    				},
							error : function(request, status, error) {
								if (request.status != '0') {
									alert("code** : " + request.status + "\r\nmessage : "
											+ request.reponseText + "\r\nerror : " + error);
								}
							}
						});
					}
					
					function log_detail(opt) {
					
						if(opt==0){
							
							pagenum = 0;
						}
						else if(opt==1){
							pagenum = pagenum - 10;
						}
						else if(opt==2){
							pagenum = pagenum + 10;
						}
						
						
						var param = "opt" + "=" + opt + "&" + 
									"pagenum" + "=" + pagenum;
						
						$.ajax({
							url : "/Secsm/api_getPxLog",
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
		    						insertLogTable(arr);
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
					
					function insertLogTable(jsonArr){
						
						document.getElementById('pxLogTbody').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
						
						for(var index = jsonArr.length-1;index >=0;index--){
							var data = jsonArr[index];
							var tableRef = document.getElementById('pxLogTable').getElementsByTagName('tbody')[0];

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
							var newText  = document.createTextNode('New row');
						//	Util.getTimestempStr
							newCell1.appendChild(document.createTextNode(data.regDate));
							newCell2.appendChild(document.createTextNode(data.name));
							newCell3.appendChild(document.createTextNode(data.count));
							newCell4.appendChild(document.createTextNode(data.price));
							newCell5.appendChild(document.createTextNode(data.with_buy));
							
							var button = document.createElement('input');
							button.setAttribute('type','button');
							button.setAttribute('class','btn btn-default');
							button.setAttribute('value','환불');
							button.setAttribute('OnClick','refund(' +data.id + ',0)');
							newCell6.appendChild(button);
							
							
						}
					}
</script>
			
<!-- 내역 조회 -->
<div class="modal fade" id="pxBuyItemsListModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel">내역 조회</h4>
			</div>
			

			<div class="modal-body">
				
					<table class="table table-hover" id = "pxLogTable">
				 	   <thead>
				   	   <tr>
				   	     <th>날짜</th>
				   	     <th>내용</th>
				   	     <th>수량</th>
				   	     <th>금액</th>
				   	     <th>함께 구매한 사람</th>
				   	     <th>비고</th>
				   	   </tr>
				  	  </thead>
				   		 <tbody id = "pxLogTbody">
		
				    	</tbody>
				 	 </table>
					<button type="button" class="btn btn-sm" onclick="log_detail(1);" style="margin: 5px;">이전</button>
					<button type="button" class="btn btn-sm" onclick="log_detail(2);" style="margin: 5px; margin-left:0px;">다음</button>
			</div>
			<div class="modal-footer">
				<button type="button" onclick = "getPxAmount();" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
</div>

