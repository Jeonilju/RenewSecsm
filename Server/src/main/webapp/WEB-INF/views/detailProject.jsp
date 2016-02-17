<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@page import="com.secsm.conf.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
	ProjectInfo info = (ProjectInfo) request.getAttribute("projectInfo");
	ArrayList<AttachInfo> attachList = (ArrayList<AttachInfo>) request.getAttribute("attachList");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title><%=info.getName() %></title>
    	
    	<script type="text/javascript">
    	
    		function setPorjectStatus(status){
    			var param = "projectId" + "=" + $("#projectId").val() + "&" + 
							"status" + "="+ status;
			
				$.ajax({
				url : "/Secsm/api_setProjectStatus",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					if(response=='200')
					{
						alert("변경되었습니다.");
					}
					else{
						alert("반영되지 않았습니다.");
					}
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				
				});
    		}
    		
    		function FileDownloadClick(filename)
			{
		    	var method = "post";  //method 부분은 입력안하면 자동으로 post가 된다.
		    	var form = document.createElement("form");
			    
		    	if(filename == "")
			    	return;
		    	
		    	form.setAttribute("method", "post");
		    	form.setAttribute("action", "/Secsm/FileDownload");
			    
		    	var hiddenField = document.createElement("input");
		    	hiddenField.setAttribute("type", "hidden");
		    	hiddenField.setAttribute("name", "filename");
		    	hiddenField.setAttribute("value", filename);
		    	form.appendChild(hiddenField);
			        
		    	document.body.appendChild(form);
		   		form.submit();
			}
    		
    		/** 프로젝트 삭제 */
    		function removeProject(){
    			if (confirm("프로젝트를 삭제합니다.\n정말 삭제하시겠습니까?") == true){    
    				//확인
    				var param = "projectId" + "=" + $("#projectId").val();
				
					$.ajax({
					url : "/Secsm/api_removeProject",
					type : "POST",
					data : param,
					cache : false,
					async : false,
					dataType : "text",
					
					success : function(response) {	
						if(response=='200')
						{
							// 정상 삭제
							location.replace("/Secsm/project");
						}
						else if(response == '400'){
							// 비로그인
							location.replace("/Secsm/index");
						}
						else if(response == '401'){
							// 자기 프로젝트 아님
							alert("권한이 없습니다.");
						}
					},
					error : function(request, status, error) {
						if (request.status != '0') {
							alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
						}
					}
					
					});
    			}else{   
    				//취소
    				return;
    			}
    		}
    		
    	</script>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>
		<div class="container body-content" style="margin-top: 150px;">
			<input id="projectId" name="projectId" type="text" style="display: none;" value="<%=info.getId()%>">
			<div class="row">
				<h1> <%=info.getName() %> </h1>
			</div>
			<div class="row" style="margin: 20px">
				<h5>프로젝트 기간</h5>
				<%=Util.getTimestempStr(info.getStartDate()) %> ~ <%=Util.getTimestempStr(info.getEndDate()) %> 
			</div>

			<div class="row" style="margin: 20px">
				<h5>프로젝트 요약</h5>
				<pre style="background: #FFFFF0;"><%= info.getSummary() %></pre>
			</div>

			<div class="row" style="margin: 20px">
				<h5>프로젝트 내용</h5>
				<pre style="background: #FFFFF0;"><%= info.getDescription() %></pre>
			</div>

			<div class="row" style="margin: 20px">
				<h5>PL 및 팀원</h5>
				PL: <%= info.getPl() %><br/>
				팀원: <%= info.getTeam() %>
			</div>
			
			<div class="row" style="margin: 20px">
				<h5>첨부파일</h5>
				<table class="table" style="width: auto;">
					<thead>
						<tr>
							<th style="width: auto;">No.</th>
							<th>Tag</th>
							<th>Attach</th>
						</tr>
					</thead>
					<tbody style="width: auto;">
						<%
							for (AttachInfo attachInfo : attachList){
								out.println("<tr>");
								out.println("<td>" + attachInfo.getId() + "</td>");
								out.println("<td>" + attachInfo.getTag() + "</td>");
								out.println("<td style=\"cursor:pointer;\" onclick=\"FileDownloadClick('" + attachInfo.getName() + "');\">" + attachInfo.getName() + "</td>");
								out.println("</tr>");
							}
						%>
					</tbody>
				</table>
			</div>
			
			<div class="row" align="right" style="display: <% 
				if(accountInfo.getId() == info.getAccountId())
					out.print("");
				else
					out.print("none");
				%>;">
				<button type="button" class="btn" data-toggle="modal" data-target="#projectAddAttach" style="margin: 5px;">문서 등록</button>
				<button type="button" class="btn" style="margin: 5px;" data-toggle="modal" data-target="#projectUpdate">프로젝트 수정</button>
				<button type="button" class="btn" style="margin: 5px;" onclick="removeProject();">프로젝트 삭제</button>
			</div>
			
			<div class="row" align="right" style="display: <% 
				if(accountInfo.getGrade() == 0 || accountInfo.getGrade() == 1)
					out.print("");
				else
					out.print("none");
				%>;">
				<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(1);">프로젝트 승인</button>
				<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(-1);">프로젝트 드랍</button>
				<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(2);">프로젝트 완료</button>
			</div>
			
		</div>
		
		<jsp:include page="base/foot.jsp" flush="false" />
		<jsp:include page="modals/projectAddAttachModal.jsp" flush="false"/>
		<jsp:include page="modals/projectUpdateModal.jsp" flush="false"/>
		
	</body>
</html>
