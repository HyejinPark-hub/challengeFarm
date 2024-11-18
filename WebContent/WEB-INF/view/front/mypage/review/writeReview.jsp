<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/review/writeReview.jsp" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/common/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	<style>
		.write::after {
			position:unset;
		}
		.reviewWrite {margin: 50px auto;}
		.reviewWrite h3 {text-align:center;}
		
		.container {max-width: 900px;}
		
		.sle_des {padding-left:50px;}
		.sle_nm {
			overflow: hidden;
			text-overflow: ellipsis;
			display: -webkit-box;
			font-size: 24px; font-weight:bold;
			-webkit-line-clamp: 2; /*2줄*/
			-webkit-box-orient: vertical;
		}
		.stars {
			display: inline-block;
		}
		.stars i {
			font-size: 30px;
			color: lightgray;
			cursor: pointer;
			transition: color 0.2s;
		}
		.stars i.full {
			color: black;
		}
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
		
		function complete() {
			
			if ($("#rating").val() == "") {
				alert("평점을 선택해주세요.");
				return;
			}
			if ($("#content").val() == "") {
				alert("상세리뷰를 입력해주세요.");
				$("#content").focus();
				return;
			}
			
			$("#frmMain").attr("action", "/front/mypage/writeReviewProc.web");
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
		<article class="reviewWrite">
			<h3>리뷰 등록</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="rating" 		name="rating" >
				<input type="hidden" id="seq_buy_dtl" 	name="seq_buy_dtl" 	value="${saleDto.seq_buy_dtl}">
				<input type="hidden" id="seq_sle" 		name="seq_sle" 		value="${saleDto.seq_sle}">
				<input type="hidden" id="seq_sll" 		name="seq_sll" 		value="${saleDto.seq_sll}">
				<input type="hidden" id="sll_nm" 		name="sll_nm" 		value="${saleDto.sll_nm}">
				<div class="write">
					<div class="sle_img">
						<img src="${saleDto.img}" alt="" style="width: 100px; height: 100px; margin-left: 10px; margin-top: 10px;">
						<div class="sle_des">
							<span class="sle_nm">${saleDto.sle_nm}</span> 
							<span>${saleDto.count}개, </span> <span>${saleDto.color}, </span> <span>${fn:split(saleDto.size_name,'/')[saleDto.size_nm]}</span> <br>
							<div class="stars" id="star-rating">
								<i class="fa fa-star" data-value="1"></i>
								<i class="fa fa-star" data-value="2"></i>
								<i class="fa fa-star" data-value="3"></i>
								<i class="fa fa-star" data-value="4"></i>
								<i class="fa fa-star" data-value="5"></i>
								<p class="explain">* 필수항목</p>
							</div>
						</div>
					</div>
					<div class="desces">
						<p>상세리뷰</p>
						<textarea name="content" id="content" placeholder="상세리뷰를 입력해주세요" required maxlength="2048"></textarea>
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
					<input type="button" value="등록" onClick="complete()">
					<a href="javascript:history.back()">취소</a>
				</div>
			</form>
		</article>
	</div>
	
	<script>
		const stars = document.querySelectorAll('.stars i');
		const ratingValue = document.getElementById('rating');
		let selectedRating = 0;
	
		// 별에 마우스를 올릴 때, 해당 별과 이전 별들에 hover 스타일 적용
		stars.forEach(star => {
			star.addEventListener('mouseover', function() {
				resetStars(); // 모든 별의 색상을 초기화
				fillStars(this.getAttribute('data-value')); // 해당 별점까지 색상 채우기
			});
	
			// 별을 클릭하면 선택한 별점의 값을 저장
			star.addEventListener('click', function() {
				selectedRating = this.getAttribute('data-value');
				ratingValue.value = selectedRating; // 선택한 별점 표시
				resetStars(); // 선택 후 모든 별을 초기화
				fillStars(selectedRating); // 선택한 별점까지 채우기
			});
	
			// 마우스가 별에서 벗어날 때, 기존 선택한 별점으로 복원
			star.addEventListener('mouseout', function() {
				resetStars();
				fillStars(selectedRating); // 선택한 별점까지 하이라이트
			});
		});
	
		// 별점 초기화 (모든 별의 색상 초기화)
		function resetStars() {
			stars.forEach(star => {
			star.classList.remove('full');
			});
		}
	
		// 선택한 별까지 채우기 (정별 처리)
		function fillStars(rating) {
			stars.forEach(star => {
				const starValue = parseFloat(star.getAttribute('data-value'));
				if (starValue <= rating) {
					star.classList.add('full'); // 선택한 별과 그 이전 별을 채우기
				}
			});
		}
	</script>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>