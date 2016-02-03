<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.info.EquipmentCategoryInfo"%>
<%@page import="com.secsm.info.AccountInfo"%>
<%@page import="java.util.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");

	@SuppressWarnings("unchecked")
	List<EquipmentCategoryInfo> equipmentCategoryList = (ArrayList<EquipmentCategoryInfo>) request.getAttribute("equipmentCategoryList");
	
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Equipment</title>
    	
	</head>
	
	<script type="text/javascript">
    	
    		function showSearch(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			
    			divSearch.style.display = "";
    			divRental.style.display = "none";
    			divApply.style.display = "none";
    		}
    		
    		function showRental(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			
    			divSearch.style.display = "none";
    			divRental.style.display = "";
    			divApply.style.display = "none";
    		}
    		
    		function showApply(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			
    			divSearch.style.display = "none";
    			divRental.style.display = "none";
    			divApply.style.display = "";
    		}
    	
    		function searchEquipment(){
    			
    			var param = "searchEquipmentType" + "=" + $("#searchEquipmentType").val() + "&" + 
						"searchEquipmentContent" + "="+ $("#searchEquipmentContent").val();
				$.ajax({
				url : "/Secsm/api_searchEquipment",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					alert(response);
					if(response=='200')
					{
					}
					
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}
    		
    		function applyEquipment(){
    			var param = "applyEquipmentContent" + "="+ $("#applyEquipmentContent").val();
				$.ajax({
				url : "/Secsm/api_applyEquipment",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					alert(response);					
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}

    		function reqEquipment(){
    			var param ="reqEquipmentTitle" + "=" + $("#reqEquipmentTitle").val() + "&" + 
						"reqEquipmentContent" + "="+ $("#reqEquipmentContent").val();
				
    			$.ajax({
				url : "/Secsm/api_reqEquipment",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					alert(response);					
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}

    		
    		function onLoad(){
    			if(<%=accountInfo%> == null){
    				location.replace("/Secsm/index");
    			}
    		}
    		
    	</script>
	
	<jsp:include page="base/nav.jsp" flush="true" />
	<body onload="onLoad();">

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> 장비 </h1>
			</div>
			
			<div class="row-fluid">
				<ul >
					<li role="presentation"><a role="menuitem" onclick="showSearch();">장비 검색</a></li>
					<li role="presentation"><a role="menuitem" onclick="showRental();">대여 및 반납</a></li>
					<li role="presentation"><a role="menuitem" onclick="showApply();">장비 요청</a></li>
				</ul>
			
			</div>
			
			<!-- 장비 검색 -->
			<div name="divSearch" id="divSearch" style="display: ;">
				장비 검색
				<select id="searchEquipmentType" name="searchEquipmentType">
					<option value=-1>전체</option>
					<%
						if(equipmentCategoryList != null){
							for(int count = 0;count < equipmentCategoryList.size();count++){
								out.print("<option value=" + equipmentCategoryList.get(count).getId() + ">");
								out.print(equipmentCategoryList.get(count).getName());
								out.print("</option>");
							}
						}
					%>
				</select>
				<input type="text" id="searchEquipmentContent" name="searchEquipmentContent">
				<button class="btn" id="searchEquipmentBtn" name="searchEquipmentBtn" onclick="searchEquipment();">검색</button>
				
			</div>
			
			<!-- 대여 및 반납 -->
			<div name="divRental" id="divRental" style="display: ;">
				대여 및 반납
				<div class="column-filter-widget">
					<input type="text" id="applyEquipmentContent" name="applyEquipmentContent">
				</div>
				<button class="btn" id="applyEquipmentBtn" name="applyEquipmentBtn" onclick="applyEquipment();">검색</button>
				
			</div>
			
			<!-- 장비 요청 -->
			<div name="divApply" id="divApply" style="display: ;">
				장비 요청
				<div style="margin: 30px">
					<div class="column-filter-widget">
						분류
						<select id="reqEquipmentType" name="reqEquipmentType">
							<option value=-1>전체</option>
							<%
								if(equipmentCategoryList != null){
									for(int count = 0;count < equipmentCategoryList.size();count++){
										out.print("<option value=" + equipmentCategoryList.get(count).getId() + ">");
										out.print(equipmentCategoryList.get(count).getName());
										out.print("</option>");
									}
								}
							%>
						</select>
					</div>
					<div class="column-filter-widget">
						장비 명
						<input type="text" id="reqEquipmentTitle" name="reqEquipmentTitle">
					</div>
					
					<div class="column-filter-widget">
						내용
						<input type="text" id="reqEquipmentContent" name="reqEquipmentContent">
					</div>
				</div>
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	


</body>
</html>
