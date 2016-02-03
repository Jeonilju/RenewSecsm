<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Book</title>
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> 도서 </h1>
			</div>
			<div class="row-fluid">
				<ul >
					<li role="presentation"><a role="menuitem" href="bookSearch">도서 검색</a></li>
					<li role="presentation"><a role="menuitem" href="bookRental">대여 및 반납</a></li>
					<li role="presentation"><a role="menuitem" href="bookApply">도서 요청</a></li>
				</ul>
			
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	


</body>
</html>
