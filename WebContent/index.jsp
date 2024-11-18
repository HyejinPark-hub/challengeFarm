<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/index.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/common/header.jsp" %>
	<script src="/js/jquery-3.3.1.min.js"></script>
	<style>
		/* Preloader 스타일 */
		#preloader {
			position: fixed;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			z-index: 9999;
			background-color: #fff;
			display: flex;
			justify-content: center;
			align-items: center;
		}

		.loader {
			border: 8px solid #f3f3f3;
			border-top: 8px solid #3498db;
			border-radius: 50%;
			width: 60px;
			height: 60px;
			animation: spin 2s linear infinite;
		}

		@keyframes spin {
			0% { transform: rotate(0deg); }
			100% { transform: rotate(360deg); }
		}

		#content {
			display: none; /* 처음에는 숨김 */
		}
		
		.checked {
			color: black;
		}
		
		.owl-carousel .owl-item img {
			width: unset;
			display: unset;
		}
		
		@media only screen and (max-width: 767px) {
			.categories__hot__deal {
				height: 350px;
				overflow: hidden;
			}
		}
	</style>
	<script>
		
		function goList(value) {
				
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("cd_ctg").value = value;
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}

		function goView(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_sle").value = value;
			
			frmMain.action="/front/buy/buy.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goBid(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_act").value = value;
			
			frmMain.action="/front/auction/view.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function heartProc(mbr, sle, t) {
			if (mbr == '') {
				alert('로그인이 필요한 기능입니다!');
				return;
			}
			
			if ($(t).hasClass('emptyHeart')) {
				var type = 'insert';
			} else {
				var type = 'delete';
			}
			
			var data = {seq_mbr: mbr, seq_sle: sle, process: type};
			
			$.ajax({
				url: '/front/sale/heart.json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					if (res) {
						if (type == 'insert') {
							alert("해당 상품을 찜하였습니다");
							$(t).removeClass('emptyHeart').addClass('fullHeart');
							$(t).attr('src', '/img/icon/heart.png');
						} else {
							alert("해당 상품을 찜 해제하였습니다");
							$(t).removeClass('fullHeart').addClass('emptyHeart');
							$(t).attr('src', '/img/icon/heart_empty.png');
						}
					} else {
						alert("찜 실패!!\n관리자에게 문의하세요");
					}
				}
			})
		}
		
		function mainSaleList(type) {
			$.ajax({
				method: 'POST', // GET 요청
				url: '/front/mainSaleList.json', // 서버의 엔드포인트 설정
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify({ type: type }),
				success:function(res) {
					
					$.each(res, function(index, item) {
						
						if(type == 'heart'){
							$("#popSale" + (index+1) + " .product__item__pic").css({"background-image": "url('" + item.img + "')"});
							
							let heartHtml = '';
							var sessionScope = "${sessionScope.SEQ_MBR}";
							sessionScope = isNaN(sessionScope) ? '' : sessionScope;
							if (item.flg_cancel != 'N' || sessionScope == ''){
								heartHtml = '<li><img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							} else if (item.flg_cancel == 'N' && sessionScope != '') {
								heartHtml = '<li><img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							}
							$("#popSale" + (index+1) + " .product__item__pic .product__hover").html(heartHtml);
							
							$("#popSale" + (index+1) + " .product__item__text h6").html(
								'<h6 onclick="javascript:goView(' + item.seq_sle + ');" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + item.sle_nm + '</h6>'
							);
							let starsHtml = '';
							for (let i = 1; i <= 5; i++) {
								starsHtml += '<i class="fa fa-star ' + (item.rating >= i ? 'checked' : '') + '" data-value="' + i + '"></i>';
							}
							$("#popSale" + (index+1) + " .product__item__text .stars").html(starsHtml);
							if(item.discount > 0){
								$("#popSale" + (index+1) + " .product__item__text .salePrice").text(parseFloat(item.price_cost * (1 - (item.discount / 100.0))).toLocaleString('ko-KR')).css('display', 'inline-block');
								$("#popSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR')).css({'color': '#a4a4a4', 'font-size': '12px', 'display': 'inline-block', 'text-decoration': 'line-through'});
								$("#popSale" + (index+1) + " .product__item__text .discount").text(item.discount+"%").css({'color': 'purple', 'display': 'inline-block'});
							}else{
								$("#popSale" + (index+1) + " .product__item__text .salePrice").css('display', 'none');
								$("#popSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR'));
								$("#popSale" + (index+1) + " .product__item__text .discount").css('display', 'none');
							}
						}else if(type == 'dt_reg'){
							$("#newSale" + (index+1) + " .product__item__pic").css({"background-image": "url('" + item.img + "')"});
							
							let heartHtml = '';
							var sessionScope = "${sessionScope.SEQ_MBR}";
							sessionScope = isNaN(sessionScope) ? '' : sessionScope;
							if (item.flg_cancel != 'N' || sessionScope == ''){
								heartHtml = '<li><img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							} else if (item.flg_cancel == 'N' && sessionScope != '') {
								heartHtml = '<li><img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							}
							$("#newSale" + (index+1) + " .product__item__pic .product__hover").html(heartHtml);
							
							$("#newSale" + (index+1) + " .product__item__text h6").html(
								'<h6 onclick="javascript:goView(' + item.seq_sle + ');" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + item.sle_nm + '</h6>'
							);
							let starsHtml = '';
							for (let i = 1; i <= 5; i++) {
								starsHtml += '<i class="fa fa-star ' + (item.rating >= i ? 'checked' : '') + '" data-value="' + i + '"></i>';
							}
							$("#newSale" + (index+1) + " .product__item__text .stars").html(starsHtml);
							if(item.discount > 0){
								$("#newSale" + (index+1) + " .product__item__text .salePrice").text(parseFloat(item.price_cost * (1 - (item.discount / 100.0))).toLocaleString('ko-KR')).css('display', 'inline-block');
								$("#newSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR')).css({'color': '#a4a4a4', 'font-size': '12px', 'display': 'inline-block', 'text-decoration': 'line-through'});
								$("#newSale" + (index+1) + " .product__item__text .discount").text(item.discount+"%").css({'color': 'purple', 'display': 'inline-block'});
							}else{
								$("#newSale" + (index+1) + " .product__item__text .salePrice").css('display', 'none');
								$("#newSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR'));
								$("#newSale" + (index+1) + " .product__item__text .discount").css('display', 'none');
							}
						}else{
							$("#hotSale" + (index+1) + " .product__item__pic").css({"background-image": "url('" + item.img + "')"});
							
							let heartHtml = '';
							var sessionScope = "${sessionScope.SEQ_MBR}";
							sessionScope = isNaN(sessionScope) ? '' : sessionScope;
							if (item.flg_cancel != 'N' || sessionScope == ''){
								heartHtml = '<li><img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							} else if (item.flg_cancel == 'N' && sessionScope != '') {
								heartHtml = '<li><img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							}
							$("#hotSale" + (index+1) + " .product__item__pic .product__hover").html(heartHtml);
							
							$("#hotSale" + (index+1) + " .product__item__text h6").html(
								'<h6 onclick="javascript:goView(' + item.seq_sle + ');" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + item.sle_nm + '</h6>'
							);
							let starsHtml = '';
							for (let i = 1; i <= 5; i++) {
								starsHtml += '<i class="fa fa-star ' + (item.rating >= i ? 'checked' : '') + '" data-value="' + i + '"></i>';
							}
							$("#hotSale" + (index+1) + " .product__item__text .stars").html(starsHtml);
							if(item.discount > 0){
								$("#hotSale" + (index+1) + " .product__item__text .salePrice").text(parseFloat(item.price_cost * (1 - (item.discount / 100.0))).toLocaleString('ko-KR')).css('display', 'inline-block');
								$("#hotSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR')).css({'color': '#a4a4a4', 'font-size': '12px', 'display': 'inline-block', 'text-decoration': 'line-through'});
								$("#hotSale" + (index+1) + " .product__item__text .discount").text(item.discount+"%").css({'color': 'purple', 'display': 'inline-block'});
							}else{
								$("#hotSale" + (index+1) + " .product__item__text .salePrice").css('display', 'none');
								$("#hotSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR'));
								$("#hotSale" + (index+1) + " .product__item__text .discount").css('display', 'none');
							}
						}
					});
					
					if(type == 'heart'){
						$('.popular-sales').css('display', 'block');
					}else if(type == 'dt_reg'){
						$('.new-arrivals').css('display', 'block');
					}else{
						$('.hot-sales').css('display', 'block');
					}
				},
				error: function() {
					// 에러 처리
				}
			});
		}
		
		$(document).ready(function() {
			let myVisit = getCookie('myVisit');
			
			// 이전 방문기록이 없을 경우만
			if (myVisit != 'Y') {
				let date = new Date();
				let _year = date.getFullYear();
				let _month = date.getMonth() + 1;
				
				$.ajax({
					method: 'POST',
					url: '/front/visits.json',
					contentType: 'application/json',
					dataType: 'json',
					data: JSON.stringify({year: _year, month: _month}),
					success: function(res) {
						if (res) {
							// 24시간마다 방문기록 리셋
							setCookie('myVisit', 'Y', 1);
						}
					}
				})
			}
			
			// 페이지가 로드될 때 Preloader를 보여주고, AJAX로 데이터를 가져옴
			$.ajax({
				method: 'POST',
				url: '/front/mainSaleList.json', // 서버의 엔드포인트 설정
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify({ type: 'heart' }),
				beforeSend: function() {
				// AJAX 요청 전 Preloader 표시
					$('#preloader').show();
				},
				success: function(res) {
					$.each(res, function(index, item) {
						if(item.heart != null){
							$("#popSale" + (index+1) + " .product__item__pic").css({"background-image": "url('" + item.img + "')"});

							let heartHtml = '';
							var sessionScope = "${sessionScope.SEQ_MBR}";
							sessionScope = isNaN(sessionScope) ? '' : sessionScope;
							if (item.flg_cancel != 'N' || sessionScope == ''){
								heartHtml = '<li><img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							} else if (item.flg_cancel == 'N' && sessionScope != '') {
								heartHtml = '<li><img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc(\'' + sessionScope + '\', ' + item.seq_sle + ', this)" style="cursor:pointer"></li>';
							}
							$("#popSale" + (index+1) + " .product__item__pic .product__hover").html(heartHtml);
							
							$("#popSale" + (index+1) + " .product__item__text h6").html(
								'<h6 onclick="javascript:goView(' + item.seq_sle + ');" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + item.sle_nm + '</h6>'
							);
							
							let starsHtml = '';
							for (let i = 1; i <= 5; i++) {
								starsHtml += '<i class="fa fa-star ' + (item.rating >= i ? 'checked' : '') + '" data-value="' + i + '"></i>';
							}
							$("#popSale" + (index+1) + " .product__item__text .stars").html(starsHtml);
									
							if(item.discount > 0){
								$("#popSale" + (index+1) + " .product__item__text .salePrice").text(parseFloat(item.price_cost * (1 - (item.discount / 100.0))).toLocaleString('ko-KR')).css('display', 'inline-block');
								$("#popSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR')).css({'color': '#a4a4a4', 'font-size': '12px', 'display': 'inline-block', 'text-decoration': 'line-through'});
								$("#popSale" + (index+1) + " .product__item__text .discount").text(item.discount+"%").css({'color': 'purple', 'display': 'inline-block'});
							}else{
								$("#popSale" + (index+1) + " .product__item__text .salePrice").css('display', 'none');
								$("#popSale" + (index+1) + " .product__item__text .priceCost").text(parseFloat(item.price_cost).toLocaleString('ko-KR'));
								$("#popSale" + (index+1) + " .product__item__text .discount").css('display', 'none');
							}
							
							$('.new-arrivals').css('display', 'none');
							$('.hot-sales').css('display', 'none');
						}
					});
				},
				error: function() {
					// 에러 처리
				},
				complete: function() {
					// 요청 완료 후 Preloader 숨기고, 콘텐츠 보여주기
					$('#preloader').hide();
				}
			});
			
			$.ajax({
				method: 'POST',
				url: '/front/popularAuction.json',
				contentType: 'application/json',
				dataType: 'json',
				success: function(res) {
					$("#popularAuction .categories__hot__deal img").attr("src", "/img/auction/" + res.img.replace(/\\/g, '/'));
					$("#popularAuction .categories__deal__countdown h2").text(res.act_nm);

					$("#countdown").countdown(res.dt_act_end, function (event) {
						$(this).html(event.strftime("<div class='cd-item'><span>%D</span> <p>Days</p> </div>" + "<div class='cd-item'><span>%H</span> <p>Hours</p> </div>" + "<div class='cd-item'><span>%M</span> <p>Minutes</p> </div>" + "<div class='cd-item'><span>%S</span> <p>Seconds</p> </div>"));
					});
					
					$("#popularAuction .categories__deal__countdown a").html('<a href="javascript:goBid(' + res.seq_act + ')" class="primary-btn">경매참여</a>');
				}
			});
			
			$.ajax({
				method: 'POST',
				url: '/front/closingAuction.json',
				contentType: 'application/json',
				dataType: 'json',
				success: function(res) {
					$('.blog__item__pic.set-bg').each(function(index, element) {
						$(element).css("background-image", "url('/img/auction/" + (res[index].img).replace(/\\/g, '/') + "')");
					});
					$('.blog__item__text h5').each(function(index, element) {
						$(element).text(res[index].act_nm);
					});
					$('.blog__item__text span').each(function(index, element) {
						$(element).text(res[index].dt_act_end);
					});
					$('.blog__item__text a').each(function(index, element) {
						$(element).attr('href', 'javascript:goBid(' + res[index].seq_act + ')').text('참여하기');
					});
					
					$('.owl-carousel').owlCarousel({
						items: 3,		// 한 번에 표시할 슬라이드 개수
						loop: true,		// 무한 루프
						//nav: true,	// 이전/다음 버튼 표시
						//navText: ["<span class='arrow_left'><span/>", "<span class='arrow_right'><span/>"],
						autoplay: true, 	// 자동 재생
						autoplayTimeout: 3000,	// 자동 재생 시간 간격
						responsive: {
							0: {
								items: 1 // 모바일에서는 한 개씩 보여줌
							},
							600: {
								items: 3, // 태블릿에서는 세 개씩 보여줌
								margin: 10		// 슬라이드 간격
							},
							1000: {
								items: 3, // 데스크탑에서는 다섯 개씩 보여줌
								margin: 10		// 슬라이드 간격
							}
						}
					});
				}
			});
			
		});
	</script>
</head>
	
<body>
	<form id="frmMain" method="POST">
		<input type="hidden" name="cd_ctg" 	id="cd_ctg"	 value=""/>
		<input type="hidden" name="seq_sle" id="seq_sle" value=""/>
		<input type="hidden" name="seq_act" id="seq_act" value=""/>
	</form>
	<!-- Page Preloder-->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	 
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->

	<!-- Hero Section Begin -->
	<section class="hero">
		<div class="hero__slider owl-carousel">
			<div class="hero__items set-bg" data-setbg="img/main/mainImg-1.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-5 col-lg-7 col-md-8">
							<div class="hero__text">
								<h2>Fall - Winter Collections 2024</h2>
								<p>독창적인 스타일, 세심하게 선별된 프리미엄 아이템을 위한 <br/>특별한 도전, 챌린지팜에서 시작하세요.</p>
								<a href="javascript:goList(1)" class="primary-btn">Shop now <span class="arrow_right"></span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="hero__items set-bg" data-setbg="img/main/mainImg-2.jpg">
				<div class="container">
					<div class="row">
						<div class="col-xl-5 col-lg-7 col-md-8">
							<div class="hero__text">
								<h2>Fall - Winter Collections 2024</h2>
								<p>독창적인 스타일, 세심하게 선별된 프리미엄 아이템을 위한 <br/>특별한 도전, 챌린지팜에서 시작하세요.</p>
								<a href="javascript:goList(1)" class="primary-btn">Shop now <span class="arrow_right"></span></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Hero Section End -->
	
	<!-- Product Section Begin -->
	<section class="product spad" style="padding-top: 50px;">
		<div class="container" id="data-container">
			<div class="row">
				<div class="col-lg-12">
					<ul class="filter__controls">
						<li class="active" data-filter=".popular-arrivals" onclick="mainSaleList('heart')">인기 상품</li>
						<li data-filter=".new-arrivals" onclick="mainSaleList('dt_reg')">최신 상품</li>
						<li data-filter=".hot-sales" onclick="mainSaleList('discount')">세일 상품</li>
					</ul>
				</div>
			</div>
			<div class="row product__filter">
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale1" >
						<div class="product__item__pic set-bg" >
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<div>
								<h5 class="salePrice"></h5>
								<h5 class="priceCost"></h5>
								<h6 class="discount"></h6>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale2" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale3" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale4" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale5" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale6" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale7" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix popular-arrivals">
					<div class="product__item" id="popSale8" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals">
					<div class="product__item" id="newSale1" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals">
					<div class="product__item" id="newSale2" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals">
					<div class="product__item" id="newSale3" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals">
					<div class="product__item" id="newSale4" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix hot-sales">
					<div class="product__item" id="hotSale1" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>			
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix hot-sales">
					<div class="product__item" id="hotSale2" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix hot-sales">
					<div class="product__item" id="hotSale3" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix hot-sales">
					<div class="product__item" id="hotSale4" >
						<div class="product__item__pic set-bg">
							<ul class="product__hover">
								<li></li>
							</ul>
						</div>
						<div class="product__item__text">
							<h6></h6>
							<div class="stars" id="star-rating" style="color:#E0E0E0;"></div>
							<h5 class="salePrice"></h5>
							<h5 class="priceCost"></h5>
							<h6 class="discount"></h6>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->

	<!-- Banner Section Begin -->
	<section class="banner spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 offset-lg-4">
					<div class="banner__item">
						<div class="banner__item__pic">
							<img src="img/banner/banner-1.jpg" alt="">
						</div>
						<div class="banner__item__text">
							<h2>아우터</h2>
							<a href="javascript:goList(11)">Shop now</a>
						</div>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="banner__item banner__item--middle">
						<div class="banner__item__pic">
							<img src="img/banner/banner-2.jpg" alt="">
						</div>
						<div class="banner__item__text">
							<h2>하의</h2>
							<a href="javascript:goList(14)">Shop now</a>
						</div>
					</div>
				</div>
				<div class="col-lg-7">
					<div class="banner__item banner__item--last">
						<div class="banner__item__pic">
							<img src="img/banner/banner-3.jpg" alt="">
						</div>
						<div class="banner__item__text">
							<h2>패션 잡화</h2>
							<a href="javascript:goList(26)">Shop now</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Banner Section End -->

	<!-- Categories Section Begin -->
	<section class="categories spad">
		<div class="container" id="popularAuction">
			<div class="row">
				<div class="col-lg-3">
					<div class="categories__text">
						<h2><br /> <span>이달의 인기 경매</span> <br /></h2>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="categories__hot__deal">
						<img src="img/product-sale.png" alt="">
					</div>
				</div>
				<div class="col-lg-4 offset-lg-1">
					<div class="categories__deal__countdown">
						<span>Popular Auction</span>
						<h2>Multi-pocket Chest Bag Black</h2>
						<div class="categories__deal__countdown__timer" id="countdown">
							<div class="cd-item">
								<span></span>
								<p>Days</p>
							</div>
							<div class="cd-item">
								<span></span>
								<p>Hours</p>
							</div>
							<div class="cd-item">
								<span></span>
								<p>Minutes</p>
							</div>
							<div class="cd-item">
								<span></span>
								<p>Seconds</p>
							</div>
						</div>
						<a href="#" class="primary-btn">경매참여</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Categories Section End -->
	
	<!-- Latest Blog Section Begin -->
	<section class="latest spad">
		<div class="container" id="closingAuction">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>마감 임박 경매</h2>
					</div>
				</div>
			</div>
			<div class="owl-carousel">
				<div class="blog__item">
					<div class="blog__item__pic set-bg" data-setbg=""></div>
						<div class="blog__item__text">
							<span><img src="img/icon/calendar.png" alt=""></span>
							<h5></h5>
							<a href="#">참여하기</a>
						</div>
				</div>
				<div class="blog__item">
					<div class="blog__item__pic set-bg" data-setbg=""></div>
						<div class="blog__item__text">
							<span><img src="img/icon/calendar.png" alt=""></span>
							<h5></h5>
							<a href="#">참여하기</a>
						</div>
				</div>
				<div class="blog__item">
					<div class="blog__item__pic set-bg" data-setbg=""></div>
						<div class="blog__item__text">
							<span><img src="img/icon/calendar.png" alt=""></span>
							<h5></h5>
							<a href="#">참여하기</a>
						</div>
				</div>
				<div class="blog__item">
					<div class="blog__item__pic set-bg" data-setbg=""></div>
						<div class="blog__item__text">
							<span><img src="img/icon/calendar.png" alt=""></span>
							<h5></h5>
							<a href="#">참여하기</a>
						</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Latest Blog Section End -->

	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->

	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search End -->
</body>

</html>