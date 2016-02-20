<%@ page pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.secsm.info.*"%>

<script type="text/javascript" src="/Secsm/resources/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">

</script>

<style>
	#bookImageModal{
		z-index:999999;
	}
</style>

<%
	ArrayList<BookCategoryInfo> bookCategory = (ArrayList<BookCategoryInfo>) request.getAttribute("bookCategory");
%>

<!-- 자동당직생성 모달-->
<div class="modal fade" id="bookImageModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<form name="bookImage" id="bookImage">
				<div class="modal-header">
					<h4 class="modal-title">이미지</h4>
				</div>
				<div class="modal-body" id="bookImageBody">
					
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>