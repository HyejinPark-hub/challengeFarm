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
		#frmMain li p:nth-child(1) {width:100px;border-right:1px solid #ddd;}
		#frmMain li p:nth-child(2) {width:calc(100% - 100px);}
		#frmMain textarea {width:500px;height:100px;margin-top:10px;border-color:#ddd;resize:none;overflow-y:scroll;}
		#frmMain textarea::-webkit-scrollbar {width:5px;}
		#frmMain textarea::-webkit-scrollbar-thumb {background:#ddd;}
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
				<h1 class="page-header">경매상세</h1>
				<ol class="breadcrumb">
					<li><a href="/console/">Home</a></li>
					<li><a href="/console/auction/list.web">auction</a></li>
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
									<input type="hidden" name="seq_act" value="${auctionDto.seq_act}">
									<div>
										<ul>
											<li>
												<p>등록자</p>
												<p>
													<plutozoneUtilTag:masking text="${auctionDto.mbr_nm}" letter="*" count="1" mode="center" />&nbsp;
													<plutozoneUtilTag:masking text="(${auctionDto.email})" letter="*" count="1" mode="email" />
												</p>
											</li>
											<li>
												<p>상품명</p>
												<p>${auctionDto.act_nm}</p>
											</li>
											<li>
												<p>가격</p>
												<p><fmt:formatNumber value="${auctionDto.price}" />원</p>
											</li>
											<li>
												<p>설명</p>
												<p>${auctionDto.desces}</p>
											</li>
											<li>
												<p>구매년도</p>
												<p>${auctionDto.buy_year}년</p>
											</li>
											<li>
												<p>상품상태</p>
												<p>
													<c:if test="${auctionDto.act_state == 1}">최상</c:if>
													<c:if test="${auctionDto.act_state == 2}">상</c:if>
													<c:if test="${auctionDto.act_state == 3}">중</c:if>
													<c:if test="${auctionDto.act_state == 4}">하</c:if>
													<c:if test="${auctionDto.act_state == 5}">최하</c:if>
												</p>
											</li>
											<li>
												<p>경매 시작일</p>
												<p>${auctionDto.dt_act_start}</p>
											</li>
											<li>
												<p>경매 종료일</p>
												<p>${auctionDto.dt_act_end}</p>
											</li>
											<li>
												<p>이미지</p>
												<p>
													<img src="/img/auction/${fn:replace(auctionDto.img, '\\', '/')}">
													<c:forEach items="${images}" var="img">
														<img src="/img/auction/${fn:replace(img.img, '\\', '/')}">
													</c:forEach>
												</p>
											</li>
											<li>
												<p>대기 상태</p>
												<p>
													<select name="cd_state_act" id="cd_state_act">
														<option value="0"<c:if test="${auctionDto.cd_state_act == 0}"> selected</c:if>>대기</option>
														<option value="1"<c:if test="${auctionDto.cd_state_act == 1}"> selected</c:if>>승인</option>
														<option value="9"<c:if test="${auctionDto.cd_state_act == 9}"> selected</c:if>>반려</option>
													</select>
													<textarea name="reject" id="reject" placeholder="반려시 반려사유를 입력해주세요." required><c:if test="${auctionDto.cd_state_act == 9}">${auctionDto.reject}</c:if></textarea>
												</p>
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