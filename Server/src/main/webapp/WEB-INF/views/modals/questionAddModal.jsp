<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript">
	
	// 아이템 구매
	function addQuestion(){
		
		$('#questionsTable tr').each(function() {
		    var customerId = $(this).find(".customerIDCell").html();    
		 });
		
		var param = "questionAddTitle" + "=" + $("#questionAddTitle").val() + "&" + 
					"questionAddContent" + "=" + $("#questionAddContent").val() + "&" +
					"questionAddStartDate" + "=" + $("#questionAddStartDate").val() + "&" +
					"questionAddEndDate" + "=" + $("#questionAddEndDate").val() + "&" +
					"questionAddQuestions" + "="+ $("#questionAddQuestions").val();

		$.ajax({
		url : "/Secsm/api_questionAdd",
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
				alert('정상 추가되었습니다.');
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
	
	$(function() {
		$('#btn-add-choice').click(function() {
            $('#questionsTable > tbody:last').append("<tr style='margin:10px;'><td>"
            		+ "객관식"
            		+ "<br/>"
            		+ "<input type='text'><br/>"
            		+ "1번 <input type='text'><br/>"
            		+ "2번 <input type='text'><br/>"
            		+ "3번 <input type='text'><br/>"
            		+ "4번 <input type='text'><br/>"
            		+ "5번 <input type='text'><br/>"
            		+ "</td></tr>");
        });
		$('#btn-add-date').click(function() {
			$('#questionsTable > tbody:last').append("<tr style='margin:10px;'><td>"
            		+ "날짜"
            		+ "<br/>"
            		+ "<input type='text'><br/>"
            		+ "</td></tr>");
        });
		$('#btn-add-time').click(function() {
			$('#questionsTable > tbody:last').append("<tr style='margin:10px;'><td>"
            		+ "시간"
            		+ "<br/>"
            		+ "<input type='text'><br/>"
            		+ "</td></tr>");
        });
		$('#btn-add-score').click(function() {
			$('#questionsTable > tbody:last').append("<tr style='margin:10px;'><td>"
            		+ "점수"
            		+ "<br/>"
            		+ "<input type='text'><br/>"
            		+ "</td></tr>");
        });
		$('#btn-add-essay').click(function() {
			$('#questionsTable > tbody:last').append("<tr style='margin:10px;'><td>"
            		+ "주관식"
            		+ "<br/>"
            		+ "<input type='text'><br/>"
            		+ "</td></tr>");
        });
		
        $('#btn-delete-row').click(function() {
            $('#questionsTable > tbody:last > tr:last').remove();
        });
    });

</script>

<div class="modal fade" id="questionAddModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="addQuestionForm" id="addQuestionForm" action="/api_questuionAdd">
				<div class="modal-header">
					<h4 class="modal-title">설문 등록</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="questionAddTitle" cond="">제목</label> 
						<input name="questionAddTitle" id="questionAddTitle" type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label for="questionAddContent" cond="">내용</label> 
						<input name="questionAddContent" id="questionAddContent" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<input name="questionAddQuestions" id="questionAddQuestions" type="text" class="form-control" style="display: none;"/>
						<input name="questionAddCount" id="questionAddCount" type="number" class="form-control" style="display: none;" value="0"/>
					</div>
					
					<hr />
					
					<table id="questionsTable" name="questionsTable">
						<tbody></tbody>
					</table>
					
					<hr />
					
					<div class="form-group">
						<button id="btn-add-choice" type="button" class="btn btn-default">+객관식</button>
						<button id="btn-add-essay" type="button" class="btn btn-default">+주관식</button>
						<button id="btn-add-date" type="button" class="btn btn-default">+날짜</button>
						<button id="btn-add-time" type="button" class="btn btn-default">+시간</button>
						<button id="btn-add-score" type="button" class="btn btn-default">+점수</button>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addQuestion();">등록</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>