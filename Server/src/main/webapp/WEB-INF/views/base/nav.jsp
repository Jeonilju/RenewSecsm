<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script language="javascript" charset='UTF-8'>
	var count =0;
	var email = '';
	function idCheck(){
		
		var email = $("#email").val();
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		  
		if(regex.test(email) === false) {  
		    alert("잘못된 이메일 형식입니다.");  
		    return false;  
		}
	    overlapCheck();
	}
	function overlapCheck(){
		
		var param = "email" + "=" + $("#email").val();
		if($("#email").val() == '' || $("#email").val()==null)
		{
			alert("아이디를 입력하세요");
			return false;
		}
		
		$.ajax({
			url : "overlaptest_db",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			success : function(response) {				
				if(response=='0')
				{
					count = 1;
					email = $("#email").val();
					alert("아이디가 중복이 되지 않습니다. 쓰셔도 됩니다.")
					
				}
				else
				{
					alert("아이디가 중복이 됩니다. 다시 입력 해주세요");
					count=0;
					return false;
				}	
			},
			
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}
	function signup_db() {
		if(count==0 || email != $("#email").val())
		{
			alert('중복확인을 눌러주세요');
			return false;
		}
		
		$.ajax({
			url : "signup_db",
			type : "POST",
			data : 
			{
				email : document.getElementById('email').value,
				password : document.getElementById('password').value,
				password_check : document.getElementById('password_check').value
			},
			cache : false,
			async : false,
			dataType : "text",
			success : function(response) {								
				if(response=='success')
				{
					location.href='index';
					alert('회원가입이 완료되었습니다.');
				}
				else if(response=='email')
				{
					alert('email을 입력해주세요.');
				}
				else if(response=='password')
				{
					alert('password를 입력해주세요.');
				}
				else if(response=='longemail')
				{
					alert('email이 너무 깁니다.');
				}
				else if(response=='longpassword')
				{
					alert('password가 너무 깁니다');
				}
				else if(response=='email')
				{
					alert('email을 입력해주세요.');
				}
				else if(response=='password')
				{
					alert('password를 입력해주세요.');
				}
				else if(response=='password_check')
				{
					alert('password confirm을 입력해주세요.');
				}
				else if(response=='password equality')
				{
					alert('패스워드가 일치하지 않습니다.');
				}
				else if(response=='overlap')
				{
					alert('이메일이 중복됩니다.');
				}
				else if(response=='error')
				{
					alert('에러가 발생했습니다.');
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}
	function onEnterSignUp()
	{
		var keyCode = window.event.keyCode;
		if(keyCode==13) signup_db();
	}
</script>

<!-- SignUpModal -->
<div class="modal fade" id="SignUpModal" tabindex="-1" role="dialog" aria-labelledby="SignUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="SignUpModalLabel">SIGN UP</h4>
			</div>

			<form action="signup_db" method="POST" id="joinForm" name="joinForm">
				<div class="modal-body">
					<div class="form-inline" style="padding:3px">
							<label for="email"  class="form-inline" style="padding-right:14px;padding-left:14px;">Email Address</label> 
							<input name="email" id="email" type="email" class="form-control" placeholder="Email Address" style="width:300px"/>
							<input type="button" class="btn" value="중복확인" onclick='idCheck()'>
						<br>
					</div>
					<div class="form-inline" style="padding:3px">
						<label for="password" style="padding-right:29px;padding-left:29px;">Password</label>
						 <input name="password" id="password" type="password" style="width:390px" class="form-control" placeholder="Password" />
					</div>
					<div class="form-inline" style="padding:3px">
						<label for="user_id" cond="">Password Confirm</label> <input
							name="password_check" id="password_check" type="password" required cond=""
							class="form-control" placeholder="Password Confirm" style="width:390px" onkeydown='onEnterSignUp()'  />
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>											
					<button type="button"  class="btn btn-primary" onclick="signup_db()">Sign Up</button>
						
				</div>
			</form>


		</div>
		<!-- /.modal-content -->
	</div>
</div>
<!-- /.modal -->

<script language="JavaScript">
	function loginsuccess(){
		history.go(0);
	}
	function loginCheck(){
		var param = "Signin_email" + "=" + $("#Signin_email").val() + "&" +"Signin_password" + "="+ $("#Signin_password").val();
		$.ajax({
			url : "login_db",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
	
			success : function(response) {								
				if(response=='1')
				{
					loginsuccess();
				}
				else if(response=='0')
				{
					alert("이메일이 존재하지 않습니다.");
				}
				else if(response=='3')
				{
					alert("비밀번호가 틀렸습니다.");
				}
				else if(response=='email')
				{
					alert("이메일이 너무 깁니다.");
				}
				else if(response=='password')
				{
					alert("비밀번호가 너무 깁니다.");
				}
				else
				{
					return false;
				}	
				
				//alert(check);
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}
	
		});
	}
	function onEnterSignIn()
	{
		var keyCode = window.event.keyCode;
		if(keyCode==13) loginCheck();
	}
</script>

<!-- SignInModal -->
<div class="modal fade" id="SignInModal" tabindex="-1" role="dialog"
	aria-labelledby="SignInModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="frm" id = "frm" action = "/login_db">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="SignInModalLabel">SIGN IN</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="user_id" cond="">Email Address</label> <input
							name="Signin_email" id="Signin_email" type="email" required cond=""
							class="form-control" placeholder="Email Address" />
					</div>
					<div class="form-group">
						<label for="user_id" cond="">Password</label> 
						<input name="Signin_password" id="Signin_password" type="password" required cond="" class="form-control"
							placeholder="Password" onkeydown='onEnterSignIn()' />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						Close</button>
					<button type="button" class="btn btn-primary" onclick='loginCheck()'>Sign In</button>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
</div>
<!-- /.modal -->

<!-- Navigation -->
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
			
			<a class="navbar-brand" href="index">Secsm</a>
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
					<a id="equipmentDrop" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">기자제<b class="caret"></b></a>
						
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
				
				<li role="presentation">
					<button type="button" class="btn btn-default" data-toggle="modal" data-target="#SignUpModal" style="margin: 5px;">Sign Up</button>
				</li>
				<li role="presentation">
					<button type="button" class="btn" data-toggle="modal" data-target="#SignInModal" style="margin: 5px;">Sign In</button>
				</li>
				<li role="presentation">
					<button type="button" class="btn" onclick="window.location.href='logout'" style="margin: 5px;">LogOut</button>
				</li>
				
			</ul>

		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>