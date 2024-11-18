<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/buy/view.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"					uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp"%>
	<style>
		.size-option {
			display: inline-block;
			padding: 10px 15px;
			margin: 5px;
			border: 1px solid #ccc;
			border-radius: 5px;
			cursor: pointer;
			transition: background-color 0.3s;
		}
		.size-option.selected {
			background-color: #007BFF;
			color: white;
			border-color: #0056b3;
		}
		.shopping__cart__table {
			margin-top: -35px;
		}
		.shopping__cart__table table tbody tr td {
			padding-bottom: 21px;
			padding-top: 0px;
		}
		.reviewContent {
			overflow: hidden;
			text-overflow: ellipsis;
			display: -webkit-box;
			-webkit-line-clamp: 5; /*5줄*/
			-webkit-box-orient: vertical;
		}
		.checked {
			color: #FF3D25;
		}
		.thumbnail {
			width: 70px; 
			height: auto; 
			margin-right: 20px; 
			cursor: pointer;
		}
		.large-image-container {
			display: none;
			margin-top: 20px;
			text-align: center;
		}
		.large-image-container img {
			width: 80%;
			max-width: 600px;
		}
		
		#sizeTable {margin:50px auto;text-align:center;font-size:18px;}
		#sizeTable th, #sizeTable td {padding:10px 25px;border:1px solid #e7e7e7;}
		#sizeTable td {font-size:16px;}
		
		#btnMoreBtn {
			display:inline-block;
			width:300px;
			height:50px;
			line-height:50px;
			border-radius:10px;
			background:#007bff;color:white;border:none;
		}
	</style>
	<script>
		
		var isLogin = false;
		
		<c:if test="${not empty sessionScope.SEQ_MBR}">
		var isLogin = true;
		</c:if>
	
		var heartCount = ${buyDto.heart};
		
		var currentPage = 1;
		
		window.onload = function() {
			var sizeNm = "${buyDto.size_nm}";			// S/M
			var eachNm = sizeNm.split("/");				// eachNm[0]: S, eachNm[1]: M
			var sizeValue = "${buyDto.size_detail}";	// 총장/100&팔길이/80,총장/105&팔길이/82
			var eachSize = sizeValue.split(",");		// eachSize[0]: 총장/100&팔길이/80, eachSize[1]: 총장/105&팔길이/82
			var sizeTable = "";
			
			
			var table = $("#sizeTable");
			
			for (var nmLoop = 0; nmLoop < eachNm.length; nmLoop++) {
				$("#sizeTable thead tr").append("<th>" + eachNm[nmLoop] + "</th>");
			}
			
			var th = [];
			var td = {};
			
			for (var loop = 0; loop < eachSize[0].split('&').length; loop++) {
				eval("td.test" + loop + " = []");
			}
			
			for (var loop = 0; loop < eachSize.length; loop++) {
				var eachValue = eachSize[loop].split('&');
				
				th.push(eachValue[loop].split('/')[0]);
				
				for (var loop2 = 0; loop2 < eachValue.length; loop2++) {
					eval("td.test" + loop2).push(eachValue[loop2].split('/')[1]);
				}
			}
			
			var tableHtml = "<tbody>";
			for (var loop = 0; loop < th.length; loop++) {
				tableHtml += "<tr><th>" + th[loop] + "</th>";
				
				for (var loop2 = 0; loop2 < eachNm.length; loop2++) {
					tableHtml += "<td>" + eval("td.test" + loop)[loop2] + "</td>";
				}
				tableHtml += "</tr></tbody>";
			}
			
			$("#sizeTable").append(tableHtml);
		}
		
		function goList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("cd_ctg").value = value;
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/sale/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
	
		function writeProc(){
			
			if (!isLogin) {
				alert("로그인이 필요합니다!");
				window.location.href = '/front/login/loginForm.web';
				return;
			}
			
			if($("#size_nm").val() == ""){
				alert("사이즈를 선택해주세요!");
				return;
			}
			
			$("input[name=size_nm]").val($("#size_nm").val());
			
			$frm = $("#frmMain");
			
			$frm.attr("action", "/front/buy/writeProc.web");
			$frm.submit();
		}
		
		function setBasket() {
			
			if (!isLogin) {
				alert("로그인이 필요합니다!");
				window.location.href = '/front/login/loginForm.web';
				return;
			}
			
			if($("#size_nm").val() == ""){	
				alert("사이즈를 선택해주세요!");
				return;
			}
			if($("#count").val() == 0){	
				alert("수량을 하나 이상 선택해주세요!");
				return;
			}
			
			$("#img").val($("#tabs-0 img").attr("src"));
			var data = {seq_sle: $("#seq_sle").val(), sle_nm: $("#sle_nm").val(), size_nm: $("#size_nm").val(), count: $("#count").val(), price: $("#price").val(), img: $("#img").val()};
			
			$.ajax({
				url: '/front/basket/setBasket.web',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					if (res) {
						if(confirm("장바구니로 이동하시겠습니까?")) {
							location.href = "/front/basket/index.web";
						}
					} else {
						alert("장바구니 실패");
					}
				}
			})
		}
		
		function showImage(img, currentPage, index) {
			
			var largeImageContainer = document.getElementById("largeImageContainer_"+currentPage+"_"+index);
			var largeImage = document.getElementById("largeImage_"+currentPage+"_"+index);

			if(largeImageContainer.style.display == "block") {
				largeImageContainer.style.display = "none";
			} else {
				largeImage.src = img.src;
				largeImageContainer.style.display = "block";
			}
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
							heartCount += 1;
							alert("해당 상품을 찜하였습니다");
							$(t).addClass("fullHeart").removeClass("emptyHeart");
							$(t).find("span").text(heartCount);
							$(t).find("img").attr("src", "/img/icon/heart.png");
						} else {
							heartCount -= 1;
							alert("해당 상품을 찜 해제하였습니다");
							$(t).addClass("emptyHeart").removeClass("fullHeart");
							$(t).find("span").text(heartCount);
							$(t).find("img").attr("src", "/img/icon/heart_empty.png");
						}
					} else {
						alert("찜 실패!!\n관리자에게 문의하세요");
					}
				}
			})
		}
		
		function moreReviews() {
			
			currentPage = currentPage + 1;
			
			var data = {currentPage: currentPage, linePerPage: $("#linePerPage").val(), seq_sle: $("#seq_sle").val()};

			$.ajax({
				url: '/front/buy/reviewList.json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(response) {
					
					$.each(response.list, function(index, item) {
						$(".reviewList").append(
							"<ul>" +
								"<li>" +
									"<div class='col-lg-6' style='margin-bottom: 10px;'>" +
										"<h6>" + item.email + "</h6>" +
									"</div>" +
								"</li>" +
								"<li>" +
									"<div class='col-lg-6' style='display: flex; justify-content: space-between; gap: 20px; flex-wrap: wrap; margin-bottom: 15px;'>" +
										"<p style='font-size:15px; color:gray;'>색상: " + item.color + " | 사이즈: " + item.size_name.split('/')[item.size_nm] + " | 개수: " + item.count + "</p>" +
										"<div class='stars' id='star-rating' style='color:gray;'>" +
											Array.from({ length: 5 }, (_, i) => 
												"<i class='fa fa-star " + (item.rating >= i + 1 ? "checked" : "") + "' data-value='" + (i + 1) + "'></i>"
											).join('') +
											"<span>" + item.rating.toFixed(1) + "</span>" +
										"</div>" +
										"<h6>" + item.dt_reg + "</h6>" +
									"</div>" +
								"</li>" +
								"<li>" +
									"<div class='col-lg-12' style='display: flex;'>" +
										"<img src='/img/front/" + item.img.replace(/\\/g, '/') + "' class='thumbnail' onclick='showImage(this, " + currentPage + ", " + index + ")'>" +
										"<div class='reviewContent'>" +
											"<h6>" + item.content + "</h6>" +
										"</div>" +
									"</div>" +
									"<div class='large-image-container' id='largeImageContainer_" + currentPage + "_" + index + "'>" +
										"<img id='largeImage_" + currentPage + "_" + index + "'>" +
									"</div>" +
								"</li>" +
							"</ul>" +
							"<hr>"
						);
					});
					
					if(currentPage == response.paging.totalPage){
						$("#btnMoreBtn").remove();
					}
				},
				error: function() {
					$(".reviewList").append("<p>데이터를 가져오는 중 오류가 발생했습니다.</p>");
				}
			})
			
		}
	</script>
</head>
<body>
<header>
	<%@ include file="/include/front/top.jsp" %>
</header>
<form id="frmBsk" method="post">
	<input type="hidden" name="seq_sle" id="seq_sle" value="${buyDto.seq_sle}">
	<input type="hidden" name="sle_nm" id="sle_nm" value="${buyDto.sle_nm}">
	<input type="hidden" name="size_nm" id="size_nm">
	<input type="hidden" name="count" id="count" value="1">
	<input type="hidden" name="img" id="img">
	<input type="hidden" name="price" id="price" value="${buyDto.price_cost}">
</form>

<form id="frmMain" method="post">
	<input type="hidden" name="linePerPage" id="linePerPage"	value="${paging.linePerPage}" />
	<input type="hidden" name="seq_sle" id="seq_sle" value="${buyDto.seq_sle}">
	<input type="hidden" name="img" id="img" value="${buyDto.img}">
	<input type="hidden" name="sle_nm" id="sle_nm" value="${buyDto.sle_nm}">
	<input type="hidden" name="size_name" id="size_name" value="${buyDto.size_nm}">
	<input type="hidden" name="size_nm" id="size_nm">
	<input type="hidden" name="count" id="count" value="1">
	<input type="hidden" name="price" id="price" value="${buyDto.price_cost}">
	<input type="hidden" name="discount" id="discount" value="${buyDto.discount}">

	<section class="shop-details">
		<div class="product__details__pic">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="product__details__breadcrumb">
							<a href="/index.jsp">메인</a>
							<a href="javascript:goList('${buyDto.cd_ctg.substring(0,1) == 1 ? '1' : '2'}')">
							<c:choose>
								<c:when test="${buyDto.cd_ctg.substring(0,1) == 1}">여성</c:when>
								<c:otherwise>남성</c:otherwise>
							</c:choose>
							</a>
							<span>
								<c:choose>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 1}">아우터</c:when>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 2}">재킷/베스트</c:when>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 3}">상의</c:when>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 4}">하의</c:when>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 5}">원피스</c:when>
									<c:when test="${buyDto.cd_ctg.substring(1,2) == 6}">패션잡화</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose>
							</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-3 col-md-3">
						<ul class="nav nav-tabs" role="tablist">
								<li class="nav-item">
									<a class="nav-link active" data-toggle="tab" href="#tabs-0" role="tab">
									<span class="product__thumb__pic set-bg" data-setbg="<c:if test="${buyDto.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(buyDto.img, '\\', '/')}"></span>
									</a>
								</li>
						<c:forEach items="${buyImgDto}" var="imgList" varStatus="status">
							<c:if test="${not status.last}">
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="#tabs-${status.index + 1}" role="tab">
											<span class="product__thumb__pic set-bg" data-setbg="<c:if test="${imgList.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(imgList.img, '\\', '/')}"></span>
									</a>
								</li>
							</c:if>
						</c:forEach>
						</ul>
					</div>
					<div class="col-lg-6 col-md-9">
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-0" role="tabpanel">
								<div class="product__details__pic__item">
									<img src="<c:if test="${buyDto.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(buyDto.img, '\\', '/')}" alt="">
								</div>
							</div>
							<c:forEach items="${buyImgDto}" var="imgList2" varStatus="status">
								<div class="tab-pane" id="tabs-${status.index + 1}" role="tabpanel">
									<div class="product__details__pic__item">
										<img src="<c:if test="${imgList2.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(imgList2.img, '\\', '/')}" alt="">
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="product__details__content">
		 	<div class="container">
				<div class="row d-flex justify-content-center">
					<div class="col-lg-8">
						<div class="product__details__text">
							<h4 >${buyDto.sle_nm} <span style ="font-size: 0.7em; color: gray"> -${buyDto.color}</span></h4>
							<div class="rating" style="margin-bottom: 0px;">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star-o"></i>
								<span> - ${buyDto.review}</span>
							</div>
							<div class="product__details__btns__option<c:if test="${buyDto.flg_cancel != 'N'}"> emptyHeart</c:if>" style="display:inline-block;margin-bottom: 10px;padding:0 10px;cursor:pointer;" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${buyDto.seq_sle}', this)">
								<c:if test="${buyDto.flg_cancel != 'N'}"><img src="/img/icon/heart_empty.png" style="margin-right:5px;"></c:if>
								<c:if test="${buyDto.flg_cancel == 'N'}"><img src="/img/icon/heart.png" style="margin-right:5px;"></c:if>
								<span>${buyDto.heart}</span>
							</div>
							<c:set var="discountedPrice" value="${buyDto.price_cost - (buyDto.price_cost * buyDto.discount / 100)}" />
							<h3>
								<c:if test="${buyDto.discount > 0}">
									<span> 
										<fmt:formatNumber value="${buyDto.price_cost}" pattern="#,###" /> 
									</span>
								</c:if>
								<c:if test="${buyDto.discount <= 0}">
									<span style="color: black; text-decoration: none;"> 
										<fmt:formatNumber value="${buyDto.price_cost}" pattern="#,###" /> 
									</span>
								</c:if>
								<c:if test="${buyDto.discount > 0}">
									<span style="color: purple; margin-left:0; text-decoration: none;"> 
										${buyDto.discount} 
									<span style="color: purple; margin-left:0; text-decoration: none; font-size: 0.8em;">%</span>
									</span>
									<br />
									<span style="color: black; margin-left:0; text-decoration: none;"> 
										<fmt:formatNumber value="${discountedPrice}" pattern="#,###" /> 
									</span>
								</c:if>
								<input type="hidden" name="buyList[0].price" value="${buyDto.price_cost}" />
							</h3>
							<c:if test="${not empty buyDto.desces}">
								<p>${buyDto.desces}</p>
							</c:if>
							
							<script>
								function selectSize(element) {
									const options = document.querySelectorAll('.size-option');
									options.forEach(option => option.classList.remove('selected'));
									element.classList.add('selected');
									
									$("#size_nm").val($(element).index() -1);
								}
							</script>
							
							<div class="product__details__option">
								<div class="product__details__option__size">
									<span>Size</span>
									<c:set var="sizes" value="${fn:split(buyDto.size_nm, '/')}" />
									<c:forEach items="${sizes}" var="size">
										<div class="size-option" onclick="selectSize(this)">
												${size.trim()} <!-- trim()을 사용해 앞뒤 공백 제거 -->
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="product__details__cart__option" style="text-align:center;">
							<div class="quantity">
								<div class="pro-qty">
									<input type="text" value="1" name="buyList[0].count" value="${buyDto.count}" >
								</div>
							</div>
							<input type="button" class="primary-btn" style="border:none;" onclick="javascript:setBasket();" value="장바구니에 담기">
							<a href="#" class="primary-btn" onclick="javascript:writeProc();">구매하기</a>
						</div>
						<div class="product__details__last__option"> 
							<ul>
								<li>
									<span>카테고리:</span>
									<c:choose>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 1}">아우터</c:when>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 2}">재킷/베스트</c:when>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 3}">상의</c:when>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 4}">하의</c:when>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 5}">원피스</c:when>
										<c:when test="${buyDto.cd_ctg.substring(1,2) == 6}">패션잡화</c:when>
										<c:otherwise>기타</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="product__details__tab">
							<ul class="nav nav-tabs" role="tablist">
								<li class="nav-item">
									<a class="nav-link active" data-toggle="tab" href="#tabs-8"role="tab">상품정보</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">사이즈&amp;핏</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">리뷰(${paging.totalLine})</a>
								</li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="tabs-8" role="tabpanel">
								<c:forEach items="${buyImgDto}" var="list">
									<div class="product__details__tab__content">
										<h5 style="text-align: center;"><img src="<c:if test="${list.img.substring(0,4) != 'http'}">/img/sale/</c:if>${fn:replace(list.img, '\\', '/')}" /></h5>
									</div>
								</c:forEach>
								</div>
								<div class="tab-pane" id="tabs-6" role="tabpanel">
									<div class="product__details__tab__content">
										<div class="product__details__tab__content__item">
											<table id="sizeTable">
												<thead>
													<tr>
														<th>사이즈</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="tabs-7" role="tabpanel">
									<div class="product__details__tab__content">
										<div class="product__details__tab__content__item">
											<div class="reviewList">
												<c:choose>
													<c:when test="${empty list}">
														<div class="">
															<h6 style="text-align:center;">등록된 리뷰가 없습니다.</h6>
														</div>
													</c:when>
													<c:otherwise>
														<c:forEach items="${list}" var="list" varStatus="status">
															<ul>
																<li>
																	<div class="col-lg-6" style="margin-bottom: 10px;">
																		<h6>${list.email}</h6>
																	</div>
																</li>
																<li>
																	<div class="col-lg-6" style="display: flex; justify-content: space-between; gap: 20px; flex-wrap:wrap; margin-bottom: 15px;">
																		<p style="font-size:15px; color:gray;">색상: ${list.color} | 사이즈: ${fn:split(list.size_name,'/')[list.size_nm]} | 개수: ${list.count} </p>
																		<div class="stars" id="star-rating" style="color:gray;">
																			<i class="fa fa-star <c:if test='${list.rating >= 1}'>checked</c:if>" data-value="1"></i>
																			<i class="fa fa-star <c:if test='${list.rating >= 2}'>checked</c:if>" data-value="2"></i>
																			<i class="fa fa-star <c:if test='${list.rating >= 3}'>checked</c:if>" data-value="3"></i>
																			<i class="fa fa-star <c:if test='${list.rating >= 4}'>checked</c:if>" data-value="4"></i>
																			<i class="fa fa-star <c:if test='${list.rating >= 5}'>checked</c:if>" data-value="5"></i>
																		<fmt:formatNumber value="${list.rating}" type="number" minFractionDigits="1" maxFractionDigits="1" />
																		</div>
																		<h6>${list.dt_reg}</h6>
																	</div>
																</li>
																<li>
																	<div class="col-lg-12" style="display: flex;">
																		<c:if test="${list.img != ''}">
																			<img src="/img/front/${fn:replace(list.img, '\\', '/')}" class="thumbnail" onclick="showImage(this, ${paging.currentPage}, ${status.index})">
																		</c:if>
																		<div class="reviewContent">
																			<h6>${list.content}</h6>
																		</div>
																	</div>
																	<div class="large-image-container" id="largeImageContainer_${paging.currentPage}_${status.index}">
																		<img id="largeImage_${paging.currentPage}_${status.index}" >
																	</div>
																</li>
															</ul>
															<hr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</div>
											<c:if test="${paging.totalPage > 1}">
												<div class="row" style="text-align: center;">
													<div class="col-lg-12">
														<input type="button" id="btnMoreBtn"value="더보기" onClick="moreReviews();"/>
													</div>
												</div>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</form>

<footer>
	<%@ include file="/include/common/footer.jsp" %>
</footer>

</body>
</html>