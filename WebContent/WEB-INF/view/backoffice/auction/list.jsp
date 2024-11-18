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
<%@ page info="/WEB-INF/view/backoffice/auction/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<script>
		// 상세페이지 이동
		function goView(act) {
			$("#seq_act").val(act);
			
			$("#frmMain").attr("action","/console/auction/view.web");
			$("#frmMain").submit();
		}
		// 검색
		function goList(value) {
			$("#cd_state_act").val(value);
			
			$("#frmMain").attr("action","/console/auction/list.web");
			$("#frmMain").submit();
		}

		function goPage(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = value;
			
			frmMain.action="/console/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
	</script>
	
	<style>
		form {padding:0 20px;}
		select {display:block;width:auto;}
		
		.act_nm {overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:1;-webkit-box-orient:vertical;}
	</style>
</head>

<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">경매상품</h1>
				<ol class="breadcrumb">
					<li><a href="/console/">Home</a></li>
					<li class="active">auction</li>
				</ol>
			</div>
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-action">
								경매 상품 (총 ${paging.totalLine}건)
							</div>
							<form name="frmMain" id="frmMain" method="post">
								<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}">
								<input type="hidden" name="seq_act" id="seq_act">
								<input type="hidden" name="cd_state_act" id="cd_state_act">
								<select onchange="javascript:goList(this.value);">
									<option value="0"<c:if test="${paging.cd_state_act == 0}"> selected</c:if>>대기</option>
									<option value="1"<c:if test="${paging.cd_state_act == 1}"> selected</c:if>>승인</option>
									<option value="9"<c:if test="${paging.cd_state_act == 9}"> selected</c:if>>반려</option>
								</select>
							</form>
							<div class="card-content">
								<div class="table-responsive">
									<table class="table table-bordered table-hover" id="dataTables-example">
										<thead>
											<tr>
												<th class="center" style="width:50px;">NO</th>
												<th class="center">경매상품명</th>
												<th class="center" style="width:90px;">등록자</th>
												<th class="center" style="width:80px;">상태</th>
												<th class="center" style="width:120px;">시작일</th>
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
															<td><a href="javascript:goView('${list.seq_act}')" class="act_nm">${list.act_nm}</a></td>
															<td class="center"><plutozoneUtilTag:masking text="${list.mbr_nm}" letter="*" count="1" mode="center" /></td>
															<td class="center">${list.cd_state_act}</td>
															<td class="center">${list.dt_act_start}</td>
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