<%@ page pageEncoding="utf-8" %>

<!-- 상품 추가 모달 -->
<div class="modal fade" id="projectAddAttach" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="addAttachForm" id="addAttachForm" action="/api_projectAddAttach">
				<div class="modal-header">
					<h4 class="modal-title">상품 등록</h4>
				</div>
				<div class="modal-body" >
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
						<input name="pxItemsPrice" id="pxItemsPrice" type="text" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="pxItemsDescription" cond="">설명</label> 
						<input name="pxItemsDescription" id="pxItemsDescription" type="text" class="form-control" style="width: 70%"/>
					</div>
					<div class="form-group">
						<label for="pxItemsCount" cond="">수량</label> 
						<input name="pxItemsCount" id="pxItemsCount" type="text" class="form-control" style="width: 70%"/>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="addItem();">등록</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>