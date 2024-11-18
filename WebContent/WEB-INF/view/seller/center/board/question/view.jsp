<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/seller/center/board/question/view.jsp" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/common/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	<style>
		input[type=button].styled-button {display:block;width:120px;height:50px;margin:20px auto 0;line-height:50px;background:black;color:white;border-radius:10px;border:none;}
	</style>
	<script>
	function download(type, sequence) {
		var frmMain = document.getElementById("frmMain");
		frmMain.type.setAttribute("value", type);
		frmMain.sequence.setAttribute("value", sequence);
		frmMain.action = "/seller/center/board/download.web";
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
		
		document.getElementById("cd_bbs_type").value = value;
		frmMain.action="/seller/center/board/remove.web";
		frmMain.submit();
	}
	
	function modifyForm(value) {
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("cd_bbs_type").value = value;
		frmMain.action="/seller/center/board/modifyForm.web";
		frmMain.submit();
	}
	
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
</head>
<body>
<header>
		<%@ include file="/include/seller/top.jsp" %>
</header>
<form id="frmMain" name="frmMain" method="POST">
<input type="hidden" id="cd_bbs_type"	name="cd_bbs_type"	value="${boardDto.cd_bbs_type}" />
<input type="hidden" id="type"			name="type" />
<input type="hidden" id="sequence"		name="sequence" />
<input type="hidden" id="imageUrl"		name="imageUrl" 	value="/img/seller/${fn:replace(boardDto.file_save, '\\', '/')}"/>
<input type="hidden" id="seq_bbs"		name="seq_bbs"		value="${boardDto.seq_bbs}" />
<input type="hidden" id="seq_bbs_reply"	name="seq_bbs"		value="${boardReplyDto.seq_bbs}" />
	<header class="header">
		<section class="breadcrumb-option" style="padding-bottom: 0px;">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="breadcrumb__text">
							<h4 style=" font-size: 2.0em;">고객문의</h4>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>
		<section class="shopping-cart spad" style=" padding-top: 30px" >
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
				</div>
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<table>
							<thead>
								<tr>
									<td colspan="4">
										<div style="height: 3px; background-color: black; margin: 2px 0;"></div>
										<span style="font-weight: bold; font-size: 25px;">${boardDto.title}</span>
										<div style="width: 100%; text-align: justify;">
										<span style="color: gray; float: right; padding-left:10px">${boardDto.dt_reg}</span>
										<span style="font-weight: bold; padding-right:10px ;">
											<c:choose>
												<c:when test="${boardDto.cd_ctg == 1}">가입 및 탈퇴</c:when>
												<c:when test="${boardDto.cd_ctg == 2}">상품</c:when>
												<c:when test="${boardDto.cd_ctg == 3}">구매</c:when>
												<c:when test="${boardDto.cd_ctg == 4}">결제</c:when>
												<c:when test="${boardDto.cd_ctg == 5}">배송</c:when>
												<c:when test="${boardDto.cd_ctg == 6}">환불</c:when>
												<c:when test="${boardDto.cd_ctg == 9}">기타</c:when>
											</c:choose>
										</span>
										</div>
										<div style ="height: 0.1px; margin: 10px; background-color:#ccc"></div>
									</td>
								</tr>
							</thead>
							<tbody>
								<tr>
								<td colspan="4" style="padding-left:10px">
									<c:out value="${boardDto.content}" escapeXml="false" />
								</td>
								</tr>
							</tbody>
						</table>
						<div style="height: 2px; background-color: gray; margin: 2px 0;"></div>
						<div class="dtlImg" style="position:relative;">
						<div>
							<div class="infoImg">
								<span style="color:blue;">${boardDto.file_orig}</span>
								<div style="position:absolute;top:0;right:0;">
									<c:if test="${not empty boardDto.file_orig}">
										<button type="button" onclick="previewImage();">미리보기</button>
										<button type="button" onclick="download('BbsQuestion', ${boardDto.seq_bbs}, '${boardDto.file_orig}');">다운로드</button>
									</c:if>
								</div>
							</div>
							<div style="display:none;" id="previewContainer">
								<img src="" id="imgPreview" style="max-height:350px;"/>
							</div>
						</div>
						</div>
					</div>
						<div style="white-space: nowrap;text-align:center">
							<c:if test="${boardDto.seq_reply == 0}">
								<input class="styled-button" type="button" value="수정" style="width:100px; display: inline-block; margin-right: 10px;" onclick="javascript:modifyForm(6);" />
								<input class="styled-button" type="button" value="삭제" style="width:100px; display: inline-block;" onclick="javascript:remove(6);" />
							</c:if>
						</div> 
					<c:if test="${boardDto.seq_reply > 0}">
						<div>
						<div style="color: black; font-size: 20pt; font-weight: bold; padding-top:30px;">[답변]</div>
							<div style="height: 3px; background-color: black; margin: 2px 0;"></div>
							<div style="color: gray; text-align:right;">
								${boardReplyDto.dt_reg}
							</div>
							<div style ="height: 0.1px; margin: 10px; background-color:#ccc"></div>
							<div>
								<div>
									<span style="width: 1000px; height: 200px;">${boardReplyDto.content}</span>
								</div>
								<c:if test="${boardReplyDto.file_orig != ''}">
									<div class="dtlImg"  style="position:relative;">
										<div>첨부 파일</div>
										<div>
											${boardDto.file_orig}
											<div style="position:absolute;top:0;right:0;">
												<c:if test="${not empty boardDto.file_orig}">
													<button type="button" onclick="previewImage();">미리보기</button>
													<button type="button" onclick="download('BbsQuestion', ${boardDto.seq_bbs}, '${boardDto.file_orig}');">다운로드</button>
												</c:if>
											</div>
										</div>
									</div>	
								</c:if>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<div style =" padding-top:30px;">
			<a href="javascript:history.back()" style ="color: gray;"> 목록으로 돌아가기</a>
			</div>
		</div>
		</section>
	</form>
	<%@ include file="/include/common/footer.jsp" %>
</body>
</html>
