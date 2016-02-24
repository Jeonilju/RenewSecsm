<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>
<%@ page contentType="text/html; charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>
<link href="/Secsm/resources/css/bootstrap-combined.min.css" rel="stylesheet">
     
<!-- Timepicker CSS -->
<link rel="stylesheet" href="/Secsm/resources/css/bootstrap-datetimepicker.min.css">
  
<!-- Timepicker JS -->
<script src="/Secsm/resources/js/bootstrap-datetimepicker.min.js"></script>

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
		    var qType = $(this).find(".qrType")[0].value;
		    
		    qInfo.qType = qType;
		    
		    switch(qType){
		    case "0":
		    	// 객관식
		    	var qId = $(this).find(".qrId")[0].value;
		    	var qanswer;
		    	if($(this).find(".q1")[0].checked){
		    		qanswer = "1";
		    	}
				else if($(this).find(".q2")[0].checked){
					qanswer = "2";	    		
				}
				else if($(this).find(".q3")[0].checked){
					qanswer = "3";
				}
				else if($(this).find(".q4")[0].checked){
					qanswer = "4";
				}
				else if($(this).find(".q5")[0].checked){
					qanswer = "5";
				}

		    	qInfo.qId = qId;
		    	qInfo.qanswer = qanswer;
		    	break;
		    case "1":
		    	// 주관식
		    	var qId = $(this).find(".qrId")[0].value;
		    	var qanswer = $(this).find(".qranswer")[0].value;

		    	qInfo.qId = qId;
		    	qInfo.qanswer = qanswer;
		    	break;
		    case "2":
		    	// 날짜
		    	var qId = $(this).find(".qrId")[0].value;
		    	var qanswer = $(this).find(".qranswer")[0].value;

		    	qInfo.qId = qId;
		    	qInfo.qanswer = qanswer;
		    	break;
		    case "3":
		    	// 시간
		    	var qId = $(this).find(".qrId")[0].value;
		    	var qanswer = $(this).find(".qranswer")[0].value;

		    	qInfo.qId = qId;
		    	qInfo.qanswer = qanswer;
		    	
		    	break;
		    case "4":
		    	// 점수
		    	var qId = $(this).find(".qrId")[0].value;
		    	var qanswer = $(this).find(".qranswer")[0].value;

		    	qInfo.qId = qId;
		    	qInfo.qanswer = qanswer;
		    	break;
		    }
		    
		    qContentList.push(qInfo);
		});
		
		var param = "id" + "=" + $("#qrId").val() + "&" + 
					"questionResQuestions" + "=" + JSON.stringify(qContentList);
		
		$.ajax({
		url : "/Secsm/api_questionRespons",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				// 정상 구매
				window.location.reload(true);
			}
			else if(response = '408'){
				alert('이미 마감된 설문입니다.');
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
					<input id="qrId" name="qrId" type="text" value="" style="display: none;">
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
					<button type="button" class="btn btn-primary" onclick="responsQuestion();">완료</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>