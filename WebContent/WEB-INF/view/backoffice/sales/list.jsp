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
<%@ page info="/WEB-INF/view/backoffice/sales/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<style>
		select {display:block;width:auto;margin-left:20px;}
	
		ul.totalInfo {display:flex;padding:0 20px;text-align:center;}
		.totalInfo li {width:25%;padding:20px 0;border:1px solid #ddd;}
		.totalInfo li:not(:last-child) {border-right:none;}
		.totalInfo li p {margin:0;}
	</style>
	
	<script>
		// 상세페이지 이동
		function goView(mst) {
			$("#seq_buy_mst").val(mst);
			
			$("#frmMain").attr("action","/console/sales/view.web");
			$("#frmMain").submit();
		}
		
		function goPage(value) {
		
			$("#currentPage").val(value);
			$("#seq_buy_mst").val(0);

			$("#frmMain").attr("action","/console/sales/list.web");
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
				<h1 class="page-header">매출</h1>
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li class="active">Sales</li>
				</ol>
			</div>
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-action"></div>
							<ul class="totalInfo">
								<c:forEach items="${sales}" var="sales">
									<li>
										<b>${sales.sll_nm}</b>
										<p>총 <b>${sales.totalCnt}</b>개</p>
										<p>총 <b><fmt:formatNumber value="${sales.totalPrice}" /></b>원</p>
									</li>
								</c:forEach>
							</ul>
							<form name="frmMain" id="frmMain" method="post">
								<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}">
								<input type="hidden" name="seq_buy_mst" id="seq_buy_mst">
							</form>
							<div class="card-content">
								<div class="table-responsive">
									<b>총 ${paging.totalLine}건</b>
									<table class="table table-bordered table-hover" id="dataTables-example">
										<thead>
											<tr>
												<th class="center" style="width:50px;">NO</th>
												<th class="center">구매정보</th>
												<th class="center" style="width:115px;">금액</th>
												<th class="center" style="width:80px;">구매자</th>
												<th class="center" style="width:120px;">구매일</th>
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
															<td><a href="javascript:goView('${list.seq_buy_mst}')" class="act_nm">${list.buy_info}</a></td>
															<td style="text-align:right;"><fmt:formatNumber value="${list.buy_price}" />원</td>
															<td class="center"><plutozoneUtilTag:masking text="${list.mbr_nm}" letter="*" count="1" mode="center" /></td>
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