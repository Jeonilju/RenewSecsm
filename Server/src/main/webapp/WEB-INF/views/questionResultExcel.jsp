<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="utf-8"%>
<%@ page session="false" import="java.util.*, com.secsm.info.*, java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String ss = sdf.format(new java.util.Date());
	
	response.setHeader("Content-Disposition", "attachment; filename=" + ss + ".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	List<EquipmentReqInfo> equipmentReqList = (List<EquipmentReqInfo>) request.getAttribute("equipmentReqList");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
	<table border="1">
	<tr>
		<th>No.</th>
		<th>신청자</th>
		<th>제목</th>
		<th>내용</th>
		<th>상태</th>
		<th>신청일</th>
	</tr>	
	<%  
		for(EquipmentReqInfo info : equipmentReqList)
		{
			out.print("<tr>");
			out.print("<th>" + info.getId() + "</th>");
			out.print("<th>" + info.getAccountId() + "</th>");
			out.print("<th>" + info.getTitle() + "</th>");
			out.print("<th>" + info.getContext() + "</th>");
			out.print("<th>" + info.getStatus() + "</th>");
			out.print("<th>" + info.getRegDate().toString() + "</th>");
			out.print("</tr>");
		}
	%>
	</table>

</body>
</html>