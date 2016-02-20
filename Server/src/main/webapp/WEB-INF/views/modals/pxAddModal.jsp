<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript">
	
	// 아이템 구매
	function addItem(){
		var param = "pxItemsName" + "=" + $("#pxItemsName").val() + "&" + 
					"pxItemsCode" + "=" + $("#pxItemsCode").val() + "&" +
					"pxItemsPrice" + "=" + $("#pxItemsPrice").val() + "&" +
					"pxItemsCount" + "="+ $("#pxItemsCount").val() + "&" +
					"pxItemsDescription" + "=" + $("#pxItemsDescription").val();
		$.ajax({
		url : "/Secsm/api_pxAddItem",
		type : "POST",
		data : param,
		cache : false,
		async : false,
		dataType : "text",
		
		success : function(response) {	
			if(response=='200')
			{
				// 정상 구매
				alert('정상 추가되었습니다.');
			}
			else{
				alert('알수없음');
			}
			
		},
		error : function(request, status, error) {
			if (request.status != '0') {
				alert("code10 : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
			}
		}
		
		});
	}


</script>

<!-- 상품 추가 모달 -->
<div class="modal fade" id="pxAddModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
				<div class="modal-header">
					<h4 class="modal-title">상품 등록</h4>
				</div>
				<div class="modal-body" >
				<form id= "add_form" onsubmit="addItem();inputreset(2);return false">
					<div class="form-group">
						<label for="pxItemsName" cond="">상품 명</label> 
						<input name="pxItemsName" id="pxItemsName" type="text" class="form-control" />
					</div>
					<div class="form-group">
						<label for="pxItemsCode" cond="">바코드</label> 
						<input name="pxItemsCode" id="pxItemsCode" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="pxItemsPrice" cond="">가격</label> 
						<input name="pxItemsPrice" id="pxItemsPrice" onkeydown="return showKeyCode(event)" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="pxItemsCount" cond="">수량</label> 
						<input name="pxItemsCount" id="pxItemsCount" onkeydown="return showKeyCode(event)" type="text" class="form-control" style="width: 70%"/>
					</div>
					<div class="form-group">
						<label for="pxItemsDescription" cond="">설명</label> 
						<input name="pxItemsDescription" id="pxItemsDescription" type="text" class="form-control" style="width: 70%"/>
					</div>
				</div>

				<div class="modal-footer">
					<input type="submit" value = "등록" class="btn btn-default" >
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
					</form>
				
		</div>
	</div>
</div>