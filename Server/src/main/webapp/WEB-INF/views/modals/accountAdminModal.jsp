<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@page import="com.secsm.conf.Util"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<%AccountInfo member = Util.getLoginedUser(request);%>

<script type="text/javascript">
	var grade = <%=member.getGrade()%>
	var accountAdminPage = 0;
	
	function getGenderStr(gender){
		var result = "";
		
		if(gender==1) result = "남자";
		else if(gender==0) result = "여자";
		else result = "알수없음";
		
		return result;
	}
	
	function adminModifyAccount(id){
		if(grade!=0 && grade!=1){
			alert("권한이 없습니다.");
			return
		}
		
		var tag = "#modifyUserGrade" +id;
		
		var param = "id" + "=" + id + "&" +
					"grade" + "=" + $(tag).val();
		
		$.ajax({
		url : "/Secsm/api_adminModifyAccount",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else
			{
				alert('회원 권한이 변경되었습니다.');
				adminAccountList(3)
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function adminDeleteAccount(id){
		if(grade!=0 && grade!=1){
			alert("권한이 없습니다.");
			return
		}
		
		var param = "id" + "=" + id;
		
		$.ajax({
		url : "/Secsm/api_adminDeleteAccount",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			if(response=='201')
			{
				alert('탈퇴처리 되었습니다.');
				location.reload();
			}
			else
			{
				alert('탈퇴처리 되었습니다.');
				adminAccountList(3)
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}

	
	function adminAccountList(option){
		if(grade!=0 && grade!=1){
			alert("권한이 없습니다.");
			return
		}
		else if(option==0)	accountAdminPage = 0;
		else if(option==1 && 0>=accountAdminPage ){
			return;
		
		}
		else if(option==1) accountAdminPage = accountAdminPage -7;
		else if(option==2) accountAdminPage = accountAdminPage +7;

		var param = "page" + "=" + accountAdminPage;
		
		$.ajax({
		url : "/Secsm/api_accountList",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else
			{
				var obj = JSON.parse(response);
				if(Object.keys(obj).length==0 && option==2){
					accountAdminPage = accountAdminPage -7;
					return;    					
				}
				
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					var gradeOption = '<select name="modifyUserGrade" id="modifyUserGrade' + obj[i].id + '" class="form-control">'
									+ '<option value = "-1">미인증</option> <option value = "0">운영자</option> <option value = "1">자치회장</option>'
									+ '<option value = "2">생활부장</option> <option value = "3">교육부장</option> <option value = "4">PX부장</option>'
									+ '<option value = "5">자산관리부장</option> <option value = "6">기획부장</option> <option value = "8">기존회원</option> <option value = "9">신입회원</option> '
									+ '</select>';
					tableContent = tableContent + '<tr> <td class="col-md-3">' + obj[i].email + '</td> <td class="col-md-2">' + obj[i].name + '</td> <td class="col-md-1">' + getGenderStr(obj[i].gender) 
					 + '</td> <td class="col-md-2">' + obj[i].phone + '</td> <td class="col-md-2">' + gradeOption + '</td> <td class="col-md-1">'
					 + '<button type="button" class="btn btn-success"  onclick="adminModifyAccount(' + obj[i].id + ')">변경</button></td> <td class="col-md-1">'
					 + '<button type="button" class="btn btn-danger"  onclick="adminDeleteAccount(' + obj[i].id + ')">탈퇴</button></td></tr>' 
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+' <th class="col-md-3">E-mail</th> <th class="col-md-2">이름</th> <th class="col-md-1">성별</th> <th class="col-md-2">휴대폰</th> <th class="col-md-2">권한</th> <th class="col-md-1">변경</th> <th class="col-md-1">탈퇴</th></tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#accountAdminListTable").html(table);
				
				for(i=0;i<Object.keys(obj).length;i++){
					var tag = "#modifyUserGrade" +obj[i].id;
					$(tag).val(obj[i].grade);
				}
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

<!-- 회원 관리 모달-->
<div class="modal fade" id="accountAdminModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog modal-lg" >
		<div class="modal-content">
			<form name="accountAdmin" id="accountAdmin">
				<div class="modal-header">
					<h4 class="modal-title">회원관리</h4>
				</div>
				<div class="modal-body" >
					<div id=accountAdminListTable>
						
					</div>
				</div>

				<div class="modal-footer form-inline">
					<button type="button" class="btn" onclick="adminAccountList(1);" style="float:left;" >이전</button>
					<button type="button" class="btn" onclick="adminAccountList(2);" style="margin-left:5px; float:left;">다음</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>