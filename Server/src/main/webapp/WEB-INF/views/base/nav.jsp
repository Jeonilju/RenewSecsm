<%@page import="com.secsm.info.AccountInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Navigation -->

<%
	AccountInfo accountInfo_nav = (AccountInfo) request.getAttribute("accountInfo");
%>

<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header page-scroll">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			
			<a class="navbar-brand" href="/Secsm/index">Secsm</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
					<a id="livingDrop" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">생활<b class="caret"></b></a>
					
					<ul class="dropdown-menu" role="menu" aria-labelledby="livingDrop">
						<li role="presentation"><a role="menuitem" href="/Secsm/attendance">출석</a></li>
						<li role="presentation"><a role="menuitem" href="/Secsm/duty">당직</a></li>
					</ul>
				</li>

				<li class="dropdown">
					<a id="projectDrop" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">교육<b class="caret"></b></a>
					
					<ul class="dropdown-menu" role="menu" aria-labelledby="projectDrop">
						<li role="presentation"><a role="menuitem" href="/Secsm/project">프로젝트</a></li>
						<li role="presentation"><a role="menuitem" href="/Secsm/question">설문</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a id="equipmentDrop" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">자산<b class="caret"></b></a>
						
					<ul class="dropdown-menu" role="menu" aria-labelledby="equipmentDrop">
						<li role="presentation"><a role="menuitem" href="/Secsm/book">도서</a></li>
						<li role="presentation"><a role="menuitem" href="/Secsm/equipment">장비</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a id="pxDrop" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">PX<b class="caret"></b></a>
						
					<ul class="dropdown-menu" role="menu" aria-labelledby="pxDrop">
						<li role="presentation"><a role="menuitem" href="/Secsm/px">PX</a></li>
					</ul>
				</li>
				
				<%
					if(accountInfo_nav != null){
						out.println("<li class='dropdown' style='margin-left: 20px'>");
						out.println("<a id='userDrop' href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' >User<b class='caret'></b></a>");
						out.println("<ul class='dropdown-menu' role='menu' aria-labelledby='userDrop'>");
						if(accountInfo_nav.getGrade()==0 || accountInfo_nav.getGrade()==1){
							out.println("<li role='presentation'><a role='menuitem' data-toggle='modal' href='#' onclick ='adminAccountList(0);' data-target='#accountAdminModal' >회원관리</a></li>");
						}
						else{
							out.println("<li role='presentation'><a role='menuitem' data-toggle='modal' href='#' onclick ='accountList(0);' data-target='#accountInfoModal' >회원정보</a></li>");
						}
						out.println("<li role='presentation'><a role='menuitem' data-toggle='modal' href='#' onclick ='accountForModify();' data-target='#accountModifyModal' >정보수정</a></li>");
						out.println("<li role='presentation'><a role='menuitem' href='/Secsm/logout'>로그아웃</a></li>");
						out.println("</ul>");
						out.println("</li>");
					}
					else{
						out.println("<li style='margin-left: 20px'>");
						out.println("<a data-toggle='modal' href='#' onclick = 'inputreset(5);' data-target='#account_SignUp' >SIGN UP<b class='caret'></b></a>");
						out.println("</li>");
					}
				%>
				
			</ul>
		</div>
	</div>
</nav>

