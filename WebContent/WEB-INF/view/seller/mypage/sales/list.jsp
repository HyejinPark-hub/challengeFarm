<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/seller/mypage/sales/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/seller/header.jsp"%>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
	
	<style>
		.sales .col-lg-3 {width:45%;}
		tr {text-align:center;}
		td.sle_nm {text-align:left;}
		.shopping__cart__table table tbody tr td {padding:10px 0;}
		
		.nice-select {float:right;}
	</style>
	
	<script>
		function goList(value) {

			$("#currentPage").val(1);
			if (value != '') {
				$("#dt_reg").val(value + "-01 00:00:00");
			}
	
			$("#frmMain").attr("action","/seller/mypage/sales/list.web");
			$("#frmMain").submit();
		}
	
		function goPage(value) {
		
			$("#currentPage").val(value);
			$("#dt_reg").val($("#period option:selected").val() + '-01 00:00:00');
	
			$("#frmMain").attr("action","/seller/mypage/sales/list.web");
			$("#frmMain").submit();
		}	
	</script>
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
						<div class="breadcrumb__links">
							<a href="/seller/mypage/">마이페이지</a><span>매출관리</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="shop spad">
		<div class="container">
			<div class="row sales">
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<form name="frmMain" id="frmMain" method="post">
							<input type="hidden" name="currentPage" id="currentPage">
							<input type="hidden" name="dt_reg" id="dt_reg">
							<select id="period" onchange="javascript:goList(this.value);">
								<option value=""<c:if test="${sMonth == ''}">selected</c:if>>전체</option>
								<c:forEach items="${month}" var="month">
									<c:out value="month.dt_reg : ${month.dt_reg}" />
									<c:out value="list.dt_reg : ${list.get(0).getDt_reg().substring(0,7)}" />
									<option value="${month.dt_reg}"<c:if test="${month.dt_reg == sMonth}"> selected</c:if>>${month.dt_reg}</option>
								</c:forEach>
							</select>
						</form>
						<ul class="totalInfo">
							<li>
								<b>총 ${paging.totalLine}건</b>
								<p>총 <b><fmt:formatNumber value="${paging.totalPrice}" /></b>원</p>
							</li>
						</ul>
						<table>
							<thead>
								<tr>
									<th style="width:60px;">NO</th>
									<th>상품명</th>
									<th>사이즈</th>
									<th style="width:150px;">금액</th>
									<th style="width:100px;">구매자</th>
									<th style="width:150px;">구매일</th>
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
											<td>
												${list.rnum}
											</td>
											<td class="sle_nm">
												<div class="product__cart__item__text">
													${list.sle_nm}
												</div>
											</td>
											<td>
												${fn:split(list.size_nm, '/')[list.size_num]}
											</td>
											<td>
												<fmt:formatNumber value="${list.price}" />원
											</td>
											<td>
												<plutozoneUtilTag:masking text="${list.mbr_nm}" letter="*" count="1" mode="center" />
											</td>
											<td>
												${list.dt_reg}
											</td>
										</tr>
									</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row" style="text-align:center;">
				<div class="col-lg-12">
					<div class="product__pagination">
						<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>