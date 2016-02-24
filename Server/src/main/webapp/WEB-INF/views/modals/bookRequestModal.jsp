<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	
	function requestBook(){

		var param = {reqTitle: $("#reqTitle").val(),
					reqPublisher: $("#reqPublisher").val(),
					reqAuthor: $("#reqAuthor").val(),
					reqLink: $("#reqLink").val(),
					reqImageURL: $("#reqImageURL").val(),
					reqPay: $("#reqPay").val()};
		
		if($("#reqTitle").val()==""){
			alert("도서명을 입력하세요.");
			return;
		}
		else if($("#reqPublisher").val()==""){
			alert("출판사를 입력하세요.");
			return;
		}
		else if($("#reqAuthor").val()==""){
			alert("저자를 입력하세요.");
			return;
		}
		else if($("#reqLink").val()==""){
			alert("링크를 입력하세요.");
			return;
		}
		else if($("#reqImageURL").val()==""){
			alert("이미지 URL을 입력하세요.");
			return;
		}
		else if($("#reqPay").val()==""){
			alert("가격을 입력하세요.");
			return;
		}
		else{}
		
		$.ajax({
		url : "/Secsm/api_reqBook",
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
				alert('신청이 완료되었습니다.');
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

<!-- 자동당직생성 모달-->
<div class="modal fade" id="bookRequestModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="bookRequest" id="bookRequest">
				<div class="modal-header">
					<h4 class="modal-title">도서신청</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<label for="reqTitle" cond="">도서명</label> 
						<input name="reqTitle" id="reqTitle" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqPublisher" cond="">출판사</label> 
						<input name="reqPublisher" id="reqPublisher" type="text" class="form-control"/>
					</div>
					
					<div class="form-group">
						<label for="reqAuthor" cond="">저자</label> 
						<input name="reqAuthor" id="reqAuthor" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqLink" cond="">링크</label> 
						<input name="reqLink" id="reqLink" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqImageURL" cond="">이미지 URL</label> 
						<input name="reqImageURL" id="reqImageURL" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="reqPay" cond="">가격</label> 
						<input name="reqPay" id="reqPay" type="number" class="form-control"/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="requestBook();">신청</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>