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
				<button type="button" class="btn" style="margin: 5px;" onclick="location.replace('/Secsm/questionResult/<%=questionInfo.getId() %>/excel');">엑셀 다운</button>
			</div>
			
			<div class="row-fluid">
				<pre><%=questionInfo.getContent() %></pre>
			</div>
			
			<div class='row'>
			<%
				int index = 1;
				for(QuestionContentInfo info : totalQuestionList){
					out.println("<div class='row-fluid' style='margin: 20px'>");
					
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
					
					out.println("<table class='table table-hover' style='width: 500px;'>");
					
					out.println("<thead>");
					out.println("<tr>");
					out.println("<td style='width: 200px;'>" + "이름" + "</td>");
					out.println("<td style='width: 300px;'>" + "답변" + "</td>");
					out.println("</tr>");
					out.println("</thead>");

					if(info.answerList != null){
						out.println("<tbody>");
						
						int q1 = 0, q2 = 0, q3 = 0, q4 = 0, q5 = 0;
						int total = 0, count = 0;
						
						for(AnswerContentInfo answerInfo : info.answerList){
							
							out.println("<tr>");
							out.println("<td style='width: 200px;'>" + answerInfo.getName() + "</td>");
							out.println("<td style='width: 300px;'>" + answerInfo.getAnswer() + "</td>");
							out.println("</tr>");
							
							if(info.qType == 0){
								// 객관식
								if(answerInfo.getAnswer().equals("1"))
									q1++;
								else if(answerInfo.getAnswer().equals("2"))
									q2++;
								else if(answerInfo.getAnswer().equals("3"))
									q3++;
								else if(answerInfo.getAnswer().equals("4"))
									q4++;
								else if(answerInfo.getAnswer().equals("5"))
									q5++;
							}
							else if(info.qType == 4){
								// 점수
								try{
									total += Integer.parseInt(answerInfo.getAnswer());	
									count++;
								}
								catch(Exception e){
									
								}

							}
						}
						
						if(info.qType == 0){
							// 객관식
							out.println("<tr>");
							out.println("<td colspan='2'>" 
									+ "1번: " + q1
									+ ", 2번: " + q2
									+ ", 3번: " + q3
									+ ", 4번: " + q4
									+ ", 5번: " + q5
									+ "</td>");
							out.println("</tr>");
						}
						else if(info.qType == 4){
							// 점수
							out.println("<tr>");
							out.println("<td colspan='2'>" 
									+ "총점: " + total
									+ ", 평균: " + (total / count) 
									+ "</td>");
							out.println("</tr>");
						}
						
						out.println("</tbody>");
					}
					
					out.println("</table>");
					out.println("</div>");
					out.println("<hr/>");
					index++;
				}
			%>
			</div>
		</div>
		<jsp:include page="base/foot.jsp" flush="false" />	
	</body>
</html>
