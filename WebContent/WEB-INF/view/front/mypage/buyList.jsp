<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/mypage/buyList.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp"%>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
</head>
<script type="text/javascript" src="/js/uranus/jquery-3.7.1.min.js"></script>
<style>
	.shop__sidebar__accordion .card {
		border: none;
		border-radius: 0;
		margin-bottom: 25px;
		width: 100px;
	}
	.border-toggle {
		box-shadow: inset 0px 0px 2px rgba(0, 0, 0, 1);
		border-radius: 25px;
		border-top: 1px solid rgba(0, 0, 0, 0.01);
		overflow: visible;
		border-bottom: unset !important;
	}
	.row {
		display: flex;
		flex-wrap: nowrap;
	}
	
	input[type=button] {display:block;width:100px;height:30px;background:#007bff;color:white;border-radius:10px;border:none;}

</style>
<script>

	function buyDetailList(value, i){
		
		if ($("#content_" + i).attr("style")) {
			var data = {seq_buy_mst: value};
			
			$.ajax({
				url: '/front/mypage/buyDetailList.json',
				type: 'post',	
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(response) {
					
				$("#content_"+ i).empty();
				
					$.each(response, function(index, item) {
						
						if(index!=0){
							$("#content_"+ i).append("<hr>");	
						}
						
						$("#content_"+ i).append(
							"<div style='display: flex; align-items: flex-start; margin-top: 30px; margin-bottom: 20px;'>" +
								"<div style='margin-right: 20px;'>" +
									"<img src='" + item.img + "' style='width: 90px; height: 90px;'>" +
								"</div>" +
								"<div>" +
									"<p style='font-size:12px; line-height: 1.0;'> 구입날짜: " + item.dt_reg + "</p>" +
									"<p style='font-size:15px; line-height: 1.0; font-weight: bold;'>" + item.sle_nm + "</p>" +
									"<p style='font-size:12px; line-height: 1.0;'> 색상: " + item.color + " | 사이즈: " + item.size_name.split('/')[item.size_nm] + " | 수량: " + item.count + "</p>" +
									 "<div style='display: flex;'>" +
										"<p style='font-size:15px; font-weight: bold; margin-right: 10px;'>" + item.price.toLocaleString('ko-KR') + "원</p>" +
										"<input type='button' id='revBtn' onclick='javascript:writeReview(" + item.seq_sle + ", " + item.seq_buy_dtl + ");' value='리뷰작성'>" +
									"</div>" +
								"</div>" +
							"</div>"
						);
					});
					
					
				},
				error: function() {
					$("#content").append("<p>데이터를 가져오는 중 오류가 발생했습니다.</p>");
				}
			});
		}
		
		$("#content_"+ i).slideToggle();
		$("#content_" + i).parents("tr").toggleClass("border-toggle");
	}
	
	function writeReview(value1, value2){
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("seq_sle").value = value1;
		document.getElementById("seq_buy_dtl").value = value2;
		
		frmMain.action="/front/mypage/writeReview.web";
		frmMain.submit();
	}

	function goPage(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("currentPage").value = value;
		
		frmMain.action="/front/mypage/buyList.web";
		frmMain.submit();
	}
</script>
<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp"%>
	</header>
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>구매 상품</h4>
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
				
				<form id="frmMain" name="frmMain" method="POST" >
					<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
					<input type="hidden" name="seq_sle" 	id="seq_sle" />
					<input type="hidden" name="seq_buy_dtl" id="seq_buy_dtl" />
					
					<div class="shopping__cart__table pc">
						<table>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="4" style="text-align: center;">구매한 상품이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
								<thead>
									<tr>
										<th style="width: 10%; text-align: center;">NO</th>
										<th style="width: 55%; text-align: center;">상품명</th>
										<th style="width: 20%; text-align: center;">총금액</th>
										<th style="width: 15%; text-align: center;">구입날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list}" var="list">
										<c:set var="i" value="${i+1}" />
										<tr>
											<td style="text-align: center;">${list.rnum}</td>
											<td class="product__cart__item">
												<div class="product__cart__item__pic" >
													<img src="${list.img}" alt="" style="width: 90px; height: 90px;">
												</div>
												<div class="product__cart__item__text">
													<h6 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.buy_info}</h6>
													<p style="color:green; cursor: pointer;" onclick="buyDetailList(${list.seq_buy_mst}, ${i-1})">주문상세></p>
													<div id="content_${i-1}" style="display: none;"></div>
												</div>
											</td>
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													<h6 style="text-align: center;"><fmt:formatNumber value="${list.buy_price}" type="number" />원</h6>
												</div>
											</td>
											<td style="text-align: center;">${list.dt_reg}</td>
										</tr>
									</c:forEach>
								</tbody>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					
					<div class="shopping__cart__table mo">
						<table>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="2" style="text-align: center;">구매한 상품이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
								<thead>
									<tr>
										<th style="width: 10%; text-align: center;">NO</th>
										<th style="width: 90%; text-align: center;">상품정보</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list}" var="list">
										<c:set var="i" value="${i+1}" />
										<tr>
											<td style="text-align: center;">${list.rnum}</td>
											<td class="product__cart__item">
												<div class="product__cart__item__pic" >
													<img src="${list.img}" alt="" style="width: 90px; height: 90px;">
												</div>
												<div class="product__cart__item__text">
													<h6 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.buy_info}</h6>
													<h6><fmt:formatNumber value="${list.buy_price}" type="number" />원 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${list.dt_reg}</h6>
													<p style="color:green; cursor: pointer;" onclick="buyDetailList(${list.seq_buy_mst}, ${i-1})">주문상세></p>
													<div id="content_${i-1}" style="display: none;"></div>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								</c:otherwise>
							</c:choose>
						</table>
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
				</form>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>