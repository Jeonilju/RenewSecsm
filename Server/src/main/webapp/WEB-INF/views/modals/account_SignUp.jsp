<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>


<script type="text/javascript">

	function NewUser_SignUp(){
		var param = "User_mail" + "=" + $("#User_mail").val() + "&" + 
					"User_password" + "=" + $("#User_password").val() + "&" + 
					"re_User_password" + "=" + $("#re_User_password").val() + "&" + 
					"User_name" + "=" + $("#User_name").val() + "&" + 
					"User_gender" + "=" + $("#User_gender").val() + "&" + 
					"User_phone" + "="+ $("#User_phone").val() + "&" + 
					"User_grade" + "="+ $("#User_grade").val();
		alert(param);
		
		$.ajax({
			url : "/Secsm/api_signup",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response=='200')
				{
					// 정상 수정
					alert("회원가입이 완료되었습니다.");
					window.location.reload(true);
				}
				else if(response == '400'){
					// 비로그인
					location.replace("/Secsm/index");
				}
				else if(response == '401'){
					// 자기 프로젝트 아님
					alert("권한이 없습니다.");
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}

</script>


<!-- 회원가입 모달 -->
<div class="modal fade" id="account_SignUp" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="accountSignUpForm" id="accountSignUpForm" action="/api_SignUp">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="SignInModalLabel">회원 가입</h4>
				</div>
				
				<div class="modal-body">
					<div class="form-group">
						<label for="User_mail">E-mail</label> 
						<input name="User_mail" id="User_mail" type="text" class="form-control" placeholder = "E-mail"/>
					</div>
					<div class="form-group">
						<label for="User_password">비밀번호</label> 
						<input name="User_password" id="User_password" type ="password" class="form-control" placeholder = "비밀번호"/>
						<p><font size = "2" class="help-block">숫자, 특수문자 포함 8자 이상</font></p>
					</div>
					
					<div class="form-group">
						<label for="re_User_password">비밀번호 재입력</label> 
						<input name="re_User_password" id="re_User_password" type ="password" class="form-control" placeholder = "비밀번호 재입력"/>
						<p><font size = "2" class="help-block">비밀번호 확인을 위해 한번 더 입력해 주세요.</font></p>
					</div>
					
					<div class="form-group">
						<label for="User_name">이름</label> 
						<input name="User_name" id="User_name" class="form-control" placeholder = "이름"/>
					</div>
					
					<div class="form-group">
						<label for="User_gender">성별</label> 
						<select name="User_gender" id="User_gender" class="form-control" style = "width:100%" >
							<option value = "0">남자</option>
							<option value = "1">여자</option>
						</select>
					</div>
					
					<div class="form-group">
						<label for="User_phone">핸드폰 번호</label> 
						<input name="User_phone" id="User_phone" class="form-control"/ placeholder = "010-1234-5678">
					</div>
					
					<div class="form-group">
						<label for="User_grade">직급</label> 
						<select name="User_grade" id="User_grade" class="form-control" style = "width">
							<option value = "0">운영자</option>
							<option value = "1">자치회장</option>
							<option value = "2">생활부장</option>
							<option value = "3">교육부장</option>
							<option value = "4">PX부장</option>
							<option value = "5">자산관리부장</option>
							<option value = "6">기획부장</option>
							<option value = "8">기존회원</option>
							<option value = "9">신입회원</option>
						</select>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick='NewUser_SignUp()();'>등록</button>
				</div>
			</form>
		</div>
	</div>
</div>