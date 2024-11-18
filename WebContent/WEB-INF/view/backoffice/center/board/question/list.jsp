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
 *				: [20241023170000][kogr0131@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/backoffice/view/backoffice/center/board/question/list.jsp"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <%@ include file="/include/console/header.jsp" %>
</head>
<style>
.card .card-action a:not(.btn):not(.btn-large):not(.btn-floating){color: black}
</style>
<script>
function goWriteForm() {
	
	// NULL 방지 at 서버
	document.getElementById("seq_bbs").remove();
	
	var frmMain = document.getElementById("frmMain");
	
	frmMain.action="/console/center/board/writeForm.web";
	frmMain.submit();
}

function goView(cd_bbs_type, value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("cd_bbs_type").value = cd_bbs_type;
	document.getElementById("seq_bbs").value = value;
	
	frmMain.action="/console/center/board/view.web";
	frmMain.submit();
}

function goList(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("searchWord").value = "";
	document.getElementById("currentPage").value = "1";
	document.getElementById("cd_bbs_type").value = value;
	
	frmMain.action="/console/center/board/question/list.web";
	frmMain.submit();
}

function goPage(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("currentPage").value = value;
	
	frmMain.action="/console/center/board/question/list.web";
	frmMain.submit();
}
</script>

<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
	</div>>
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">고객문의</h1>
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li><a href="#">Board</a></li>
					<li class="active">Question</li>
				</ol>
			</div>
			<form id="frmMain" method="POST">
			<input type="hidden" name="seq_bbs"		id="seq_bbs"/>
			<input type="hidden" name="cd_bbs_type" id="cd_bbs_type" value="${paging.cd_bbs_type}" />
			<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}" />
			<input type="hidden" name="flg_reply" id="flg_reply" />
			<input type="hidden" name="cd_ctg" id="cd_ctg" />
				<div class="col-md-6" style="width:100%">
					<div class="card" >
						<div class="card-action">
							<div class="card-content" style="font-weight: normal;">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
											<th></th>
											<th style="text-align:center">답변현황</th>
											<th>제목</th>
											<th style="text-align:center">카테고리</th>
											<th style="text-align:center">등록일</th>
											</tr>
										</thead>
										<tbody>
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="5" style="text-align: center; padding:50px">등록된 게시글이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${list}" var="item">
											<tr>
												<td style="text-align: center; width: 7%;">
													<c:choose>
														<c:when test="${item.cd_bbs_type == 3}">
															<span style="color: red;">[구매자]</span>
														</c:when>
														<c:when test="${item.cd_bbs_type == 6}">
															<span style="color: blue;">[판매자]</span>
														</c:when>
														<c:otherwise>
															${item.cd_bbs_type}
														</c:otherwise>
													</c:choose>
												</td>
												<td style= "text-align: center; font-weight: bold; width: 7%;">
													<c:choose>
														<c:when test="${empty item.flg_reply}">
															대기중
														</c:when>
														<c:when test="${item.flg_reply > 0}">
															답변완료
														</c:when>
														<c:otherwise>
															${item.flg_reply}
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<a href="javascript:goView(${item.cd_bbs_type}, ${item.seq_bbs});">
													${item.title}</a>
												</td>
												<td style="font-weight: bold;color: gray; font-size: 13px; text-align: center; width: 10%">
													<c:choose>
														<c:when test="${item.cd_ctg == 1}">
															가입 및 탈퇴
														</c:when>
														<c:when test="${item.cd_ctg == 2}">
															상품
														</c:when>
														<c:when test="${item.cd_ctg == 3}">
															구매
														</c:when>
														<c:when test="${item.cd_ctg == 4}">
															결제
														</c:when>
														<c:when test="${item.cd_ctg == 5}">
															배송
														</c:when>
														<c:when test="${item.cd_ctg == 6}">
															환불
														</c:when>
														<c:when test="${item.cd_ctg == 9}">
															기타
														</c:when>
														<c:otherwise>
															${item.cd_ctg}
														</c:otherwise>
													</c:choose>
												</td>
												<td style="font-weight: bold;color: gray; font-size: 13px; text-align: center; width: 8%">
													${item.dt_reg}
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
								</table>
							</div>
							<div class="row" style="text-align:center;" >
								<div class="col-lg-12">
									<div class="product__pagination">
										<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer><p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p></footer>
		</form>
	</div>
</body>
</html>
