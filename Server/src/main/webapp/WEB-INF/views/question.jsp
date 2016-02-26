<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.secsm.info.*"%>
<%@ page pageEncoding="utf-8" %>

<%
	List<QuestionInfo> questionList = (List<QuestionInfo>)request.getAttribute("questionList");
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
		
    	<title>Question</title>
    	
    	<script type="text/javascript">

    		// 설문지 조회
    		function loadQuestion(id){
    			var param = "id" + "=" + id;
	
				$.ajax({
				url : "/Secsm/api_questionGet",
				type : "POST",
				data : param,
				cache : false,
				async : false,
				dataType : "text",
				
				success : function(response) {	
					$("#qrTable tr").remove();
					var obj = JSON.parse(response);
					var index = 1;
					
					document.getElementById("qrId").value = id;
					document.getElementById("qrTitle").innerText = obj[0].qTitle;
					document.getElementById("qrContent").innerText = obj[0].qContent;
					
					for(index = 1;index < obj.length;index++){
						
						switch (obj[index].qType) {
						case 0:
							// 객관식
						$('#qrTable > tbody:last').append(
								"<tr style='margin:10px;'><td>"
			            		+ "객관식"
			            		+ "<br/>"
			            		+ "<input type='text' class='form-control qrType' name='qrType' style='display: none;' value='" + obj[index].qType + "'<br/>"
			            		+ "<input type='text' class='form-control qrId' name='qrId' style='display: none;' value='" + obj[index].id + "'<br/>"
			            		+ "<pre style='background: #FFFFF0;'>" + obj[index].qTitle
			            		+ "<br/><br/>"
			            		+ "1번 <input type='radio' name='" + obj[index].id + "' class='q1'>" + obj[index].q1 + "<br/>"
			            		+ "2번 <input type='radio' name='" + obj[index].id + "' class='q2'>" + obj[index].q2 + "<br/>"
			            		+ "3번 <input type='radio' name='" + obj[index].id + "' class='q3'>" + obj[index].q3 + "<br/>"
			            		+ "4번 <input type='radio' name='" + obj[index].id + "' class='q4'>" + obj[index].q4 + "<br/>"
			            		+ "5번 <input type='radio' name='" + obj[index].id + "' class='q5'>" + obj[index].q5 + "<br/>" + "</pre>"
			            		+ "</td></tr>");
							break;
						case 1:
							// 주관식
							$('#qrTable > tbody:last').append(
								"<tr style='margin:10px;'><td>"
			            		+ "주관식"
			            		+ "<br/>"
			            		+ "<input type='text' class='form-control qrType' name='qrType' style='display: none;' value='" + obj[index].qType + "'<br/>"
			            		+ "<input type='text' class='form-control qrId' name='qrId' style='display: none;' value='" + obj[index].id + "'<br/>"
			            		+ "<pre style='background: #FFFFF0;'>" + obj[index].qTitle
			            		+ "<br/><br/>"
			            		+ "<input type='text' class='form-control qranswer' name='qranswer'>" + "</pre>"
			            		+ "</td></tr>");
							break;
							break;
						case 2:
							// 날짜
							$('#qrTable > tbody:last').append(
								"<tr style='margin:10px;'><td>"
			            		+ "날짜"
			            		+ "<br/>"
			            		+ "<input type='text' class='form-control qrType' name='qrType' style='display: none;' value='" + obj[index].qType + "'<br/>"
			            		+ "<input type='text' class='form-control qrId' name='qrId' style='display: none;' value='" + obj[index].id + "'<br/>"
			            		+ "<pre style='background: #FFFFF0;'>" +  obj[index].qTitle 
			            		+ "<br/><br/>"
			            		+ "<input type='text' class='form-control qranswer datepicker' name='qranswer'>" + "</pre>"
			            		+ "</td></tr>");
							break;
						case 3:
							// 시간
							$('#qrTable > tbody:last').append(
								"<tr style='margin:10px;'><td>"
			            		+ "시간"
			            		+ "<br/>"
			            		+ "<input type='text' class='qrType' name='qrType' style='display: none;' value='" + obj[index].qType + "'<br/>"
			            		+ "<input type='text' class='qrId' name='qrId' style='display: none;' value='" + obj[index].id + "'<br/>"
			            		+ "<pre style='background: #FFFFF0;'>" +  obj[index].qTitle 
			            		+ "<br/><br/>"
			            		+ "<div class='input-append timepicker'>"
							    + "<input data-format='hh:mm:ss' type='text' class='form-control qranswer'></input>"
							    + "<span class='add-on'>"
							    + "  <i data-time-icon='icon-time' data-date-icon='icon-calendar'></i>"
							    + "</span>"
								+ "</div>"
			            		
								+ "</pre>"
			            		+ "</td></tr>");
							
							break;
						case 4:
							// 점수
							$('#qrTable > tbody:last').append(
								"<tr style='margin:10px;'><td>"
			            		+ "점수"
			            		+ "<br/>"
			            		+ "<input type='text' class='qrType' name='qrType' style='display: none;' value='" + obj[index].qType + "'<br/>"
			            		+ "<input type='text' class='qrId' name='qrId' style='display: none;' value='" + obj[index].id + "'<br/>"
			            		+ "<pre style='background: #FFFFF0;'>" +  obj[index].qTitle 
			            		+ "<br/><br/>"
			            		+ "<input type='number' class='form-control qranswer' name='qranswer' min='0' max='100'>" + "</pre>"
			            		+ "</td></tr>");
							break;
						default:
							break;
						}
					}
					
					$('.timepicker').datetimepicker({
			    		pickDate: false
			    	});
					
					$('.datepicker').datepicker();
					
					$("#qrModal").modal();
				},
				error : function(request, status, error) {
					if (request.status != '0') {
						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
					}
				}
				});
    		}	
    	
    	
    	// 설문지 결과 조회
		function resultQuestion(id){
			var param = "id" + "=" + id;

			$.ajax({
			url : "/Secsm/api_questionResult",
			type : "GET",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response == "200"){
					location.replace("/Secsm/questionResult/" + id);
				}
				else if(response == "401"){
					// 비로그인
					location.replace("/Secsm/index");
				}
				else if(response == "403"){
					// 자기 설문지 아님
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
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> 설문 </h1>
			</div>
			
			<div align="right" >
				<button type="button" class="btn" data-toggle="modal" data-target="#questionAddModal" style="margin: 5px;">설문 등록</button>
			</div>
			
			<div>
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>No.</th>
				        <th>제목</th>
				        <th>작성자</th>
				        <th>기간</th>
				        <th>비고</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<%
				    		for(QuestionInfo info : questionList){
				    			out.print("<tr style=\"cursor:pointer;\" onClick=\"loadQuestion(" + info.getId() + ")\" data-toggle=\"modal\" data-target=\"#questionnaireModal\">");
				    			out.print("<td>" + info.getId() + "</td>");
				    			out.print("<td>" + info.getTitle() + "</td>");
				    			out.print("<td>" + info.getAccountId() + "</td>");
				    			out.print("<td>" + Util.getTimestempStr(info.getStartDate()) 
		    						+ " ~ " + Util.getTimestempStr(info.getEndDate()) + "</td>");
		    					if(info.getAccountId() == accountInfo.getId()){
		    						out.print("<td>" + "<button type='button' class='btn' onclick='event.cancelBubble=true; resultQuestion(" + info.getId() + ");'>결과 조회</button>" + "</td>");
		    					}
				    			
				    			out.print("</tr>");
				    		}
				    	%>
				    </tbody>
				  </table>
			</div>
			
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	
	</body>
	 <jsp:include page="modals/accountAdminModal.jsp" flush="false" />
	   	<jsp:include page="modals/accountInfoModal.jsp" flush="false" />
		<jsp:include page="modals/accountModifyModal.jsp" flush="false" />	
	<jsp:include page="modals/questionAddModal.jsp" flush="false" />
	<jsp:include page="modals/questionnaireModal.jsp" flush="false" />
</html>
