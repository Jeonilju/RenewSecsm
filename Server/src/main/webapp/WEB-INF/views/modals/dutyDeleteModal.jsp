<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">		
	function eventDelete(){
		   var param = "title" + "=" + $('#dutyDeleteName').text() + "&" + 
		   			"date" + "=" + deleteDate;
		   
		 $.ajax({
		    url : "/Secsm/dutyDelete",
		    type : "POST",
		    data : param,
		    cache : false,
		    async : false,
		    dataType : "text",

	    	success : function(response) {   
	    		alert(response);
	       		if(response=='0')
	       		{
	       		  	alert($('#dutyDeleteName').text() + '님의 당직일정이 삭제 되었습니다.');
	       	    	location.reload();
	      	 	}
	       		if(response=='1')
	       		{
	       		  	alert('해당 회원이 존재하지 않습니다.');
	       	    	location.reload();
	      	 	}
	       		if(response=='3')
	       		{
	       		  	alert('로그인을 하세요.');
	       	    	location.reload();
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
<div class="modal fade" id="dutyDeleteModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="dutyDelete" id="dutyDelete">
				<div class="modal-header">
					<h4 class="modal-title">당직삭제</h4>
				</div>
				<div class="modal-body" >
					<p><span id="dutyDeleteName"></span><span>님의 당직일정을 삭제하시겠습니까?</span></p>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="eventDelete()">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>