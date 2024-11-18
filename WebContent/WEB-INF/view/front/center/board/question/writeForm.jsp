<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/question/writeForm.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/common/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	<style>
		input[type=button].styled-button {display:block;width:120px;height:50px;margin:20px auto 0;line-height:50px;background:black;color:white;border-radius:10px;border:none;}
	</style>
</head>
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
		
	function writeProc(value) {
		
		
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
		document.getElementById("cd_bbs_type").value = value;
		
		$("#frmMain").attr("action", "/front/center/board/writeProc.web");
		$("#frmMain").submit();
	}

	</script>	
<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<div class="container">
		<nav></nav>
		<article class="saleWrite">
			<h3>문의 등록</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="cd_bbs_type" name="cd_bbs_type" />
				<div class="write">
					<div class="sle_nm">
						<p>제목</p>
						<div><input type="text" name="title" id="title" placeholder="제목을 입력해주세요." required></div>
					</div>
					<div>
						<p>카테고리</p>
						<div>
							<select id="cd_ctg" name="cd_ctg" required>
							<option value="0">선택</option>
							<option value="1">가입 및 탈퇴</option>
							<option value="2">상품</option>
							<option value="3">구매</option>
							<option value="4">결제</option>
							<option value="5">배송</option>
							<option value="6">환불</option>
							<option value="9">기타</option>
						</select>
						</div>
					</div>
					<div class="desces">
						<p>내용</p>
						<textarea name="content" id="content" placeholder="내용을 입력해주세요" required maxlength="2048"></textarea>
					</div>
					<div class="dtlImg">
						<p>첨부파일</p>
						<div>
							<input type="file" id="files_0" name="files[0]" />
							<button type='button' onclick='cancelFileUpload(0);'>취소</button>
						<!--<p class="pButton" onClick="plusImg(this)">+ 파일 추가</p> -->
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
						</div>
					</div>
				</div>
				<div style="white-space: nowrap; text-align: center;">
					<input class="styled-button" type="button" value="등록" style="width:100px; display: inline-block; margin-right: 10px;" onclick="javascript:writeProc(3)" />
					<input class="styled-button" type="button" value="취소" style="width:100px; display: inline-block;" onclick="javascript:history.back();" />
				</div> 
			</form>
		</article>
	</div>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>