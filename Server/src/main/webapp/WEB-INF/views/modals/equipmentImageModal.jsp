<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

</script>

<!-- 장비 이미지 모달-->
<div class="modal fade" id="equipmentImageModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="equipmentImage" id="equipmentImage">
				<div class="modal-header">
					<h4 class="modal-title">이미지</h4>
				</div>
				<div class="modal-body" id="equipmentImageBody">
					
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>