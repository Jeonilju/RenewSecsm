<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.EquipmentItemsInfo"%>
<%@page import="com.secsm.info.EquipmentCategoryInfo"%>
<%@page import="com.secsm.info.AccountInfo"%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Equipment</title>
    	
    	<%AccountInfo member = Util.getLoginedUser(request);%>
    	
    	<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>
    	
    	<script type="text/javascript">
    		
    		var grade = <%=member.getGrade()%>;
    		var searchOptionVar=0;
    		var searchCategoryVar='ALL';
    		var searchKeywordVar='';
    		var page = 7;
    		
    		$(document).ready(function(){
    			equipmentSearch(0);
    			if(grade==0 || grade==5){
    				$('.adminButton').css('display', 'block'); 
    			}
    			
    	   		$("#searchOptionWrap").css({"margin-top":"15px","margin-left":"5px","margin-right":"5px"});
    	   		$(window).keydown(function(event){
    	   		    if(event.keyCode == 13) {
    	   		      event.preventDefault();
    	   		      return false;
    	   		    }
    	   		}); 	   		
    		});
    		
    		function goImage(imageURL){
    			var imageSrc = '<img src="./resources/equipmentImage/'+ imageURL + '" class="img-thumbnail" alt="No Image">';
    			$("#equipmentImageBody").html(imageSrc)
    			$("#equipmentImageBody").css("text-align","center");
    		}
    		
    		function recentLog(){
    			$('#allLog').removeAttr("checked");
    			$('select[name=logOption]').val(0);
    			$("#logSearch").val("");
    			logEquipment(0);
    		}
    		
    		function rent(id){
    			$('#rentId').val(id);
    		}
    		
    		function noRent(id){
    			$('#allLog').removeAttr("checked");
    			$('select[name=logOption]').val(1);
    			$("#logSearch").val(id);
    			logEquipment(0);
    		}
    		
    		function equipmentSearch(option){
    			if(option==0){
        			searchOptionVar= $(':radio[name="searchOption"]:checked').val();
            		searchCategoryVar= $("#searchCategory option:selected").val();
            		searchKeywordVar= $("#searchKeyword").val();
        			page = 0;
        		}
        		else if(option==1 && 0>=page) return;
        		else if(option==1) page = page-7;
        		else if(option==2) page = page+7;
    			
    			var param = {searchOption: searchOptionVar, 
    						searchCategory: searchCategoryVar, 
    						searchKeyword: searchKeywordVar,
    						searchPage: page
    						}

    			$.ajax({
    			url : "/Secsm/api_equipmentSearch",
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
    					alert("해당 카테고리가 존재하지 않습니다.");
    					location.reload();
    				}
    				else
    				{
    					var obj = JSON.parse(response);
    					
    					if(Object.keys(obj).length==0 && option==2){
    						page = page-7;
							return;    					
    					}
    					
    					var tableContent = '<tbody>';
    					var i;
    					for(i=0;i<Object.keys(obj).length;i++){
    						tableContent = tableContent + '<tr>'
    										+ '<td class="col-md-1">' + obj[i].id + '</td>'
    										+ '<td class="col-md-1">' + '<button type="button" class="btn btn-info" onclick="goImage(\'' + obj[i].imageURL
    										+ '\');" data-toggle="modal" data-target="#equipmentImageModal">보기</button> </td>';
    						if(grade==0 ||grade==5){
    							tableContent = tableContent + '<td class="col-md-5" style="cursor:pointer;" onClick="modifyEquipment(' + obj[i].id + ')" data-toggle="modal" data-target="#equipmentModifyModal">' + obj[i].name + '</td>';
    						}
    						else {
    							tableContent = tableContent + '<td class="col-md-5">' + obj[i].name + '</td>';
    						}
    						
    						tableContent = tableContent	+ '<td class="col-md-3">' + obj[i].manufacturer + '</td>'
    										+ '<td class="col-md-1">' + obj[i].count + '/' + obj[i].totalCount + '</td>';

    						if(obj[i].count=='0'){
    							tableContent = tableContent + '<td class="col-md-1">' + '<button type="button" class="btn btn-danger" onclick="noRent('
												+ obj[i].id + ');" data-toggle="modal" data-target="#equipmentLogModal">대여불가</button>' + '</td> </tr>';
    						}
    						else{
    							tableContent = tableContent + '<td class="col-md-1">' + '<button type="button" class="btn btn-success" onclick="rent('
								+ obj[i].id + ');" data-toggle="modal" data-target="#equipmentRentModal">대여가능</button>' + '</td> </tr>';
    						}
    					}
    					tableContent = tableContent + '</tbody>';
    					var tableHeader = '<thead> <tr> <th class="col-md-1">No.</th> <th class="col-md-1">이미지</th> <th class="col-md-5">장비명</th>' +
				        				'<th class="col-md-3">제조사</th> <th class="col-md-1">수량</th> <th class="col-md-1">대여</th> </tr> </thead>';
    				    var table = tableHeader + tableContent;
    				    
    					$("#mainTable").html(table);
    				}
    			},
    			error : function(request, status, error) {
    				if (request.status != '0') {
    					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
    				}
    			}
    			
    			});
    		}
    		
    		function modifyEquipment(id){
    			var param = {searchId: id};
    			$('#modifyId').val(id);
    			
    			$.ajax({
        			url : "/Secsm/api_equipmentSearchForModify",
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
        				else if(response=='402')
        				{
        					alert("해당 장비정보가 없습니다.");
        					location.reload();
        				}
        				else if(response=='403')
        				{
        					alert('권한이 없습니다.');
        				}
        				else
        				{
        					var obj = JSON.parse(response);
        					
        					$("#modifyCode").val(obj[0].code);
        					$("#modifyTitle").val(obj[0].name);
        					$("#modifyManufacturer").val(obj[0].manufacturer);
        					$("#modifyCount").val(obj[0].totalCount);
        					$('select[name=modifyType]').val(parseInt(obj[0].type));
        				}
        			},
        			error : function(request, status, error) {
        				if (request.status != '0') {
        					alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
        				}
        			}
        			
        			});
    		}
    		
    		$(document).keyup(function(event){
    			if(event.keyCode != 13){
    			
    			}
    			else if($('#equipmentAddModal').is(':visible')){
    				isFile();
    		    }
    		    else if($('#equipmentCategoryModal').is(':visible')){
    		    	addCategory();
    		    }
    		    else if($('#equipmentLogModal').is(':visible')){
    		    	logEquipment(0);
    		    }
    		    else if($('#equipmentModifyModal').is(':visible')){
    		    	modifyReq();
    		    }
    		    else if($('#equipmentRentModal').is(':visible')){
    		    	rentEquipment();
    		    }
    		    else if($('#equipmentReqModifyModal').is(':visible')){
    		    	requestModify();
    		    }
    		    else if($('#equipmentReqListModal').is(':visible')){
    		    	reqList(0);
    		    }
    		    else if($('#equipmentRequestModal').is(':visible')){
    		    	requestEquipment();
    		    }
    		    else if($('#equipmentImageModifyModal').is(':visible')){
    		    	modifyImageEquipment();
    		    }
    		    else{
    		    	equipmentSearch(0);
    		    }
    		});
    		
    	</script>
    	
    	<style>
    		#searchKeyword{
    			margin-top:6px;
    			width: 300px;
    		}
    		#category{
    			margin-top:6px;
    		}
    		.datepicker{z-index:1151 !important;}
    		
    		td{
    			word-break:break-all;
    		}
    		
    		.adminButton{
				display:none;
			}
		}
			
    	</style>
	</head>
	
	<%
		ArrayList<EquipmentCategoryInfo> equipmentCategory = (ArrayList<EquipmentCategoryInfo>) request.getAttribute("equipmentCategory");
	%>
	
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row">
				<h1> Equipment </h1>
			</div>
			<div class="row">
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#equipmentRequestModal" style="margin: 5px; margin-right: 0px;">장비신청</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" onclick="equipmentSearch(0);" style="margin: 5px;">검색</button>
				</div>
				<div class="pull-right">
					<input type="text" class="form-control" id="searchKeyword" maxlength="30" autofocus>
				</div>
				<div class="pull-right">
					<select class="form-control" name="searchCategory" id="searchCategory" style="width:10em; margin-top:6px">
              			<%
              				for (EquipmentCategoryInfo info : equipmentCategory){
              					out.println("<option>" + info.getName() + "</option>");
              				}
              			%>
         			 </select>
         		</div>
         		<div class="pull-right" id="searchOptionWrap">
					<label for="searchOption"><input type="radio" name="searchOption" value="0" checked>장비명</label>
					<label for="searchOption"><input type="radio" name="searchOption" value="1" >코드</label>
					<label for="searchOption"><input type="radio" name="searchOption" value="2" >ID</label>
				</div>
         		<div class="pull-right">
					<button type="button" class="btn adminButton" data-toggle="modal" data-target="#equipmentCategoryModal" style="margin: 5px;">추가/삭제</button>
				</div>
			</div>
			<div class="row">
			<div class="pull-right">
				<table class="table table-hover" id="mainTable" style="table-layout:fixed;">
				</table>
			</div>
			</div>
			<div class="row">
				<div class="pull-left">
					<button type="button" class="btn" onclick="equipmentSearch(1);" style="margin: 5px;">이전</button>
				</div>
				<div class="pull-left">
					<button type="button" class="btn" onclick="equipmentSearch(2);" style="margin: 5px; margin-left:0px;">다음</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#equipmentLogModal" onclick="recentLog();" style="margin: 5px; margin-right:0px;">대여로그</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn adminButton" data-toggle="modal" data-target="#equipmentAddModal" style="margin: 5px;">장비등록</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#equipmentReqListModal" style="margin: 5px;" onclick="myReqList(0);">신청목록</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn btn-danger adminButton" data-toggle="modal" data-target="#equipmentLogModal" onclick="logEquipment(4);" style="margin: 5px;">미납자</button>
				</div>
			</div>
		</div>	
		

		<jsp:include page="base/foot.jsp" flush="false" />
	</body>
	 <jsp:include page="modals/accountAdminModal.jsp" flush="false" />
	   	<jsp:include page="modals/accountInfoModal.jsp" flush="false" />
		<jsp:include page="modals/accountModifyModal.jsp" flush="false" />	
	<jsp:include page="modals/equipmentReqModifyModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentImageModifyModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentModifyModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentImageModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentCategoryModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentLogModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentRentModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentRequestModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentAddModal.jsp" flush="false" />
	<jsp:include page="modals/equipmentReqListModal.jsp" flush="false" />

</html>
