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
<%@ page info="/backoffice/view/backoffice/center/board/notice/view.jsp"%>
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

function remove(value) {
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("cd_bbs_type").value = value;
	frmMain.action="/console/center/board/remove.web";
	frmMain.submit();
}

function modifyForm(value) {
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("cd_bbs_type").value = value;
	frmMain.action="/console/center/board/modifyForm.web";
	frmMain.submit();
}
/*
function goWriteForm() {
	
	// NULL 방지 at 서버
	document.getElementById("seq_bbs").remove();
	
	var frmMain = document.getElementById("frmMain");
	
	frmMain.action="/front/center/board/writeForm.web";
	frmMain.submit();
}

function goView(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("seq_bbs").value = value;
	
	frmMain.action="/front/center/board/view.web";
	frmMain.submit();
}

function goList(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("searchWord").value = "";
	document.getElementById("currentPage").value = "1";
	document.getElementById("cd_bbs_type").value = value;
	
	frmMain.action="/front/center/board/list.web";
	frmMain.submit();
}

function goPage(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("currentPage").value = value;
	
	frmMain.action="/front/center/board/list.web";
	frmMain.submit();
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
			<h1 class="page-header">공지사항</h1>
		</div>
		<form id="frmMain" method="POST">
		<input type="hidden" name="seq_bbs"		id="seq_bbs"		value="${boardDto.seq_bbs}" />
		<input type="hidden" name="cd_bbs_type" id="cd_bbs_type"	value="${boardDto.cd_bbs_type}" />
		<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
		<input type="hidden" name="flg_reply" id="flg_reply" />
		<input type="hidden" name="cd_ctg" id="cd_ctg" />
		<!--<input placeholder="Placeholder" id="first_name" type="text" class="validate"> -->
			<div id="page-inner"> 
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-action" style="padding-bottom:0px">
								<span style="font-weight: bold; font-size: 25px;">${boardDto.title}</span>
							</div>
							<div class="card-content">
								<div class="col s12">
									<div class="row">
									<!--<div class="input-field col s6">
											<label for="first_name">First Name</label>
										</div>-->
										<div  style="text-align: right">
											<span style="color: gray;">${boardDto.dt_reg}</span><span style="padding: 10px; color: gray;">${boardDto.readed}</span>
										</div>
										<div style ="height: 0.1px; margin: 10px; background-color:#ccc"></div>
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
									<div style="text-align: right">
										<input class="waves-effect waves-light btn" type="button" value="수정" style="width:100px" onclick="javascript:modifyForm(1);" />
										<input class="waves-effect waves-light btn" type="button" value="삭제" style="width:100px" onclick="javascript:remove(1);" />
									</div>
								</div>
								<div class="clearBoth">
								</div>
							</div>
						</div>
						<a href="javascript:history.back()"> 목록으로 돌아가기</a>
					</div>
				</div>
				<footer><p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
		</form>
	</div>
</body>
</html>