<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	
	function addItem(){
		var r=confirm("기존에 생성된 당직일정이 있다면 초기화 됩니다.\n계속 진행하시겠습니까?");
        if (r===false){
        	return;
        }
		
		var param = "weekdayStart" + "=" + $("#weekdayStart").val() + "&" + 
					"weekendStart" + "=" + $("#weekendStart").val() + "&" +
					"dutyDate" + "=" + $(':radio[name="dutyDate"]:checked').val() + "&" +
					"weekdayCount" + "=" + $(':radio[name="weekdayCount"]:checked').val() + "&" +
					"weekendCount" + "=" + $(':radio[name="weekendCount"]:checked').val() + "&" +
					"exceptionDay" + "=" + $("#exceptionDay").val() + "&" +
					"exceptionPerson" + "=" + $("#exceptionPerson").val();
		
		$.ajax({
		url : "/Secsm/dutyAutoCreate",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='0')
			{
				alert('당직일정이 자동생성 되었습니다.');
				location.reload();
			}
			else if(response=='1')
			{
				alert('평일시작 회원이 존재하지 않습니다.');
			}
			else if(response=='2'){
				alert('주말시작 회원이 존재하지 않습니다.');
			}
			else if(response=='3'){
				alert('제외날짜의 포맷을 확인하세요.');
			}
			else{
				alert('제외인원이 존재하지 않거나 잘못된 포맷을 사용하고 있습니다.');
			}
			
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}
	
	$("#etItemCode").keyup(function(event){
	    if(event.keyCode == 13){
	    	addItem();
	    }
	});

</script>

<!-- 자동당직생성 모달-->
<div class="modal fade" id="dutyCreateModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="autoDutyCreate" id="autoDutyCreate" action="/dutyAutoCreate">
				<div class="modal-header">
					<h4 class="modal-title">자동당직생성</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="dutyDate">다음달</label>
						<input type="radio" name="dutyDate" value="0" checked>
						<label for="dutyDate" style="margin-left:8px">이번달</label>
						<input type="radio" name="dutyDate" value="1">
					</div>
					
					<div class="form-group">
						<label for="weekdayCount" style="margin-right:8px">평일인원:</label>
						<label for="weekdayCount" style="margin-right:5px"><input type="radio" name="weekdayCount" value="1">1명</label>
						<label for="weekdayCount" style="margin-right:5px"><input type="radio" name="weekdayCount" value="2" checked>2명</label>
						<label for="weekdayCount"><input type="radio" name="weekdayCount" value="3">3명</label>
					</div>
					
					<div class="form-group">
						<label for="weekendCount" style="margin-right:8px">주말인원:</label>
						<label for="weekendCount" style="margin-right:5px"><input type="radio" name="weekendCount" value="1">1명</label>
						<label for="weekendCount" style="margin-right:5px"><input type="radio" name="weekendCount" value="2" checked>2명</label>
						<label for="weekendCount"><input type="radio" name="weekendCount" value="3">3명</label>
					</div>
					
					<div class="form-group">
						<label for="exceptionDay" cond="">제외날짜 ex)15/16/17</label> 
						<input name="exceptionDay" id="exceptionDay" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="exceptionPerson" cond="">제외인원 ex)조규현/전일주</label> 
						<input name="exceptionPerson" id="exceptionPerson" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="weekdayStart" cond="">평일시작</label> 
						<input name="weekdayStart" id="weekdayStart" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="weekendStart" cond="">주말시작</label> 
						<input name="weekendStart" id="weekendStart" type="text" class="form-control"/>
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addItem();">생성</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>