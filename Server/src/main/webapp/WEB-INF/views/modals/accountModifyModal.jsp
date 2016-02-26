<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>
<%@page import="com.secsm.conf.Util"%>

<%AccountInfo member = Util.getLoginedUser(request);%>
<script type="text/javascript">

	var name_check = "1";
	
	function accountForModify(){
		$.ajax({
			url : "/Secsm/api_accountForModify",
			type : "POST",
			cache : false,
			async : false,
			dataType : "text",
		
			success : function(response) {	
				if(response == "401"){
					alert('로그인을 하세요.');
					location.reload();
				}
				else{
					var obj = JSON.parse(response);
					$("#User_password").val(obj.pw);
					$("#re_User_password").val(obj.pw);
					$("#User_name").val(obj.name);
					$("#User_gender").val(obj.gender);
					$("#User_phone").val(obj.phone);
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
		});
	}
	
	function modifyAccount(){
		var param = "User_password" + "=" + $("#User_password").val() + "&" + 
					"re_User_password" + "=" + $("#re_User_password").val() + "&" + 
					"User_name" + "=" + $("#User_name").val() + "&" + 
					"User_gender" + "=" + $("#User_gender").val() + "&" + 
					"User_phone" + "="+ $("#User_phone").val();
		
		var form = document.accountModify;
	
		if(form.User_gender.value== "-1"){
			alert("성별을 선택해주세요.");
			return;
		}
		else if(name_check == "" && $("#User_name").val()!='<%=member.getName()%>'){
			alert("이름 중복검사를 해주세요.");
			return;
		}
		else if(form.User_password.value == "" || re_User_password == ""){
			alert("비밀번호를 입력하지 않았습니다.");
			return;
		}
		else if(form.User_password.value != form.re_User_password.value){
			alert("비밀번호와 재입력 비밀번호가 일치하지 않습니다.");
			return;
		}
		else if(form.User_phone.value == ""){
			alert("핸드폰 번호를 입력하지 않았습니다.");
			return;
		}
		else if(form.User_password.value.length < 8){
			alert("비밀번호 길이가 짧습니다.");
			return;
		}
		else if(form.User_password.value.length >= 50){
			alert("비밀번호 길이는 50글자를 넘을 수 없습니다.");
			return;
		}
		else if(form.User_name.value== ""){
			alert("이름을 입력하지 않았습니다.");
			return;
		}
		else if(form.User_name.value.length >=50){
			alert("이름은 50글자를 넘을 수 없습니다.");
			return;
		}
		else if(form.User_phone.value.length >=45){
			alert("핸드폰 번호는 45글자를 넘을 수 없습니다.");
			return;
		}
		else{
			$.ajax({
				url : "/Secsm/api_modifyAccount",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
			
				success : function(response) {	
					if(response=='200')
					{
						// 정상 수정
						alert("회원정보가 수정 되었습니다.");
						location.reload();
					}
					else if(response=='401')
					{
						alert('로그인을 하세요.');
						location.reload();
					}
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
			});
		}
	}
	
	function check_duplicate_name(){
		var param = "User_name" + "=" + $("#User_name").val();
		
		if($("#User_name").val()==""){
			alert("이름을 입력하세요.");
			return;
		}
		else if($("#User_name").val()=='<%=member.getName()%>'){
			alert("사용할 수 있습니다.");
			name_check = "1";
			return;
		}
		$.ajax({
			url : "/Secsm/api_nameDuplicate_check",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
		
			success : function(response) {	
				if(response=='200')
				{
					alert("이름이 중복되지 않습니다. 사용하셔도 됩니다.");
					name_check = "1";
				}
				else if(response == '400'){
					alert("이름이 중복됩니다. 이름 뒤에 기수를 명시해주세요.\nex)조규현(25-2)");
				}
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
				}
			}
		});
		
	}
	
	function name_reset(){
		name_check = "";
	}
	
</script>


<!-- 회원정보수정 모달 -->
<div class="modal fade" id="accountModifyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="accountModify" id="accountModify">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">정보수정</h4>
				</div>
				
				<div class="modal-body">
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
					
					<label for="User_name">이름</label> 
					<div class="form-inline">
						<input name="User_name" id="User_name" class="form-control" placeholder = "이름" onkeydown = "name_reset();" style="width: 459.22222px;"/>
						<button type = "button" class = "btn btn-default" id = "check_name" onclick = "check_duplicate_name()" >중복확인</button>	
					</div>
					
					<div class="form-group">
						<label for="User_gender">성별</label> 
						<select name="User_gender" id="User_gender" class="form-control" style = "width:100%" >
							<option value = "-1">선택</option>
							<option value = "1">남자</option>
							<option value = "0">여자</option>
						</select>
					</div>
					
					<div class="form-group">
						<label for="User_phone">핸드폰 번호</label> 
						<input name="User_phone" id="User_phone" class="form-control" placeholder = "010-1234-5678">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick='modifyAccount();'>변경</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>