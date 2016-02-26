<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
		
	//DatePicker 설정
	$(function() 
		{
			$("#questionAddStartDate").datepicker();
			$("#questionAddEndDate").datepicker();
		}
	);
	
	function addQuestion(){

		var qContentList = new Array();

		$('#questionsTable tr').each(function() {
			var qInfo = new Object();
		    var qType = $(this).find(".qType")[0].value;
		    
		    qInfo.qType = qType;
		    switch (qType) {
			case "0":
				// 객관식
				qInfo.qTitle = $(this).find(".qTitle")[0].value;
				qInfo.q1 = $(this).find(".q1")[0].value;
				qInfo.q2 = $(this).find(".q2")[0].value;
				qInfo.q3 = $(this).find(".q3")[0].value;
				qInfo.q4 = $(this).find(".q4")[0].value;
				qInfo.q5 = $(this).find(".q5")[0].value;
				break;
			case "1":
				// 주관식
				qInfo.qTitle = $(this).find(".qTitle")[0].value;
				break;
			case "2":
				// 날짜
				qInfo.qTitle = $(this).find(".qTitle")[0].value;
				break;
			case "3":
				// 시간
				qInfo.qTitle = $(this).find(".qTitle")[0].value;
				break;
			case "4":
				// 점수
				qInfo.qTitle = $(this).find(".qTitle")[0].value;
				break;

			default:
				break;
			}
		    
		    qContentList.push(qInfo);
		 });
		
		var isChecked = document.getElementById("questionAddIdCode").checked;
		var questionAddCode = "";
		if(isChecked){
			questionAddCode = $("#questionAddCode").val()
		}
		else{
			
		}
		
		var param = "questionAddTitle" + "=" + $("#questionAddTitle").val() + "&" + 
					"questionAddContent" + "=" + $("#questionAddContent").val() + "&" +
					"questionAddStartDate" + "=" + $("#questionAddStartDate").val() + "&" +
					"questionAddEndDate" + "=" + $("#questionAddEndDate").val() + "&" +
					"questionAddIdCode" + "=" + $("#questionAddIdCode").val() + "&" +
					"questionAddCode" + "=" + $("#questionAddCode").val() + "&" +
					"questionAddQuestions" + "=" + JSON.stringify(qContentList);
		
		$.ajax({
		url : "/Secsm/api_questionAdd",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				// 정상 구매
				alert('정상 추가되었습니다.');
				window.location.reload(true);
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
	
	function getQuestionContent(type){
		var param = "type" + "=" + type;
	
		$.ajax({
		url : "/Secsm/api_questionContent/" + type ,
		type : "GET",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			$('#questionsTable > tbody:last').append(response);
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
			getQuestionContent(0);
        });
		$('#btn-add-essay').click(function() {
			getQuestionContent(1);
        });
		$('#btn-add-date').click(function() {
			getQuestionContent(2);
        });
		$('#btn-add-time').click(function() {
			getQuestionContent(3);
        });
		$('#btn-add-score').click(function() {
			getQuestionContent(4);
        });
		
        $('#btn-delete-row').click(function() {
            $('#questionsTable > tbody:last > tr:last').remove();
        });
    });

	
</script>

<style>
	.datepicker{z-index:1151 !important;}
</style>

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
					
					<hr />
					
					<table id="questionsTable" name="questionsTable">
						<tbody></tbody>
					</table>
					
					<hr />
					
					<div class="form-group">
						시작날짜
						<input name="questionAddStartDate" id="questionAddStartDate" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						마감날짜
						<input name="questionAddEndDate" id="questionAddEndDate" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						비공개
						<input name='questionAddIdCode' id='questionAddIdCode' type="checkbox"/>
						<input name="questionAddCode" id="questionAddCode" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<button id="btn-add-choice" type="button" class="btn btn-default">+객관식</button>
						<button id="btn-add-essay" type="button" class="btn btn-default">+주관식</button>
						<button id="btn-add-date" type="button" class="btn btn-default">+날짜</button>
						<button id="btn-add-time" type="button" class="btn btn-default">+시간</button>
						<button id="btn-add-score" type="button" class="btn btn-default">+점수</button>
						<button id="btn-delete-row" type="button" class="btn btn-danger">-삭제</button>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="addQuestion();">등록</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>