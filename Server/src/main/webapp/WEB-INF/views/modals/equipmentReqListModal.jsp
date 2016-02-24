<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	var reqListStartDateVar = $("#reqListStartDate").val(); 
	var reqListEndDateVar = $("#reqListEndDate").val();
	var reqPage = 0;
	var isMy = true;
	
	$(function() 
		{
			$("#reqListStartDate").datepicker();
			$("#reqListEndDate").datepicker();
		}
	);
	
	function goExcel(){
		if($("#reqListStartDate").val()==""){
			alert("시작일을 입력하세요.");
			return;
		}
		else if($("#reqListEndDate").val()==""){
			alert("마감일을 입력하세요.");
			return;
		}
		
		var excelURL = window.location.href + 'ReqExcel?'
						+ "reqListStartDate" + "=" + $("#reqListStartDate").val() + "&" 
						+ "reqListEndDate" + "=" + $("#reqListEndDate").val();
		window.open(excelURL); 
	}
	
	function reqListCheck(option){
		if(isMy) myReqList(option);
		else reqList(option);
	}
	
	function myReqList(option){
		if(option ==0){
			reqPage = 0;
			isMy= true;
		}
		else if(option==1 && 0>=reqPage ) return;
		else if(option==1) reqPage = reqPage -7;
		else if(option==2) reqPage = reqPage +7;
		
		var param = "reqPage" + "=" + reqPage;
		
		$.ajax({
		url : "/Secsm/api_equipmentMyReqList",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else
			{
				var obj = JSON.parse(response);
				
				if(Object.keys(obj).length==0 && option==2){
					reqPage = reqPage -7;
					return;    					
				}
				
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					tableContent = tableContent + '<tr> <td class="col-md-2">' + obj[i].typeKr 
					+ '</td> <td class="col-md-4" style="cursor:pointer;" onClick="reqSearchEquipment(' + obj[i].id + ')" data-toggle="modal" data-target="#equipmentReqModifyModal">'
					+ obj[i].titleKr + '</td> <td class="col-md-2">' + obj[i].brand + '</td> <td class="col-md-1">' 
					+ obj[i].count + '</td> <td class="col-md-1">' + obj[i].accountName + '</td> <td class="col-md-2">' + obj[i].strRegDate  + '</td> </tr>';	
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+'<th class="col-md-2">분류</th> <th class="col-md-4">장비명</th> <th class="col-md-2">브랜드</th> <th class="col-md-1">수량</th> <th class="col-md-1">신청자</th> <th class="col-md-2">신청일</th> </tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#equipmentReqListTable").html(table);
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	function reqList(option){
		if(option==0){
			reqListStartDateVar = $("#reqListStartDate").val(); 
			reqListEndDateVar = $("#reqListEndDate").val();
			reqPage = 0;
			isMy = false;
		}
		else if(option==1 && 0>=reqPage ) return;
		else if(option==1) reqPage = reqPage -7;
		else if(option==2) reqPage = reqPage +7;

		var param = "reqListStartDate" + "=" + reqListStartDateVar + "&" + 
					"reqListEndDate" + "=" + reqListEndDateVar  + "&" + 
					"reqPage" + "=" + reqPage;
 		
		if($("#reqListStartDate").val()==""){
			alert("시작일을 입력하세요.");
			return;
		}
		else if($("#reqListEndDate").val()==""){
			alert("마감일을 입력하세요.");
			return;
		}
		else{}
		
		$.ajax({
		url : "/Secsm/api_equipmentReqList",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='401')
			{
				alert('로그인을 하세요.');
				location.reload();
			}
			else
			{
				var obj = JSON.parse(response);
				
				if(Object.keys(obj).length==0 && option==2){
					reqPage = reqPage -7;
					return;    					
				}
				
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					tableContent = tableContent + '<tr> <td class="col-md-2">' + obj[i].typeKr + '</td> <td class="col-md-4">'
								+ obj[i].titleKr + '</td> <td class="col-md-2">' + obj[i].brand + '</td> <td class="col-md-1">' 
								+ obj[i].count + '</td> <td class="col-md-1">' + obj[i].accountName + '</td> <td class="col-md-2">' + obj[i].strRegDate  + '</td> </tr>';	
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+'<th class="col-md-2">분류</th> <th class="col-md-4">장비명</th> <th class="col-md-2">브랜드</th> <th class="col-md-1">수량</th> <th class="col-md-1">신청자</th> <th class="col-md-2">신청일</th> </tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#equipmentReqListTable").html(table);
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

<div class="modal fade" id="equipmentReqListModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog modal-lg" >
		<div class="modal-content">
			<form name="equipmentReqList" id="equipmentReqList">
				<div class="modal-header">
					<h4 class="modal-title">신청목록</h4>
				</div>
				<div class="modal-body" >
					<div id=equipmentReqListTable>
						
					</div>
				</div>

				<div class="modal-footer form-inline">
					<button type="button" class="btn" onclick="reqListCheck(1);" style="float:left;" >이전</button>
					<button type="button" class="btn" onclick="reqListCheck(2);" style="margin-left:5px; float:left;">다음</button>
					<label for="reqListStartDate" style="margin-right:4px">기간:</label>
					<input name="reqListStartDate" id="reqListStartDate" type="text" class="form-control" style="width: 15%; margin-right:5px"/>~ 
					<input name="reqListEndDate" id="reqListEndDate" type="text" class="form-control" style="width: 15%"/>
					<button type="button" class="btn btn-default" onclick="reqList(0);">검색</button>
					<button type="button" class="btn btn-success" onclick="goExcel();">Excel</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>