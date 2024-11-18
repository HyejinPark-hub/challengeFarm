<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/basket/writeProc.jsp" %>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<script type="text/javascript" src="/js/uranus/front.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/basket/main.css" />
	<script src="https://standard.testpayup.co.kr/assets/js/payup_standard_dev-1.0.js"></script>

	<style>
		.moTable {display:none;}
		@media all and (max-width: 479px) {
			.pcTable {display:none}
			.moTable {display:table;}
			.spad {padding-bottom:0;}
		
			.col-lg-8 {padding:0;}
			
			.product__cart__item__pic {width:auto;}
			
			.dlvTable p {margin-bottom:0;} 
			.dlvTable > div {display:block;}
			.dlvTable input, .dlvTable textarea {width:100%;}
			.dlvTable > div > div {width:100%;}
			.dlvTable #post {width:calc(100% - 155.9px);}
			.dlvTable #message {width:100%;}
			
			.payInfo ul {display:block;}
			.payInfo ul li {margin-bottom:15px;line-height:1.3em;}
			.payInfo ul li::before {top:60px;left:15px;}
		}
	</style>
	<script>
		var isLogin = false;
		
		<c:if test="${not empty sessionScope.SEQ_MBR}">
		var isLogin = true;
		</c:if>
		
		var total = 0;
		var discount = 0;
		var totalCount = 0;
		
		window.onload = function() {
			
			<c:forEach items="${list}" var="list">
				total += ${list.price} * ${list.count};
				discount += (${list.price} * ${list.discount} / 100) * ${list.count};
				totalCount += ${list.count};
			</c:forEach>
			
			console.log(total + " / " + discount);
			
			$(".totalPrice").text(addComma(total));
			$(".discount").text(addComma(discount));
			//$(".resultPrice").text(addComma(total - discount));
			
			var result = parseInt(total - discount, 10);
			$(".resultPrice").text(addComma(result));
			
			$("[name='buyList[0].totalPrice']").val(result);
			$("[name='buyList[0].totalCount']").val(totalCount);

		}
		
		function addComma(value){
			return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		// 인증 완료 시 콜백 함수(해당 함수명, 폼 아이디 등 절대 변경 금지)
		function payupPaymentSubmit(payForm) {
			
			const hiddenFields = [
				{ name: 'dlv_nm', value: $("#dlv_nm").val()},
				{ name: 'phone', value: $("#phone").val()},
				{ name: 'post', value: $("#post").val()},
				{ name: 'addr1', value: $("#addr1").val()},
				{ name: 'addr2', value: $("#addr2").val()},
				{ name: 'message', value: $("#message").val()}
			];
			for (var i = 0; i < hiddenFields.length; i++) {
				$("#PayupPaymentStandardForm").append(
					$('<input>', {
						type: 'hidden',
						name: hiddenFields[i].name,
						value: hiddenFields[i].value
					})
				);
			}
			
			var formData = $("#PayupPaymentStandardForm").serializeArray();

			var dataObject = {};
			$.each(formData, function(index, field) {
				dataObject[field.name] = field.value;
			});
			
			$.ajax({
				url: '/front/interface/payup/pay.json',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(dataObject),
				success: function(responseObject) {
					
					if (responseObject.responseCode != "0000") {
						alert("[" + responseObject.responseCode + "]" + responseObject.responseMsg);
					}
					else {
						alert(responseObject.responseMsg);
						location.href="/front/mypage/buyList.web";
					}
					
				},
				error: function(error) {
					alert("연동 에러");
				}
			});
		}
		
		function order(){
			
			if (!isLogin) {
				alert("로그인이 필요합니다!");
				return;
			}

			$.ajax({
				url: '/front/interface/payup/order.json',
				type: 'POST',
				dataType: "json",
				data: $("#frmMain").serialize(),
				success: function(responseObject) {
					
					if (responseObject.responseCode != "0000") {
						alert(responseObject.responseMsg + "[" + responseObject.responseCode + "]");
						location.href="/";
					}
					else {
						var data = {
							merchantId: responseObject.merchantId,
							itemName: responseObject.itemName,
							amount: responseObject.amount,
							userName: responseObject.userName,
							orderNumber: responseObject.orderNumber,
							returnUrl: responseObject.returnUrl
						};
						// 표준결제창 SDK 실행
						goPayupPay(data);
					}
				},
				error: function(error) {
					alert("연동 에러");
				}
			});
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
						<h4 style="margin-bottom:0;">주문/결제</h4>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shopping Cart Section Begin -->
	<section class="shopping-cart spad"  ondragstart="return false">
		<div class="container">
			<div class="row" style="display:unset;">
				<form name="frmMain" id="frmMain" method="post">
					<div class="col-lg-8">
						<div class="shopping__cart__table">
							<p class="orderTitle">주문상품 정보</p>
							<table class="orderTable pcTable">
								<thead>
									<tr>
										<th colspan="2">상품정보</th>
										<th>사이즈</th>
										<th>수량</th>
										<th>상품금액</th>
										<th>할인</th>
										<th>합계금액</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list}" var="list">
										<c:set var="i" value="${i+1}" />
										<tr>
											<td>
												<div class="product__cart__item__pic">
													<img src="${list.img}" alt="">
													<input type="hidden" name="buyList[${i-1}].seq_sle" value="${list.seq_sle}">
													<input type="hidden" name="buyList[${i-1}].sle_nm" value="${list.sle_nm}">
													<input type="hidden" name="buyList[${i-1}].count" value="${list.count}">
													<input type="hidden" name="buyList[${i-1}].size_nm" value="${list.size_nm}">
													<input type="hidden" name="buyList[${i-1}].price" value="${list.price}">
													<input type="hidden" name="buyList[${i-1}].discount" value="${list.discount}">
													<input type="hidden" name="buyList[0].totalPrice" value="">
													<input type="hidden" name="buyList[0].totalCount" value="">
												</div>
											</td>
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													${list.sle_nm}
												</div>
											</td>
											<td>
												${fn:split(list.size_name,'/')[list.size_nm]}
											</td>
											<td>
												${list.count}
											</td>
											<td>
												<fmt:formatNumber value="${list.price}" type="number" />원
											</td>
											<td>
												<c:if test="${list.discount > 0}">
													${list.discount}%
												</c:if>
											</td>
											<td>
												<fmt:formatNumber value="${(list.price - list.price * list.discount / 100) * list.count}" type="number" />원
											</td>
										</tr>
								</c:forEach>
								</tbody>
							</table>
							
							<table class="orderTable moTable">
								<thead>
									<tr>
										<th colspan="2">상품정보</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list}" var="list">
										<c:set var="i" value="${i+1}" />
										<tr>
											<td>
												<div class="product__cart__item__pic" style="display:flex;justify-content:space-between;">
													<div style="width:100px;">
														<img src="${list.img}" alt="">
													</div>
													<div style="width:calc(100% - 100px);text-align:left;">
														<p style="margin-bottom:0">${list.sle_nm}</p>
														<p style="margin-bottom:0"><span>사이즈 : ${fn:split(list.size_name,'/')[list.size_nm]}</span></p>
														<p style="margin-bottom:0"><span>수량 : ${list.count}</span></p>
														<p style="margin-bottom:0">
															<del><fmt:formatNumber value="${(list.price - list.price * list.discount / 100) * list.count}" type="number" />원</del>
															<span style="color:red;"><c:if test="${list.discount > 0}">${list.discount}%</c:if></span>
															<span style="font-weight:bold;"><fmt:formatNumber value="${list.price}" type="number" />원</span>
														</p>
													</div>
												</div>
												
											</td>
										</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
						<div>
							<p class="orderTitle">배송지 정보</p>
							<div class="dlvTable">
								<div>
									<p class="essential">이름</p>
									<input type="text" name="dlv_nm" id="dlv_nm" value="${memberDto.mbr_nm}">
								</div>
								<div>
									<p class="essential">연락처</p>
									<input type="text" name="phone" id="phone" value="${memberDto.phone}">
								</div>
								<div>
									<p class="essential">배송주소</p>
									<div>
										<input type="text" maxlength="5" id="post" name="post" value="${memberDto.post}" required readonly />
										<input type="button" value="우편번호 찾기" onClick="execDaumPostcode();" /><br />
										<input type="text" size="40" required id="addr1" name="addr1" value="${memberDto.addr1}" readonly placeholder="도로명 주소" />
										<input type="hidden" id="jibunAdd" />
										<input type="hidden" id="exliaAddress" />
										<span id="guide" style="color:#999; display:none"></span>
										<input type="text" placeholder="상세 주소" required id="addr2" name="addr2" value="${memberDto.addr2}" />
									</div>
								</div>
								<div>
									<p>배송 메시지</p>
									<textarea name="message" id="message" maxlength="50" placeholder="최대 50자 입력"></textarea>
								</div>
							</div>
						</div>
						<div class="payInfo">
							<p class="orderTitle">결제 정보</p>
							<div class="cart__total">
								<ul>
									<li>
										<em class="totalPrice"></em>원<br><i>총 상품 금액</i>
									</li>
									<li>
										<em class="discount"></em>원<br><i>총 할인 금액</i>
									</li>
									<li>
										<em class="resultPrice"></em>원<br><i>총 결제 금액</i>
									</li>
								</ul>
								<input type="button" class="primary-btn" value="결제하기" onClick="order()">
							</div>
						</div>
					</div>
				</form>
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