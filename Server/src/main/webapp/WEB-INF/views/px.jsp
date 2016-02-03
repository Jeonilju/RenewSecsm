<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8" %>

<html>
	<head>
		<!-- Encoding -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="base/header.jsp" flush="false" />
    	<title>PX</title>
    	
    	<script type="text/javascript">
    	
    	
    		/** 아이템 구매 */
    		function buyItemss(){
    			
    			
    			
    		}
    		
    		/** 바코드창으로 포커싱 */
    		function forcusToEditor(){
    			
    		}
    		
    		/** 상품 요청 */
    		function requestItem(){
    			
    		}
    		
    		function 
    	
    	</script>
    	
	</head>
	<jsp:include page="base/nav.jsp" flush="true" />
	<body>

	<div class="container body-content" style="margin-top: 150px; height: 200px;">
		<div class="row-fluid">
			<h1> PX </h1>
		</div>
		
		<div class="row-fluid">
				<button type="button" class="btn" style="margin: 5px; width: 260px; height: 100px" data-toggle="modal" data-target="#pxBuyItemsModal" >상품 구매</button>
				<button type="button" class="btn" style="margin: 5px; width: 260px; height: 100px" data-toggle="modal" data-target="#pxBuyItemsListModal" >내역 조회</button>
				<button type="button" class="btn" style="margin: 5px; width: 260px; height: 100px" data-toggle="modal" data-target="#pxApplyModal" >상품 요청</button>
		</div>
	</div>	
			<jsp:include page="base/foot.jsp" flush="false" />
	
</body>

		<!-- 상품 구매 모달 -->
		<div class="modal fade" id="pxBuyItemsModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form name="createProjectForm" id="createProjectForm" action="/api_createProject">
						<div class="modal-header">
							<h4 class="modal-title" id="SignInModalLabel">상품 구매</h4>
						</div>
						<div class="modal-body">
							<div class="row-fluid">
								<div class="col-md-4">    
								</div>
								<div class="col-md-4">
									내 잔액 : 
								</div>
								<div class="col-md-4">    
								    <input type="text" style="width: 70px" value="220000">원
								</div>
							</div>
							
							<div class="row-fluid">
								<div class="col-md-3">
									<select>
										<option>바코드</option>
										<option>상품 명</option>
									</select>
								</div>
								<div class="col-md-6">
									<input type="text" style="width: 200px">
								</div>
								<div class="col-md-3">
									<input type="button" value="승인">
								</div>
							</div>
							
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- 내역 조회 -->
		<div class="modal fade" id="pxBuyItemsListModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="SignInModalLabel">내역 조회</h4>
					</div>
					
					<div class="modal-body">
						<table class="table table-hover">
						    <thead>
						      <tr>
						        <th>날짜</th>
						        <th>내용</th>
						        <th>수량</th>
						        <th>금액</th>
						      </tr>
						    </thead>
						    <tbody>
						      <tr>
						        <td>16.01.22</td>
						        <td>콜라</td>
						        <td>2</td>
						        <td>2000</td>
						      </tr>
						      <tr>
						        <td>16.01.22</td>
						        <td>콜라</td>
						        <td>2</td>
						        <td>2000</td>
						      </tr>
						      <tr>
						        <td>16.01.22</td>
						        <td>콜라</td>
						        <td>2</td>
						        <td>2000</td>
						      </tr>
						    </tbody>
						  </table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
		</div>
		
		<div class="modal fade" id="pxApplyModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="SignInModalLabel">상품 요청</h4>
					</div>
					
					<div class="modal-body">
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
		</div>
		<!-- 신청 -->
</html>
