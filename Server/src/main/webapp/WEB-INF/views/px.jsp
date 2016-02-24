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
    		
    		
    		function view_buylist(){
    			var view_list = document.getElementById("cur_list");
    			var temp_list = document.getElementById("empty_list");
    			view_list.style.display = "";
    			temp_list.style.display = "none";
    		}
    		
    	</script>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body onload="onLoad();getPxAmount();">

		<div class="container body-content" style="margin-top: 150px;">
			<div class="row-fluid">
				<h1 style="
				height: 10px;
				margin-bottom: 10px;
				"> PX </h1>
			</div>
			
			
			<div class = "buy_item">
				<div class="modal-body" >
				
					<div class="row-fluid" style="height: 40px;">
					<div class="col-md-9"></div>
						내 잔액 : 
				   	     	<label id="amount" style="padding-right: 0px;margin-bottom : 0px;width: 70px;margin-left: 20px;"></label>
				   	     	<button onclick="getPxAmount();inputreset(1);" type="button" class="btn" style="margin: 5px; " data-toggle="modal" data-target="#pxChargemoneyModal">금액 충전</button>
					</div>
					
					<div class="row-fluid">
	
					<table class="table table-hover" style = "margin-bottom : 0px">
						
						<thead>
						<tr>
							<th><div class=""></div></th>
							<th style="widhth : 66px;padding-left: 60px;width: 198px;">분류</th>
				   	     	<th style="padding-left: 125px;width: 301px;">상품명</th>
				   	     	<th style="padding-left: 40px;">수량</th>
				   	     </tr> 
				   	     </thead>
					</table>
	
					</div>
					
					<form id= "buy_form" name = "buy_form" onsubmit="buyItem();getPxAmount();inputreset(0); return false">
					<div  class="row-fluid">
						<div class="col-md-1"></div>
						<div class="col-md-3" style="width: 180px;">
							<select id="slItemType" name="slItemType" class="form-control" style="width: 132.22222px;">
								<option value="0"> 바코드 </option>
								<option value="1"> 상품 명 </option>
							</select>
						</div>
						<div id="box2" class="col-md-3">
							<input id="etItemCode" name="etItemCode" class="form-control ui-autocomplete-input" type="text" onkeypress="auto_list();" style="width: 302.22222px;" autocomplete="off">
						</div>
						
						<div class="col-md-1">
							<input id="item_cnt" name="item_cnt" class="form-control" type="text" style="margin-left: 50px;width: 82.22222px;">
						</div>
						
						<div class="col-md-5">
							<input type="submit" class="btn btn-default" value="구입" style="margin-left: 50px;">
						</div>
					</div>
				</form>
					
					<div style="height: 60px;"></div>
				</div>
			
				<div id = "cur_list" name = "cur_list" style="display: none; margin-left: 130px;">
				<div style="height: 40px;"></div>
					
					<h4>최근 구매내역</h4>
					<div style="height: 30px;"></div>
					
					<table class="table table-hover" id = "currentbuyTable" style = "margin-left : 50px">
				 	   <thead>
				   	   <tr>
				   	
				   	     <th style = "width:216px">날짜</th>
				   	     <td style="width: 166px;">상품명</td>
				   	     <td style="width: 166px;">금액</td>
				   	     <td style="width: 86px;">수량</td>
				   	   </tr>
				  	  </thead>
				   		 <tbody id = "pxCurrentbuyTbody">
		
				    	</tbody>
				 	 </table>
				 	 <div style="height: 40px;"></div>
				</div>
				
				<div id = "empty_list" name = "empty_list" style="display: ;">
					<div style="height: 150px;"></div>
				</div>
				
			</div>
			
			<div class="row-fluid">
					<div class="col-md-1" style = "width : 130px;"></div>
					<button onclick = "log_detail(0);" type="button" class="btn" style="margin: 5px; " data-toggle="modal" data-target="#pxBuyItemsListModal" >내역 조회</button>
					<%
						if(accountInfo.getGrade() == 4 || accountInfo.getGrade() == 0){
							out.println("<button onclick= \"refreshReqTable2(0);inputreset(4);\" type=\"button\" class=\"btn\" style=\"margin: 5px; \" data-toggle=\"modal\" data-target=\"#pxApplyModal2\" >상품 요청</button>");
							out.println("<button onclick= \"inputreset(2);\" type=\"button\" class=\"btn\" style=\"margin: 5px;\" data-toggle=\"modal\" data-target=\"#pxAddModal\" >상품 추가</button>");
						}
						else{
							out.println("<button onclick= \"refreshReqTable(0);inputreset(3);\" type=\"button\" class=\"btn\" style=\"margin: 5px; \" data-toggle=\"modal\" data-target=\"#pxApplyModal\" >상품 요청</button>");
						}
					%>
					<button type="button" onclick = "total_item_list();" class="btn" style="margin: 5px; " data-toggle="modal" data-target="#pxItem_list" >전체 상품목록</button>
					
					
			</div>
			
		</div>
		<jsp:include page="modals/pxBuyItemsModal.jsp" flush="false" />
		<jsp:include page="modals/pxBuyItemsListModal.jsp" flush="false" />
		<jsp:include page="modals/pxApplyModal.jsp" flush="false" />
		<jsp:include page="modals/pxAddModal.jsp" flush="false" />
		<jsp:include page="modals/pxApplyModal2.jsp" flush="false" />
		<jsp:include page="modals/pxChargemoneyModal.jsp" flush="false" />	
		<jsp:include page="modals/pxItem_list.jsp" flush="false" />
		<jsp:include page="base/foot.jsp" flush="false"/>
	</body>
</html>
