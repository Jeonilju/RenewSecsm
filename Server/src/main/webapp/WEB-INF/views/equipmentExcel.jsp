<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="utf-8"%>
<%@ page session="false" import="java.util.*, com.secsm.info.*, java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String ss = sdf.format(new java.util.Date());
	
	response.setHeader("Content-Disposition", "attachment; filename=Equipment(" + ss + ").xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	List<EquipmentReqInfo> equipmentReqList = (List<EquipmentReqInfo>) request.getAttribute("equipmentReqList");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
	<table>
	<tr>
		<th>신청일</th>
		<th>분류</th>
		<th>분류(영어)</th>
		<th>장비명</th>
		<th>장비명(영어)</th>
		<th>브랜드</th>
		<th>단가</th>
		<th>수량</th>
		<th>합계</th>
		<th>참고링크</th>
		<th>신청자</th>
	</tr>	
	<%  
		for(EquipmentReqInfo info : equipmentReqList)
		{
			out.print("<tr>");
			out.print("<th>" + info.getStrRegDate() + "</th>");
			out.print("<th>" + info.getTypeKr() + "</th>");
			out.print("<th>" + info.getTypeEn() + "</th>");
			out.print("<th>" + info.getTitleKr() + "</th>");
			out.print("<th>" + info.getTitleEn() + "</th>");
			out.print("<th>" + info.getBrand() + "</th>");
			out.print("<th>" + info.getPay() + "</th>");
			out.print("<th>" + info.getCount() + "</th>");
			out.print("<th>" + info.getPay()*info.getCount() + "</th>");
			out.print("<th>" + info.getLink() + "</th>");
			out.print("<th>" + info.getAccountName() + "</th>");
			out.print("</tr>");
		}
	%>
	</table>

</body>
</html>