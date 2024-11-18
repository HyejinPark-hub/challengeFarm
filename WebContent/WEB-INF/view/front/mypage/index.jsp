<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/mypage/index.jsp"%>
<!DOCTYPE html>
<html lang="kr">

<head>
	<%@ include file="/include/front/header.jsp"%>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp"%>
	</header>
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4 style="margin-bottom:0;">마이페이지</h4>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="shop spad">
		<div class="container">
			<div class="row myPage">
				<h4>${sessionScope.NAME}<span>님 환영합니다</span></h4>
				<ul class="myPageMenu">
					<li><a href="/front/mypage/myInfo.web"><i class="fa-solid fa-user"></i>내정보</a></li>
					<li><a href="javascript:alert('추후 개발 예정');"><i class="fa-solid fa-truck"></i>배송조회</a></li>
					<li><a href="/front/mypage/buyList.web"><i class="fa-solid fa-credit-card"></i>구매내역</a></li>
					<li><a href="/front/basket/"><i class="fa-solid fa-cart-shopping"></i>장바구니</a></li>
				</ul>
				<ul class="myPageSubMenu">
					<li><a href="/front/mypage/heartList.web"><i class="fa-solid fa-heart"></i><span>찜한상품</span><i class="fa-solid fa-angle-right"></i></a></li>
					<li><a href="/front/mypage/review/list.web"><i class="fa-solid fa-thumbs-up"></i><span>리뷰내역</span><i class="fa-solid fa-angle-right"></i></a></li>
					<li><a href="/front/mypage/question/list.web"><i class="fa-solid fa-comment-dots"></i><span>문의내역</span><i class="fa-solid fa-angle-right"></i></a></li>
					<li><a href="/front/mypage/auction/myList.web"><i class="fa-solid fa-gavel"></i><span>등록한 경매</span><i class="fa-solid fa-angle-right"></i></a></li>
					<li><a href="/front/mypage/auction/joinList.web"><i class="fa-solid fa-handshake"></i><span>참여한 경매</span><i class="fa-solid fa-angle-right"></i></a></li>
				</ul>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>