<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="com.secsm.conf.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>
<%@page import="com.secsm.info.BookItemsInfo"%>
<%@page import="com.secsm.info.BookCategoryInfo"%>
<%@page import="com.secsm.info.AccountInfo"%>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>Book</title>
    	
    	<%AccountInfo member = Util.getLoginedUser(request);%>
    	
    	<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>
    	
    	<script type="text/javascript">
    		
    		var grade = <%=member.getGrade()%>;
    		var searchOptionVar=0;
    		var searchCategoryVar='ALL';
    		var searchKeywordVar='';
    		var page = 7;
    		
    		$(document).ready(function(){
    			bookSearch(0);
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
    			var imageSrc = '<img src="'+ imageURL + '" class="img-thumbnail" alt="No Image">';
    			$("#bookImageBody").html(imageSrc)
    			$("#bookImageBody").css("text-align","center");
    		}
    		
    		function recentLog(){
    			$('#allLog').removeAttr("checked");
    			$('select[name=logOption]').val(0);
    			$("#logSearch").val("");
    			logBook(0);
    		}
    		
    		function rent(id){
    			$('#rentId').val(id);
    		}
    		
    		function noRent(id){
    			$('#allLog').removeAttr("checked");
    			$('select[name=logOption]').val(1);
    			$("#logSearch").val(id);
    			logBook(0);
    		}
    		
    		function bookSearch(option){
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
    			url : "/Secsm/api_bookSearch",
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
    					if(Object.keys(obj).length == 1 && searchOptionVar == 1){
    						if(obj[0].count >=1){
    							DirectRent(obj[0].id);
    						}
    						else{
    							DirectlogBook(0,obj[0].id);
    						}
    					}
    					
    					for(i=0;i<Object.keys(obj).length;i++){
    						tableContent = tableContent + '<tr>'
    										+ '<td class="col-md-1">' + obj[i].id + '</td>'
    										+ '<td class="col-md-1">' + '<button type="button" class="btn btn-info" onclick="goImage(\'' + obj[i].imageURL
    										+ '\');" data-toggle="modal" data-target="#bookImageModal">보기</button> </td>';
    						if(grade==0 ||grade==5){
    							tableContent = tableContent + '<td class="col-md-5" style="cursor:pointer;" onClick="modifyBook(' + obj[i].id + ')" data-toggle="modal" data-target="#bookModifyModal">' + obj[i].name + '</td>';
    						}
    						else {
    							tableContent = tableContent + '<td class="col-md-5">' + obj[i].name + '</td>';
    						}
    						
    						tableContent = tableContent	+ '<td class="col-md-2">' + obj[i].publisher + '</td>'
    										+ '<td class="col-md-1">' + obj[i].author + '</td>'
    										+ '<td class="col-md-1">' + obj[i].count + '/' + obj[i].totalCount + '</td>';

    						if(obj[i].count=='0'){
    							tableContent = tableContent + '<td class="col-md-1">' + '<button type="button" class="btn btn-danger" onclick="noRent('
												+ obj[i].id + ');" data-toggle="modal" data-target="#bookLogModal">대여불가</button>' + '</td> </tr>';
    						}
    						else{
    							tableContent = tableContent + '<td class="col-md-1">' + '<button type="button" class="btn btn-success" onclick="rent('
								+ obj[i].id + ');" data-toggle="modal" data-target="#bookRentModal">대여가능</button>' + '</td> </tr>';
    						}
    					}
    					tableContent = tableContent + '</tbody>';
    					var tableHeader = '<thead> <tr> <th class="col-md-1">No.</th> <th class="col-md-1">이미지</th> <th class="col-md-5">도서명</th>' +
				        				'<th class="col-md-2">출판사</th> <th class="col-md-1">저자</th> <th class="col-md-1">수량</th> <th class="col-md-1">대여</th> </tr> </thead>';
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
    		    		
    		function modifyBook(id){
    			var param = {searchId: id};
    			$('#modifyId').val(id);
    			
    			$.ajax({
        			url : "/Secsm/api_bookSearchForModify",
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
        					alert("해당 책정보가 없습니다.");
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
        					$("#modifyPublisher").val(obj[0].publisher);
        					$("#modifyAuthor").val(obj[0].author);
        					$("#modifyImageURL").val(obj[0].imageURL);
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
    			else if($('#bookAddModal').is(':visible')){
    		    	addBook();
    		    }
    		    else if($('#bookCategoryModal').is(':visible')){
    		    	addCategory();
    		    }
    		    else if($('#bookLogModal').is(':visible')){
    		    	logBook(0);
    		    }
    		    else if($('#bookModifyModal').is(':visible')){
    		    	modifyReq();
    		    }
    		    else if($('#bookRentModal').is(':visible')){
    		    	rentBook();
    		    }
    		    else if($('#bookReqModifyModal').is(':visible')){
    		    	requestModify()
    		    }
    		    else if($('#bookReqListModal').is(':visible')){
    		    	reqList(0);
    		    }
    		    else if($('#bookRequestModal').is(':visible')){
    		    	requestBook();
    		    }
    		    else{
    		    	bookSearch(0);
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
		ArrayList<BookCategoryInfo> bookCategory = (ArrayList<BookCategoryInfo>) request.getAttribute("bookCategory");
	%>
	
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

		<div class="container body-content" style="margin-top: 150px">
			<div class="row">
				<h1> Book </h1>
			</div>
			<div class="row">
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#bookRequestModal" style="margin: 5px; margin-right: 0px;">도서신청</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" onclick="bookSearch(0);" style="margin: 5px; ">검색</button>
				</div>
				<div class="pull-right">
					<input type="text" class="form-control" id="searchKeyword" maxlength="30" autofocus>
				</div>
				<div class="pull-right">
					<select class="form-control" name="searchCategory" id="searchCategory" style="width:10em; margin-top:6px">
              			<%
              				for (BookCategoryInfo info : bookCategory){
              					out.println("<option>" + info.getName() + "</option>");
              				}
              			%>
         			 </select>
         		</div>
         		<div class="pull-right" id="searchOptionWrap">
					<label for="searchOption"><input type="radio" name="searchOption" value="0" checked>도서명</label>
					<label for="searchOption"><input type="radio" name="searchOption" value="1" >코드</label>
					<label for="searchOption"><input type="radio" name="searchOption" value="2" >ID</label>
				</div>
         		<div class="pull-right">
					<button type="button" class="btn adminButton" data-toggle="modal" data-target="#bookCategoryModal" style="margin: 5px;">추가/삭제</button>
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
					<button type="button" class="btn" onclick="bookSearch(1);" style="margin: 5px;">이전</button>
				</div>
				<div class="pull-left">
					<button type="button" class="btn" onclick="bookSearch(2);" style="margin: 5px; margin-left:0px;">다음</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#bookLogModal" onclick="recentLog();" style="margin: 5px; margin-right:0px;">대여로그</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn adminButton" data-toggle="modal" data-target="#bookAddModal" style="margin: 5px;">도서등록</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn" data-toggle="modal" data-target="#bookReqListModal" style="margin: 5px;" onclick="myReqList(0);">신청목록</button>
				</div>
				<div class="pull-right">
					<button type="button" class="btn btn-danger adminButton" data-toggle="modal" data-target="#bookLogModal" onclick="logBook(4);" style="margin: 5px;">미납자</button>
				</div>
			</div>
		</div>	
		

		<jsp:include page="base/foot.jsp" flush="false" />
	</body>
	 <jsp:include page="modals/accountAdminModal.jsp" flush="false" />
	  <jsp:include page="modals/accountInfoModal.jsp" flush="false" />
	<jsp:include page="modals/accountModifyModal.jsp" flush="false" />
	<jsp:include page="modals/bookReqModifyModal.jsp" flush="false" />
	<jsp:include page="modals/bookModifyModal.jsp" flush="false" />
	<jsp:include page="modals/bookImageModal.jsp" flush="false" />
	<jsp:include page="modals/bookCategoryModal.jsp" flush="false" />
	<jsp:include page="modals/bookLogModal.jsp" flush="false" />
	<jsp:include page="modals/bookRentModal.jsp" flush="false" />
	<jsp:include page="modals/bookRequestModal.jsp" flush="false" />
	<jsp:include page="modals/bookAddModal.jsp" flush="false" />
	<jsp:include page="modals/bookReqListModal.jsp" flush="false" />

</html>
