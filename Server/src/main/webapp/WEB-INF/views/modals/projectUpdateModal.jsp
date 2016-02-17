<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>
<%
	ProjectInfo info2 = (ProjectInfo) request.getAttribute("projectInfo");
	int projectId = info2.getId();
	
	AccountInfo accountInfo2 = (AccountInfo) request.getAttribute("accountInfo");
%>

<script type="text/javascript">

	function updateProject(){
		var param = "updateProjectId" + "=" + $("#updateProjectId").val() + "&" + 
					"updateProjectName" + "=" + $("#updateProjectName").val() + "&" + 
					"updateProjectSummary" + "=" + $("#updateProjectSummary").val() + "&" + 
					"updateProjectDiscription" + "=" + $("#updateProjectDiscription").val() + "&" + 
					"updateProjectPL" + "=" + $("#updateProjectPL").val() + "&" + 
					"updateProjectTeam" + "="+ $("#updateProjectTeam").val();
		alert(param);
		$.ajax({
			url : "/Secsm/api_updateProject",
			type : "POST",
			data : param,
			cache : false,
			async : false,
			dataType : "text",
			
			success : function(response) {	
				if(response=='200')
				{
					// 정상 수정
					window.location.reload(true);
				}
				else if(response == '400'){
					// 비로그인
					location.replace("/Secsm/index");
				}
				else if(response == '401'){
					// 자기 프로젝트 아님
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


<!-- 프로젝트 생성 모달 -->
<div class="modal fade" id="projectUpdate" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="updateProjectForm" id="updateProjectForm" action="/api_updateProject">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<input id="updateProjectId" name="updateProjectId" type="text" style="display: none;" value="<%=projectId%>">
					<h4 class="modal-title" id="SignInModalLabel">프로젝트 수정</h4>
				</div>
				
				<div class="modal-body">
					<div class="form-group">
						<label for="updateProjectName">프로젝트 명</label> 
						<input name="updateProjectName" id="updateProjectName" type="text" class="form-control" value="<%=info2.getName()%>"/>
					</div>
					<div class="form-group">
						<label for="updateProjectSummary">요약</label> 
						<textarea name="updateProjectSummary" id="updateProjectSummary" rows="4" cols="50" class="form-control"><%=info2.getSummary() %></textarea>
					</div>
					<div class="form-group">
						<label for="updateProjectDiscription">내용</label> 
						<textarea name="updateProjectDiscription" id="updateProjectDiscription" rows="4" cols="50" class="form-control"><%=info2.getDescription() %></textarea>
					</div>
					<div class="form-group">
						<label for="updateProjectPL">PL</label> 
						<input name="updateProjectPL" id="updateProjectPL" type="text" class="form-control" style="width: 30%" value="<%=info2.getPl()%>"/>
					</div>
					<div class="form-group">
						<label for="updateProjectTeam">팀원</label> 
						<input name="updateProjectTeam" id="updateProjectTeam" type="text" class="form-control" style="width: 70%" value="<%=info2.getTeam()%>"/>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick='updateProject();'>수정</button>
				</div>
			</form>
		</div>
	</div>
</div>