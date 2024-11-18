<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/auction/myList.jsp" %>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
</head>
<style>
	.auctionList {
		padding-bottom: 20px;
		width: 100%;
	}
	.auctionHeader {
		display: flex;
		flex-wrap: nowrap;
		justify-content: space-between;
		font-weight: bold;
		border-bottom: 1px solid #ddd;
		padding: 30px;
	}
	.auctionItem {
		display: flex;
		flex-wrap: nowrap;
		justify-content: space-between;
		border-bottom: 1px solid #ddd;
		padding: 30px 0;
	}
	#auctionNm {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2	; /*2줄*/
		-webkit-box-orient: vertical;
		max-height: 65px;
	}
	input[type=button] {margin:20px auto; display:block;width:100px;height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
	
	article {width:83%;}
	
	@media only screen and (max-width: 767px) {
		article {width:100%;}
	}
</style>
<script>
	function modify(value){
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("seq_act").value = value;
		
		frmMain.action="/front/mypage/auction/modify.web";
		frmMain.submit();
		
	}
	
	function goPage(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("currentPage").value = value;
		
		frmMain.action="/front/mypage/auction/myList.web";
		frmMain.submit();
	}

	function goBid(act) {

		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("seq_act").value = act;
		
		frmMain.action="/front/mypage/auction/bidView.web";
		frmMain.submit();
	}
	
	function goSortList(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("cd_state_act").value = value;
		frmMain.action="/front/mypage/auction/myList.web";
		frmMain.target = "";
		frmMain.submit();
	}
</script>
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
						<h4>내가 등록한 경매</h4>
						<div class="breadcrumb__links">
							<a href="/front/mypage/">마이페이지</a> <span>내가 등록한 경매</span>
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
				<article class="">
					<form id="frmMain" name="frmMain" method="POST">
						<input type="hidden" name="currentPage" 	id="currentPage"	value="${paging.currentPage}" />
						<input type="hidden" name="seq_act" 		id="seq_act"/>
						<input type="hidden" name="cd_state_act" 	id="cd_state_act"/>
						
						<div class="shop__product__option__right">
							<select onchange="goSortList(this.value);" >
								<option value="all"<c:if test="${paging.cd_state_act == 'all'}"> selected</c:if>>전체</option>
								<option value="0"<c:if test="${paging.cd_state_act == '0'}"> selected</c:if>>대기</option>
								<option value="1"<c:if test="${paging.cd_state_act == '1'}"> selected</c:if>>승인</option>
								<option value="9"<c:if test="${paging.cd_state_act == '9'}"> selected</c:if>>반려</option>
							</select>
						</div>
								
						<div class="auction">
							<c:choose>
								<c:when test="${empty list}">
									<p style="text-align: center; padding-top: 20px;">등록한 경매가 없습니다.</p>
								</c:when>
								<c:otherwise>
								
									<div class="auctionList pc">
										<div class="auctionHeader">
											<span style="width: 10%; text-align: center;">NO</span> 
											<span style="width: 55%; text-align: center;">상품명</span>
											<span style="width: 20%; text-align: center;">시작일자</span>
											<span style="width: 15%; text-align: center;">종료일자</span>
										</div>
										<c:forEach items="${list}" var="list">
											<c:set var="i" value="${i+1}" />
											<div class="auctionItem">
												<span style="width: 10%; text-align: center; padding-top:30px;">${list.rnum}</span>
												<div class="" style="width: 55%;display:flex;align-items:center;">
													<img src="/img/auction/${fn:replace(list.img, '\\', '/')}" alt="" style="width: 90px; height: 90px;">
													<c:if test="${list.cd_state_act == 0}">
														<h6 id="auctionNm" style="font-weight: bold;cursor:pointer;padding-left:20px;" onclick="javascript:modify('${list.seq_act}');">${list.act_nm}</h6>
													</c:if>
													<c:if test="${list.cd_state_act == 1}">
														<div style="cursor:pointer;padding-left:20px;">
															<b style="padding: 2px 10px;background: #5A9BD5;color:white;border-radius: 20px;font-size: 12px;">진행중 - 입찰현황 보기</b>
															<h6 style="margin-top:5px;font-weight: bold;" id="auctionNm" onclick="goBid(${list.seq_act})" title="입찰현황 보러가기">${list.act_nm}</h6>
														</div>
													</c:if>
													<c:if test="${list.cd_state_act == 9}">
														<div style="padding-left:20px;">
															<b style="padding: 2px 10px;background: var(--red);color:white;border-radius: 20px;font-size: 12px;">반려된 경매</b>
															<h6 style="margin: 5px 0;cursor:pointer;" id="auctionNm" onclick="goBid(${list.seq_act})" title="반려사유 보러가기">${list.act_nm}</h6>
														</div>
													</c:if>
												</div>
												<span style="width: 15%; text-align: center; padding-top:30px;">${list.dt_act_start}</span>
												<span style="width: 15%; text-align: center; padding-top:30px;">${list.dt_act_end}</span>
											</div>
										</c:forEach>
									</div>
									
									<div class="auctionList mo">
										<c:forEach items="${list}" var="list">
											<c:set var="i" value="${i+1}" />
											<div class="auctionItem">
												<span style="width: 10%; text-align: center;">${list.rnum}</span>
												<div class="" style="display:flex;width:90%;align-items:center;">
													<img src="/img/auction/${fn:replace(list.img, '\\', '/')}" alt="" style="width: 90px; height: 90px;">
													<div style="display:flex;flex-wrap:wrap;margin-left:10px;width: calc(100% - 95px);">
														<c:if test="${list.cd_state_act == 0}">
															<a href="/front/mypage/auction/modify.web" style="width:100%;">${list.act_nm}</a>
														</c:if>
														<c:if test="${list.cd_state_act == 1}">
															<div style="width:100%;">
																<b style="padding: 2px 10px;background: #5A9BD5;color:white;border-radius: 20px;font-size: 12px;">진행중 - 입찰현황 보기</b>
																<h6 style="margin: 5px 0;" id="auctionNm" onclick="goBid(${list.seq_act})" title="입찰현황 보러가기">${list.act_nm}</h6>
															</div>
														</c:if>
														<c:if test="${list.cd_state_act == 9}">
															<div style="width:100%;">
																<b style="padding: 2px 10px;background: var(--red);color:white;border-radius: 20px;font-size: 12px;">반려된 경매</b>
																<h6 style="margin: 5px 0;" id="auctionNm" onclick="goBid(${list.seq_act})" title="반려사유 보러가기">${list.act_nm}</h6>
															</div>
														</c:if>
														<span>${list.dt_act_start}</span>
														<span style="width:20px;text-align:center;">~</span>
														<span>${list.dt_act_end}</span>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
									
								</c:otherwise>
							</c:choose>
						</div>
						<c:if test="${paging.totalLine > 0}">
							<div class="row">
								<div class="col-lg-12">
									<div class="product__pagination">
										<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
									</div>
								</div>
							</div>
						</c:if>
						<div class="row">
							<div class="col-lg-12">
								<div>
									<input type="button" onclick="location.href='/front/mypage/auction/write.web';" value="경매 등록">
								</div>
							</div>
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