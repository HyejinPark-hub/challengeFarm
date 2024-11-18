<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/auction/write.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	
	<script>
		window.onload = function (){
			
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
		
		function readDtlURL(input){
			$("#previewDtl").show();
			
			var inputIndex = $(input).attr("data-value");
			
			if (input.files.length == 0) {
				$("#previewDtl .dtlImg_" + inputIndex).hide();
			}
			else if (input.files && input.files[0]) {
				if (input.files[0].size > maxSize) {
					alert("첨부파일은 5MB 이내로 등록 가능합니다");
					$(input).val("");
					$("#previewDtl").hide();
				} else {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#previewDtl .dtlImg_" + inputIndex).attr("src",e.target.result);
						$("#previewDtl .dtlImg_" + inputIndex).show();
					};
					reader.readAsDataURL(input.files[0]);
				}
			} else {
				document.getElementById('previewDtl').src = "";
			}
		}
		
		var imgCount = 2;
		function plusImg(t) {
			if (imgCount < 11) {
				var imgTag = "<input type='file' name='files[" + imgCount + "]' id='files_" + imgCount + "' onchange='readDtlURL(this);' data-value='" + imgCount + "' accept='image/gif, image/jpeg, image/png' style='width:100%;margin-top:5px;'>";
				$(t).before(imgTag);
				imgCount++;
			}
			else {
				alert("이미지는 최대 10개까지 등록 가능합니다");
			}
		}
		
		function writeProc() {

			if ($("#act_nm").val() == "") {
				alert("상품명을 입력해주세요");
				$("#act_nm").focus();
				return;
			}
			if ($("#price").val() == "" || $("#price").val() <= 0) {
				alert("가격을 입력해주세요");
				$("#price").focus();
				return;
			}
			if ($("#desces").val() == "") {
				alert("상품 설명을 입력해주세요");
				$("#desces").focus();
				return;
			}
			if ($("#files_0").val() == "") {
				alert("리스트 이미지를 선택해주세요");
				$("#img").focus();
				return;
			}
			if ($(".dtlImg input[name^=files]").length == 1 && $("#files_1").val() == "") {
				alert("미리보기 이미지를 하나 이상 선택해주세요");
				return;
			} else if ($(".dtlImg input[name^=files]").val() == "") {
				if (!confirm("미리보기 이미지에 선택되지 않은 항목이 있습니다.\n이대로 진행하시겠습니까?'")) {
					return
				}
			}
			if ($("#buy_year").val() == "" || $("#buy_year").val().length < 4) {
				alert("구매년도를 정확히 입력해주세요");
				$("#buy_year").focus();
				return;
			}
			if ($("#dt_act_start").val() == "") {
				alert("판매시작일을 선택해주세요");
				$("#dt_act_start").focus();
				return;
			}
			if ($("#dt_act_end").val() == "") {
				alert("판매종료일을 선택해주세요");
				$("#dt_act_end").focus();
				return;
			}
			if ($("#dt_act_end").val() < $("#dt_act_start").val() ) {
				alert("시작일과 종료일을 확인해주세요");
				return;
			}
			
			$("#frmMain").attr("action", "/front/mypage/auction/writeProc.web");
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
			<h3>경매 등록</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<div class="write">
					<div class="sle_nm">
						<p>상품명</p>
						<div><input type="text" name="act_nm" id="act_nm" placeholder="상품명을 입력해주세요." required></div>
					</div>
					<div class="price">
						<p>가격</p>
						<input type="text" name="price" id="price" placeholder="기본 구매 가격을 입력해주세요." required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					</div>
					<div class="desces">
						<p>상품 설명</p>
						<textarea name="desces" id="desces" placeholder="사이즈, 색상, 소재 등의 상품 설명을 입력해주세요" required maxlength="2048"></textarea>
					</div>
					<div class="mainImg">
						<p>리스트 이미지</p>
						<div>
							<input type="file" name="files[0]" id="files_0" onchange="readURL(this);" accept="image/gif, image/jpeg, image/png" required>
							<div style="display:none;"><img id="preview"></div>
							<p class="explain">* 경매 리스트에 보여질 대표 이미지를 등록해주세요</p>
						</div>
					</div>
					<div class="dtlImg">
						<p>미리보기 및<br>상품 이미지</p>
						<div>
							<input type="file" name="files[1]" id="files_1" onchange="readDtlURL(this);" data-value="1" accept="image/gif, image/jpeg, image/png">
							<p class="pButton" onClick="plusImg(this)">+ 이미지 추가</p>
							<div id="previewDtl" style="display:none;">
								<img class="dtlImg_1">
								<img class="dtlImg_2">
								<img class="dtlImg_3">
								<img class="dtlImg_4">
								<img class="dtlImg_5">
								<img class="dtlImg_6">
								<img class="dtlImg_7">
								<img class="dtlImg_8">
								<img class="dtlImg_9">
								<img class="dtlImg_10">
							</div>
							<p class="explain">
								* 상세페이지에서 보여질 옷 이미지를 등록해주세요<br>
								* 해당 이미지는 상단 썸네일과 하단 상품정보 두 곳에서 보여집니다<br>
								* 이미지는 등록된 순서대로 보여집니다.
							</p>
						</div>
					</div>
					<div class="buy_year">
						<p>구매년도</p>
						<input type="text" name="buy_year" id="buy_year" placeholder="YYYY" required>
					</div>
					<div class="act_state">
						<p>상품 품질</p>
						<input type="radio" name="act_state" id="act_state_1" value="1" required checked>
						<label for="act_state_1">최상</label>
						<input type="radio" name="act_state" id="act_state_2" value="2" required>
						<label for="act_state_2">상</label>
						<input type="radio" name="act_state" id="act_state_3" value="3" required>
						<label for="act_state_3">중</label>
						<input type="radio" name="act_state" id="act_state_4" value="4" required>
						<label for="act_state_4">하</label>
						<input type="radio" name="act_state" id="act_state_5" value="5" required>
						<label for="act_state_5">최하</label>
					</div>
					<div class="dt_sale_start">
						<p>경매 시작일</p>
						<input type="date" name="dt_act_start" id="dt_act_start" required>
					</div>
					<div class="dt_sale_start">
						<p>경매 종료일</p>
						<input type="date" name="dt_act_end" id="dt_act_end" required>
					</div>
				</div>
				<div id="btnArea">
					<input type="button" value="등록" onClick="writeProc()">
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