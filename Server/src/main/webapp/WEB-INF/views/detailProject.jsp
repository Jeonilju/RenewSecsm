<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@page import="com.secsm.conf.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	ProjectInfo info = (ProjectInfo) request.getAttribute("projectInfo");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title><%=info.getName() %></title>
    	
    	<script type="text/javascript">
    	
    		function setPorjectStatus(status){
    			var param = "projectId" + "=" + $("#pxItemsName").val() + "&" + 
							"status" + "="+ $("#pxItemsCount").val();
			
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
					}
					else{
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
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> <%=info.getName() %> </h1>
			</div>
			<div class="row-fluid">
				프로젝트 기간	
				<%=Util.getTimestempStr(info.getStartDate()) %> ~ <%=Util.getTimestempStr(info.getEndDate()) %> 
			</div>

			<div class="row-fluid">
				프로젝트 요약
				<%= info.getSummary() %>
			</div>

			<div class="row-fluid">
				프로젝트 내용
				<%= info.getDescription() %>
			</div>

			<div class="row-fluid">
				PL 및 팀원
				PL: <%= info.getPl() %>
				팀원: <%= info.getTeam() %>
			</div>
			
		</div>

		<div>
			<button type="button" class="btn" style="margin: 5px;">문서 등록</button>
			<button type="button" class="btn" style="margin: 5px;">프로젝트 수정</button>
			<button type="button" class="btn" style="margin: 5px;">프로젝트 삭제</button>
		</div>
		
		<div>
			<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(1);">프로젝트 승인</button>
			<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(-1);">프로젝트 드랍</button>
			<button type="button" class="btn" style="margin: 5px;" onclick="setPorjectStatus(2);">프로젝트 완료</button>
		</div>
		
		
		<jsp:include page="base/foot.jsp" flush="false" />	
	</body>
</html>
