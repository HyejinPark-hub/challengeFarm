<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/auction/bidView.jsp" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
	<link rel="stylesheet" href="/css/auction/main.css" type="text/css">
	
	<script>
		window.onload = function (){
			
		}
	</script>
</head>
	
<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>마이페이지</h4>
						<div class="breadcrumb__links">
							<a href="/front/mypage/auction/myList.web">경매 정보</a> <a href="javascript:history.back();">내가 등록한 경매</a> <span>입찰 내역</span>
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
				<article>
					<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
						<c:choose>
							<c:when test="${auctionDto.cd_state_act == 9}">
								<div class="reject">
									<ul>
										<li>반려사유</li>
										<li>${auctionDto.reject}</li>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${empty list}">
										<div class="auctionItem"><p>입찰자가 없습니다.</p></div>
									</c:when>
									<c:otherwise>
										<ul class="auctionItem">
											<c:forEach items="${list}" var="list" varStatus="status">
												<c:if test="${status.first}">
													<li class="act_price">
														<span>0</span>
														<span><fmt:formatNumber value="${list.act_price}" pattern="#,###" /></span>
														<span><fmt:formatNumber value="${list.act_price * 2}" pattern="#,###" /></span>
													</li>
												</c:if>
												<li>
													<p class="mbr_nm"><plutozoneUtilTag:masking text="${list.mbr_nm}" letter="*" count="1" mode="center" /></p>
													<p class="priceGraph">
														<span style="width:${list.bid_price / list.act_price * 100 / 2}%"></span>
													</p>
													<p class="bid_price"><fmt:formatNumber value="${list.bid_price}" pattern="#,###" />원</p>
												</li>
											</c:forEach>
										</ul>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<div id="btnArea">
							<a href="javascript:history.back()">뒤로가기</a>
						</div>
					</form>
				</article>
			</div>
		</div>
	</section>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>