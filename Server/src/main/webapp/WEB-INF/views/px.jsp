<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
%>


<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>PX</title>
    	
    	<script type="text/javascript">
    	
    	
    		/** 아이템 구매 */
    		function buyItemss(){
    				
    		}
    		
    		/** 바코드창으로 포커싱 */
    		function forcusToEditor(){
    			
    		}
    		
    		/** 상품 요청 */
    		function requestItem(){
    			
    		}
    		
    		function onLoad(){
    			<%
					if(accountInfo == null){
						out.println("location.replace(\"/Secsm/index\");");
					}
				%>
			}
    		
    	</script>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body onload="onLoad();">

		<div class="container body-content" style="margin-top: 150px; height: 200px;">
			<div class="row-fluid">
				<h1> PX </h1>
			</div>
			
			<div class="row-fluid">
					<button type="button" class="btn" style="margin: 5px; width: 260px; height: 100px" data-toggle="modal" data-target="#pxBuyItemsModal" >상품 구매</button>
					<button type="button" class="btn" style="margin: 5px; width: 260px; height: 100px" data-toggle="modal" data-target="#pxBuyItemsListModal" >내역 조회</button>
					<%
						if(accountInfo.getGrade() == 5 || accountInfo.getGrade() == 0){
							out.println("<button type=\"button\" class=\"btn\" style=\"margin: 5px; width: 260px; height: 100px\" data-toggle=\"modal\" data-target=\"#pxApplyModal2\" >상품 요청</button>");
							out.println("<button type=\"button\" class=\"btn\" style=\"margin: 5px; width: 260px; height: 100px\" data-toggle=\"modal\" data-target=\"#pxAddModal\" >상품 추가</button>");
						}
						else{
							out.println("<button type=\"button\" class=\"btn\" style=\"margin: 5px; width: 260px; height: 100px\" data-toggle=\"modal\" data-target=\"#pxApplyModal\" >상품 요청</button>");
						}
					%>
			</div>
		</div>	
		<jsp:include page="base/foot.jsp" flush="false" />
		
	</body>

	<jsp:include page="modals/pxBuyItemsModal.jsp" flush="false" />
	<jsp:include page="modals/pxBuyItemsListModal.jsp" flush="false" />
	<jsp:include page="modals/pxApplyModal.jsp" flush="false" />
	<jsp:include page="modals/pxAddModal.jsp" flush="false" />
	<jsp:include page="modals/pxApplyModal2.jsp" flush="false" />
</html>
