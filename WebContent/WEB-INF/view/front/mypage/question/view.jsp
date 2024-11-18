<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/question/view.jsp" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	
	<style>
		.infoImg {
			display: block;
			width: 100%;
			display: flex;
			justify-content:space-between;
			flex-wrap: nowrap;
		}
		.infoImg div{
			display: flex;
			flex-wrap: nowrap;
		}
		.answer {position:relative;margin-top:30px;padding:20px;border:2px solid var(--gray-light);border-radius:20px;}
		.content{position:relative;margin:30px 0;padding:20px;height:150px;border:2px solid var(--gray-light);}
		.dtlImg > div {width:100%;}
		#btnArea input:not(:first-child) {color:black;background:white;border:1px solid black;}
		input[type=button] {display:block;width:100px;height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
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
		
		function remove() {
			var frmMain = document.getElementById("frmMain");
			
			frmMain.action="/front/mypage/question/remove.web";
			frmMain.submit();
		}
		
		function modifyForm() {
			var frmMain = document.getElementById("frmMain");
			
			frmMain.action="/front/mypage/question/modifyForm.web";
			frmMain.submit();
		}
	</script>
</head>
	
<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<div class="container">
		<nav></nav>
		<article class="saleWrite">
			<form id="frmMain" name="frmMain" method="POST">
				<input type="hidden" id="type"			name="type" />
				<input type="hidden" id="sequence"		name="sequence" />
				<input type="hidden" id="imageUrl"		name="imageUrl" 	value="/img/front/${fn:replace(boardDto.file_save, '\\', '/')}"/>
				<input type="hidden" id="seq_bbs"		name="seq_bbs"		value="${boardDto.seq_bbs}" />
				
				<div class="write">
					<div class="sle_nm">
						<p>제목</p>
						<div>${boardDto.title}</div>
					</div>
					<div class="cd_ctg">
						<p>카테고리</p>
						<div>
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
					</div>
					<div class="desces">
						<p>내용</p>
						<span style="height:200px;">${boardDto.content}</span>
					</div>
					<div class="dtlImg">
						<p>첨부파일</p>
						<div>
							<div class="infoImg">
								<span>${boardDto.file_orig}</span>
								<div>
									<c:if test="${not empty boardDto.file_orig}">
										<input type="button" onclick="previewImage();" value="미리보기" style="margin:0 10px;"/>
										<input type="button" onclick="download('BbsQuestion', ${boardDto.seq_bbs}, '${boardDto.file_orig}');" value="다운로드"/>
									</c:if>
								</div>
							</div>
							<div style="display:none;" id="previewContainer">
								<img src="" id="imgPreview" style="max-height:350px;"/>
							</div>
						</div>
					</div>
				</div>
			<c:if test="${boardDto.seq_reply == 0}" >	
				<div id="btnArea">
					<input type="button" value="수정" onclick="javascript:modifyForm();" />
					<input type="button" value="삭제" onclick="javascript:remove();" />
					<input type="button" value="목록" onclick="javascript:history.back();" />
				</div>
			</c:if>
				
			<c:if test="${boardDto.seq_reply > 0}">
				<div class="answer">
					<h4 style="text-align:left;">관리자 답변</h4>
					<div class="content">
						<span style="height:200px;">${boardReplyDto.content}</span>
					</div>
					<span>${boardReplyDto.dt_reg}</span>
				</div>
				<div id="btnArea">
					<input type="button" value="목록" onclick="javascript:history.back();" />
				</div>
			</c:if>
				
			</form>
		</article>
	</div>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>