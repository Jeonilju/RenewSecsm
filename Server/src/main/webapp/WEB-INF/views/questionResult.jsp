<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	QuestionInfo questionInfo = (QuestionInfo) request.getAttribute("questionInfo");
	List<QuestionChoiceInfo> choiceList = (List<QuestionChoiceInfo>) request.getAttribute("choiceList");
	List<QuestionEssayInfo> essayList = (List<QuestionEssayInfo>) request.getAttribute("essayList");
	List<QuestionDateInfo> dateList = (List<QuestionDateInfo>) request.getAttribute("dateList");
	List<QuestionTimeInfo> timeList = (List<QuestionTimeInfo>) request.getAttribute("timeList");
	List<QuestionScoreInfo> scoreList = (List<QuestionScoreInfo>) request.getAttribute("scoreList");
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
				<h1> 결과조회 </h1>
			</div>
			
			<div align="right" >
				<button type="button" class="btn" style="margin: 5px;" onclick="location.replace('/Secsm/questionResultExcel " + <%=questionInfo.getId() %>> + "');">엑셀 다운</button>
			</div>
			
			<div>
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>No.</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<%
				    		
				    	%>
				    </tbody>
				  </table>
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	
	</body>
</html>
