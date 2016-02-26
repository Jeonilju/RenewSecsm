<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">

<script type="text/javascript">

	function login(){
		
		var param = "login_email" + "=" + $("#loginID").val() + "&" + 
				"login_password" + "="+ $("#loginPW").val();
		
		$.ajax({
		url : "/Secsm/api_login",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				location.href="/Secsm/attendance";
			}
			else{
				alert(response);
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	
	}
	
	function onLoad(){
		$("#loginPW").keyup(function(event){
		    if(event.keyCode == 13){
		    	login();
		    }
		});
		
		$("#User_phone").keyup(function(event){
		    if(event.keyCode == 13){
		    	NewUser_SignUp();
		    }
		});
		
		<%
			if(request.getAttribute("isLogined") != null){
				out.println("location.href=\"/Secsm/attendance\";");
			}
		%>
		}
</script>

<!-- Header -->
<header>
	<jsp:include page="base/header.jsp" flush="false" />
	
</header>
<body style="margin-top: 150px;" onload="onLoad();" >
	<jsp:include page="base/nav.jsp" flush="false" />
	
	<div class="container" align="center">
		<div class="row">
			<div class="col-lg-12">
				<div class="intro-text">
					 
					<form>
						<table style="margin-right:50px">
						<tr>
								<td></td>
								<td><img src="/Secsm/resources/image/Logo.jpg" width="270px" height="200"></td>
							</tr>
							<tr>
								<td></td>
								<td><span class="name" style="font-size: 3em; margin: 10px;">Secsm 2016</span></td>
							</tr>
							<tr>
								<td><label for="loginID"  class="form-inline" style="margin: 10px;">ID</label> </td>
								<td><input name="loginID" id="loginID" type="text" class="form-control" style="width:300px; margin-bottom: 5px; margin-top: 15px;"/></td>
							</tr>

							<tr>
								<td><label for="loginPW" style="margin: 10px; padding-right: 14px;">PW</label></td>
								<td><input name="loginPW" id="loginPW" type="password" style="width:300px; margin-bottom: 5px;" class="form-control"/></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" value ="Login" class="btn" style="width:300px;" onclick="login();"></input></td>									
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="modals/account_SignUp.jsp" flush="false" />
	<jsp:include page="modals/pxBuyItemsModal.jsp" flush="false" />	
	<jsp:include page="base/foot.jsp" flush="false" />
	
</body>


</html>


