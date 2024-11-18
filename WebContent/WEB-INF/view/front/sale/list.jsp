<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/sale/women/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp"%>
	<style>
	.checked {
		color: black;
	}
	</style>
	<script>
		window.onload = function() {
			var productItems = document.querySelectorAll('.product__item');
			var container = document.getElementById('product-container');
			
			container.innerHTML = '';  // 기존 내용을 지움
			
			for (var i = 0; i < 9; i++) {
				if (i % 3 === 0) {
					var rowDiv = document.createElement('div');
					rowDiv.classList.add('row');
					container.appendChild(rowDiv);
				}
				var colDiv = document.createElement('div');
				colDiv.classList.add('col-lg-4', 'col-md-6', 'col-sm-6');
				
				colDiv.appendChild(productItems[i]);
				container.lastChild.appendChild(colDiv);
			}
		};
	
		function goView(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_sle").value = value;
			
			frmMain.action="/front/buy/buy.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goPage(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = value;
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("cd_ctg").value = value;
			document.getElementById("brd_ctg").value = "";
			document.getElementById("prc_ctg").value = "";
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goBrandList(value1, value2) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("cd_ctg").value = value1;
			document.getElementById("brd_ctg").value = value2;
			document.getElementById("prc_ctg").value = "";
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goPriceList(value1, value2) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("cd_ctg").value = value1;
			document.getElementById("brd_ctg").value = "";
			document.getElementById("prc_ctg").value = value2;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goSizeList(value1, value2) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("cd_ctg").value = value1;
			document.getElementById("brd_ctg").value = "";
			document.getElementById("prc_ctg").value = "";
			document.querySelector('input[name="size_nm"]:checked').value = value2;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
	
		function goSortList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("sale_sort").value = value;
			frmMain.action="/front/sale/list.web";
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
	</script>
</head>

<body>
<header class="header">
	<%@ include file="/include/front/top.jsp"%>
</header>

<form id="frmMain" method="POST">
<input type="hidden" name="seq_sle"		id="seq_sle" />
<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
<input type="hidden" name="cd_ctg" 		id="cd_ctg"			value="${paging.cd_ctg}"/>
<input type="hidden" name="brd_ctg" 	id="brd_ctg"		value="${paging.brd_ctg}"/>
<input type="hidden" name="prc_ctg" 	id="prc_ctg"		value="${paging.prc_ctg}"/>
<input type="hidden" name="sale_sort"	id="sale_sort" />
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<c:choose>
							<c:when test="${fn:contains(paging.cd_ctg, '11')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>아우터</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '12')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>재킷/베스트</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '13')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>상의</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '14')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>하의</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '15')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>원피스</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '16')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">여성</a> <span>패션잡화</span>
								</div>
							</c:when>
							<c:when test="${fn:startsWith(paging.cd_ctg, '1')}">
								<h4>여성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <span>여성</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '21')}">
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">남성</a> <span>아우터</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '22')}">
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">남성</a> <span>재킷/베스트</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '23')}">
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">남성</a> <span>상의</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '24')}">
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">남성</a> <span>하의</span>
								</div>
							</c:when>
							<c:when test="${fn:contains(paging.cd_ctg, '26')}">
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <a href="#">남성</a> <span>패션잡화</span>
								</div>
							</c:when>
							<c:otherwise>
								<h4>남성</h4>
								<div class="breadcrumb__links">
									<a href="/index.jsp">메인</a> <span>남성</span>
								</div>	
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="shop spad">
		<div class="container">
			<div class="row">
				<%@ include file="/include/front/lnbSale.jsp"%>
				<div class="col-lg-9">
					<div class="shop__product__option">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__left">
									<c:if test="${paging.cd_ctg == '11'}"><strong style="font-size: 30px;">아우터</strong></c:if>
									<c:if test="${paging.cd_ctg == '12'}"><strong style="font-size: 30px;">재킷/베스트</strong></c:if>
									<c:if test="${paging.cd_ctg == '13'}"><strong style="font-size: 30px;">상의</strong></c:if>
									<c:if test="${paging.cd_ctg == '14'}"><strong style="font-size: 30px;">하의</strong></c:if>
									<c:if test="${paging.cd_ctg == '15'}"><strong style="font-size: 30px;">원피스</strong></c:if>
									<c:if test="${paging.cd_ctg == '16'}"><strong style="font-size: 30px;">패션잡화</strong></c:if>
									<c:if test="${paging.cd_ctg == '21'}"><strong style="font-size: 30px;">아우터</strong></c:if>
									<c:if test="${paging.cd_ctg == '22'}"><strong style="font-size: 30px;">재킷/베스트</strong></c:if>
									<c:if test="${paging.cd_ctg == '23'}"><strong style="font-size: 30px;">상의</strong></c:if>
									<c:if test="${paging.cd_ctg == '24'}"><strong style="font-size: 30px;">하의</strong></c:if>
									<c:if test="${paging.cd_ctg == '26'}"><strong style="font-size: 30px;">패션잡화</strong></c:if>
									&nbsp;&nbsp;&nbsp;<span style="font-size: 15px;">${paging.totalLine}개 상품</span> 
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__right">
									<p></p>
									<select onchange="goSortList(this.value);" >
										<option value="new"<c:if test="${paging.sale_sort == 'new'}"> selected</c:if>>신상품순</option>
										<option value="popular"<c:if test="${paging.sale_sort == 'popular'}"> selected</c:if>>인기상품순</option>
										<option value="low_price"<c:if test="${paging.sale_sort == 'low_price'}"> selected</c:if>>낮은가격순</option>
										<option value="high_price"<c:if test="${paging.sale_sort == 'high_price'}"> selected</c:if>>높은가격순</option>
										<option value="discount"<c:if test="${paging.sale_sort == 'discount'}"> selected</c:if>>높은할인율순</option>
										<option value="review"<c:if test="${paging.sale_sort == 'review'}"> selected</c:if>>구매후기순</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div id="product-container">
					<c:choose>
						<c:when test="${empty list}">
							<div class="row">
								<div class="col-lg-4 col-md-6 col-sm-6">
									등록된 상품이 없습니다.
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="list">
							 	<div class="row">
									<div class="col-lg-4 col-md-6 col-sm-6">
										<div class="product__item">
											<div class="product__item__pic set-bg" data-setbg="<c:if test="${list.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(list.img, '\\', '/')}">
												<a href="javascript:goView(${list.seq_sle});" style="display:block; width:100%; height:100%;"></a>
												<ul class="product__hover">
													<li>
														<c:if test="${list.flg_cancel != 'N' || empty sessionScope.SEQ_MBR}">
															<img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${list.seq_sle}', this)" style="cursor:pointer">
														</c:if>
														<c:if test="${list.flg_cancel == 'N' && not empty sessionScope.SEQ_MBR}">
															<img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${list.seq_sle}', this)" style="cursor:pointer">
														</c:if>
													</li>
												</ul>
											</div>
											<div class="product__item__text">
												<h6 onclick="javascript:goView(${list.seq_sle});" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.sle_nm}</h6>
												<div class="stars" id="star-rating" style="color:#E0E0E0;">
													<i class="fa fa-star <c:if test='${list.rating >= 1}'>checked</c:if>" data-value="1"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 2}'>checked</c:if>" data-value="2"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 3}'>checked</c:if>" data-value="3"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 4}'>checked</c:if>" data-value="4"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 5}'>checked</c:if>" data-value="5"></i>
												</div>
												<div>
													<c:choose>
														<c:when test="${list.discount > 0}">
															<h5 style="display: inline-block;"><fmt:formatNumber value="${list.price_cost * (1 - (list.discount / 100.0))}" /> </h5>
															<h5 style="color: #a4a4a4; text-decoration: line-through; display:inline-block; font-size: 12px;" ><fmt:formatNumber value="${list.price_cost}" /> </h5>
															<h6 style="color: purple; display:inline-block;"> ${list.discount}% </h6>
														</c:when>
														<c:otherwise>
															<h5><fmt:formatNumber value="${list.price_cost}" /> </h5>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="product__pagination">
								<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</form>	

<footer>
<%@ include file="/include/common/footer.jsp"%>
</footer>
</body>
</html>