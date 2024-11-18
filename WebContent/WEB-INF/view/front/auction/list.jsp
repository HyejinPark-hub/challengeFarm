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
	<script src="/js/jquery-3.3.1.min.js"></script>
	
	<style></style>
	<script>

		const listSize = ${list.size()};
		
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
			
			updateTimer();
		};

		var time = {};
		var endTime = {};
		function updateTimer() {
			
			<c:forEach items="${list}" var="list" varStatus="status">
				eval("time.test" + ${status.index} + "= ${list.day_remain}");
				eval("endTime.test" + ${status.index} + "= '${list.dt_act_end}'");
			</c:forEach>
			
			for (var loop = 0; loop < listSize; loop++) {
				if (eval("time.test" + loop) <= 3) {
					const endDate = new Date(eval("endTime.test" + loop));
					const now = new Date();
					let remainingTime = endDate - now;
					
					if (remainingTime > 0 ) {
						const hours = Math.floor((remainingTime / (1000 * 60 * 60)) % 24);
						const minutes = Math.floor((remainingTime / (1000 * 60)) % 60);
						const seconds = Math.floor((remainingTime / 1000) % 60);
						
						var fullTime = String(hours).padStart(2, '0') + ':' + String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
						$("span[id^=timer_]").eq(loop).text(fullTime);
						remainingTime -= 1000; // 1초 감소
					} else {
						$("span[id^=timer_]").eq(loop).text("경매 종료");
						clearInterval(timerInterval);
					}
				}
			}
		}
		
		const timerInterval = setInterval(updateTimer, 1000);
		updateTimer();
			
		function goView(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_act").value = value;
			
			frmMain.action="/front/auction/view.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goPage(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = value;
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goPriceList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("prc_ctg").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goBuyYearList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("buy_ctg").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goActStateList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("state_ctg").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function goSuccessList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("searchWord").value = "";
			document.getElementById("scs_ctg").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		function goSortList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("sale_sort").value = value;
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
		
		function heartProc(mbr, act, t) {
			
			if (mbr == '') {
				alert('로그인이 필요한 기능입니다!');
				return;
			}
			
			if ($(t).hasClass('emptyHeart')) {
				var type = 'insert';
			} else {
				var type = 'delete';
			}
			
			var data = {seq_mbr: mbr, seq_act: act, process: type};
			
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
<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
<input type="hidden" name="seq_act"		id="seq_act" />
<input type="hidden" name="prc_ctg" 	id="prc_ctg"	/>
<input type="hidden" name="buy_ctg" 	id="buy_ctg"	/>
<input type="hidden" name="state_ctg" 	id="state_ctg"	/>
<input type="hidden" name="scs_ctg" 	id="scs_ctg"	/>
<input type="hidden" name="sale_sort"	id="sale_sort"	/>
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>경매</h4>
						<div class="breadcrumb__links">
							<a href="/index.jsp">메인</a> <span>경매</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="shop spad">
		<div class="container">
			<div class="row">
				<%@ include file="/include/front/lnbAuction.jsp"%>
				<div class="col-lg-9">
					<div class="shop__product__option">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__left">
									<span style="font-size: 15px;">${paging.totalLine}개 상품</span> 
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="shop__product__option__right">
									<p></p>
									<select onchange="goSortList(this.value);" >
										<option value="popular"<c:if test="${paging.sale_sort == 'popular'}"> selected</c:if>>인기경매순</option>
										<option value="closing"<c:if test="${paging.sale_sort == 'closing'}"> selected</c:if>>마감임박순</option>
										<option value="new"<c:if test="${paging.sale_sort == 'new'}"> selected</c:if>>신규경매순</option>
										<option value="high_price"<c:if test="${paging.sale_sort == 'high_price'}"> selected</c:if>>높은가격순</option>
										<option value="low_price"<c:if test="${paging.sale_sort == 'low_price'}"> selected</c:if>>낮은가격순</option>
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
							<c:forEach items="${list}" var="list" varStatus="status">
							 	<div class="row auctionList">
									<div class="col-lg-4 col-md-6 col-sm-6">
										<div class="product__item">
											<div class="product__item__pic set-bg" data-setbg="<c:if test="${list.img.substring(0,4) != 'http'}">/img/auction/</c:if>${fn:replace(list.img, '\\', '/')}">
												<a href="javascript:goView(${list.seq_act});" style="display:block; width:100%; height:100%;"></a>
												<ul class="product__hover">
													<li>
														<c:if test="${list.flg_cancel != 'N' || empty sessionScope.SEQ_MBR}">
															<img src="/img/icon/heart_empty.png" class="emptyHeart" alt="찜" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${list.seq_act}', this)" style="cursor:pointer">
														</c:if>
														<c:if test="${list.flg_cancel == 'N' && not empty sessionScope.SEQ_MBR}">
															<img src="/img/icon/heart.png" class="fullHeart" alt="찜" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${list.seq_act}', this)" style="cursor:pointer">
														</c:if>
													</li>
												</ul>
											</div>
											<div class="product__item__text">
												<h6 onclick="javascript:goView(${list.seq_act});" style="cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.act_nm}</h6>
												<h5 style="padding:10px 0;"><fmt:formatNumber value="${list.price}"/> 원</h5>
												<div>
													<span>입찰 ${list.bid_cnt} 회 | </span>
													<span>종료 ${list.day_remain} 일</span> <span id="timer_${status.index}" style="color:red;"> </span>
												</div>
												<input type="hidden" name="dt_act_end"	id="dt_act_end" value="${list.dt_act_end}"/> 
												<input type="hidden" name="day_remain"	id="day_remain" value="${list.day_remain}"/> 
												<span>판매자 <plutozoneUtilTag:masking text="${list.seller}" letter="*" count="1" mode="center" /></span>
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