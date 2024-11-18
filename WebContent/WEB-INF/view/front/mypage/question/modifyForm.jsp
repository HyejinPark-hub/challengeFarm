<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/faq/list.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/common/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	<style>
		input[type=button] {display:block;width:100px;height:30px;background:#007bff;color:white;border-radius:10px;border:none; }
	</style>
	<script>

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
	
	function modifyProc() {
		
		if ($("#title").val() == "") {
			alert("제목을 입력해주세요");
			$("#title").focus();
			return;
		}
		if ($("#cd_ctg").val() == "0") {
			alert("카테고리를 선택해주세요");
			return;
		}
		if ($("#content").val() == "") {
			alert("내용을 입력해주세요");
			$("#content").focus();
			return;
		}
		
		$("#frmMain").attr("action", "/front/mypage/question/modifyProc.web");
		$("#frmMain").submit();
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
			<h3>문의 수정</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="seq_bbs"	name="seq_bbs"	value="${boardDto.seq_bbs}" />
				<div class="write">
					<div class="sle_nm">
						<p>제목</p>
						<div><input value="${boardDto.title}" type="text" id="title" name="title" style="width: 550px;" required /></div>
					</div>
					<div>
						<p>카테고리</p>
						<div>
							<select id="cd_ctg" name="cd_ctg" required>
							<option value="0"<c:if test="${boardDto.cd_ctg == '0'}"> selected</c:if>>선택</option>
							<option value="1"<c:if test="${boardDto.cd_ctg == '1'}"> selected</c:if>>가입 및 탈퇴</option>
							<option value="2"<c:if test="${boardDto.cd_ctg == '2'}"> selected</c:if>>상품</option>
							<option value="3"<c:if test="${boardDto.cd_ctg == '3'}"> selected</c:if>>구매</option>
							<option value="4"<c:if test="${boardDto.cd_ctg == '4'}"> selected</c:if>>결제</option>
							<option value="5"<c:if test="${boardDto.cd_ctg == '5'}"> selected</c:if>>배송</option>
							<option value="6"<c:if test="${boardDto.cd_ctg == '6'}"> selected</c:if>>환불</option>
							<option value="9"<c:if test="${boardDto.cd_ctg == '9'}"> selected</c:if>>기타</option>
						</select>
						</div>
					</div>
					<div class="desces">
						<p>내용</p>
						<textarea id="content" name="content" required>${boardDto.content}</textarea>
					</div>
					<div class="mainImg">
						<p>사진첨부	</p>
						<div>
							<input type="file" name="files[0]" id="files_0" onchange="readURL(this);" accept="image/gif, image/jpeg, image/png" required>
							<div style="display:none;"><img id="preview"></div>
							<p class="explain">
								* 사진은 JPG, PNG, GIF 파일 첨부 가능합니다.<br>
							</p>
						</div>
					</div>
				</div>
				<div id="btnArea">
					<input type="button" value="저장" onclick="javascript:modifyProc();" />
					<a href="javascript:history.back()">취소</a>
				</div>
			</form>
		</article>
	</div>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>