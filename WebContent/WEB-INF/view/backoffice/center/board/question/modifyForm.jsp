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
<%@ page info="/backoffice/view/backoffice/center/board/notice/writeForm.jsp"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <%@ include file="/include/console/header.jsp" %>
 	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	<script type="text/javascript" src="/js/package/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="/js/package/tinymce.js"></script>
</head>
<style>
.card .card-action a:not(.btn):not(.btn-large):not(.btn-floating){color: black}

</style>
	<script>
	window.onload = function () {
		// HTML Editor
		tinymce.init({selector:'textarea'});
	}
	
	var maxSize = 5 * 1024 * 1024; // 5MB
	
	function readURL(input) {
		$(".mainImg > div > div").show();
		
		if (input.files && input.files[0]) {
			if (input.files[0].size > maxSize) {
				alert("첨부파일은 5MB 이내로 등록 가능합니다");
				$(input).val("");
				$(".mainImg > div > div").hide();
			}
			else {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#preview").attr("src",e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}
		} else {
			document.getElementById('preview').src = "";
		}
	}
	
	function readInfoURL(input) {
		$(".infoImg > div > div").show();
		
		if (input.files && input.files[0]) {
			if (input.files[0].size > maxSize) {
				alert("첨부파일은 5MB 이내로 등록 가능합니다");
				$(input).val("");
				$(".infoImg > div > div").hide();
			} else {
				var reader = new FileReader();
				reader.onload = function(e) {
					$("#previewInfo").attr("src",e.target.result);
				};
				reader.readAsDataURL(input.files[0]);
			}
		} else {
			document.getElementById('preview').src = "";
		}
	}
	
	var imgCount = 1;
	function plusImg(t) {
		if (imgCount < 10) {
			var imgTag = "<input type='file' name='files[" + imgCount + "]' id='files_" + imgCount + "' onchange='readDtlURL(this);' data-value='" + imgCount + "' style='width:100%;margin-top:5px;'>";
			var cancelButton = "<button type='button' onclick='cancelFileUpload(" + imgCount + ");'>취소</button>"; // 취소 버튼
			$(t).before(imgTag + cancelButton); // 추가된 코드
			imgCount++;
		} else {
			alert("이미지는 최대 10개까지 등록 가능합니다");
		}
	}	
	function modifyProc(value) {
		
		
		if ($("#title").val() == "") {
			alert("제목을 입력해주세요");
			$("#title").focus();
			return;
		}
		/*
		if ($("#cd_ctg").val() == "0") {
			alert("카테고리를 선택해주세요");
			return;
		}*/
		if (tinymce.activeEditor.getContent() == "") {
			alert("내용을 입력해주세요");
			$("#content").focus();
			return;
		}
		/*	
		if ($("#files_0").val() == "") {
			alert("리스트 이미지를 선택해주세요");
			$("#img").focus();
			return;
		}
		*/
		/*
		if ($(".dtlImg input[name^=files]").length == 1 && $("#files_1").val() == "") {
			alert("미리보기 이미지를 하나 이상 선택해주세요");
			return;
		}
		else
		*/
		if ($(".dtlImg input[name^=files]").val() == "") {
			if (!confirm("미리보기 이미지에 선택되지 않은 항목이 있습니다.\n이대로 진행하시겠습니까?'")) {
				return
			}
		}
		/*
		if ($("#files_11").val() == "") {
			alert("상품 정보 이미지를 선택해주세요");
			$("#img").focus();
			return;
		}
		*/
		document.getElementById("seq_bbs").value = value;
		
		$("#frmMain").attr("action", "/console/center/board/modifyProc.web");
		$("#frmMain").submit();
	}

	</script>
<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		<%@ include file="/include/console/gnb.jsp" %>
	</div>
	<div id="page-wrapper" >
		<div class="header">
			<h1 class="page-header">고객문의 수정</h1>
		</div>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
			<input type="hidden" id="cd_bbs_type"	name="cd_bbs_type"	value="${boardDto.cd_bbs_type}" />
			<input type="hidden" id="seq_bbs"		name="seq_bbs"		value="${boardDto.seq_bbs}" />
			<div id="page-inner"> 
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-content">
								<div class="row">
								 <div class="sle_nm">
									<div>
									<input type="hidden"  id="title" name="title" value="${boardDto.title}" required>
									</div>
								</div> 
									<div class="input-field col s12">
										<textarea name="content" id="content" placeholder="내용을 입력해주세요" required maxlength="2048"></textarea>
									</div>
									<div class="dtlImg">
										<div>
											<input type="file" id="files_0" name="files[0]" />
											<button type='button' onclick='cancelFileUpload(0);'>취소</button>
										</div>
									</div>
								</div>
								<div style="text-align:right">
									<input class="waves-effect waves-light btn" type="button" value="등록" style="width:100px" onclick="javascript:modifyProc(${boardDto.seq_bbs});" />
									<input class="waves-effect waves-light btn" type="button" value="취소" style="width:100px" onclick="javascript:history.back();"/>
							</div>
							</div>
						</div>
					</div>
				</div>
				<footer>
				<p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
		</form>
	</div>
	<%@ include file="/include/common/footer.jsp" %>
</body>
</html>