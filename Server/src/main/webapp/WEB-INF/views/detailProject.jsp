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

		<jsp:include page="base/foot.jsp" flush="false" />

		</div>	
	</body>
</html>
