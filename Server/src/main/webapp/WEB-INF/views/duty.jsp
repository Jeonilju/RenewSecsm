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
    		var deleteDate;
    		var insertDate;
    		
	    	
    		$(document).ready(function() {
    			$(window).keydown(function(event){
    	   		    if(event.keyCode == 13) {
    	   		      event.preventDefault();
    	   		      return false;
    	   		    }
    	   		}); 	
    			
    			var info = '<%=obj%>';
    			var obj = JSON.parse(info);
    			
   				if(grade==0 || grade==2) $('#createDuty').css('display', 'block'); 
    			
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
    					$("#dutyDeleteName").text(calEvent.title);
    					deleteDate = calEvent.start;
    					$('#dutyDeleteModal').modal();
    				},
    				dayClick: function(date, allDay, jsEvent, view) {
    				    insertDate=date;
    				    $('#dutyInsertModal').modal();
    				}
    			});	

			});
    		
    		$(document).keyup(function(event){
    			if(event.keyCode != 13){
    			
    			}
    			else if($('#dutyDeleteModal').is(':visible')){
    		    	eventDelete();
    		    }
    			else if($('#dutyInsertModal').is(':visible')){
    				eventInsert();
    		    }
    			else if($('#dutyCreateModal').is(':visible')){
    				addDuty();
    		    }
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
				<div>
					<h1>당직</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8"></div>
				<div class="col-md-2">
					<button type="button" id="createDuty" class='btn' data-toggle="modal" data-target="#dutyCreateModal">
					<b>당직 자동생성</b></button>
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
		</div>
	</body>
	
	<!--  <jsp:include page="modals/accountAdminModal.jsp" flush="false" />
	   	<jsp:include page="modals/accountInfoModal.jsp" flush="false" />
		<jsp:include page="modals/accountModifyModal.jsp" flush="false" />-->	
	<jsp:include page="modals/dutyCreateModal.jsp" flush="false" />
	<jsp:include page="modals/dutyDeleteModal.jsp" flush="false" />
	<jsp:include page="modals/dutyInsertModal.jsp" flush="false" />
	<jsp:include page="base/foot.jsp" flush="false" />	
</html>
