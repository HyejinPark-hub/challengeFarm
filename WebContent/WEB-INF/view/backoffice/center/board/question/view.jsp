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
<%@ page info="/backoffice/view/backoffice/center/board/question/view.jsp"%>
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
function download(type, sequence) {
	var frmMain = document.getElementById("frmMain");
	frmMain.type.setAttribute("value", type);
	frmMain.sequence.setAttribute("value", sequence);
	frmMain.action = "/front/center/board/download.web";
	frmMain.target = "frmBlank";
	frmMain.submit();
}

function previewImage() {
	var imageUrl = document.getElementById("imageUrl").value;
	var imgPreview = document.getElementById("imgPreview");
	var previewContainer = document.getElementById("previewContainer");

	// 이미지 URL이 있는 경우
	if(imageUrl) {
		// 이미지가 이미 표시되고 있다면 숨기기
		if(imgPreview.style.display === "block") {
			imgPreview.style.display = "none"; // 이미지 숨기기
			previewContainer.style.display = "none"; // 컨테이너 숨기기
		}else {
			imgPreview.src = imageUrl; // 이미지 URL 설정
			imgPreview.style.display = "block"; // 이미지 표시
			previewContainer.style.display = "block"; // 컨테이너 표시
		}
	}else {
		imgPreview.style.display = "none"; // 이미지 숨기기
		previewContainer.style.display = "none"; // 컨테이너 숨기기
	}
}

function remove(value) {
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("seq_bbs").value = value;
	frmMain.action="/console/center/board/remove.web";
	frmMain.submit();
}

/*function modifyForm(value) {
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("cd_bbs_type").value = value;
	frmMain.action="/console/center/board/modifyForm.web";
	frmMain.submit();
}*/

/*
function showImage(filePath) {
	var preview = document.getElementById("previewInfo");
	preview.src = filePath;
	document.getElementById("previewContainer").style.display = "block"; // 미리보기 컨테이너 보이기
}

function showImage(filePath) {
	var preview = document.getElementById("previewInfo");
	preview.src = filePath;
	document.getElementById("previewContainer").style.display = "block"; // 미리보기 컨테이너 보이기
}
*/
</script>
<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
	</div>
	<div id="page-wrapper" >
		<div class="header">
			<h1 class="page-header">고객문의</h1>
		</div>
		<form id="frmMain" method="POST">
				<input type="hidden" id="cd_bbs_type"	name="cd_bbs_type"	value="${boardDto.cd_bbs_type}" />
				<input type="hidden" id="type"			name="type" />
				<input type="hidden" id="sequence"		name="sequence" />
				<input type="hidden" id="imageUrl"		name="imageUrl" 		value="/img/front/${fn:replace(boardDto.file_save, '\\', '/')}"/>
				<input type="hidden" id="seq_bbs"		name="seq_bbs"			value="${boardDto.seq_bbs}" />
				<input type="hidden" id="seq_bbs_reply"	name="seq_bbs_reply"	value="${boardReplyDto.seq_bbs}" />
			<div id="page-inner"> 
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-action" style="padding-bottom:0px">
								<span style="font-weight: bold; font-size: 25px;">${boardDto.title}</span>
							</div>
							<div class="card-content">
								<div class="col s12" style="padding-bottom: 50px;">
									<div class="row" >
									<!--<div class="input-field col s6">
											<label for="first_name">First Name</label>
										</div>-->
										<div style="text-align: right">
											<div class="new badge green" style="padding: 10px;">
												<c:choose>
													<c:when test="${boardDto.cd_ctg == 1}">가입 및 탈퇴</c:when>
													<c:when test="${boardDto.cd_ctg == 2}">상품</c:when>
													<c:when test="${boardDto.cd_ctg == 3}">구매</c:when>
													<c:when test="${boardDto.cd_ctg == 4}">결제</c:when>
													<c:when test="${boardDto.cd_ctg == 5}">배송</c:when>
													<c:when test="${boardDto.cd_ctg == 6}">환불</c:when>
													<c:when test="${boardDto.cd_ctg == 9}">기타</c:when>
												</c:choose>
											</div>
											<span style="color: gray; padding: 10px; ">${boardDto.dt_reg}</span>
										</div>
										<div style="height: 0.1px; margin: 10px; background-color:#ccc"></div>
									</div>
									<div class="row">
										<table>
											<tbody>
												<tr>
													<td colspan="4" style="padding-left:20px;">
														<c:out value="${boardDto.content}" escapeXml="false" />
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									
									
									<div class="dtlImg" style="position:relative;">
										<div>
											<div class="infoImg">
												<div style=" position:absolute;top:0;right:0;">
													<c:if test="${not empty boardDto.file_orig}">
														<button class="new badge" style="background-color:#26a69a;" type="button" onclick="previewImage();">미리보기</button>
														<button class="new badge" style="background-color:#26a69a;" type="button" onclick="download('BbsQuestion', ${boardDto.seq_bbs}, '${boardDto.file_orig}');">다운로드</button>
													</c:if>
												</div>
											</div>
											<div style="display:none;" id="previewContainer">
												<img src="" id="imgPreview" style="max-height:350px;"/>
											</div>
										</div>
									</div>
								</div>
							<!--<div style="text-align: right">
									<input class="waves-effect waves-light btn" type="button" value="수정" style="width:100px" onclick="javascript:modifyForm(1);" />
									<input class="waves-effect waves-light btn" type="button" value="삭제" style="width:100px" onclick="javascript:remove(1);" />
								</div>-->
								<div style="text-align:right; padding:10px;">
								<c:if test="${boardDto.seq_reply == 0}" >
									<input class="waves-effect waves-light btn" type="button" value="답변 등록"  style="width:100px" onclick="location.href='/console/center/board/writeForm.web?cd_bbs_type=${boardDto.cd_bbs_type}&seq_bbs=${boardDto.seq_bbs}'" />
								</c:if>
								</div>
								<div class="clearBoth"></div>
							</div>
						</div>
					</div>
					<c:if test="${boardDto.seq_reply > 0}">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-content">
								<div class="col s12" style="padding-bottom: 50px;">
									<div class="row">
									<!--<div class="input-field col s6">
											<label for="first_name">First Name</label>
										</div>-->
										<div style="text-align: right">
											<span style="color: gray; padding: 10px; ">${boardReplyDto.dt_reg}</span>
										</div>
										<div style="height: 0.1px; margin: 10px; background-color:#ccc"></div>
									</div>
									<div class="row">
										<table>
											<tbody>
												<tr>
													<td colspan="4" style="padding-left:20px;">
														<c:out value="${boardReplyDto.content}" escapeXml="false" />
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div style="text-align: right">
									<input class="waves-effect waves-light btn" type="button" value="수정" style="width:100px" onclick="location.href='/console/center/board/modifyForm.web?cd_bbs_type=${boardDto.cd_bbs_type}&seq_bbs=${boardReplyDto.seq_bbs}'" />
									<input class="waves-effect waves-light btn" type="button" value="삭제" style="width:100px" onclick="javascript:remove(${boardReplyDto.seq_bbs});"/>
								</div>
							<!--<div class="clearBoth"></div>-->
							</div>
						</div>
					</div>
					</c:if>
					<a href="javascript:history.back()" style="padding-left:15px"> 목록으로 돌아가기</a>
				</div><footer><p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p></footer>
			</div>
		</form>
	</div>
</body>
</html>
