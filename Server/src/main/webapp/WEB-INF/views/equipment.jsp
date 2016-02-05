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
	
	<body onload="onLoad();">
	
	<script type="text/javascript">
    	
    		function showSearch(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			var divAdd = document.getElementById("divAdd");
    			
    			divSearch.style.display = "";
    			divRental.style.display = "none";
    			divApply.style.display = "none";
    			divAdd.style.display = "none";
    		}
    		
    		function showRental(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			var divAdd = document.getElementById("divAdd");
    			
    			divSearch.style.display = "none";
    			divRental.style.display = "";
    			divApply.style.display = "none";
    			divAdd.style.display = "none";
    		}
    		
    		function showApply(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			var divAdd = document.getElementById("divAdd");
    			
    			divSearch.style.display = "none";
    			divRental.style.display = "none";
    			divApply.style.display = "";
    			divAdd.style.display = "none";
    		}
    		
    		function showAdd(){
    			var divSearch = document.getElementById("divSearch");
    			var divRental = document.getElementById("divRental");
    			var divApply = document.getElementById("divApply");
    			var divAdd = document.getElementById("divAdd");
    			
    			divSearch.style.display = "none";
    			divRental.style.display = "none";
    			divApply.style.display = "none";
    			divAdd.style.display = "";
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
					var arr = JSON.parse(response);
					insertSearchTable(arr);
					
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}
    		
    		function applyEquipment(){
    			var param = "applyEquipmentType" + "=" + $("#applyEquipmentType").val() + "&" + 
					"applyEquipmentContent" + "="+ $("#applyEquipmentContent").val();
				
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

    		function addEquipment(){
    			var param ="addEquipmentName" + "=" + $("#addEquipmentName").val() + "&" +
		    			"addEquipmentCode" + "=" + $("#addEquipmentCode").val() + "&" +
		    			"addEquipmentCount" + "=" + $("#addEquipmentCount").val() + "&" +
		    			"addEquipmentType" + "=" + $("#addEquipmentType").val() + "&" +
						"addEquipmentContent" + "="+ $("#addEquipmentContent").val();
				
				$.ajax({
				url : "/Secsm/api_addEquipment",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					if(response == '200'){
						alert("추가되었습니다.");
								
					}
					
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}
    		
    		function onLoad(){
    			<%
    				if(accountInfo == null){
    					out.println("location.replace(\"/Secsm/index\");");
    				}
    			%>
    		}
    		
    		/** 검색 테이블 삽입 */
    		function insertSearchTable(jsonArr){
    			
    			document.getElementById('equipmentSearchTbody').innerHTML = "";	// 기존 테이블에 있는 내용 초기화
    			
    			for(var index = 0;index < jsonArr.length;index++){
    				var data = jsonArr[index];
    				var tableRef = document.getElementById('equipmentSearchTable').getElementsByTagName('tbody')[0];

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
    				newCell2.appendChild(document.createTextNode(data.name));
    				newCell3.appendChild(document.createTextNode(data.count));
    				newCell4.appendChild(document.createTextNode(data.status));
    			}
    		}
    		
    	</script>
	
		<jsp:include page="base/nav.jsp" flush="true" />
		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> 장비 </h1>
			</div>
			
			<div class="row-fluid">
				<ul >
					<li role="presentation" style="cursor:pointer"><a role="menuitem" onclick="showSearch();">장비 검색</a></li>
					<li role="presentation" style="cursor:pointer"><a role="menuitem" onclick="showRental();">대여 및 반납</a></li>
					<li role="presentation" style="cursor:pointer"><a role="menuitem" onclick="showApply();">장비 요청</a></li>
					
					<%
//						if(accountInfo.getGrade() == 4 || accountInfo.getGrade() == 0){
							// 장비부장 or 최고관리자
							out.println("<li role=\"presentation\" style=\"cursor:pointer\" ><a role=\"menuitem\" onclick=\"showAdd();\">장비 추가</a></li>");
//						}
					%>
				</ul>
			
			</div>
			
			<!-- 장비 검색 -->
			<div name="divSearch" id="divSearch" style="display: none;">
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
				
				<table id="equipmentSearchTable" class="table table-hover" >
					<thead>
						<td>id</td>
						<td>이름</td>
						<td>수량</td>
						<td>상태</td>
					</thead>
					<tbody id="equipmentSearchTbody">
						
					</tbody>
				</table>
				
			</div>
			
			<!-- 대여 및 반납 -->
			<div name="divRental" id="divRental" style="display: ;">
				대여 및 반납
				<select id="applyEquipmentType" name="applyEquipmentType">
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
				
				<div class="column-filter-widget">
					<input type="text" id="applyEquipmentContent" name="applyEquipmentContent">
				</div>
				<button class="btn" id="applyEquipmentBtn" name="applyEquipmentBtn" onclick="applyEquipment();">검색</button>
				
			</div>
			
			<!-- 장비 요청 -->
			<div name="divApply" id="divApply" style="display: none;">
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
				<button class="btn" id="applyEquipmentBtn" name="applyEquipmentBtn" onclick="reqEquipment();">요청</button>
				</div>
			</div>
			
			<!-- 장비 추가 -->
			<div name="divAdd" id="divAdd" style="display: none;">
				장비 추가
				<div style="margin: 30px">
					<div class="column-filter-widget">
						분류
						<select id="addEquipmentType" name="addEquipmentType">
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
						<input type="text" id="addEquipmentName" name="addEquipmentName">
					</div>
					
					<div class="column-filter-widget">
						코드
						<input type="text" id="addEquipmentCode" name="addEquipmentCode">
					</div>
					
					<div class="column-filter-widget">
						수량
						<input type="text" id="addEquipmentCount" name="addEquipmentCount">
					</div>
					
					<div class="column-filter-widget">
						설명
						<input type="text" id="addEquipmentContent" name="addEquipmentContent">
					</div>
					
					<button class="btn" id="addEquipmentBtn" name="addEquipmentBtn" onclick="addEquipment();">추가</button>
					
				</div>
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	


</body>
</html>
