<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/seller/mypage/index.jsp"%>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/seller/header.jsp"%>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
	<header class="header">
		<%@ include file="/include/seller/top.jsp"%>
	</header>
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>마이페이지</h4>
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
					<li><a href="/seller/mypage/myInfo.web"><i class="fa-solid fa-user"></i>내정보</a></li>
					<li><a href="/seller/sale/list.web"><i class="fa-solid fa-shirt"></i>상품관리</a></li>
					<li><a href="/seller/mypage/sales/list.web"><i class="fa-solid fa-piggy-bank"></i>매출관리</a></li>
					<li><a href="/seller/center/board.web"><i class="fa-solid fa-comment-dots"></i><span>게시판</span></a></li>
				</ul>
				<ul class="myPageSubMenu"></ul>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>