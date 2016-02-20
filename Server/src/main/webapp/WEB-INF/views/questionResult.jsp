<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.Util"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	QuestionInfo questionInfo = (QuestionInfo) request.getAttribute("questionInfo");
	ArrayList<QuestionContentInfo> totalQuestionList = (ArrayList<QuestionContentInfo>) request.getAttribute("totalQuestionList");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
		
    	<title>Question</title>
    	
    	<script type="text/javascript">

    	</script>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> <%= questionInfo.getTitle() %> </h1>
			</div>
			
			<div align="right" >
				<button type="button" class="btn" style="margin: 5px;" onclick="location.replace('/Secsm/questionResultExcel " + <%=questionInfo.getId() %> + "');">엑셀 다운</button>
			</div>
			
			<div class="row-fluid">
				<pre><%=questionInfo.getContent() %></pre>
			</div>
			
			<%
				int index = 1;
				for(QuestionContentInfo info : totalQuestionList){
					out.println("<div class='row-fluid'>");
					
					String qType = "";
					if(info.qType == 0){
						qType = "객관식";
					}
					else if(info.qType == 1){
						qType = "주관식";
					}
					else if(info.qType == 2){
						qType = "날짜";
					}
					else if(info.qType == 3){
						qType = "시간";
					}
					else if(info.qType == 4){
						qType = "점수";
					}
					out.println("" + index + ". " + qType + ": " + info.qTitle + "<br/>");
					
					out.println("<table class='table table-hover'>");
					
					out.println("<thead>");
					out.println("<tr>");
					out.println("<td>" + "이름" + "</td>");
					out.println("<td>" + "답변" + "</td>");
					out.println("</tr>");
					out.println("</thead>");
					
					if(info.answerList != null){
						for(AnswerContentInfo answerInfo : info.answerList){
							
							out.println("<tbody>");
							out.println("<tr>");
							out.println("<td>" + answerInfo.getAccountId() + "</td>");
							out.println("<td>" + answerInfo.getAnswer() + "</td>");
							out.println("</tr>");
							out.println("</tbody>");
						}
					}
					
					out.println("</div>");
					
					index++;
				}
			%>
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	
	</body>
</html>
