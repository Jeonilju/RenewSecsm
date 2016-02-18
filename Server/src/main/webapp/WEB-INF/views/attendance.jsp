<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.info.AttendanceInfo"%>
<%@page import="com.secsm.conf.*"%>
<%@page import="com.secsm.info.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@ page pageEncoding="utf-8"%>

<html>
<head>
<!-- Encoding -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="base/header.jsp" flush="false" />
<link href='./resources/jquery.jqplot.1.0.8r1250/dist/jquery.jqplot.min.css' rel='stylesheet' />
<link rel='stylesheet' href='./resources/fullcalendar/fullcalendar.css' />
<script src='./resources/fullcalendar/lib/jquery.min.js'></script>
<script src='./resources/fullcalendar/lib/moment.min.js'></script>
<script src='./resources/fullcalendar/fullcalendar.js'></script>
<script src='./resources/jquery.jqplot.1.0.8r1250/dist/jquery.jqplot.min.js'></script>
<script src="./resources/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script src="./resources/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.barRenderer.min.js"></script>
<script src="./resources/jquery.jqplot.1.0.8r1250/dist/plugins/jqplot.pointLabels.min.js"></script>

<title>Attendance</title>

<%
    ArrayList<AttendanceInfo> attendanceList = (ArrayList<AttendanceInfo>) request.getAttribute("AttendanceInfo");
	String obj = "[";	
	if(attendanceList != null){
		for (AttendanceInfo info : attendanceList) {
			obj = obj +"{\"start\":\"" + info.getRegDate() + "\","
				+"\"className\":\"attendance\",\"borderColor\":\"white\",\"allDay\":\"false\"},";	
		}
		obj = obj.substring(0, obj.length()-1); 
		obj += "]";
	}
	else {
		obj ="[]";
	}
%>

<%
	int month1, month2, month3, month4;
	int[] rate =  (int[]) request.getAttribute("AttendanceRate");
	Date today = new Date();
	month1 = today.getMonth()+1;
	month2 = (month1-1>0 ? month1-1 : month1+11);
	month3 = (month1-2>0 ? month1-2 : month1+10);
	month4 = (month1-3>0 ? month1-3 : month1+9);	
%>

<script type="text/javascript">
	$(document).ready(function() {
		var info = '<%=obj%>';
		var obj = JSON.parse(info);
		var date = new Date();
		
		$('#calendar').fullCalendar({
			header : {
				left : '',
				center: 'title',
				right : 'prev,next,today'
			},
			editable : false,
			eventLimit : true,
			allDay : false,
			events : obj,
			
		});
		
		
	    $('#plot1').jqplot([[[<%=rate[month1-1]%>,<%=month1%>+'월'],[null,null]]], {
	        	title:'이번달 출석률(' + (date.getMonth()+1) + '.' + date.getDate() + '일 기준)',
	    		seriesDefaults: {
				    renderer:$.jqplot.BarRenderer,
				    rendererOptions: {
				        barDirection: 'horizontal'
				    },
	    			pointLabels: {show: true, formatString: '%d\%'}
	    		},
				axes: {
			    yaxis: {
			        renderer: $.jqplot.CategoryAxisRenderer,
			    },
	    		xaxis:{
	    			ticks:[0,20,40,60,80,100],
	                tickOptions:{formatString:'%d\%'}
	            }

			}
		});
	    
	    
	    var line2 = [<%=rate[month4-1]%>,<%=rate[month3-1]%>,<%=rate[month2-1]%>];
	    var ticks2 = [<%=month4%>+'월',<%=month3%>+'월',<%=month2%>+'월'];
	    $('#plot2').jqplot([line2], {
	        title:'최근 3개월 출석률',
	        // Provide a custom seriesColors array to override the default colors.
	        seriesColors:['#5e61a3', '#383b78', '#02064a'],
	        seriesDefaults:{
	            renderer:$.jqplot.BarRenderer,
	            rendererOptions: {
	                varyBarColor: true
	            },
	   			pointLabels: {show: true, formatString: '%d\%'}
	        },
	        axes:{
	            xaxis:{
	                renderer: $.jqplot.CategoryAxisRenderer,
	            	ticks:ticks2
	            },
	        	yaxis:{
                	ticks:[0,20,40,60,80,100],
                	tickOptions:{formatString:'%d\%'}
            	}
	        }
	    });
	});
</script>

<style>
	.attendance{
		margin:0, auto;
		background-color:white;
		background-image: url("./resources/image/attendance.PNG");
		background-repeat:no-repeat;
		background-position: center;
		background-size: contain;
		height:3em;
	}
	
	.fc-today{
		color:red;
		font-weight: bold;
	}
	
	#plot1{
		margin-top:10px;
		height:130px;
	}
	
	#plot2{
		margin-top:15px;
		height:330px;
	}

</style>
</head>



<jsp:include page="base/nav.jsp" flush="true" />
<body>

	<div class="container body-content" style="margin-top: 150px">
		<div class="row-fluid">
			<div class="col-md-12">
				<div>
				<h1>출석</h1>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">	
			<div class="col-md-4">
				<div>
					<div id='plot1'></div>
				</div>
				<div>
					<div id='plot2'></div>
				</div>
			</div>
			
			<div class="col-md-1"></div>
		
			<div class="col-md-7">
				<div>
					<div id='calendar'></div>
				</div>
			</div>
		</div>

		<!--<jsp:include page="base/foot.jsp" flush="false" />-->
	</div>
</body>
</html>
