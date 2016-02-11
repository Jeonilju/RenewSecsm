<%@page import="com.secsm.conf.Util"%>
<%@page import="com.secsm.info.PxLogInfo"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>


<%
	List<PxLogInfo> pxLogList = (List<PxLogInfo>)request.getAttribute("pxLogList");
%>

<script type="text/javascript">

					function refund(idx) {
						alert(idx);
						var param = "idx" + "=" + $("#idx").val();
					
						$.ajax({
							url : "/Secsm/Refund_px_items",
							type : "POST",
							data : param,
							cache : false,
							async : false,
							dataType : "text",
							
							success : function(response) {	
		    					alert(response);
		    					if(response=='200')
		    					{
		    						alert("환불되었습니다!");
		    						location.reload();
		    					}
		    					else
		    					{
		    						alert("환불할 수 없습니다.");
		    						
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
</script>
			
<!-- 내역 조회 -->
<div class="modal fade" id="pxBuyItemsListModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="SignInModalLabel">내역 조회</h4>
			</div>
			

			<div class="modal-body">
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>날짜</th>
				        <th>내용</th>
				        <th>수량</th>
				        <th>금액</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<%
				    		for(PxLogInfo info : pxLogList){
				    			out.print("<tr>");
				    			out.print("<td>" + Util.getTimestempStr(info.getRegDate()) + "</td>");
				    			out.print("<td>" + (info.getName()) + "</td>");
				    			out.print("<td>" + (info.getCount()) + "</td>");
				    			out.print("<td>" + (info.getPrice()) + "</td>");
				    			out.print("<td>"+"<button type = 'button' class='btn btn-default' id = 'refund' onclick = 'refund("+ info.getId()+");'>환불</button>"+"</td>");
				    			out.print("</tr>");
				    		}
				    	%>
				    </tbody>
				  </table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
</div>

