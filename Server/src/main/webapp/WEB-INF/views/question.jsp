<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	List<QuestionInfo> questionList = (List<QuestionInfo>)request.getAttribute("questionList");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Question</title>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> 설문 </h1>
			</div>
			
			<div>
				<button type="button" class="btn" data-toggle="modal" data-target="#questionAddModal" style="margin: 5px;">설문 등록</button>
			</div>
			
			<div>
			
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>No.</th>
				        <th>제목</th>
				        <th>작성자</th>
				        <th>기간</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<%
				    		for(QuestionInfo info : questionList){
				    			out.print("<tr>");
				    			out.print("<td>" + info.getId() + "</td>");
				    			out.print("<td>" + info.getTitle() + "</td>");
				    			out.print("<td>" + info.getAccountId() + "</td>");
				    			out.print("<td>" + Util.getTimestempStr(info.getStartDate()) 
				    					+ " ~ " + Util.getTimestempStr(info.getEndDate()) + "</td>");
				    			out.print("</tr>");
				    		}
				    	%>
				    </tbody>
				  </table>
			
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	
	</body>

	<jsp:include page="modals/questionAddModal.jsp" flush="false" />

</html>
