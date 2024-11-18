<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/faq/list.jsp" %>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<style>
		table {
			caret-color: transparent; 
		}
		
		input[type=button] {display:block;width:120px;height:50px;margin:20px auto 0;line-height:50px;background:#007bff;color:white;border-radius:10px;border:none;}
	
		#modifyBtn {display:block;width:50px;height:30px;margin:5px auto 0;line-height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
	</style>
	<script>
		function goPage(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = value;
			
			frmMain.action="/seller/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goModify(value){
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_sle").value = value;
			
			frmMain.action="/seller/sale/modify.web";
			frmMain.submit();
			
		}
		
		function goStateList(value){
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("cd_state_sale").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/seller/sale/list.web";
			frmMain.submit();
			
		}
		
		function goSortList(value){
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("sale_sort").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/seller/sale/list.web";
			frmMain.submit();
			
		}
		
		function goSearchList(){
			
			var frmMain = document.getElementById("frmMain");
			
			frmMain.action="/seller/sale/list.web";
			frmMain.submit();
			
		}
		
		function goLinePerPage(value){
			
			var frmMain = document.getElementById("frmMain");
			document.getElementById("currentPage").value = "1";
			document.getElementById("linePerPage").value = "";
			document.getElementById("linePerPage").value = value;
			
			frmMain.action="/seller/sale/list.web";
			frmMain.submit();
			
		}
	</script>
</head>

<body>
<form id="frmMain" method="POST">
<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
<input type="hidden" name="linePerPage" id="linePerPage"	value="${paging.linePerPage}" />
<input type="hidden" name="seq_sle" 	id="seq_sle"/>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/seller/top.jsp" %>
		<section class="breadcrumb-option">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="breadcrumb__text">
							<h4>상품관리</h4>
							<div class="breadcrumb__links">
								<a href="/seller/mypage/">마이페이지</a><span>상품관리</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>
	<!-- Header Section End -->
	
	<!-- Shopping Cart Section Begin -->
	<section class="shopping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shop__product__option__right" style="margin-bottom: 20px;">
						<span style="font-size: 15px; font-weight: bold; position:absolute; left:25px;">전체 ${paging.totalLine}개</span>
						<select id="itemsPerPage" name="itemsPerPage" onchange="goLinePerPage(this.value);">
							<option value="10" <c:if test="${paging.linePerPage == 10}"> selected</c:if>>10개씩 보기</option>
							<option value="20" <c:if test="${paging.linePerPage == 20}"> selected</c:if>>20개씩 보기</option>
							<option value="50" <c:if test="${paging.linePerPage == 50}"> selected</c:if>>50개씩 보기</option>
							<option value="100" <c:if test="${paging.linePerPage == 100}"> selected</c:if>>100개씩 보기</option>
						</select>
						<select id="cd_state_sale" name="cd_state_sale" onchange="goStateList(this.value);" >
							<option value="1"<c:if test="${paging.cd_state_sale == 1}"> selected</c:if>>판매중</option>
							<option value="2"<c:if test="${paging.cd_state_sale == 2}"> selected</c:if>>품절</option>
							<option value="3"<c:if test="${paging.cd_state_sale == 3}"> selected</c:if>>판매중지</option>
							<option value="9"<c:if test="${paging.cd_state_sale == 9}"> selected</c:if>>반려</option>
						</select>
						<select id="sale_sort" name="sale_sort" onchange="goSortList(this.value);" >
							<option value="new"<c:if test="${paging.sale_sort == 'new'}"> selected</c:if>>구매많은순</option>
							<option value="review"<c:if test="${paging.sale_sort == 'review'}"> selected</c:if>>리뷰많은순</option>
							<option value="heart"<c:if test="${paging.sale_sort == 'heart'}"> selected</c:if>>찜많은순</option>
						</select>
							<input type="text" name="searchWord" id="searchWord" value="${paging.searchWord}" style="border: none; border-bottom: 2px solid black; outline: none;">
							<a href="javascript:goSearchList()" class="search-switch">
								<img src="/img/icon/search.png" alt="" style="position: absolute; right: 15px;">
							</a>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<table>
							<thead>
								<tr>
									<th style="width: 10%; text-align: center;">NO</th>
									<th style="width: 40%; text-align: center;">상품명</th>
									<th style="width: 10%; text-align: center;">카테고리</th>
									<th style="width: 10%; text-align: center;">원가(할인율)</th>
<!-- 									<th style="width: 10%; text-align: center;">재고</th> -->
									<th style="width: 10%; text-align: center;">상태</th>
									<th style="text-align: center;">판매시작일</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="8" style="text-align: center;">등록된 상품이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
									<c:forEach items="${list}" var="list">
										<tr>
											<td style="text-align: center;">${list.rnum}</td>
											<td class="product__cart__item">
												<div class="product__cart__item__pic" >
													<img src="<c:if test="${list.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(list.img, '\\', '/')}" alt="" style="width: 90px; height: 90px;">
												</div>
												<div class="product__cart__item__text">
													<h6 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.sle_nm}</h6>
												</div>
											</td>
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '11'}">아우터</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '12'}">재킷/베스트</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '13'}">상의</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '14'}">하의</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '15'}">원피스</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '16'}">패션잡화</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '21'}">아우터</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '22'}">재킷/베스트</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '23'}">상의</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '24'}">하의</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_ctg == '26'}">패션잡화</c:if></h6>
												</div>
											</td>
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													<h6 style="text-align: center;"><fmt:formatNumber value="${list.price_cost}" type="number" />원<br>(${list.discount}%)</h6>
												</div>
											</td>
<!-- 											 <td class="product__cart__item"> -->
<!-- 												<div class="product__cart__item__text"> -->
<!-- 													<h6 style="text-align: center;">재고</h6> -->
<!-- 												</div> -->
<!-- 											</td> -->
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													<h6 style="text-align: center;"><c:if test="${list.cd_state_sale == '1'}">판매중</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_state_sale == '2'}">품절</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_state_sale == '3'}">판매중지</c:if></h6>
													<h6 style="text-align: center;"><c:if test="${list.cd_state_sale == '9'}">반려</c:if></h6>
												</div>
											</td>
											<td class="product__cart__item">
												<div class="product__cart__item__text">
													<h6 style="text-align: center;">${list.dt_sale_start}</h6>
												</div>
											</td>
											<td><input type="button" id="modifyBtn" onclick="javascript:goModify(${list.seq_sle});" value="수정"></td>
										</tr>
									</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
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
						<input type="button" onclick="location.href='/seller/sale/write.web';" value="상품 등록">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Shopping Cart Section End -->
			
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</form>	
</body>
</html>