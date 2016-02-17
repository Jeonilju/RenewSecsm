<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
		
	//DatePicker 설정
	$(function() 
		{
			$("#qrDate").datepicker();
		}
	);
	
	// 설문 응답
	function responsQuestion(){

		var qContentList = new Array();

		$('#qrTable tr').each(function() {
			var qInfo = new Object();
		    var qType = $(this).find(".qType")[0].value;
		    
		    qInfo.qType = qType;
		});
		
		var param = "questionAddTitle" + "=" + $("#questionAddTitle").val() + "&" + 
					"questionAddContent" + "=" + $("#questionAddContent").val() + "&" +
					"questionAddStartDate" + "=" + $("#questionAddStartDate").val() + "&" +
					"questionAddEndDate" + "=" + $("#questionAddEndDate").val() + "&" +
					"questionAddQuestions" + "=" + JSON.stringify(qContentList);
		
		$.ajax({
		url : "/Secsm/api_questionRespons",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			alert(response);
			if(response=='200')
			{
				// 정상 구매
				alert('응답이 완료되었습니다.');
			}
			else{
				alert('알수없음');
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

<div class="modal fade" id="qrModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="qrForm" id="qrForm" action="/api_qr">
				<div class="modal-header">
					<h4 class="modal-title">설문 응답</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<h3 id="qrTitle" name="qrTitle">제목</h3> 
					</div>
					<div class="form-group">
						<label id="qrContent" name="qrContent">내용</label> 
					</div>

					<hr />
					
					<table id="qrTable" name="qrTable">
						<tbody></tbody>
					</table>
					
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addQuestion();">완료</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>