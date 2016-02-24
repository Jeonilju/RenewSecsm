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
				<img src="/Secsm/resources/image/Logo.jpg" width="250px" height="200">
				<div class="intro-text">
					<span class="name" style="font-size: 3em; margin: 10px;">Secsm 2016</span> 
					<form>
						<div class="form-inline" style="padding:3px">
								<label for="loginID"  class="form-inline" style="margin: 10px;">ID</label> 
								<input name="loginID" id="loginID" type="text" class="form-control" style="width:300px"/>
							<br>
						</div>
						<div class="form-inline" style="padding:3px">
							<label for="loginPW" style="margin: 10px;">Password</label>
							<input name="loginPW" id="loginPW" type="password" style="width:300px" class="form-control"/>
						</div>
						<input type="button" value ="Login"class="btn" style="width:300px; margin: 10px;" onclick="login();"></input>										
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


