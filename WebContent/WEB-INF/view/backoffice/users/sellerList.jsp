<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page info="/WEB-INF/view/backoffice/modifyForm.jsp"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

<head>
	<%@ include file="/include/console/header.jsp"%>

	<script>
		// 페이지 로딩 후 select 초기화
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('select');
			M.FormSelect.init(elems);
		});
	
		function goModifyState(seq_sll, cd_state) {
			if (confirm("상태를 변경하시겠습니까?")) {
				var frmMain = document.getElementById("frmMain");
				
				document.getElementById("seq_sll").value = seq_sll;
				document.getElementById("cd_state").value = cd_state;
				frmMain.action="/console/users/modify_Seller.web";
				frmMain.submit();
			}
		}
	</script>
	
	<style>
		.select-wrapper input.select-dropdown {
			margin: 0;
			text-align: center;
			position: relative; /* 부모 요소에 relative를 설정 */
			display: inline-block; /* input과 화살표가 한 줄로 배치되도록 설정 */
			border-bottom: 0.1px solid #9e9e9e;
			font-size: 14px;
		}
	
		.select-wrapper {
			position: relative;
			display: inline-block;
		}
	
		select {
			appearance: none;
			-webkit-appearance: none;
			-moz-appearance: none;
			padding: 8px 30px 8px 8px;
			background-color: #F0F0F0;
			border-radius: 5px;
			border: 1px solid #ccc;
			font-size: 1rem;
			width: 100%;
			text-align: center;
		}
	
		.select-wrapper .caret {
			position: absolute;
			top: 50%;
			left: 5.3vw;
			transform: translateY(-50%);
			pointer-events: none;
		}

		.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
			vertical-align: middle;
		}

		[type="checkbox"]+label {
			height: 9px;
		}
	</style>
</head>

<body>
	<form id="frmMain" method="POST" action="/console/users/sellerList.web">
	<input type="hidden" name="seq_sll"	id="seq_sll" />
	<input type="hidden" name="cd_state" id="cd_state" />
		<div id="wrapper">
			<%@ include file="/include/console/top.jsp"%>
			<%@ include file="/include/console/gnb.jsp"%>
			
			<div id="page-wrapper">
				<div class="header">
					<h1 class="page-header">판매자</h1>
					<ol class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li class="active">판매자 가입현황</li>
					</ol>
				</div>
				
				<div id="page-inner">
					<div class="row">
						<div class="col-md-12">
							<div class="card"> 
								<div class="card-content">
									<table class="table table-striped">
										<thead>
											<tr>
												<th style="text-align: center; width: 12.5%;">NO</th>
												<th style="text-align: center; width: 12.5%;">아이디</th>
												<th style="text-align: center; width: 12.5%;">상태</th>
												<th style="text-align: center; width: 12.5%;">이름</th>
												<th style="text-align: center; width: 12.5%;">이메일</th>
												<th style="text-align: center; width: 12.5%;">전화번호</th>
												<th style="text-align: center; width: 12.5%;">회사명</th>
												<th style="text-align: center; width: 12.5%;">가입일</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${list}" var="dto" varStatus="status">
												<tr>
													<td style="text-align: center;">${status.index + 1}</td>
													
													<td style="text-align: center;">
														<script>
															var id = "${dto.id}";
															if (id) {
																var maskedId = id.substring(0, 2) + "*****";
																document.write(maskedId);
															}
														</script>
													</td>
													
													<td style="text-align: center;">
														<select style="background:#F0F0F0;" onchange="goModifyState(${dto.seq_sll}, this.value);">
															<option value="0" <c:if test="${dto.cd_state == 0}">selected</c:if>>대기</option>
															<option value="1" <c:if test="${dto.cd_state == 1}">selected</c:if>>사용중</option>
															<option value="8" <c:if test="${dto.cd_state == 8}">selected</c:if>>자퇴</option>
															<option value="9" <c:if test="${dto.cd_state == 9}">selected</c:if>>강퇴</option>
														</select>
													</td>
													
													<td style="text-align: center;">
														<script>
															var sll_nm = "${dto.sll_nm}";
															if (sll_nm) {
																var maskedSll_nm = sll_nm.substring(0, 2) + "*****"
																document.write(maskedSll_nm);
															}
														</script>
													</td>
													
													<td style="text-align: center;">
														<script>
															var email = "${dto.email}";
															if (email) {
																var maskedEmail = email.substring(0, 2) + "*****" + email.substring(email.indexOf('@'));
																document.write(maskedEmail);
															}
														</script>
													</td>
													
													<td style="text-align: center;">
														<script>
															var phone = "${dto.phone}";
															if (phone) {
																var maskedPhone = phone.substring(0, 4) + "*******"
																document.write(maskedPhone);
															}
														</script>
													</td>
													
													<td style="text-align: center;">
														<script>
															var corp_nm = "${dto.corp_nm}";
															if (corp_nm) {
																var maskedCorp_nm = corp_nm.substring(0, 4) + "***"
																document.write(maskedCorp_nm);
															}
														</script>
													</td>
													
													<td style="text-align: center;">
														<script>
															var serverDate = new Date('${dto.dt_reg}');
															var formattedDate = serverDate.toISOString().split('T')[0]; // 'yyyy-MM-dd' 형식으로 변환
															document.write(formattedDate);
														</script>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</form>

</body>
</html>