<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="utf-8"%>
<%@ page session="false" import="java.util.*, com.secsm.info.*, java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String ss = sdf.format(new java.util.Date());
	
	response.setHeader("Content-Disposition", "attachment; filename=" + ss + ".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	List<BookReqInfo> bookReqList = (List<BookReqInfo>) request.getAttribute("bookReqList");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
	<table>
	<tr>
		<th>신청일</th>
		<th>도서명</th>
		<th>출판사</th>
		<th>저자</th>
		<th>링크</th>
		<th>가격</th>
		<th>신청자</th>
	</tr>	
	<%  
		for(BookReqInfo info : bookReqList)
		{
			out.print("<tr>");
			out.print("<th>" + info.getStrRegDate() + "</th>");
			out.print("<th>" + info.getTitle() + "</th>");
			out.print("<th>" + info.getPublisher() + "</th>");
			out.print("<th>" + info.getAuthor() + "</th>");
			out.print("<th>" + info.getLink() + "</th>");
			out.print("<th>" + info.getPay() + "</th>");
			out.print("<th>" + info.getAccountName() + "</th>");
			out.print("</tr>");
		}
	%>
	</table>

</body>
</html>