<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/mypage/question/list.jsp" %>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
	
	<style>
		.questionList {
			padding-bottom: 20px;
			width: 100%;
		}
		.questionHeader {
			display: flex;
			flex-wrap: nowrap;
			justify-content: space-between;
			font-weight: bold;
			border-bottom: 1px solid #ddd;
			padding-bottom: 20px;
		}
		.questionItem {
			display: flex;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items: center;
			border-bottom: 1px solid #ddd;
			padding: 30px 0;
		}
		#questionNm {
			overflow: hidden;
			text-overflow: ellipsis;
			display: -webkit-box;
			-webkit-line-clamp: 2	; /*2줄*/
			-webkit-box-orient: vertical;
		}
		input[type=button] {margin:20px auto; display:block;width:100px;height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
		
		article {width:83%;}
		
		@media only screen and (max-width: 767px) {
			article {width:100%;padding:0 15px;}
			#questionNm {display:block;margin:0;}
			#questionNm span:first-child {-webkit-line-clamp: 1;}
		}
	</style>
	<script>
		function goView(value){
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("seq_bbs").value = value;
			
			frmMain.action="/front/mypage/question/view.web";
			frmMain.submit();
			
		}
		
		function goPage(value) {
			
			var frmMain = document.getElementById("frmMain");
			
			document.getElementById("currentPage").value = value;
			
			frmMain.action="/front/mypage/question/list.web";
			frmMain.submit();
		}
	</script>
</head>

<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>문의 내역</h4>
						<div class="breadcrumb__links">
							<a href="/front/mypage/">마이페이지</a> <span>문의 내역</span>
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
				<article>
					<form id="frmMain" name="frmMain" method="POST">
						<input type="hidden" name="currentPage" id="currentPage"	value="${paging.currentPage}" />
						<input type="hidden" name="seq_bbs" 	id="seq_bbs"/>
						
						<div class="question">
							<c:choose>
								<c:when test="${empty list}">
									<p style="text-align: center; padding-top: 20px;">문의한 내역이 없습니다.</p>
								</c:when>
								<c:otherwise>
								
									<div class="questionList pc">
										<div class="questionHeader">
											<span style="width: 10%; text-align: center;">NO</span> 
											<span style="width: 15%; text-align: center;">카테고리</span>
											<span style="width: 50%; text-align: center;">제목</span>
											<span style="width: 10%; text-align: center;">답변여부</span>
											<span style="width: 15%; text-align: center;">등록일자</span>
										</div>
										<c:forEach items="${list}" var="list">
											<c:set var="i" value="${i+1}" />
											<div class="questionItem">
												<span style="width: 10%; text-align: center; padding-top:15px;">${list.rnum}</span>
												<span style="width: 15%; text-align: center; padding-top:15px;">
													<c:choose>
														<c:when test="${list.cd_ctg == 1}">
															가입 및 탈퇴
														</c:when>
														<c:when test="${list.cd_ctg == 2}">
															상품
														</c:when>
														<c:when test="${list.cd_ctg == 3}">
															구매
														</c:when>
														<c:when test="${list.cd_ctg == 4}">
															결제
														</c:when>
														<c:when test="${list.cd_ctg == 5}">
															배송
														</c:when>
														<c:when test="${list.cd_ctg == 6}">
															환불
														</c:when>
														<c:when test="${list.cd_ctg == 9}">
															기타
														</c:when>
														<c:otherwise>
															${list.cd_ctg}
														</c:otherwise>
													</c:choose>
												</span>
												<span id = "questionNm" style="width: 50%; text-align: left; cursor:pointer; padding-top:15px;"onclick="javascript:goView('${list.seq_bbs}');">${list.title}</span>
												<span style="width: 10%; text-align: center; font-weight: bold; padding-top:15px;">
													<c:choose>
														<c:when test="${empty list.flg_reply}">
															대기중
														</c:when>
														<c:when test="${list.flg_reply > 0}">
															답변완료
														</c:when>
														<c:otherwise>
															${list.flg_reply}
														</c:otherwise>
													</c:choose>
												</span>
												<span style="width: 15%; text-align: center; padding-top:15px;">${list.dt_reg}</span>
											</div>
										</c:forEach>
									</div>
									
									<div class="questionList mo" >
										<div class="questionHeader">
											<span style="width: 75%; text-align: center;">제목</span>
											<span style="width: 25%; text-align: center;">답변여부</span>
										</div>
										
										<c:forEach items="${list}" var="list">
											<c:set var="i" value="${i+1}" />
											<div class="questionItem">
												<p id="questionNm" style="width: 75%; text-align: left; cursor:pointer;"onclick="javascript:goView('${list.seq_bbs}');">
													<span style="display:block;width:100%;">${list.title}</span>
													<span style="width: 20%; text-align: center;">${list.dt_reg}</span>
												</p>
												<span style="width: 25%; text-align: center; font-weight: bold;">
													<c:choose>
														<c:when test="${empty list.flg_reply}">
															대기중
														</c:when>
														<c:when test="${list.flg_reply > 0}">
															답변완료
														</c:when>
														<c:otherwise>
															${list.flg_reply}
														</c:otherwise>
													</c:choose>
												</span>
											</div>
										</c:forEach>
									</div>
									
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
				</article>
			</div>
		</div>
	</section>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>