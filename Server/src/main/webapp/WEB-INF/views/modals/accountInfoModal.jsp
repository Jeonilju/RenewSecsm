<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>


<script type="text/javascript">
	var accountPage = 0;
	
	function getGradeStr(grade){
		var result = "";	
		if(grade==-1) result = "미인증";
		else if(grade==0) result = "운영자";
		else if(grade==1) result = "자치회장";
		else if(grade==2) result = "생활부장";
		else if(grade==3) result = "교육부장";
		else if(grade==4) result = "PX부장";
		else if(grade==5) result = "자산관리부장";
		else if(grade==6) result = "기획부장";
		else if(grade==7) result = "없음";
		else if(grade==8) result = "기존회원";
		else if(grade==9) result = "신입회원";
		else result = "알수없음";
		
		return result;
	}
	function getGenderStr(gender){
		var result = "";
		
		if(gender==1) result = "남자";
		else if(gender==0) result = "여자";
		else result = "알수없음";
		
		return result;
	}
	
	function accountList(option){
		if(option==0)	accountPage = 0;
		else if(option==1 && 0>=accountPage ){
			return;
		
		}
		else if(option==1) accountPage = accountPage -7;
		else if(option==2) accountPage = accountPage +7;

		var param = "page" + "=" + accountPage;
		
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
					accountPage = accountPage -7;
					return;    					
				}
				
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					if(obj[i].grade==-1) continue;
					tableContent = tableContent + '<tr> <td class="col-md-4">' + obj[i].email + '</td> <td class="col-md-2">' + obj[i].name + '</td> <td class="col-md-1">' + getGenderStr(obj[i].gender)
					 + '</td> <td class="col-md-3">' + obj[i].phone + '</td> <td class="col-md-2">' + getGradeStr(obj[i].grade)  + '</td> </tr>';	
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+'<th class="col-md-4">E-mail</th> <th class="col-md-2">이름</th> <th class="col-md-1">성별</th> <th class="col-md-3">휴대폰</th> <th class="col-md-2">권한</th> </tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#accountListTable").html(table);
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

<!-- 회원 정보 모달-->
<div class="modal fade" id="accountInfoModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content">
			<form name="accountInfo" id="accountInfo">
				<div class="modal-header">
					<h4 class="modal-title">회원정보</h4>
				</div>
				<div class="modal-body" >
					<div id=accountListTable>
						
					</div>
				</div>

				<div class="modal-footer form-inline">
					<button type="button" class="btn" onclick="accountList(1);" style="float:left;" >이전</button>
					<button type="button" class="btn" onclick="accountList(2);" style="margin-left:5px; float:left;">다음</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>