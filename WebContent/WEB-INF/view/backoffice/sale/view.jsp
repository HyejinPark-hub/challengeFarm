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
<%@ page info="/WEB-INF/view/backoffice/sale/view.jsp"%>
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
		#frmMain li p:nth-child(1) {width:150px;border-right:1px solid #ddd;}
		#frmMain li p:nth-child(2) {width:calc(100% - 100px);}
		#frmMain img {width:100px;}
		
		#frmMain textarea {width:500px;height:100px;margin-top:7px;border-color:#ddd;resize:none;overflow-y:scroll;}
		#frmMain textarea::-webkit-scrollbar {width:5px;}
		#frmMain textarea::-webkit-scrollbar-thumb {background:#ddd;}
		
		#frmMain .size {position:relative;margin-right:10px;}
		#frmMain .size:not(:last-child)::after {content:"/";position:absolute;bottom:-4px;right:-6px;}
		#frmMain .detail {display:block;}
	</style>
	
	<script>
		function update() {
			$("#frmMain").attr("action","/console/sale/update.web");
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
				<h1 class="page-header">상품상세</h1>
				<ol class="breadcrumb">
					<li><a href="/console/">Home</a></li>
					<li><a href="/console/sale/list.web">Sale</a></li>
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
									<input type="hidden" name="seq_sle" value="${saleDto.seq_sle}">
									<div>
										<ul>
											<li>
												<p>판매자</p>
												<p>${saleDto.sll_nm}</p>
											</li>
											<li>
												<p>상품명</p>
												<p>${saleDto.sle_nm}</p>
											</li>
											<li>
												<p>카테고리</p>
												<p>
													<c:if test="${fn:substring(saleDto.cd_ctg, 0, 1) == '1'}">여성</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 0, 1) == '2'}">남성</c:if>
													-
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '1'}">아우터</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '2'}">재킷/베스트</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '3'}">상의</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '4'}">하의</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '5'}">원피스</c:if>
													<c:if test="${fn:substring(saleDto.cd_ctg, 1, 2) == '6'}">패션잡화</c:if>
												</p>
											</li>
											<li>
												<p>사이즈별 재고수량</p>
												<p>
													<c:set var="sizeNm" value="${fn:split(saleDto.size_nm, '/')}" />
													<c:forEach items="${sizeNm}" var="sizeNm" varStatus="status">
														<span class="size">${sizeNm}
														<c:choose>
															<c:when test="${saleDto.count_stock == ''}">
																(0)
															</c:when>
															<c:otherwise>
																(${fn:split(saleDto.count_stock, '/')[status.index]})
															</c:otherwise>
														</c:choose>
														</span>
													</c:forEach>
												</p>
											</li>
											<li>
												<p>상세 사이즈</p>
												<p>
													<c:set var="sizeDetail" value="${fn:split(saleDto.size_detail, ',')}" />
													<c:forEach items="${sizeDetail}" var="sizeDetail" varStatus="status">
														<span class="detail">${sizeDetail}</span>
													</c:forEach>
												</p>
											</li>
											<li>
												<p>원가 (할인율)</p>
												<p>
													<fmt:formatNumber value="${saleDto.price_cost}" />원 (${saleDto.discount}%)
												</p>
											</li>
											<li>
												<p>색상 / 소재</p>
												<p>
													${saleDto.color} / ${saleDto.merterial}
												</p>
											</li>
											<li>
												<p>설명</p>
												<p>
													<textarea>${saleDto.desces}</textarea>
												</p>
											</li>
											<li>
												<p>이미지</p>
												<p>
													<img src="<c:if test="${saleDto.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(saleDto.img, '\\', '/')}">
													<c:forEach items="${dtlImgs}" var="dtlImgs">
														<img src="<c:if test="${dtlImgs.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(dtlImgs.img, '\\', '/')}">
													</c:forEach>
												</p>
											</li>
											<li>
												<p>판매상태</p>
												<p>
													<select name="cd_state_sale">
														<option value="1"<c:if test="${saleDto.cd_state_sale == '1'}"> selected</c:if>>판매</option>
														<option value="9"<c:if test="${saleDto.cd_state_sale == '9'}"> selected</c:if>>반려</option>
													</select>
												</p>
											</li>
											<li>
												<p>판매시작일</p>
												<p>${saleDto.dt_sale_start}</p>
											</li>
											<li>
												<p>상품등록일</p>
												<p>${saleDto.dt_reg}</p>
											</li>
										</ul>
									</div>
									
									<div style="text-align:right;">
										<input type="button" value="수정" class="waves-effect waves-light btn" onclick="javascript:update();">
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