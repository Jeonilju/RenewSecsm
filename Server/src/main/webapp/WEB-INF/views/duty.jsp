<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.conf.*"%>


<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
		<link rel='stylesheet' href='./resources/fullcalendar/fullcalendar.css' />
		<script src='./resources/fullcalendar/lib/jquery.min.js'></script>
		<script src='./resources/fullcalendar/lib/moment.min.js'></script>
		<script src='./resources/fullcalendar/fullcalendar.js'></script>
    	<title>Duty</title>
    	
    	<%
    		ArrayList<DutyInfo> dutyList = (ArrayList<DutyInfo>) request.getAttribute("DutyInfo");
			AccountInfo member = Util.getLoginedUser(request);
		
			String obj ="";
			if(dutyList.size() != 0){     	
				obj = "[";
				for (DutyInfo info : dutyList) {
					if(info.getName1()!=null){
						if(info.getName1().equals(member.getName())){
							obj = obj +"{\"title\":\"" + info.getName1() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
									+"\"className\":\"my\",\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
						else{
							obj = obj +"{\"title\":\"" + info.getName1() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
								+"\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
					}
					if(info.getName2()!=null){
						if(info.getName2().equals(member.getName())){
							obj = obj +"{\"title\":\"" + info.getName2() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
									+"\"className\":\"my\",\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
						else{
							obj = obj +"{\"title\":\"" + info.getName2() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
								+"\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
					}
					if(info.getName3()!=null){
						if(info.getName3().equals(member.getName())){
							obj = obj +"{\"title\":\"" + info.getName3() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
									+"\"className\":\"my\",\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
						else{
							obj = obj +"{\"title\":\"" + info.getName3() + "\","  + "\"start\":\"" + info.getDutyDate() + "\","
								+"\"borderColor\":\"white\",\"allDay\":\"false\"},";
						}
					}
				}
				obj = obj.substring(0, obj.length()-1); 
				obj += "]";
			}
			else obj="[]";
		%>
    	
    	<script type="text/javascript">
    	   	
    		var grade = <%=member.getGrade()%>;
    	
	    	function eventInsert(title ,date){
    			var param = "title" + "=" + title + "&" + 
				"date" + "=" + date;
    			
				$.ajax({
					url : "/Secsm/dutyInsert",
					type : "POST",
					data : param,
					cache : false,
					async : false,
					dataType : "text",	

					success : function(response) {	
						if(response=='0')
						{
							alert(title + '님의 당직일정이 추가 되었습니다.');
							location.reload();
						}
						else if(response == '1')
						{
							alert('해당 회원은 존재하지 않습니다.');
						}	
						else if(response == '2'){
							alert('해당 당직 날짜에 당직일정을 추가할 수 없습니다.');
						}
						else{
							alert('해당 날짜에 당직자가 이미 초과하였습니다.');
						}
					},
					error : function(request, status, error) {
						if (request.status != '0') {
							alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
						}
					}
				});
			
	   		}
	    	
	    	function eventDelete(title ,date){
    			var param = "title" + "=" + title + "&" + 
				"date" + "=" + date;
    			
				$.ajax({
					url : "/Secsm/dutyDelete",
					type : "POST",
					data : param,
					cache : false,
					async : false,
					dataType : "text",	

					success : function(response) {	
						if(response=='0')
						{
							alert(title + '님의 당직일정이 삭제 되었습니다.');
							location.reload();
						}
						else
						{
							alert('새로고침 후 다시 시도해주세요.');
						}
					},
					error : function(request, status, error) {
						if (request.status != '0') {
							alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
						}
					}
				});
	   		}
	    	
    		$(document).ready(function() {
    			var info = '<%=obj%>';
    			var obj = JSON.parse(info);
    			
   				if(grade==0 || grade==3) $('#createDuty').css('display', 'block'); 
    			
    			$('#calendar').fullCalendar({
    				header : {
    					left : '',
    					center: 'title',
    					right : 'prev,next,today'
    				},
    				events: obj,
    				editable: false,
    				eventLimit : true,
    				allDay : false,
    				droppable: false,
    				eventClick: function(calEvent, jsEvent, view) {
    					var r=confirm(calEvent.title + "님의 당직일정을 삭제하시겠습니까?");
    		            if (r===true){
    		            	eventDelete(calEvent.title, calEvent.start);
    		            }
    				},
    				dayClick: function(date, allDay, jsEvent, view) {
    				    var title = prompt("당직일정에 추가할 이름을 입력하세요.");
    				    
    				    if (title) {
    				    	eventInsert(title,date);
    					}
    				}
    			});	

			});
    </script>
    
    <style>	
		body {
			padding: 0;
			font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
			font-size: 15px;
		}
		
		#calendar {
			margin-top:20px;
		}
		
		.fc-today{
			color:red;
			font-weight: bold;
		}
		
		.my{
			background-color: #02064a;
		}
		.fc-content{
			text-align: center;
		}
		#calendar a{
			text-decoration: none;
		}
		
		#createDuty{
			float:right;
			display:none;
			margin-top:20px;
			margin-right:10px;
		}

    </style>
    
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top:150px">
			<div class="row">
				<div class="col-md-8">
					<div>
						<h1>당직</h1>
					</div>
				</div>
				<div class="col-md-2">
					<button type="button" id="createDuty" class='btn' data-toggle="modal" data-target="#dutyCreateModal">
					<b>자동당직생성</b></button>
				</div>
				<div class="col-md-2"></div>
			</div>
		
			<div class="row-fluid">	
				<div class="col-md-2"></div>
			
				<div class="col-md-8">
					<div id='calendar'></div>
				</div>
				<div class="col-md-2"></div>
			</div>
			<jsp:include page="base/foot.jsp" flush="false" />
		</div>	
</body>
<jsp:include page="modals/dutyCreateModal.jsp" flush="false" />

</html>
