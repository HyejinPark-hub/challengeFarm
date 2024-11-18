<%
/**
 * YOU ARE STRICTLY PROHIBITED TO COPY, DISCLOSE, DISTRIBUTE, MODIFY OR USE THIS PROGRAM
 * IN PART OR AS A WHOLE WITHOUT THE PRIOR WRITTEN CONSENT OF HIMEDIA.CO.KR.
 * HIMEDIA.CO.KR OWNS THE INTELLECTUAL PROPERTY RIGHTS IN AND TO THIS PROGRAM.
 * COPYRIGHT (C) 2024 HIMEDIA.CO.KR ALL RIGHTS RESERVED.
 *
 * 하기 프로그램에 대한 저작권을 포함한 지적재산권은 himedia.co.kr에 있으며,
 * himedia.co.kr이 명시적으로 허용하지 않는 사용, 복사, 변경 및 제 3자에 의한 공개, 배포는 엄격히 금지되며
 * himedia.co.kr의 지적재산권 침해에 해당된다.
 * Copyright (C) 2024 himedia.co.kr All Rights Reserved.
 *
 *
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			:
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241025100000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/WEB-INF/view/backoffice/sale/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<style>
		select {display:inline-block;width:auto;}
		select#register {margin-left:20px;}
		.waves-effect.waves-light.btn {height:auto;margin-left:5px;padding:6px 12px;line-height:1;vertical-align:top;}
	
		ul.totalInfo {display:flex;padding:0 20px;text-align:center;}
		.totalInfo li {width:25%;padding:20px 0;border:1px solid #ddd;}
		.totalInfo li:not(:last-child) {border-right:none;}
		.totalInfo li p {margin:0;}
	</style>
	
	<script>
		// 상세페이지 이동
		function goView(sle) {
			$("#seq_sle").val(sle);
			
			$("#frmMain").attr("action","/console/sale/view.web");
			$("#frmMain").submit();
		}
		// 검색
		function goList() {
			//$("#cd_state_sale").val(value);
			
			$("#frmMain").attr("action","/console/sale/list.web");
			$("#frmMain").submit();
		}

		function goPage(value) {
			$("#currentPage").val(value);

			$("#frmMain").attr("action","/console/sale/list.web");
			$("#frmMain").submit();
		}
		
	</script>
</head>

<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
	
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">상품</h1>
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Sale</li>
				</ol>
			</div>
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-action">
								총 ${paging.totalLine}건
							</div>
							<form name="frmMain" id="frmMain" method="post">
								<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}">
								<input type="hidden" name="seq_sle" id="seq_sle">
								<select id="register" name="register">
									<option value="0"<c:if test="${paging.register == 0}"> selected</c:if>>전체</option>
									<option value="5"<c:if test="${paging.register == 5}"> selected</c:if>>꼼데가르송</option>
									<option value="2"<c:if test="${paging.register == 2}"> selected</c:if>>라코스테</option>
									<option value="4"<c:if test="${paging.register == 4}"> selected</c:if>>리바이스</option>
									<option value="1"<c:if test="${paging.register == 1}"> selected</c:if>>빈폴</option>
								</select>
								<select id="cd_state_sale" name="cd_state_sale">
									<option value="1"<c:if test="${paging.cd_state_sale == 1}"> selected</c:if>>판매</option>
									<option value="2"<c:if test="${paging.cd_state_sale == 2}"> selected</c:if>>품절</option>
									<option value="3"<c:if test="${paging.cd_state_sale == 3}"> selected</c:if>>중지</option>
									<option value="9"<c:if test="${paging.cd_state_sale == 9}"> selected</c:if>>반려</option>
								</select>
								<input type="button" value="검색" onclick="javascript:goList()" class="waves-effect waves-light btn">
							</form>
							<div class="card-content">
								<div class="table-responsive">
									<table class="table table-bordered table-hover" id="dataTables-example">
										<thead>
											<tr>
												<th class="center" style="width:50px;">NO</th>
												<th class="center">상품명</th>
												<th class="center" style="width:115px;">금액</th>
												<th class="center" style="width:110px;">판매자</th>
												<th class="center" style="width:120px;">등록일</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${empty list}">
													<tr>
														<td colspan="5" class="center">리스트가 없습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${list}" var="list">
														<tr class="odd gradeX">
															<td class="center">${list.rnum}</td>
															<td><a href="javascript:goView('${list.seq_sle}')" class="act_nm">${list.sle_nm}</a></td>
															<td style="text-align:right;"><fmt:formatNumber value="${list.price_cost}" />원</td>
															<td class="center">${list.sll_nm}</td>
															<td class="center">${list.dt_reg}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
								
								<div class="row" style="text-align:center;">
									<div class="col-lg-12">
										<div class="product__pagination">
											<plutozoneUtilTag:page styleID="admin_text" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<footer>
					<p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
</body>
</html>