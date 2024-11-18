<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/mypage/heartList/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 					uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/front/header.jsp"%>
<script type="text/javascript" src="/js/uranus/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="/js/uranus/mypage/heartList.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
<link rel="stylesheet" href="/css/mypage/heartList.css" type="text/css">
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
						<h4>찜한 상품</h4>
						<div class="breadcrumb__links">
							<a href="/front/mypage/">마이페이지</a> <span>구매 상품</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="shop spad">
		<div class="container">
			<div class="row">
				<%@ include file="/include/front/lnbMyPage.jsp"%>
				
				<c:set var="mbr" value="${sessionScope.SEQ_MBR}" />
				<form id="frmMain" name="frmMain" method="POST">
					<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}" />
					<input type="hidden" name="seq_mbr" id="seq_mbr" />
					<input type="hidden" name="seq_sle" id="seq_sle" />
					
					<div class="shopping__cart__table">
						<table>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="5" style="text-align: center;">찜한 상품이 없습니다.</td>
									</tr>
								</c:when>
							<c:otherwise>
								<thead>
								
									<tr>
										<th style="width: 10%; text-align: center;">NO</th>
										<th style="width: 15%; text-align: center;">상품이미지</th>
										<th style="width: 35%; text-align: center;">상품명</th>
										<th style="width: 20%; text-align: center;">찜한날짜</th>
										<th style="width: 10%; text-align: center;">해제</th>
									</tr>
								</thead>
							<c:set var="i" value="0" />
							<c:forEach items="${list}" var="item">
								<c:set var="i" value="${i + 1}" />
								<tr>
									<td style="text-align: center;">${item.rnum}</td>
										<td class="product__cart__item">
											<div class="product__cart__item__pic">
												<img src="${item.sle_img}" alt="${item.sle_nm} 이미지" style="width: 90px; height: 90px;">
											</div>
										</td>
										<td style="text-align: left; padding-left: 60px;">${item.sle_nm}</td>
										<td style="text-align: center;">${item.dt_reg}</td>
										<td style="text-align: center;">
					<button class="btn btn-light" style="border: none; cursor: pointer;" onclick="heartProc('${sessionScope.SEQ_MBR}', '${item.seq_sle}', this);">
						<i class="fas fa-trash" data-item-id="${item.seq_sle}" style="margin-right: 0;"></i>
					</button>
										</td>
								</tr>
							</c:forEach>
							</c:otherwise>
							</c:choose>
						</table>
					</div>
					
					<div class="row">
						<div class="col-lg-12">
							<div class="product__pagination">
								<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>