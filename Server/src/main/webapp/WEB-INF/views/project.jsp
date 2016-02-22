<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.info.AccountInfo"%>
<%@page import="com.secsm.info.ProjectInfo"%>
<%@page import="com.secsm.conf.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>

<%
	AccountInfo accountInfo = (AccountInfo) request.getAttribute("accountInfo");
%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Project</title>
    	
    	<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>
    	
    	<script type="text/javascript">
    		
    		// DatePicker 설정
			$(function() 
				{
					$("#createProjectStartDate").datepicker();
					$("#createProjectEndDate").datepicker();
				}
			);

    	
    		// 프로젝트 등록 다이얼로그
    		function createProject(){
    			var param = "createProjectName" + "=" + $("#createProjectName").val() + "&" + 
			    			"createProjectSummary" + "=" + $("#createProjectSummary").val() + "&" + 
			    			"createProjectDiscription" + "=" + $("#createProjectDiscription").val() + "&" + 
			    			"createProjectPL" + "=" + $("#createProjectPL").val() + "&" + 
			    			"createProjectPL_id" + "=" + $("#createProjectPL_id").val() + "&" + 
			    			"createProjectTeam" + "=" + $("#createProjectTeam").val() + "&" + 
			    			"createProjectStartDate" + "=" + $("#createProjectStartDate").val() + "&" + 
    						"createProjectEndDate" + "="+ $("#createProjectEndDate").val();
    			$.ajax({
    				url : "/Secsm/api_createProject",
    				type : "POST",
    				data : param,
    				cache : false,
    				async : false,
    				dataType : "text",
    		
    				success : function(response) {	
    					if(response=='200')
    					{
    						location.reload();
    					}
    					else
    					{
    						alert("프로젝트를 생성할 수 없습니다.");
    						return false;
    					}	
    					
    				},
    				error : function(request, status, error) {
    					if (request.status != '0') {
    						alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
    					}
    				}
    		
    			});
    		}
    		
    		function showDetailProject(projectId){
    			location.href= "/Secsm/detailProject/" + projectId;
    		}
    	</script>
    	
    	<style>
			.datepicker{z-index:1151 !important;}
		</style>
    	
	</head>

	<%
		ArrayList<ProjectInfo> projectList = (ArrayList<ProjectInfo>) request.getAttribute("projectList");
	%>

	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row-fluid">
				<h1> Project </h1>
			</div>
			
			<div class="pull-right">
				<button type="button" class="btn" data-toggle="modal" data-target="#createProjectModal" style="margin: 5px;">프로젝트 등록</button>
			</div>
			
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>No.</th>
			        <th>프로젝트 명</th>
			        <th>기간</th>
			        <th>PL</th>
			        <th>상태</th>
			      </tr>
			    </thead>
			    <tbody>
					<%
						for (ProjectInfo info : projectList){
							out.println("<tr style=\"cursor:pointer;\" onClick=\"showDetailProject(" + info.getId() + ")\">");
							out.println("<td>" + info.getId() + "</td>");
							out.println("<td>" + info.getName() + "</td>");
							out.println("<td>" + Util.getTimestempStr(info.getStartDate()) 
										+ " ~ " + Util.getTimestempStr(info.getEndDate()) + "</td>");
							out.println("<td>" + info.getPl() + "</td>");
							
							if(info.getStatus() == 0){
								// 시작단계
								out.println("<td>" + "미승인" + "</td>");
							}
							else if(info.getStatus() == 1){
								// 완료					
								out.println("<td>" + "진행중" + "</td>");
							}
							else if(info.getStatus() == 2){
								// 완료					
								out.println("<td>" + "완료" + "</td>");
							}
							else if(info.getStatus() == -1){
								// 드랍
								out.println("<td>" + "드랍" + "</td>");
							}
							else{
								// 알수없음
								out.println("<td>" + "알수없음" + "</td>");
							}
							
							out.println("</tr>");
						}
					%>
				</tbody>
			</table>
			
			<div>
				<button type="button" class="btn" >이전</button>
				<button type="button" class="btn" >다음</button>
			</div>
			
		</div>	

		<jsp:include page="base/foot.jsp" flush="false" />
	</body>

	<!-- 프로젝트 생성 모달 -->
	<div class="modal fade" id="createProjectModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form name="createProjectForm" id="createProjectForm" action="/api_createProject">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="SignInModalLabel">프로젝트 등록</h4>
					</div>
					
					<div class="modal-body">
						<div class="form-group">
							<label for="createProjectName" cond="">프로젝트 명</label> 
							<input name="createProjectName" id="createProjectName" type="text" class="form-control" />
						</div>
						<div class="form-group">
							<label for="createProjectSummary" cond="">요약</label> 
							<textarea name="createProjectSummary" id="createProjectSummary" rows="4" cols="50" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<label for="createProjectDiscription" cond="">내용</label> 
							<textarea name="createProjectDiscription" id="createProjectDiscription" rows="4" cols="50" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<label for="createProjectPL" cond="">PL</label> 
							<input name="createProjectPL" id="createProjectPL" type="text" class="form-control" style="width: 30%"/>
						</div>
						<div class="form-group">
							<label for="createProjectTeam" cond="">팀원</label> 
							<input name="createProjectTeam" id="createProjectTeam" type="text" class="form-control" style="width: 70%"/>
						</div>
						<div class="form-group">
							<label for="createProjectStartDate" cond="">시작일</label> 
							<input name="createProjectStartDate" id="createProjectStartDate" type="text" class="form-control" style="width: 30%"/>
						</div>
						<div class="form-group">
							<label for="createProjectEndDate" cond="">완료일</label> 
							<input name="createProjectEndDate" id="createProjectEndDate" type="text" class="form-control" style="width: 30%"/>
						</div>
						
						<input name="createProjectPL_id" id="createProjectPL_id" type="text" style="display: none;" value="<%=accountInfo.getId() %>"/>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" onclick='createProject()'>등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</html>
