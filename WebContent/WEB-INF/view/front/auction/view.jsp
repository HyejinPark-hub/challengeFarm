<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/auction/view.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp"%>
	
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/auction/main.css" />
	
	<style>
		.tab-content {text-align:center;}
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
		
		.product__details__pic .nav-tabs {width:230px;}
		.product__details__pic .nav-tabs .nav-item {margin-right:10px;}
		
		#bid_price {width:250px;height:45px;margin-right:10px;padding:0 10px;border:none;border-bottom:1px solid black;font-size:20px;}
		
		@media only screen and (max-width: 767px) {
			.product__details__pic .nav-tabs {width:auto;}
		}
		
		@media all and (max-width:479px) {
			#bid_price {width:calc(100% - 150px);}
			.chatArea {width:93%;}
		}
	</style>
	
	<script>
		var isLogin = false;
		
		<c:if test="${not empty sessionScope.SEQ_MBR}">
		var isLogin = true;
		</c:if>
		
		window.onload = function() {

			$("input[name=content]").keydown(function(e) {
				if (e.keyCode == 13) {
					chatProc(${auctionDto.seq_act}, ${sessionScope.SEQ_MBR});
				}
			});
		}
		
		var heartCount = ${auctionDto.heart};
	
		function goList(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = "1";
			
			frmMain.action="/front/auction/list.web";
			frmMain.target = "";
			frmMain.submit();
		}
	
		function setActiveTab(selectedLink) {
			// 모든 링크에서 active 클래스를 제거
			var links = document.querySelectorAll('.nav-link');
			links.forEach(function(link) {
				link.classList.remove('active');
			});
		
			// 클릭한 링크에 active 클래스를 추가
			selectedLink.classList.add('active');
		}
		
		// 입찰하기
		function bidProc(type){
			
			if (!isLogin) {
				alert("로그인이 필요합니다!");
				window.location.href = '/front/login/loginForm.web';
				return;
			}
			
			<c:if test="${auctionDto.seq_mbr == sessionScope.SEQ_MBR}">
			alert("본인의 경매상품에는 입찰할 수 없습니다.");
			return;
			</c:if>
			
			var bidPrice = $("#bid_price").val();
			
			if (type != 'delete' && (bidPrice == '' || bidPrice <= 0)) {
				alert("입찰가를 입력해주세요");
				return;
			}
			
			var data = {seq_mbr: $("#seq_mbr").val(), seq_act: $("#seq_act").val(), bid_price: bidPrice, process: type};
			
			$.ajax({
				url: '/front/auction/bidProc.json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					if (res) {
						if (type == 'delete') {
							alert("입찰을 포기하였습니다.")
							$("#bid_price").attr('placeholder', '');
							var buttonHtml = '<input type="button" value="입찰하기" class="primary-btn" onclick="javascript:bidProc(\'rebid\');">';
						} else {
							if (type != 'update') {
								alert("입찰이 완료되었습니다.");
								$("#bid_price").attr('placeholder', '내 입찰가 : ' + bidPrice);
							}
							else {
								alert("입찰가를 수정하였습니다.");
								$("#bid_price").attr('placeholder', '내 입찰가 : ' + bidPrice);
							}
							var buttonHtml = '<input type="button" value="입찰가 수정" class="primary-btn" style="margin-right:5px" onclick="javascript:bidProc(\'update\');">' +
											 '<input type="button" value="입찰 포기" class="primary-btn" onclick="javascript:bidProc(\'delete\');">';
						}
						$("#bid_price").val('');
						$("#frmBid input[type=button]").remove();
						$("#frmBid").append(buttonHtml);
					} else {
						alert("입찰 실패!!\n관리자에게 문의하세요");
					}
				}
			})
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
		
		function setChat(act, mbr) {
			
			$(".tab-content #tabs-8").removeClass("active");
			$(".tab-content #tabs-7").addClass("active");
			
			var data = {seq_act: act, register: mbr, content: $("#content").val()};
			var reg = "";
			
			$.ajax({
				url: '/front/auction/chatForm.json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					var li = "";
					$.each(res, function(index, item) {
						// 판매자 채팅 오른쪽, 입찰자 채팅 왼쪽
						if (${auctionDto.register} == item.register) {
							li += "<li class='myChat'><p>" + item.content + "</p></li>";
						} else {
							li += "<li><p>" + item.content + "</p></li>";
						}
						reg = item.dt_reg;
					});
					$(".chatView > ul").html(li);
					
					setTimeout(function() {
						$(".chatView > ul").scrollTop($(".chatView > ul")[0].scrollHeight - 430);
					}, 0);
				}
			})
			
			setInterval(function(){
				var data = {seq_act: ${auctionDto.seq_act}, dt_reg: reg};
				
				$.ajax({
					url: '/front/auction/chatInterval.json',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function(res) {
						if (res != '') {
							
							var li = "";
							var liHeight = 0;
							$.each(res, function(index, item) {
								// 판매자 채팅 오른쪽, 입찰자 채팅 왼쪽
								if (${auctionDto.register} == item.register) {
									li += "<li class='myChat'><p>" + item.content + "</p></li>";
								} else {
									li += "<li><p>" + item.content + "</p></li>";
								}
								reg = item.dt_reg;
								liHeight += 39;
							});
							$(".chatView > ul").append(li);
							
							setTimeout(function() {
								$(".chatView > ul").scrollTop($(".chatView > ul")[0].scrollHeight - 430);
							}, 0);
						}
					}
				})
			}, 1000);
		}
		
		function chatProc(act, mbr) {
			console.log(mbr);
			if ($("#content").val() == '') {
				alert("글을 입력해주세요!");
				return false;
			}
			
			var data = {seq_act: act, register: mbr, content: $("#content").val()};
			
			$.ajax({
				url: '/front/auction/chatProc.json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(res) {
					if (res) {
						$("#content").val('');
					} else {
						alert("채팅 등록 실패!!\n관리자에게 문의하세요");
					}
				}
			})
		}
		
	</script>
</head>
<body>
	<header>
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<form id="frmMain" method="post">
		<input type="hidden" id="cd_ctg" name="cd_ctg" />
		<input type="hidden" id="currentPage" name="currentPage" />
	</form>

	<section class="shop-details">
		<div class="product__details__pic">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="product__details__breadcrumb">
							<a href="/index.jsp">메인</a>
							<a href="/front/auction/list.web">경매</a>
							경매 상세정보
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-3 col-md-3">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="tab" href="#tabs-0" role="tab">
									<span class="product__thumb__pic set-bg" data-setbg="/img/auction/${fn:replace(auctionDto.img, '\\', '/')}"></span>
								</a>
							</li>
							<c:forEach items="${auctionImgDto}" var="imgList" varStatus="status">
								<li class="nav-item">
									<a class="nav-link" data-toggle="tab" href="#tabs-${status.index + 1}" role="tab">
										<span class="product__thumb__pic set-bg" data-setbg="/img/auction/${fn:replace(imgList.img, '\\', '/')}"></span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="col-lg-6 col-md-9">
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-0" role="tabpanel">
								<div class="product__details__pic__item">
									<img src="/img/auction/${auctionDto.img}" alt="">
								</div>
							</div>
							<c:forEach items="${auctionImgDto}" var="imgList2" varStatus="status">
								<div class="tab-pane" id="tabs-${status.index + 1}" role="tabpanel">
									<div class="product__details__pic__item">
										<img src="/img/auction/${fn:replace(imgList2.img, '\\', '/')}" alt="">
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
							<h4 >${auctionDto.act_nm}</h4>
							<div class="product__details__btns__option<c:if test="${auctionDto.flg_cancel != 'N'}"> emptyHeart</c:if>" style="display:inline-block;margin-bottom: 10px;padding:0 10px;cursor:pointer;" onclick="javascript:heartProc('${sessionScope.SEQ_MBR}', '${auctionDto.seq_act}', this)">
								<c:if test="${auctionDto.flg_cancel != 'N'}"><img src="/img/icon/heart_empty.png" style="margin-right:5px;"></c:if>
								<c:if test="${auctionDto.flg_cancel == 'N'}"><img src="/img/icon/heart.png" style="margin-right:5px;"></c:if>
								<span>${auctionDto.heart}</span>
							</div>
							<h3>
								<span style="color: black; text-decoration: none;"> 
									기본가 : <fmt:formatNumber value="${auctionDto.price}" pattern="#,###" />원
								</span>
							</h3>
							<p>${auctionDto.desces}</p>
						</div>
						<div class="product__details__cart__option" style="text-align:center">
							<form id="frmBid" method="post">
								<input type="hidden" name="seq_mbr" id="seq_mbr" value="${sessionScope.SEQ_MBR}">
								<input type="hidden" name="seq_act" id="seq_act" value="${auctionDto.seq_act}">
								
								<c:choose>
									<c:when test="${auctionDto.bid_price > 0}">
										<c:if test="${auctionDto.flg_giveup == 'Y'}">
											<input type="text" name="bid_price" id="bid_price" placeholder="입찰가를 입력해주세요" autocomplete="off">
											<input type="button" value="입찰하기" class="primary-btn" onclick="javascript:bidProc('rebid');">
										</c:if>
										<c:if test="${auctionDto.flg_giveup != 'Y'}">
											<input type="text" name="bid_price" id="bid_price" placeholder="내 입찰가 : ${auctionDto.bid_price}" autocomplete="off">
											<input type="button" value="입찰가 수정" class="primary-btn" onclick="javascript:bidProc('update');">
											<input type="button" value="입찰 포기" class="primary-btn" onclick="javascript:bidProc('delete');">
										</c:if>
									</c:when>
									<c:otherwise>
										<input type="text" name="bid_price" id="bid_price" placeholder="입찰가를 입력해주세요" autocomplete="off">
										<input type="button" value="입찰하기" class="primary-btn" onclick="javascript:bidProc('insert');">
									</c:otherwise>
								</c:choose>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="product__details__tab">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" data-toggle="tab" href="#tabs-8" role="tab">상품정보</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="chatting" onclick="javascript:setChat(${auctionDto.seq_act}, ${sessionScope.SEQ_MBR});" data-toggle="tab" href="#tabs-7" role="tab">채팅</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-8" role="tabpanel">
								<div class="product__details__tab__content">
									<c:forEach items="${auctionImgDto}" var="list">
										<h5><img src="/img/auction/${fn:replace(list.img, '\\', '/')}" alt="사진 없어" /></h5>
									</c:forEach>
								</div>
							</div>
							<div class="tab-pane" id="tabs-7" role="tabpanel">
								<div class="product__details__tab__content">
									<div class="chatArea">
										<div class="chatView">
											<ul></ul>
										</div>
										<div class="chatText">
											<input type="text" name="content" id="content" autocomplete="off">
											<input type="button" value="입력" onclick="javascript:chatProc(${auctionDto.seq_act}, ${sessionScope.SEQ_MBR});">
										</div>
									</div>
									<p>* 판매자 채팅은 오른쪽 입찰자 채팅은 왼쪽에 보여집니다. 비속어 사용 적발시 탈퇴처리됩니다.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp" %>
	</footer>

</body>
</html>