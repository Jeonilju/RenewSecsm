<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	//설문지 조회 비공개
	function getQuestionPW(){
		var param = "qId" + "=" + currentQuestionId + "&"
				+ "code" + "=" + $('#questionPWCode').val();
	
		$.ajax({
		url : "/Secsm/api_questionGetPW",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response == "-1"){
				// 비공개
				alert("비공개 설문조사입니다.");
			}else if(response == "-2"){
				// 암호 틀림
				alert("잘못된 코드입니다.");
			}
			else{
				setQuestionTable(response, currentQuestionId);
				$("#questionPasswordModal").modal("hide");
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

<div class="modal fade" id="questionPasswordModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="pwQuestionForm" id="pwQuestionForm" action="api_questionGetPW">
				<div class="modal-header">
					<h4 class="modal-title">비공개 설문 코드</h4>
					<input name="questionPWID" id="questionPWID" type="text" class="form-control" style="display: none;" />
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="questionAddTitle" cond="">코드명</label> 
						<input name="questionPWCode" id="questionPWCode" type="text" class="form-control" />
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="getQuestionPW();">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>