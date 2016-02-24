<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>
<%
	ProjectInfo info2 = (ProjectInfo) request.getAttribute("projectInfo");
	int projectId = info2.getId();
%>

<script type="text/javascript">
	$(function(){
	    $("#addAttachBtn").click(function(){
	  	  var formData = new FormData();
	  	  formData.append("projectId", $("input[name=projectId]").val());
	  	  formData.append("tag", $("input[name=tag]").val());
	  	  formData.append("attachFile", $("input[name=attachFile]")[0].files[0]);
	  	 
	  	  $.ajax({
	  	    url: '/Secsm/api_projectAddAttach',
	  	    data: formData,
	  	    processData: false,
	  	    contentType: false,
	  	    type: 'POST',
	  	    success: function(data){
	  	    	if(data =="200"){
	  	    		alert("등록되었습니다.");
	  	    		window.location.reload(true);
	  	    	}
	  	    	else{
	  	    		alert("Error");	
	  	    	}
	  	    	
	  	    }
	  	  });
	
	    });
	});
</script>

<!-- 문서 추가 -->
<div class="modal fade" id="projectAddAttach" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="addAttachForm" id="addAttachForm" action="/api_projectAddAttach" enctype="multipart/form-data">
				<input id="projectId" name="projectId" value="<%=projectId%>" style="display: none;">
				<div class="modal-header">
					<h4 class="modal-title">문서 등록</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="tag" cond="">Tag</label> 
						<input name="tag" id="tag" type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label for="attachFile" cond="">파일</label> 
						<input name="attachFile" id="attachFile" type="file" class="form-control"/>
					</div>
				</div>

				<div class="modal-footer">
					<button id="addAttachBtn" name="addAttachBtn" type="button" class="btn btn-default" ">등록</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>