<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
function reqSearchBook(id){
	var param = {reqModifyId: id};
	$('#reqModifyId').val(id);
	
	$.ajax({
		url : "/Secsm/api_reqSearchBook",
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
				alert("해당 도서신청이 존재하지 않습니다.");
				location.reload();
			}
			else
			{
				var obj = JSON.parse(response);
				
				$("#reqModifyTitle").val(obj[0].title);
				$("#reqModifyPublisher").val(obj[0].publisher);
				$("#reqModifyAuthor").val(obj[0].author);
				$("#reqModifyLink").val(obj[0].link);
				$("#reqModifyImageURL").val(obj[0].imageURL);
				$("#reqModifyPay").val(obj[0].pay);
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
	});
}	
	
function requestDelete(){	
	var param = {reqModifyId: $("#reqModifyId").val()}; 
	
	$.ajax({
		url : "/Secsm/api_reqBookCancel",
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
				alert('철회 되었습니다.');
				location.reload();
			}
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}

	});
}


function requestModify(){

	var param = {
				reqModifyId: $("#reqModifyId").val(),
				reqModifyTitle: $("#reqModifyTitle").val(),
				reqModifyPublisher: $("#reqModifyPublisher").val(), 
				reqModifyAuthor: $("#reqModifyAuthor").val(),
				reqModifyLink: $("#reqModifyLink").val(),
				reqModifyImageURL: $("#reqModifyImageURL").val(),
				reqModifyPay: $("#reqModifyPay").val()};

	
	if($("#reqModifyTitle").val()==""){
		alert("도서명을 입력하세요.");
		return;
	}
	else if($("#reqModifyPublisher").val()==""){
		alert("출판사를 입력하세요.");
		return;
	}
	else if($("#reqModifyAuthor").val()==""){
		alert("저자를 입력하세요.");
		return;
	}
	else if($("#reqModifyLink").val()==""){
		alert("링크를 입력하세요.");
		return;
	}
	else if($("#reqModifyImageURL").val()==""){
		alert("이미지 URL을 입력하세요.");
		return;
	}
	else if($("#reqModifyPay").val()==""){
		alert("가격을 입력하세요.");
		return;
	}
	else{}
	
	$.ajax({
	url : "/Secsm/api_reqModifyBook",
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

		if(response=='402')
		{
			alert('수량을 확인해주세요.');
		}
		
		else
		{
			alert('수정이 완료되었습니다.');
			location.reload();
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

<style>
	#bookReqModifyModal{
		z-index:999999;
	}
</style>	

<div class="modal fade" id="bookReqModifyModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="bookReqModify" id="bookReqModify">
				<div class="modal-header">
					<h4 class="modal-title">도서신청 수정</h4>
				</div>
				<input type="hidden" name="reqModifyId" id="reqModifyId" value=""/>
				<div class="modal-body" >
					<div class="form-group">
						<label for="reqModifyTitle" cond="">도서명</label> 
						<input name="reqModifyTitle" id="reqModifyTitle" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyPublisher" cond="">출판사</label> 
						<input name="reqModifyPublisher" id="reqModifyPublisher" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyAuthor" cond="">저자</label> 
						<input name="reqModifyAuthor" id="reqModifyAuthor" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyLink" cond="">링크</label> 
						<input name="reqModifyLink" id="reqModifyLink" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyImageURL" cond="">이미지 URL</label> 
						<input name="reqModifyImageURL" id="reqModifyImageURL" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqModifyPay" cond="">가격</label> 
						<input name="reqModifyPay" id="reqModifyPay" type="number" class="form-control"/>
					</div>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="requestDelete();">철회</button>
					<button type="button" class="btn btn-default" onclick="requestModify();">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>