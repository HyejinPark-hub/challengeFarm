<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/basket/index.jsp" %>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/basket/main.css" />
	
	<style>
		.moTd {display:none;}
		.cart__total {width:40%;}
		
		@media all and (max-width: 479px) {
			.pcTd {display:none}
			.moTd {display:table-cell;}
			.cart__total {width:100%;}
			.moTd .changeCnt {padding-left:10px;}
			
			.shopping__cart__table table tbody tr td {padding-top:15px;padding-bottom:15px;}
			.mo .quantity {padding-left:10px;}
			.shopping__cart__table table tbody tr td.product__cart__item {width:auto;padding-left:5px;padding-top:30px;}
			.mo .cart__close {content:"";position:absolute;top:0;right:0;}
			.shopping__cart__table table tbody tr td.product__cart__item .product__cart__item__text h6 {overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;}
		}
	</style>
	
	<script>
		var products = new Array();
		var origProducts = new Array();
		var total = 0;
		var discount = 0;
		var count = 0;
		var result = 0;
		
		window.onload = function() {
			
			<c:forEach items="${list}" var="list">
				total += ${list.price} * ${list.count};
				discount += (${list.price} * ${list.discount} / 100) * ${list.count};
				count += ${list.count};
				products.push(${list.seq_bsk});
			</c:forEach>
			
			origProducts = products;
			result = total - discount;

			$("#buy_count").val(count);
			$("#buy_price").val(result);
			$("#products").val(products);

			result = addComma(result);
			total = addComma(total);
			discount = addComma(discount);
			
			$(".totalPrice").text(total);
			$("span.discount").text("-" +discount);
			$(".resultPrice").text(result);
		}
		
		function addComma(value){
			return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function chkBasket(type, t) {
			if (type == 'all') {
				products = [];
				
				if ($(t).prop("checked")) {
					$("input[name^=chk_]").prop("checked", true);
					$("#buy_count").val(count);
					$("#buy_price").val(result);
					
					var tr = $("table tbody tr");
					
					for (var a = 0; a < tr.length; a++) {
						var td = tr.eq(a).find("td:first-child");
						var checkbox = td.find("input[type=checkbox]");
						
						// 체크된 항목인지
						if (checkbox.prop("checked")) {
							products.push(checkbox.val());
						}
					}
					$("#products").val(products);
					
					$(".totalPrice").text(total);
					$(".discount").text("-" + discount);
					$(".resultPrice").text(result);
				} else {
					$("input[name^=chk_]").prop("checked", false);
					
					$("#buy_count").val("");
					$("#buy_price").val("");
					$("#products").val(products);
					
					$(".totalPrice").text(0);
					$(".discount").text("-" +0);
					$(".resultPrice").text(0);
				}
			}
			else {
				var chkLength = $("input[name^=chk_]").length;
				var _chkLength = $("input[name^=chk_]:checked").length;
				
				if (chkLength == _chkLength) $("#chkAll").prop("checked", true);
				else $("#chkAll").prop("checked", false);
				
				// 결제페이지로 이동할 때 넘길 장바구니 일련번호
				if (!$(t).prop("checked")) {
					for (var a = 0; a < products.length; a++) {
						
						if (products[a] == $(t).val()) {
							products.splice(a, 1);
							$("#products").val(products);
						}
					}
				}
				else {
					products.push($(t).val());
					$("#products").val(products);
				}
				
				var tr = $("table tbody tr");
				var _total = 0;
				var _discount = 0;
				var _count = 0;
				for(var loop = 0; loop < tr.length; loop++) {
					var td = tr.eq(loop).find("td:first-child");
					var checked = td.find("input[type=checkbox]").prop("checked");
					
					// 체크된 항목인지
					if (checked) {
						var p = td.find(".origPrice").val();
						var d = td.find(".discount").val();
						var c = td.find(".totalCnt").val();
						
						_total += p * c;
						_discount += (p * d / 100) * c;
						_count += Number(c);
					}
				}
				total = _total;
				count = _count;
				discount = _discount;
				result = total - _discount;
				
				$("#buy_count").val(count);
				$("#buy_price").val(result);
				$("#products").val(products);

				result = addComma(result);
				total = addComma(total);
				discount = addComma(discount);
				
				$(".totalPrice").text(total);
				$("span.discount").text("-" +discount);
				$(".resultPrice").text(result);
			}
		}
		
		function changeCnt(bskNo, type, t, sleNo, size) {
			var chgValue = 0;
			var resultValue = 0;
			
			if (type == 'p') {			// 더하기
				chgValue = Number($(t).prev().val()) +1;
				
				$(t).siblings(".minusCnt").css({"point-events": "auto", "color": "#888"});
				
				$(t).prev().val(chgValue);
				resultValue = 1;
				
			} else if (type == 'm') {	// 빼기
				chgValue = Number($(t).next().val()) -1;
				
				$(t).next().val(chgValue);
				
				if (chgValue == '1') {
					$(t).css({"point-events": "none", "color": "#eee"});
				}
				resultValue = -1;
				
			} else if (type == 'd') {	// 삭제
				resultValue = $(t).parent("td").siblings(".quantity__item").find("input").val() * -1;
				
				for (var a = 0; a < products.length; a++) {
					
					if (products[a] == bskNo) {
						products.splice(a, 1);
						$("#products").val(products);
					}
				}
			}
			
			var data = {seq_bsk: bskNo, count: resultValue, seq_sle: sleNo, size_nm: size};
			
			$.ajax({
				url: '/front/basket/changeBaket.web',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					if (res) {
						if (type == 'd') {	// 삭제
							$(t).parents("tr").remove();
						} else {			// 수량 변경
							var orig_price = $(t).parents("td").siblings("td").eq(0).find(".origPrice").val();
							var orig_dct = $(t).parents("td").siblings("td").eq(0).find(".discount").val();
							var totalCnt = $(t).parents("td").siblings("td").eq(0).find(".totalCnt");
							totalCnt.val(chgValue);
							
							var totalPriceText	= Number(orig_price) * totalCnt.val();
							var resultPriceText	= (Number(orig_price) - Number(orig_price) * Number(orig_dct) / 100) * totalCnt.val();
							
							$(t).parents("td").siblings("td.product__cart__item").find("span.price_cost").text(addComma(totalPriceText.toString()));
							$(t).parents("td").siblings("td.cart__price").text(addComma(resultPriceText.toString()) + "원");
							
						}
						
						var tr = $("table tbody tr");
						var _total = 0;
						var _discount = 0;
						var _count = 0;
						for(var loop = 0; loop < tr.length; loop++) {
							var td = tr.eq(loop).find("td:first-child");
							var checked = td.find("input[type=checkbox]").prop("checked");
							
							// 체크된 항목인지
							if (checked) {
								var p = td.find(".origPrice").val();
								var d = td.find(".discount").val();
								var c = td.find(".totalCnt").val();
								
								_total += p * c;
								_discount += (p * d / 100) * c;
								_count += Number(c);
							}
						}
						total = _total;
						count = _count;
						discount = _discount;
						result = _total - _discount;
						
						$("#buy_count").val(count);
						$("#buy_price").val(result);

						result = addComma(result);
						total = addComma(total);
						discount = addComma(discount);
						
						$(".totalPrice").text(total);
						$("span.discount").text("-" +discount);
						$(".resultPrice").text(result);
						
						
					} else {
						alert("실패");
					}
				}
			})
		}
		
		function goOrder() {
			if ($("input[name^=chk_]:checked").length < 1) {
				alert("구매할 상품을 하나 이상 선택해주세요!");
				return;
			}
			
			$("#frmMain").attr("action", "/front/basket/writeProc.web");
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

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4 style="margin-bottom:0;">장바구니</h4>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shopping Cart Section Begin -->
	<section class="shopping-cart spad"  ondragstart="return false">
		<div class="container">
			<form name="frmMain" id="frmMain" method="post">
				<input type="hidden" name="products" id="products">
				<input type="hidden" name="buy_count" id="buy_count">
				<input type="hidden" name="buy_price" id="buy_price">
			</form>
			<div class="row" style="display:unset;">
				<div class="col-lg-8" style="padding:0">
					<div class="shopping__cart__table">
						<table>
							<thead class="pcTd">
								<tr>
									<th><input type="checkbox" name="chkAll" id="chkAll" onClick="chkBasket('all', this)" checked></th>
									<th style="width:130px;">이미지</th>
									<th>상품</th>
									<th>사이즈</th>
									<th>수량</th>
									<th>가격</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="5">장바구니 리스트가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="list">
										<c:set var="i" value="${i+1}" />
										<tr>
											<td>
												<input type="checkbox" name="chk_${list.seq_bsk}" id="chk_${list.seq_bsk}" value="${list.seq_bsk}" onClick="chkBasket('', this)" checked>
												<input type="hidden" name="origPrice_${i-1}" id="origPrice_${i-1}" class="origPrice" value="${list.price}">
												<input type="hidden" name="discount_${i-1}" id="discount_${i-1}" class="discount" value="${list.discount}">
												<input type="hidden" name="totalCnt_${i-1}" id="totalCnt_${i-1}" class="totalCnt" value="${list.count}">
											</td>
											<td>
												<div class="product__cart__item__pic">
													<img src="${list.img}" alt="">
												</div>
											</td>
											<td class="product__cart__item pcTd">
												<div class="product__cart__item__text">
													<h6>${list.sle_nm}</h6>
													<c:if test="${list.discount > 0}">
														<p>
															<span class="price_cost"><fmt:formatNumber value="${list.price * list.count}" type="number" /></span>
															<span class="red">${list.discount}%</span>
														</p>
													</c:if>
												</div>
											</td>
											<td class="pcTd">${fn:split(list.size_name,'/')[list.size_nm]}</td>
											<td class="quantity__item pcTd">
												<div class="quantity">
													<div class="changeCnt">
														<span class="minusCnt fa" onClick="changeCnt(${list.seq_bsk}, 'm', this, ${list.seq_sle}, '${list.size_nm}')"<c:if test="${list.count <= 1}"> style="color:#eee"</c:if>></span>
														<input type="text" value="${list.count}">
														<span class="plusCnt fa" onClick="changeCnt(${list.seq_bsk}, 'p', this, ${list.seq_sle}, '${list.size_nm}')"></span>
													</div>
												</div>
											</td>
											<td class="cart__price pcTd">
												<fmt:formatNumber value="${(list.price - list.price * list.discount / 100) * list.count}" type="number" />원
											</td>
											
											<td class="product__cart__item moTd">
												<div class="product__cart__item__text">
													<h6 style="margin:0;">${list.sle_nm}</h6>
													<p style="margin:0;">${fn:split(list.size_name,'/')[list.size_nm]}</p>
													<p style="margin:0;">
														<c:if test="${list.discount > 0}">
															<span class="price_cost"><fmt:formatNumber value="${list.price * list.count}" type="number" /></span>
															<span class="red">${list.discount}%</span>
														</c:if>
														<span style="font-weight:bold;"><fmt:formatNumber value="${(list.price - list.price * list.discount / 100) * list.count}" type="number" />원</span>
													</p>
												</div>
												<div class="quantity">
													<div class="changeCnt">
														<span class="minusCnt fa" onClick="changeCnt(${list.seq_bsk}, 'm', this, ${list.seq_sle}, '${list.size_nm}')"<c:if test="${list.count <= 1}"> style="color:#eee"</c:if>></span>
														<input type="text" value="${list.count}">
														<span class="plusCnt fa" onClick="changeCnt(${list.seq_bsk}, 'p', this, ${list.seq_sle}, '${list.size_nm}')"></span>
													</div>
												</div>
											</td>
											<td class="cart__close"><i class="fa fa-close" onClick="changeCnt(${list.seq_bsk}, 'd', this, ${list.seq_sle}, '${list.size_nm}')"></i></td>
										</tr>
										
								</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-lg-4" style="display:flex;width:100%;justify-content:end;margin-top:50px;padding:0">
					<div class="cart__total">
						<h6>결제 금액</h6>
						<ul>
							<li>총 상품 금액 <span class="totalPrice"></span></li>
							<li>총 할인 금액 <span class="discount"></span></li>
							<li><b>총 결제 금액 <span class="resultPrice"></span></b></li>
						</ul>
						<input type="button" class="primary-btn" value="구매" onClick="goOrder()" style="width:100%;">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shopping Cart Section End -->

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