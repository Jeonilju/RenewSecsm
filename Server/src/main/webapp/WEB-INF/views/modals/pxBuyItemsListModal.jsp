<%@page import="com.secsm.conf.Util"%>
<%@page import="com.secsm.info.PxLogInfo"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.PxReqInfo"%>
<%@page import="java.util.List"%>

<%
	List<PxLogInfo> pxLogList = (List<PxLogInfo>)request.getAttribute("pxLogList");
%>

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
