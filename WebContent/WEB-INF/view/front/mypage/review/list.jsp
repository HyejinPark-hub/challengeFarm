<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/front/mypage/review/list.jsp"%>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 					uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	.sle_des {
		display: flex; 
		align-items: flex-start; 
		border-top: 1px solid #dddddd;
		border-bottom: 1px solid #eeeeee; 
		padding-top:20px;
		padding-bottom: 20px;
		padding-left:15px;
		padding-right:15px;
	}
	.sle_des p {
		margin-bottom: 5px;
	}
	.checked {
		color: #FF3D25;
	}
	.review {
		display: flex;
		flex-wrap: nowrap;
	}
	.sle_nm {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 5; /*5줄*/
		-webkit-box-orient: vertical;
		padding-left:15px;
		padding-right:15px;
	}
	.large-image-container img {
		width: 80%;
		max-width: 400px;
		padding-left:15px;
	}
	
	input[type=button] {display:block;width:100px;height:30px;margin:12px auto 0;line-height:30px;background:#007bff;color:white;border-radius:10px;border:none;}

</style>
<script>

	function goPage(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("currentPage").value = value;
		
		frmMain.action="/front/mypage/review/list.web";
		frmMain.submit();
	}
	
	function showImage(img, index) {
		
		var largeImageContainer = document.getElementById("largeImageContainer_"+index);
		var largeImage = document.getElementById("largeImage_"+index);

		if(largeImageContainer.style.display == "block") {
			largeImageContainer.style.display = "none";
		} else {
			largeImage.src = img.src;
			largeImageContainer.style.display = "block";
		}
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
						<h4>리뷰관리</h4>
						<div class="breadcrumb__links">
							<a href="/front/mypage/">마이페이지</a> <span>리뷰 관리</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
		
	<section class="shop spad">
		<div class="container">
			<div class="row review">
				<%@ include file="/include/front/lnbMyPage.jsp"%>
				
				<form id="frmMain" name="frmMain" method="POST">
					<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
					<input type="hidden" name="seq_sle" 	id="seq_sle" />
					
						<div>
							<c:choose>
								<c:when test="${empty list}">
									<h6 style="text-align: center; padding-top: 20px;">등록된 리뷰가 없습니다.</h6>
								</c:when>
								<c:otherwise>
								<c:forEach items="${list}" var="list" varStatus="status">
									<div class="review_list pc">
										<div class="sle_des">
											<div>
												<img src="${list.sle_img}" alt="" style="width: 110px; height: 110px; margin-right:10px;">
											</div>
											<div>	
												<p style="font-size:15px; color:gray;">[${list.sll_nm}]</p>
												<p style="font-size:20px;">${list.sle_nm}</p>
												<p style="font-size:15px; color:gray;">색상: ${list.color} | 사이즈: ${fn:split(list.size_name,'/')[list.size_nm]} | 개수: ${list.count} </p> 
												<div class="stars" id="star-rating" style="color:gray;">
													<i class="fa fa-star <c:if test='${list.rating >= 1}'>checked</c:if>" data-value="1"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 2}'>checked</c:if>" data-value="2"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 3}'>checked</c:if>" data-value="3"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 4}'>checked</c:if>" data-value="4"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 5}'>checked</c:if>" data-value="5"></i>
													${list.rating}
												</div> 
											</div>
										</div>
										<div class="rev_des" style="padding-top:20px;">
											
											<p class="sle_nm" style="min-height:220px;">${list.content}</p> 
										</div>
										<c:if test="${list.img != ''}">
											<div class="mainImg" style="padding-bottom:20px; padding-left:15px; padding-right:15px;">
												<div>
													<img src="/img/front/${fn:replace(list.img, '\\', '/')}" alt="" style="width: 150px; height: 150px;" onclick="showImage(this, ${status.index})">
												</div>
											</div>
											<div class="large-image-container" id="largeImageContainer_${status.index}">
												<img id="largeImage_${status.index}" >
											</div>
										</c:if>
									</div>
									
									<div class="review_list mo">
										<div class="sle_des">
											<div>	
												<p style="font-size:15px; color:gray;">[${list.sll_nm}]</p>
												<p style="font-size:18px;">${list.sle_nm}</p>
												<p style="font-size:15px; color:gray;">색상: ${list.color} | 사이즈: ${fn:split(list.size_name,'/')[list.size_nm]} | 개수: ${list.count} </p> 
												<div class="stars" id="star-rating" style="color:gray;">
													<i class="fa fa-star <c:if test='${list.rating >= 1}'>checked</c:if>" data-value="1"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 2}'>checked</c:if>" data-value="2"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 3}'>checked</c:if>" data-value="3"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 4}'>checked</c:if>" data-value="4"></i>
													<i class="fa fa-star <c:if test='${list.rating >= 5}'>checked</c:if>" data-value="5"></i>
													${list.rating}
												</div> 
											</div>
										</div>
										<div class="rev_des" style="padding-top:20px;">
											
											<p class="sle_nm" style="min-height:130px;">${list.content}</p> 
										</div>
										<c:if test="${list.img != ''}">
											<div class="mainImg" style="padding-bottom:20px; padding-left:15px; padding-right:15px;">
												<div>
													<img src="/img/front/${fn:replace(list.img, '\\', '/')}" alt="" style="width: 150px; height: 150px;">
												</div>
											</div>
										</c:if>
									</div>
								</c:forEach>
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
				</form>
			</div>
		</div>
	</section>
	
	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>