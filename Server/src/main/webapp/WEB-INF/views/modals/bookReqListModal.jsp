<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	$(function() 
		{
			$("#reqListStartDate").datepicker();
			$("#reqListEndDate").datepicker();
		}
	);
	
	function goImage(imageURL){
		var imageSrc = '<img src="'+ imageURL + '" class="img-thumbnail" alt="No Image">';
		$("#bookImageBody").html(imageSrc)
		$("#bookImageBody").css("text-align","center");
	}
	
	function reqList(){

		var param = "reqListStartDate" + "=" + $("#reqListStartDate").val() + "&" + 
					"reqListEndDate" + "=" + $("#reqListEndDate").val();
		
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
		url : "/Secsm/api_reqList",
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
				var tableContent = '<tbody>';
				var i;
				for(i=0;i<Object.keys(obj).length;i++){
					tableContent = tableContent + '<tr> <td class="col-md-2"> <button type="button" class="btn btn-info" onclick="goImage(\'' + obj[i].imageURL
								+'\');" data-toggle="modal" data-target="#bookImageModal">보기</button> </td> <td class="col-md-4">' + obj[i].title 
								+ '</td> <td class="col-md-3">' + obj[i].publisher + '</td> <td class="col-md-1">' + obj[i].accountName + '</td> <td class="col-md-2">' + obj[i].strRegDate  + '</td> </tr>';	
				}
				tableContent = tableContent + '</tbody> </table>'
				var tableHeader = '<table class="table" style="table-layout:fixed;"> <thead> <tr>'
			      					+'<th class="col-md-2">이미지</th> <th class="col-md-4">도서명</th> <th class="col-md-3">출판사</th> <th class="col-md-1">신청자</th> <th class="col-md-2">신청일</th> </tr> </thead>';
			    var table = tableHeader + tableContent;
				$("#bookReqListTable").html(table);
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

<!-- 자동당직생성 모달-->
<div class="modal fade" id="bookReqListModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog modal-lg" >
		<div class="modal-content">
			<form name="bookAdd" id="bookReqList">
				<div class="modal-header">
					<h4 class="modal-title">신청목록</h4>
				</div>
				<div class="modal-body" >
					<div id=bookReqListTable>
						
					</div>
				</div>

				<div class="modal-footer form-inline">
					<label for="reqListStartDate" style="margin-right:4px">기간:</label>
					<input name="reqListStartDate" id="reqListStartDate" type="text" class="form-control" style="width: 25%; margin-right:5px"/>~ 
					<input name="reqListEndDate" id="reqListEndDate" type="text" class="form-control" style="width: 25%"/>
					<button type="button" class="btn btn-default" onclick="reqList();">검색</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>