<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="utf-8"%>
<%@ page session="false" import="java.util.*, com.secsm.info.*, java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String ss = sdf.format(new java.util.Date());
	
	response.setHeader("Content-Disposition", "attachment; filename=" + ss + ".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	QuestionInfo questionInfo = (QuestionInfo) request.getAttribute("questionInfo");
	ArrayList<QuestionContentInfo> totalQuestionList = (ArrayList<QuestionContentInfo>) request.getAttribute("totalQuestionList");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
	<table>
		<tr>
			<td>제목</td>
			<td>내용</td>
		</tr>
		<tr>
			<td><%=questionInfo.getTitle()%></td>
			<td><%=questionInfo.getContent()%></td>
		</tr>
		
	</table>

	<table border="1">
	<tr>
		<th>답변자</th>
		<th>결과</th>
	</tr>
	</table>


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
							out.println("<td>" + answerInfo.getName() + "</td>");
							out.println("<td>" + answerInfo.getAnswer() + "</td>");
							out.println("</tr>");
							out.println("</tbody>");
						}
					}
					
					out.println("</table>");
					out.println("</div>");
					
					index++;
				}
			%>

</body>
</html>