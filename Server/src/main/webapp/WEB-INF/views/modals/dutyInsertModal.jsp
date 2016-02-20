<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">		

	function eventInsert(){
		var param = "title" + "=" + $('#insertTitle').val() + "&" + 
					"date" + "=" + insertDate;
		
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
					alert( $('#insertTitle').val() + '님의 당직일정이 추가 되었습니다.');
					location.reload();
				}
				else if(response == '1')
				{
					alert('해당 회원은 존재하지 않습니다.');
				}	
				else if(response == '2'){
					alert('해당 당직 날짜에 당직일정을 추가할 수 없습니다.');
				}
				else if(response == '3'){
					alert('해당 날짜에 당직자가 이미 초과하였습니다.');
				}
				else if(response == '4'){
					alert('로그인을 하세요.');
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

</script>
	
<!-- 자동당직생성 모달-->
<div class="modal fade" id="dutyInsertModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="dutyInsert" id="dutyInsert">
				<div class="modal-header">
					<h4 class="modal-title">당직추가</h4>
				</div>
				<div class="modal-body" >
					<label for="insertTitle" cond="">이름</label> 
					<input name="insertTitle" id="insertTitle" type="text" class="form-control"/>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="eventInsert()">추가</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>