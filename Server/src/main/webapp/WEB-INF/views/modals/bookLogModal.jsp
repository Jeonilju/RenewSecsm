<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript">
	
	$(function() 
		{
			$("#rentEndDate").datepicker();
		}
	);
	
	function rentBack(logId, accountId, bookItemsId){

		var param = "logId" + "=" + logId + "&" + 
					"accountId" + "=" + accountId + "&" +
					"bookItemsId" + "=" + bookItemsId;
		
		$.ajax({
		url : "/Secsm/api_rentBack",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{ 
				alert("반납완료");
				location.reload();
			}
			else if(response=='401')
			{
				alert("로그인을 하세요.");
				location.reload();
			}
			else if(response=='402')
			{
				alert("대여자가 아닙니다.");
			}
			else{}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function logBook(){

		var param = {logOption: $("#logOption option:selected").text(), 
					logSearch: $("#logSearch").val(),
					allLog: $('#allLog').is(':checked')};
		
		$.ajax({
		url : "/Secsm/api_logBook",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{ 
				alert("로그인을 하세요.");
				location.reload();
			}
			if(response=='402')
			{ 
				alert("ID 값은 숫자만 입력하세요.");
			}
			else
			{
				var obj = JSON.parse(response);
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					tableContent = tableContent + '<tr> <td class="col-md-1">' + obj[i].bookItemsId + '</td> <td class="col-md-4">' + obj[i].bookItemsName
									+ '</td> <td class="col-md-2">' + obj[i].strStartDate + '</td> <td class="col-md-2">' + obj[i].strEndDate
									+ '</td> <td class="col-md-2">' + obj[i].accountName;
					if(obj[i].status=="1"){
						tableContent = tableContent + '</td> <td class="col-md-1"> <button type="button" class="btn btn-success"  onclick="rentBack('
										+ obj[i].id + ',' + obj[i].accountId + ',' + obj[i].bookItemsId + ')">반납</button> </td> </tr>';	
					}
					else tableContent = tableContent + '</td> <td class="col-md-1"> <button type="button" class="btn btn-danger"  onclick="">완료</button> </td> </tr>';	
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+'<th class="col-md-1">ID</th> <th class="col-md-4">도서명</th> <th class="col-md-2">대여일</th>'
			        				+'<th class="col-md-2">반납일</th> <th class="col-md-2">대여자</th>'
			        				+'<th class="col-md-1">반납</th></tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#bookLogTable").html(table);
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

<div class="modal fade" id="bookLogModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form name="bookLog" id="bookLog">
				<div class="modal-header">
					<h4 class="modal-title">대여로그</h4>
				</div>
				<div class="modal-body" >
					<div id=bookLogTable>
						
					</div>
				</div>

				<div class="modal-footer form-inline">
					<div class="checkbox">
						<label><input type="checkbox" id = "allLog">모든로그보기</label>
  					</div>
				
					<select class="form-control" name="logOption" id="logOption" style="width: 20% margin-left:0px">
           	  			<option value="0">도서명</option>
           	  			<option>대여자</option>
           	  			<option>코드</option>	
           	  			<option value="1">ID</option>
         			 </select>
         			
         			<label for="logSearch" cond=""></label> 
					<input name="logSearch" id="logSearch" type="text" class="form-control" style="width: 30%"/>
					<button type="button" class="btn btn-default" onclick="logBook();">검색</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>