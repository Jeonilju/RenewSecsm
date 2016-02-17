<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.*"%>
<%
	ProjectInfo info2 = (ProjectInfo) request.getAttribute("projectInfo");
	int projectId = info2.getId();
	
	AccountInfo accountInfo2 = (AccountInfo) request.getAttribute("accountInfo");
%>

<script type="text/javascript">

	function updateProject(){
		
	}

</script>


<!-- 프로젝트 생성 모달 -->
<div class="modal fade" id="updateProjectModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="updateProjectForm" id="updateProjectForm" action="/api_updateProject">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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
					<div class="form-group">
						<label for="updateProjectStartDate">시작일</label> 
						<input name="updateProjectStartDate" id="updateProjectStartDate" type="text" class="form-control" style="width: 30%" value="<%=info2.getStartDate()%>"/>
					</div>
					<div class="form-group">
						<label for="updateProjectEndDate">완료일</label> 
						<input name="updateProjectEndDate" id="updateProjectEndDate" type="text" class="form-control" style="width: 30%" value="<%=info2.getEndDate()%>"/>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick='updateProject()'>등록</button>
				</div>
			</form>
		</div>
	</div>
</div>