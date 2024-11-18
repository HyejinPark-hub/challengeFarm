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
<%@ page info="/WEB-INF/view/backoffice/auction/view.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<style>
		select {display:block;width:auto;margin-top:3px;}
		#frmMain li {display:flex;border:1px solid #ddd;}
		#frmMain li:not(:last-child) {border-bottom:none;}
		#frmMain li p {padding:3px 10px;}
		#frmMain li p:nth-child(1) {width:140px;border-right:1px solid #ddd;}
		#frmMain li p:nth-child(2) {width:calc(100% - 100px);}
		#frmMain img {width:100px;}
	</style>
	
	<script>
		function update() {
			if ($("#cd_state_act").val() == 9 && $("#reject").val() == '') {
				alert("반려사유를 입력해주세요");
				$("#reject").focus();
				return;
			}
			
			$("#frmMain").attr("action","/console/auction/update.web");
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
				<h1 class="page-header">매출상세</h1>
				<ol class="breadcrumb">
					<li><a href="/console/">Home</a></li>
					<li><a href="/console/sales/list.web">Sales</a></li>
					<li class="active">view</li>
				</ol>
			</div>
			<div id="page-inner">
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-action">
								
							</div>
							<div class="card-content">
								<form name="frmMain" id="frmMain">
									<div>
										<c:forEach items="${list}" var="list">
											<ul>
												<li>
													<p>판매자</p>
													<p>${list.sll_nm}</p>
												</li>
												<li>
													<p>상품명</p>
													<p>${list.sle_nm}</p>
												</li>
												<li>
													<p>수량 / 사이즈</p>
													<p>${list.count}개 / ${fn:split(list.size_nm,'/')[list.size_num]}</p>
												</li>
												<li>
													<p>원가 / 판매가</p>
													<p>
														<fmt:formatNumber value="${list.price_cost}" />원
														/
														<fmt:formatNumber value="${list.price / list.count}" />원
													</p>
												</li>
												<li>
													<p>총 결제금액</p>
													<p><fmt:formatNumber value="${list.price}" />원</p>
												</li>
											</ul>
										</c:forEach>
									</div>
									
									<div style="text-align:right;">
										<input type="button" value="목록" class="waves-effect waves-light btn" onclick="javascript:history.back();">
									</div>
								</form>
								<div class="clearBoth"></div>
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